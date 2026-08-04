# Plan: own the player-colour configstring keys, add hex effects colours

Renames the `c3`/`c4`/`c5` player-colour keys onto our own naming, and finally
implements `effectsColor1`/`effectsColor2` as nullable hex overrides that fall
back to the vq3 `color1`/`color2` digits when empty.

**Done**, except the dead-UI cleanup noted in step 3. Decision taken:
**`effectsColor*` are hex-only** - digits keep working through `color1`/`color2`
where they already live, so the fallback gate stays trivial and nothing has to
sniff formats.

Verified live: one bot injected with `effectsColor1 0x2a8000ff`,
`effectsColor2 zznotahexcolor` and `modelColorHead #f0a` produced

```
c1\4\c2\5\mh\#FF00AA\mu\\ml\\e1\#2A8000\e2\\
```

i.e. `0x` prefix accepted and alpha dropped, malformed value rejected to empty so
the client falls back to `c2`, 3-digit shorthand expanded, and `c1`/`c2` carried
through untouched.

## Terminology, because the code is misleading here

These are **configstring** keys in `CS_PLAYERS`, not userinfo keys - `g_client.c`
says as much at the `trap_SetConfigstring` call ("this is not the userinfo, more
like the configstring actually"). The client cvar name and the wire key name are
independent, and only the wire key is cheap to change. Three distinct layers:

| Layer | vq3 colours | model parts | effects hex |
| --- | --- | --- | --- |
| Client cvar | `color1`, `color2` | `modelColorHead` / `Upper` / `Lower` | `effectsColor1` / `2` |
| Wire key (`CS_PLAYERS`) | `c1`, `c2` (raw digit copy) | `c3`, `c4`, `c5` (normalised `#RRGGBB`) | *none yet* |
| cgame parse | `CG_ColorFromChar` (`cg_players.c:1473`) | `CG_BroadcastPartColor` (`cg_players.c:1489`) | *none yet* |

`effectsColor1`/`2` are registered `CVAR_USERINFO | CVAR_ARCHIVE` at
`cg_main.c:186-187` and **read by nothing** - they have been inert stubs since
they were added.

## What the effect colours actually drive

Worth knowing before changing them, since "effects colour" is vague:

- **`color1`** - rail core beam and its trail (`cg_weapons.c:226-233`), and the
  railgun *pickup model* tint for the viewing client (`cg_ents.c:327`).
- **`color2`** - rail rings sprite and trail (`cg_weapons.c:281-288`).

All of these write `shaderRGBA[0..2]` and hardcode `shaderRGBA[3] = 255`, so
**alpha is dropped**, exactly as it is for model part colours.

## Key naming

Two-char keys. `CS_PLAYERS` shares the 1024-byte `MAX_INFO_STRING` with the
player name and both model paths, so this is the one place terseness pays.

| Old | New | Meaning |
| --- | --- | --- |
| `c3` | `mh` | model colour, head |
| `c4` | `mu` | model colour, upper |
| `c5` | `ml` | model colour, lower |
| - | `e1` | effects colour 1 (rail core) |
| - | `e2` | effects colour 2 (rail rings) |

`c1`/`c2` are left exactly as they are. Two new keys at `\e1\#RRGGBB` is ~22
bytes worst case.

## Step 1 - server (`g_client.c`, `ClientUserinfoChanged`)

- Add `char e1[MAX_HEXCOLOR_STRING];` / `e2[...]` beside the existing `c3`-`c5`
  declarations (`:623-628`).
- Two more `BG_NormalizeHexColor` calls reading `effectsColor1` / `effectsColor2`
  out of userinfo, next to the three `modelColor*` ones.
- Rename `c3`/`c4`/`c5` to `mh`/`mu`/`ml` and append `\e1\%s\e2\%s` in **both**
  `va()` format strings - the bot branch and the non-bot branch.

**Do not overload `c1`/`c2` with hex.** Keeping hex in its own keys means
`c1[8]`/`c2[8]` never need resizing - they cannot hold `#RRGGBBAA` and have been
a latent hazard since the original per-part colour plan flagged them. It also
leaves `c1`/`c2` readable by anything still expecting vq3 semantics.

## Step 2 - client (`cg_players.c`, `CG_NewClientInfo`)

An outer gate, kept separate from hex parsing:

```c
// hex key wins; empty or unparsable falls back to the vq3 digit
static void CG_ResolveEffectColor( const char *hex, const char *vq3, vec3_t out ) {
	vec4_t c;

	if ( hex[0] && BG_ParseHexColor( hex, c ) ) {
		VectorCopy( c, out );
		return;
	}
	CG_ColorFromChar( vq3[0], out );
}
```

Replaces the two bare `CG_ColorFromChar` calls at `:1473-1477`, and the three
`c3`/`c4`/`c5` lookups at `:1489-1491` become `mh`/`mu`/`ml`.

## Step 3 - UI (`player.menu`, `ui_main.c`)

The existing Effects control writes **`color1` only** (`ui_main.c:2619`) and never
`color2`, so it cannot express even the vq3 pair, let alone hex. Replace it with
two `ITEM_TYPE_HEXCOLOR` swatches bound to `effectsColor1` / `effectsColor2`.

Done already in `f5fc12b` - both swatches exist in `player.menu` and the
`UI_EFFECTS` ownerdraw block is commented out rather than deleted.

**Still outstanding:** `uiInfo.effectsColor` and its handlers are now dead -
`ui_main.c:1359`, `:1368`, `:2608-2619`, `:6100-6102`. Left in place on purpose:
the menu block was preserved as a comment rather than deleted, which reads as
keeping the option open, and this is stock TA code so removing it means
commenting it out per the ~Dimmskii convention rather than a clean delete. It is
inert either way - no live menu references `UI_EFFECTS`.

## Compatibility

- **Old client, new server** - sends no `effectsColor*`, so `e1`/`e2` arrive
  empty and every client falls back to `c1`/`c2`. Behaviour unchanged.
- **New client, old server** - no `e1`/`e2` in the configstring,
  `Info_ValueForKey` returns `""`, the same fallback fires. Unchanged.
- **The `c3/c4/c5` -> `mh/mu/ml` rename breaks mixed 0.61-indev builds**: a client
  still reading `c3`-`c5` shows white parts against a new server. Both sides are
  pre-release so this is acceptable, but it is the one genuinely breaking change
  here, and it is the argument for doing the rename *before* 0.61 ships rather
  than after.

## Verification

1. All three VMs build with no new warnings.
2. Two clients, one setting `effectsColor1 #FF0000` and `effectsColor2 #00FF00`:
   both see the rail core red and rings green, including the railgun pickup tint.
3. Clear both `effectsColor*` - rail returns to whatever `color1`/`color2` give,
   proving the fallback.
4. Set a deliberately malformed `effectsColor1` (e.g. `zzz`) - falls back rather
   than rendering black.
5. `modelColor*` still work, now over `mh`/`mu`/`ml`.
6. `/serverinfo`-style check or the `ClientUserinfoChanged` log line shows
   `mh\...\mu\...\ml\...\e1\...\e2\...`.
