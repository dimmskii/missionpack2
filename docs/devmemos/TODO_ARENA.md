# Open items: Arena / Clan Arena / Freeze round lifecycle

Deferred work left over from the 0.61 arena round-flow fixes (`3fc1917`,
`43e41b0`, `663d396`, `c538382`). Everything here is known and deliberately
not done yet - none of it is a regression from those commits.

Applies to all three round-based gametypes unless stated: `GT_ARENA` (FFA
Arena, gt 14), `GT_CLAN_ARENA`, `GT_FREEZE` - i.e. whatever `GT_IsArenaGame`
covers.

## Verified round-lifecycle facts (hard-won; don't re-derive)

Confirmed on a live dedicated server with traces, not just by reading code.

- **`G_WarmupEnd` runs at the end of EVERY round's warmup**, not once per
  match. `Arena_BeginRound` sets `warmupTime` positive, the countdown expires,
  and `CheckTournament` calls `G_WarmupEnd`. Any per-match assumption there is
  wrong - that was the `roundNumber` bug (`c538382`).
- **`level.startTime` resets on every round** as a result, and that is
  intentional: `g_roundtimelimit` measures `level.time - level.startTime`
  (`g_main.c:1913`). It is also why `g_timelimit` is explicitly short-circuited
  for arena at `g_main.c:1931`.
- **Two unfreeze valves exist** for players stuck in `SPECTATOR_FOLLOW`:
  `G_WarmupEnd`'s arena block (added by `8056cee`) and the same pattern in
  `Arena_BeginRound`. Both are reachable only while a round cycle is running.
- **`CheckTournament` returns early when `numPlayingClients == 0`**
  (`g_main.c:2217`), so nothing at all happens on a completely empty server.
- **`ClientSpawn`'s mid-round freeze fires on `!level.warmupTime`**
  (`g_client.c:1374`). Any code that respawns players must run while
  `warmupTime` is still non-zero or it gets undone immediately.

## 1. Warmup still requires a click to respawn

`g_active.c:1041` - the arena death block only handles `!level.warmupTime`, so
a player who dies *during* warmup falls through to the vanilla path and waits
on `g_forcerespawn` (20 s) or an attack press.

Fix shape: branch both ways in that block; when `level.warmupTime` is set,
`respawn( ent )` once `level.time > client->respawnTime` (death animation still
plays, no click needed).

Low urgency - `Arena_ForceRespawnDead` (`663d396`) removed the *consequence*
(entering a round dead and losing it instantly), so this is now ergonomics only.

## 2. Narrow the `ClientSpawn` freeze condition

`g_client.c:1374` freezes any joiner while a round is live. Combined with
`CheckTournament`'s `numPlayingClients == 0` early return, the very first client
on an empty server is frozen for a frame or two before the "Waiting for players"
transition fires, then sits dead until forcerespawn or a click rather than
spawning clean.

Fix shape: don't freeze when there is no live round to sit out (e.g. no alive
players on the joiner's team).

**Do not drop the `sessionTeam != TEAM_SPECTATOR` term** - that is a crash fix
from `488525e`.

## 3. Round-start revive can telefrag

`Arena_ForceRespawnDead` calls `respawn()`, and `ClientSpawn:1321` calls
`G_KillBox` for non-spectators. `SelectRandomFurthestSpawnPoint` avoids the
death point, not living players, so a revive can gib someone standing on the
chosen spawn - decisive in a mode where one death ends the round.

Stock behaviour on every respawn, not something the revive invents, but it now
fires at a newly sensitive moment. Options: accept; skip `G_KillBox` for
round-start revives (risk: interpenetration); or move the revive to
`Arena_BeginRound`, where `respawnAll()` relocates everyone anyway.

Waiting on whether it actually shows up in play.

## 4. Weapon freeze persists into intermission

`Arena_FreezeSurvivorWeapons` is called at the top of `Arena_EndRound`, above
its `g_roundlimit` early returns, so when the *match* is decided weapons stay
frozen through the intermission queue rather than only across the
`ARENA_ROUND_DELAY_TIME` gap.

Reads as correct (the match is over), but it is broader than the stated scope.
Tighten only if it feels wrong in play.

## 5. Scores reset by "Waiting for players" - DONE

`Arena_ResetMatchScores` now wipes `PERS_ROUNDWINS`, `PERS_SCORE`, captures and
the award counters, plus `level.teamScores`, from the same one-shot `notEnough`
transition that zeroes `roundNumber`. `CalculateRanks()` re-publishes
`CS_SCORES1/2` correctly for both the team and non-team cases, so those
configstrings are deliberately not set by hand.

It cannot live in `G_WarmupEnd` like the non-arena reset does (`g_main.c:2113`),
because that runs at the end of every round's warmup - resetting there would
stop anyone ever accumulating round wins. That is exactly what the `if (!isArena)`
guards at `:2072` are protecting.

Accepted tradeoff: the trigger is a transient `numPlayingClients < 2` dip, so in
a 2-player arena one player briefly reconnecting wipes the match. Judged better
than an abandoned match's scores bleeding into the next one.

## 6. `cg_newdraw.c` / `cg_olddraw.c` duplicate the arena score rescan

`CG_HudScores` (`cg_newdraw.c`, from `3fc1917`) and the inline block in
`cg_olddraw.c` both recompute the top-two `roundWins` from `cg.scores[]`,
because `CS_SCORES1/2` carry `PERS_SCORE` in FFA arena. Both are best-effort
and can lag between scoreboard refreshes.

Both disappear once the server publishes round wins directly in those
configstrings - again the QL pers-stat work. Until then, keep them in sync.

## 7. Wipe leftover world state between rounds

Narrower than it first looks - most of the sweep already exists. `G_WarmupEnd`'s
entity loop (`g_main.c:2141-2193`) runs for arena too and already frees every
`ET_MISSILE`, removes `FL_DROPPED_ITEM` pickups and respawns picked-up items;
`ClearBodyQue()` (`:2033`) unlinks the recycled bodies. Gibs and explosions are
client-side temp entities that expire on their own.

The real gap is **timing**. That cleanup happens in `G_WarmupEnd`, i.e. when the
round goes *live* - but `Arena_BeginRound` respawns everyone at the *start* of
warmup, one `g_warmup` period earlier. So for the whole warmup, players stand
freshly spawned while the previous round's rockets and grenades are still in
flight and can damage or telefrag them. It self-corrects only because
`Arena_ForceRespawnDead` revives anyone killed that way.

Fix shape: sweep at round end or at `Arena_BeginRound` instead of (or as well
as) `G_WarmupEnd`, so the map is clean for the entire warmup rather than only
from the go-live instant. Easiest is to factor the `ET_MISSILE` free out of
`G_WarmupEnd`'s loop into a small helper both can call.

Watch out for: map-placed entities share a `classname` with dropped items, so
any pickup filter must test `ent->flags & FL_DROPPED_ITEM` (`g_local.h:37`, set
at `g_items.c:715`) rather than classname, or respawning items get deleted
permanently.
