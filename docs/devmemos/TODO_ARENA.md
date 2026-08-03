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

## 5. Scores are not reset by "Waiting for players"

`c538382` resets `roundNumber` to 0 when the server drops below two players, so
a resumed match legitimately restarts at Round 1 - but `PERS_ROUNDWINS` and
`level.teamScores` survive, because `G_WarmupEnd` preserves them for arena
(`if (!isArena)` at `g_main.c:2072` and `:2113`). So "Round 1" can appear beside
a player already holding 3 round wins.

Deliberately not fixed: the trigger is a transient `numPlayingClients < 2` dip,
so in a 2-player arena one player briefly reconnecting would wipe the whole
match score. That is a worse failure than the cosmetic mismatch, and a cheap
grief vector.

Right place to settle it is the QL pers-stat restructuring, where match state
gets reorganised anyway.

## 6. `cg_newdraw.c` / `cg_olddraw.c` duplicate the arena score rescan

`CG_HudScores` (`cg_newdraw.c`, from `3fc1917`) and the inline block in
`cg_olddraw.c` both recompute the top-two `roundWins` from `cg.scores[]`,
because `CS_SCORES1/2` carry `PERS_SCORE` in FFA arena. Both are best-effort
and can lag between scoreboard refreshes.

Both disappear once the server publishes round wins directly in those
configstrings - again the QL pers-stat work. Until then, keep them in sync.

## 7. Wipe leftover world state between rounds

A new round should start on a clean map. Today it doesn't: rockets, grenades,
plasma and prox mines fired in the dying seconds of a round survive the round
break and can kill someone on the next round's spawn. Corpses, dropped items
and other debris linger the same way.

What already happens in `G_WarmupEnd`: `ClearBodyQue()` (`g_main.c:2033`) only
unlinks the `BODY_QUEUE_SIZE` recycled body entities, and `Team_ResetFlags()`
returns flags. Nothing touches in-flight projectiles or dropped pickups.

Candidates to sweep, by `classname` in `g_missile.c`: `rocket`, `grenade`,
`plasma`, `bfg`, `nail`, `prox mine`, `proxmine_trigger`, `hook`, plus
`kamikaze` (`g_weapon.c:1232`) and items dropped on death
(`dropped->classname = item->classname`, `g_items.c:688`). Client-side gib and
explosion effects are temp entities and expire on their own - no server-side
work needed there.

Fix shape: one `Arena_ClearRoundDebris()` beside the other `Arena_*` helpers,
walking `g_entities` and freeing the above. Call it from `Arena_BeginRound`
(round warmup start, where `respawnAll()` already resets players) rather than
`G_WarmupEnd`, so the map is clean for the whole warmup rather than only from
the go-live instant.

Watch out for: map-placed entities sharing a `classname` with dropped items -
filter on `ent->flags & FL_DROPPED_ITEM` rather than classname alone for
pickups, or respawning items get deleted permanently.
