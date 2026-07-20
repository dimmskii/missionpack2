# QL HUD build-up plan

Tracks what's dead/stubbed on both sides of the QL-compat HUD effort, so
follow-up work has a map instead of needing to be rediscovered. Update this
as items get fixed or new gaps are found.

## MPP (our own) - dead or broken, unrelated to QL

- **Chat text buffers never get written.** `systemChat`/`teamChat1`/
  `teamChat2` (`cg_newdraw.c` globals) back `CG_AREA_CHAT`/
  `CG_AREA_TEAMCHAT`/`CG_AREA_SYSTEMCHAT`/`CG_AREA_NEW_CHAT`, but nothing in
  the codebase ever assigns to them outside `cg_newdraw.c` itself - they're
  declared and read, never populated. All four of those ownerdraws are
  currently non-functional (always show empty/stale text), independent of
  anything QL-related. Needs wiring into the real chat-print path (wherever
  the console/notify-line chat text actually lands) before any visibility
  flag work on the new-chat icons matters.
- **`CG_DrawStatusBar` + helpers are fully commented out.** `cg_draw.c`:
  `CG_DrawStatusBarHead`, `CG_DrawStatusBarFlag`, `CG_DrawStatusBar` are
  entirely commented-out function bodies, permanently dead since
  `MISSIONPACK` is always defined here (the itemDef/menuDef HUD system
  replaced the classic status bar outright). Not a bug, just confirmed-dead
  code worth knowing about if anyone goes looking for the "old" HUD path.

## QL groundwork - stubbed or not yet functional

- **`ItemParse_font` is still a stub** (`ui_shared.c`) - parses the
  item-level `font FONT_DEFAULT`/`FONT_SANS`/`FONT_MONO` keyword and
  discards it. Not fixed because the real `hud.menu`/`hud3.menu` only ever
  use `FONT_DEFAULT`, and our engine already auto-buckets
  textFont/smallFont/bigFont by each item's `textscale` value regardless of
  this keyword - so it wasn't blocking anything observed yet. Would need
  real work if a future QL file actually uses `FONT_SANS`/`FONT_MONO`.
- **`CG_OwnerDrawVisible` (`cg_newdraw.c`) - fixed.** Was riddled with
  fall-through bugs (several checks only ever returned `qfalse` on the
  negative case with no `qtrue` on success, e.g. `CG_SHOW_ANYARENAGAME`;
  several others had no `else` at all, e.g. `CG_SHOW_CTF`/
  `CG_SHOW_HEALTHCRITICAL`/`CG_SHOW_HEALTHOK`/`CG_SHOW_SINGLEPLAYER`/
  `CG_SHOW_TOURNAMENT`/`CG_SHOW_IF_PLAYER_HAS_FLAG`; `CG_SHOW_DURINGINCOMINGVOICE`
  was a literal empty block) - every check now returns explicitly both
  ways. All 5 cleanly-inferable missing flags real `hud.menu` uses are now
  implemented: `CG_SHOW_PLAYERS_REMAINING` (scoped to `GT_CLAN_ARENA`),
  `CG_SHOW_IF_RED_IS_FIRST_PLACE`/`CG_SHOW_IF_BLUE_IS_FIRST_PLACE` (team
  score comparison), `CG_SHOW_IF_PLYR_IS_FIRST_PLACE`/
  `CG_SHOW_IF_PLYR_IS_NOT_FIRST_PLACE` (individual `PERS_RANK`, non-team
  gametypes only - team games reuse `PERS_RANK` for team standing instead,
  see `CalculateRanks` in `g_main.c`). `CG_SHOW_IF_MSG_PRESENT`/
  `CG_SHOW_IF_NOTICE_PRESENT` are now explicit documented no-ops (still
  blocked on the dead chat-buffer issue above, not silent fall-through
  anymore).
- **`cg_gametype` cvar added** (`cg_cvar.h`, `CVAR_ROM`) - read-only
  client-side mirror of `cgs.gametype`, for `hud.menu` itemDef
  `cvarTest`/`showCvar` gating (e.g. the Round panel:
  `cvarTest "cg_gametype" showCvar { "12" }`). Our `gametype_t` enum
  matches QL's real wire numbering directly through `GT_TEAMTOURNAMENT`(13)
  (confirmed against QL-SRP's own `gametype_t`), so showCvar literals
  copied verbatim from a real QL `.menu` file work unmodified - no per-item
  remap needed. Found and removed dead/wrong remap machinery
  (`Item_EnableShowViaCvar_QL`/`toQLGametypeMap[]` in `ui_shared.c`) that
  predated this and read the wrong cvar (`g_gametype`, the real
  authoritative *server* cvar, never mirrored client-side).
- **`CG_RACE_STATUS`/`CG_RACE_TIMES`** (`cg_newdraw.c`) - wired into the
  ownerdraw switch but deliberately no-op. Race (`GT_RACE`, aliased to
  `GT_SINGLE_PLAYER`) has zero server-side checkpoint/timing tracking -
  confirmed via grep, it's just an enum alias and a name string. Real
  implementation needs actual Race gametype mechanics first, out of scope
  for HUD work alone.
- **`CG_RED_OWNED_FLAGS`/`CG_BLUE_OWNED_FLAGS`** (`cg_newdraw.c`) - same
  situation as Race: Domination (`GT_DOMINATION`) has zero server-side
  capture-point tracking. `ownerdrawflag CG_SHOW_DOMINATION` already gates
  these to `CG_SHOW_NEVER` in `menudef.h`, so this is at least consistently
  hidden rather than half-wired.
- **Font baking effort scrapped** - real QL fonts (handelgothic.ttf etc,
  baked at QL's real point sizes 24/16/48) rendered "jumbled" in-engine
  despite passing structural validation; root cause not diagnosed. Whole
  effort (custom font baker, extracted QL assets, notes on what was tried
  and likely bugs) moved out of this repo to `~/ql-font-baker/` (see its
  `MEMO.md`). `hud.menu`'s `assetGlobalDef` font block currently still
  points at real QL's `fonts/font`/`smallfont`/`bigfont` in the reference
  copy at `/opt/openclaw/zzqlhudfiles` - swapping to MPP's own
  `fonts/impact.ttf` @ 16/12/20 avoids renderer fallback garbling but
  doesn't fix layout (QL's `rect`/`textscale` numbers were tuned for a font
  we don't have working yet).
- **Missing QL assets** - `bluechip.tga`, `redchip.tga`,
  `textures/ad_content/pwned.jpg` (all `hud3.menu`-only) aren't in the
  `pak00.pk3` we have; need a later `pak0X.pk3` to source them. Everything
  `hud.menu` (the main one) needs is already extracted.
- **`hud2.txt`/`hud3.txt` reference files we don't have at all** -
  `hud2.txt` loads `ui/min_hud.menu`, `hud3.txt` loads `ui/comp_hud.menu`,
  neither exists in the `zzqlhudfiles` dump. The `hud3.menu` file that
  *does* exist there was being treated as "comp_hud" all session by
  filename coincidence, not because `hud3.txt` actually references it.
  Worth sourcing the real files before assuming what's in hand is correct.
- **`src/scripts/ui_hud_ql_import.shader`** - staged cherry-picked shader
  stanzas from real QL (team-color backgrounds, gametype icons, weaplit2,
  skull icons, ca_score), not yet merged into `scripts/ui_hud.shader`/
  `icons.shader`, not wired into any build. Intended to keep growing as
  more QL ownerdraws/assets get implemented instead of re-extracting ad hoc
  each time.
