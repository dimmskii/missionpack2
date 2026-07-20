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
- **`CG_OwnerDrawVisible` (`cg_newdraw.c`) has real bugs, not just gaps:**
  - `CG_SHOW_ANYARENAGAME`/`CG_SHOW_ANYNONARENAGAME` only ever `return
    qfalse` on the negative case - no `return qtrue` when the condition
    holds, so an item gated *only* by one of these never shows.
  - `CG_SHOW_CTF`, `CG_SHOW_HEALTHCRITICAL`, `CG_SHOW_HEALTHOK`,
    `CG_SHOW_SINGLEPLAYER`, `CG_SHOW_TOURNAMENT`,
    `CG_SHOW_IF_PLAYER_HAS_FLAG` have no `else` - a false condition falls
    through to check unrelated later flags instead of returning false,
    unlike their correctly-written siblings (`CG_SHOW_HARVESTER`/
    `CG_SHOW_ONEFLAG`/`CG_SHOW_OBELISK`).
  - `CG_SHOW_DURINGINCOMINGVOICE` is a literal empty `{}` block.
  - **7 flags the real `hud.menu`/`hud3.menu` use aren't handled at all**
    (fall through to the final `return qfalse`): `CG_SHOW_IF_BLUE_IS_FIRST_PLACE`,
    `CG_SHOW_IF_RED_IS_FIRST_PLACE`, `CG_SHOW_IF_PLYR_IS_FIRST_PLACE`,
    `CG_SHOW_IF_PLYR_IS_NOT_FIRST_PLACE`, `CG_SHOW_PLAYERS_REMAINING`,
    `CG_SHOW_IF_MSG_PRESENT`, `CG_SHOW_IF_NOTICE_PRESENT`. The first four
    plus `PLAYERS_REMAINING` are cleanly inferable from data already
    available (`cgs.scores1`/`scores2`, alive-player counts, same pattern
    as `CG_CountTeamPlayers`). The `MSG_PRESENT`/`NOTICE_PRESENT` pair (QL's
    "new tell"/"challenge pending" icons) block on the dead chat-buffer
    issue above - no real "message present" signal exists client-side at
    all right now.
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
