# QL-shaped gameplay-cvar sync plan (Scope A, no structs)

Replaces the ad-hoc `CVAR_SERVERINFO` + serverinfo-parse transport for
gameplay cvars with QL-SRP's dedicated-configstring pattern, but keeps our
cvars as the single source of truth (no settings structs/caches on either
side). The server serializes cvars into QL-shaped configstring messages; the
client parses them back into the same cvars / `cgs.*` fields.

Root motivation: `g_sgPellets`/`g_sgPelletSpread` were registered `flags=0`,
never reached `CS_SERVERINFO`, so `CG_ShotgunPattern` looped 0 pellets and
drew no shotgun impacts. Broader motivation: the 14 `weapon_reload_*` cvars
on `CVAR_SERVERINFO` bloat the 1 KB serverinfo budget and will overflow as
more gameplay cvars are added.

## GOVERNING EDIT RULE (~Dimmskii) - applies to EVERY step below

See `CONVENTIONS_CODING_C_H.md` for the full ~Dimmskii tagging convention.
Assume it applies to every step below without being repeated per step.

## Groupings (mirror QL-SRP's messages)

| QL-shaped message | Carries | Client destination |
|---|---|---|
| `CS_WEAPON_RELOAD_TIMES` | 14 `weapon_reload_*` as one int slab | `trap_Cvar_Set` each mirror cvar |
| `CS_SERVER_SETTINGS_INFO_A` | reserved: future boolean flags | - |
| `CS_SERVER_SETTINGS_INFO_B` | scalars: `g_sgPellets`, `g_sgPelletSpread` | `atoi` into `cgs.*` |
| `CS_PMOVE_SETTINGS` | reserved: future gameplay `pmove_*` | - |

Only `pmove_fixed`/`pmove_msec` exist today and they're engine cvars the
engine already syncs, so `CS_PMOVE_SETTINGS` is a defined-but-empty stub.

**Scope split (deliberate):** cvars that are already Kr3m/mpp serverinfo cvars
and currently work - `g_grappleDelayTime`, `g_grapplePull` (both
`CVAR_SERVERINFO`) - **stay on serverinfo for now** and keep their existing
`CG_ParseServerinfo` reads untouched. This migration only moves (a) the 14
`weapon_reload_*` (our own additions, the real serverinfo-overflow driver)
and (b) the broken `g_sgPellets`/`g_sgPelletSpread` (`flags=0`, never
reached the client). Folding the grapple cvars (and other pre-overflow Kr3m
serverinfo cvars) into `CS_SERVER_SETTINGS_INFO_B` is deferred to a later
pass.

## Step 1 - Configstring block (`src/code/game/bg_public.h`)

Our CS layout is compact (`CS_MAX` = 736); QL's retail indices (0x2A9+)
would collide with `CS_PLAYERS`/`CS_PARTICLES`. Use our free range at the
current `CS_MAX` slot and push `CS_MAX` up:

```c
#define CS_WEAPON_RELOAD_TIMES     (CS_PARTICLES+MAX_LOCATIONS)   // old CS_MAX value, first free slot
#define CS_SERVER_SETTINGS_INFO_A  (CS_WEAPON_RELOAD_TIMES+1)
#define CS_SERVER_SETTINGS_INFO_B  (CS_SERVER_SETTINGS_INFO_A+1)
#define CS_PMOVE_SETTINGS          (CS_SERVER_SETTINGS_INFO_B+1)  // reserved stub
#define CS_MAX                     (CS_PMOVE_SETTINGS+1)
```

The existing `#if (CS_MAX) > MAX_CONFIGSTRINGS #error` guard stays and still
passes (737 slots << 1024). Comment out the old `#define CS_MAX ...` per the
edit rule.

## Step 2 - Server publishers (`src/code/game/g_main.c`)

Per-message functions modeled on QL's `G_Update*Configstring(qboolean
forceBroadcast)`: build payload -> diff vs a `static char
s_*Payload[MAX_INFO_STRING]` -> `trap_SetConfigstring` only when changed or
forced.

- `G_UpdateWeaponReloadConfigstring(force)` - `Com_sprintf` a 14-int slab in
  QL's weapon order (GAUNTLET, MG, SG, GL, RL, LG, RG, PG, BFG, HOOK, NG,
  PROX, CG, HMG), read straight from `weapon_reload_*.integer`.
- `G_UpdateServerSettingsConfigstrings(force)` - `Info_SetValueForKey` into
  payload B: `sgPellets`, `sgSpread` from their `.integer`. Leave A empty for
  now. (Grapple scalars stay on serverinfo this pass - see Scope split.)
- `G_UpdatePmoveConfigstring(force)` - stub publishing `""` until gameplay
  `pmove_*` cvars exist.

## Step 3 - Server drivers (`src/code/game/g_main.c`)

- Init (force): near the end of `G_InitGame` (after the CS table exists),
  call all three publishers with `qtrue` (optionally via a small
  `G_InitPublishedCvarState()` helper).
- Per-frame (diff): in `G_UpdateCvars()` (`g_main.c:668`), after the cvar
  mirrors refresh, call all three with `qfalse`. This is the "on each admin
  `set`" path - change picked up next frame, diffed, rebroadcast.

## Step 4 - Client parsers (`src/code/cgame/cg_servercmds.c`)

- `CG_ParseWeaponReloadConfigString()` - `CG_ConfigString(CS_WEAPON_RELOAD_TIMES)`,
  `COM_ParseExt` 14 tokens, `trap_Cvar_Set("weapon_reload_gauntlet", tok)` ...
  in the same order. No cache - writes the mirror cvars `bg_pmove` reads.
- `CG_ParseServerSettingsConfigString()` -
  `CG_ConfigString(CS_SERVER_SETTINGS_INFO_B)`, `Info_ValueForKey` -> `atoi`
  into `cgs.g_sgPellets`, `cgs.g_sgPelletSpread`. (Leave the
  `cgs.g_grappleDelayTime`/`cgs.g_grapplePull` serverinfo reads in place.)

## Step 5 - Client dispatch + init parse (`src/code/cgame/cg_servercmds.c`)

- In `CG_ConfigStringModified()` (`:362`) add:
  ```c
  else if ( num == CS_WEAPON_RELOAD_TIMES )    CG_ParseWeaponReloadConfigString();
  else if ( num == CS_SERVER_SETTINGS_INFO_B ) CG_ParseServerSettingsConfigString();
  ```
- In `CG_SetConfigValues()` (`:294`) call both parsers once - the gamestate
  CS batch on connect isn't auto-dispatched, so this seeds initial values
  (otherwise they only arrive on the first mid-game change).

## Step 6 - Remove the old transport

- `CG_ParseServerinfo` (`cg_servercmds.c:200-201`): retire only the 2
  `Info_ValueForKey(info, "g_sgPellets"/"g_sgPelletSpread")` reads (now
  sourced from `CS_SERVER_SETTINGS_INFO_B`). Comment out per the edit rule.
  **Leave lines 198-199 (`g_grappleDelayTime`/`g_grapplePull`) intact** -
  those stay on serverinfo this pass.
- `bg_cvar.h`: change the 14 `weapon_reload_*` flags `CVAR_SERVERINFO` -> `0`
  (stop serverinfo double-transport; mirrors stay registered).
- `g_cvar.h`: leave `g_sgPellets`/`g_sgPelletSpread` at `flags=0` (they ride
  the CS now); leave `g_grappleDelayTime`/`g_grapplePull` at
  `CVAR_SERVERINFO` (unchanged, still serverinfo).

## Step 7 - Build & verify (server-side / console only, no screenshots)

- `make vm_debug -j"$(nproc)"`, then debug-deploy.
- Dump the new configstrings from the dedicated console; confirm the slabs
  populate and re-diff on `set weapon_reload_rl 500` / `set g_sgPellets 20`.
- Functional: shotgun impacts reappear; serverinfo shrinks by 14 reload keys.

## Notes

- No structs, no caches: server builds payloads from cvars, client writes
  values back into cvars / `cgs.*`. The only server-side state is the
  `s_*Payload` diff strings (transport bookkeeping to avoid rebroadcast
  spam, not a settings cache).
- `CS_SERVER_SETTINGS_INFO_A` and `CS_PMOVE_SETTINGS` are defined and driven
  now but carry nothing until flag-type settings / gameplay `pmove_*` cvars
  are added - then they slot in with no new plumbing.

## Verified / cross-engine notes

- Confirmed fixing shotgun hitmarks on VQ3, ioq3, and q3e engine forks.
- The pellet count - and every value on these dedicated configstrings - rides
  the reliable gamestate baseline (delivered at connect, and via reliable `cs`
  updates on change), NOT snapshots. That's core Q3 netcode implemented
  identically across forks, which is why the fix lit up uniformly on all three
  engines. It is *not* an "ioq3 tolerates serverinfo" effect: `sg_pellets`
  isn't in serverinfo at all anymore (it shrank 977 -> 667 bytes and the keys
  are gone), and pre-fix the `flags=0` value was `atoi("")` = 0, i.e. broken.
- What *is* `sv_fps`/snapshot-bound is the per-shot impact CADENCE, not the
  count: `EV_SHOTGUN` events ride snapshots at `sv_fps`, so raising `sv_fps`
  makes the shell hits return snappier. q3e exposes this more than ioq3
  (stricter server-authoritative timing vs ioq3's more generous event
  smoothing). Orthogonal to this cvar work - the count is reliable/one-time,
  the cadence is the engine tick. The diff-guarded per-frame republish means
  cranking `sv_fps` costs nothing on the configstring side.
- This reliable-configstring transport is exactly what the eventual
  prediction-heavy `pmove_*` settings (`CS_PMOVE_SETTINGS`) want: client-side
  movement prediction needs to hold the authoritative values deterministically,
  and the reliable gamestate guarantees that regardless of fork or tick rate -
  which serverinfo (length-capped, and here already brimming) could not.
