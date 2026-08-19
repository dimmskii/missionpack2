# Warmup and ready-up: assessment against QL-SRP

Written after chasing two separate "the warmup text never appeared" bugs that
both turned out to be the same structural problem. This is an assessment and a
staging plan, not a record of work done - nothing here is implemented yet unless
a section says so. See `FREEZE_TAG.md` for the same treatment of the freeze
mechanic itself.

QL-SRP source referenced throughout is `/opt/openclaw/QL-SRP/src/code/`.

## The thing we're actually missing is a single mutator

QL never assigns `level.warmupTime` directly. Every write goes through one
function, `g_main.c:7736`:

```c
void G_SetWarmupTime( int warmupTime ) {
	level.warmupTime = warmupTime;
	trap_SetConfigstring( CS_WARMUP, va( "%i", level.warmupTime ) );
	G_UpdateReadyUpConfigstring();
	G_CheckAutoRecord();

	if      ( warmupTime <  0 ) state = GAME_STATE_PRE_GAME;
	else if ( warmupTime == 0 ) state = GAME_STATE_IN_PROGRESS;
	else                        state = GAME_STATE_COUNT_DOWN;
	G_SetGameState( state );
}
```

No change-gating, no conditional publish, no caller that can forget. That is
exactly the bug class we keep hitting. Our tree currently has ten raw
`level.warmupTime = ` writes, and two of them never publish `CS_WARMUP` at all:
`g_main.c:992` (the round-based init) and `g_main.c:1158` (the tournament
spectator pull-in). The publishes that do exist sit behind
`if ( level.warmupTime != -1 )`, so a value that is *already* `-1` never gets
announced - which is why a point publish bolted onto the init (`d38d2aa`,
reverted in `f347f6c`) changed nothing in practice: the very next frame took a
path that skipped the gated publish anyway. Patching call sites one at a time
does not work here; removing the ability to forget does.

This is the same family as `GFACTORY_CVARS_COUNT` and `SCORE_FIELDS`: two places
that must agree, with nothing in the language enforcing it. The fix is the same
shape - remove the opportunity rather than audit the call sites.

The tri-state also finally gets a vocabulary. `PRE_GAME` / `COUNT_DOWN` /
`IN_PROGRESS` is what our `warmupTime < 0` / `> 0` / `== 0` comparisons are
groping for every time we write one.

## The ready-up layer proper

### State

`client->pers.readyUpLatch`, one boolean. Only ever set through
`G_SetClientReadyState()` (`g_client.c:110`), which mirrors it into
`ps.eFlags |= EF_READY` so the HUD sees it without a second channel.
`G_SyncClientReadyState()` (`g_client.c:130`) re-asserts the eFlag after
anything that rebuilds the playerstate - called from `ClientSpawn`
(`g_client.c:2192`) and `ClientBegin` (`g_client.c:2916`).

### Broadcast

Three channels, all refreshed from `G_WarmupReadyToStart()` (`g_main.c:7724`):

- `ps.stats[STAT_CLIENTS_READY]` - a 16-bit per-client mask, written to every
  connected client's playerstate.
- `CS_WARMUP_READY` - infostring carrying `percent` / `count` / `eligible`,
  built by `G_PublishWarmupReadyConfigstring()` (`g_main.c:7672`).
- `CS_READYUP_STATUS` - the deadline timestamp, via
  `G_UpdateReadyUpConfigstring()`. Falls back to `level.warmupTime` when no
  ready-up delay is armed.

### Gate

`G_WarmupReadyToStart()` returns go/no-go and is consulted by `CheckTournament`
(`g_main.c:8313`) *before* any countdown is armed. In order:

1. `level.trainingMapActive` - always yes.
2. `!g_doWarmup.integer` - always yes. This is the master off switch for the
   entire ready-up system.
3. Dedicated, not duel, and `level.time - level.startTime < g_warmupDelay*1000`
   - no. A grace period after level start.
4. `level.warmupTime >= 0` - yes. The latch only gates *entry* into the
   countdown; once counting or live it never retracts.
5. Duel: exactly 2 eligible and both ready.
6. Team: `Team_HasMinimumPlayersForWarmup()`. Non-team:
   `level.numPlayingClients >= 2`.
7. `readyCount / eligibleCount >= sv_warmupReadyPercentage`.

`Team_HasMinimumPlayersForWarmup()` (`g_team.c:1591`) is worth reading on its
own - it is the real "are enough people here" predicate, driven by
`g_teamSizeMin` and `g_teamForcePresent`, and it is what our hand-rolled
`counts[TEAM_RED] < 1 || counts[TEAM_BLUE] < 1` in `CheckTournament` is a
degenerate case of.

### Cvars

| cvar | default | flags | meaning |
| --- | --- | --- | --- |
| `g_warmup` | `10` | `CVAR_ARCHIVE` | countdown length, **seconds** (inherited Q3 cvar, inherited units) |
| `g_doWarmup` | `1` | `CVAR_ARCHIVE` | master switch for warmup/ready-up |
| `g_warmupDelay` | `15` | - | seconds after level start before countdown checks may proceed (dedicated only) |
| `sv_warmupReadyPercentage` | `0.51` | `CVAR_ARCHIVE\|CVAR_LATCH` | fraction of eligible clients that must be ready |
| `g_warmupReadyDelay` | `0` | - | duel only: seconds to wait when exactly one duelist readies; 0 disables |
| `g_warmupReadyDelayAction` | `1` | - | duel only: 1 = spectate the unready player, 2 = force both ready |
| `g_teamSizeMin` | `1` | `CVAR_SERVERINFO` | minimum players per team |
| `g_teamForcePresent` | `1` | - | require *both* teams to meet the minimum |

`g_warmup` staying in seconds is consistent with the unit rule recorded in
`QL_CVAR_SYNC.md`: inherited Q3 cvars keep their original units, QL-*added*
cvars are milliseconds. `g_warmupDelay` and `g_warmupReadyDelay` are QL
additions yet are read as `* 1000`, i.e. seconds - a genuine exception, and one
to double-check against retail before we copy the defaults.

### Commands

Registered in `g_cmds.c:8443-8578`:

- `readyup` - toggle. The bound-key prompt on the HUD names this one.
- `ready` / `notready` / `unready` - explicit set.
- `allready` - `PRIV_MOD`, readies everyone (`g_cmds.c:7126`).

All refuse spectators. All route denials through
`G_GetReadyUpBlockedMessage()` (`g_cmds.c:2496`), which returns retail-exact
strings: "The match has already started.", "Players cannot ready up until both
teams are present.", "Players cannot ready up until both teams are fully
present.", "Cannot ready up until more players are present."

## Client side

`CG_DrawWarmup()` (`cg_draw.c:5928`) computes the countdown **inside itself**:

```c
sec = ((sec - cg.time) + 1000) / 1000;
if ( sec != cg.warmupCount ) { cg.warmupCount = sec; ...count sound... }
```

Ours splits this across two functions called from different points in
`CG_DrawActive` - `CG_WarmupEvents()` owns `cg.warmupCount`, `CG_DrawWarmup()`
only reads it. Same coupling hazard, one more thing that can silently
desynchronise. Consolidating is a small, self-contained win.

Three display states:

- **`sec < 0`** - `CG_DrawWarmupWaitingStatus()` draws two lines built by
  `CG_BuildWarmupWaitingStatus()` (per-team shortfall: "Waiting for 2 more
  players" / "to join the Blue Team."), then `CG_DrawWarmupReadyPrompt()` draws
  "Press %s to ready yourself" with the actual `readyup` binding.
- **`sec > 0`** - `CG_DrawWarmupStatusText()` draws a title at y=90 and the
  countdown at y=125.
- **`sec == 0`** - nothing.

The title logic is what we want for round-based modes (`cg_draw.c:5457`):

```c
case GT_CLAN_ARENA: case GT_FREEZE: case GT_ATTACK_DEFEND: case GT_RED_ROVER:
	if ( cgs.matchRoundNumber > 0 ) {
		title = cgs.matchSuddenDeathActive ? "Sudden Death" : "Round Begins in";
		shortCountdown = qtrue;   // bare "3", no "Starts in:" prefix
		break;
	}
	break;                        // round 0 falls through to the gametype banner
```

Round 0 gives "Freeze Tag" + "Starts in: N"; rounds 1+ give "Round Begins in" +
a bare number. We already publish `CS_ROUND_NUMBER`, so `cgs.matchRoundNumber`
has a direct local equivalent with no new plumbing.

`cg_drawPregameMessages` gates the waiting-status lines only, not the countdown.

## What we already have for free

- **`STAT_CLIENTS_READY` exists** (`bg_public.h:222`). Today it carries only the
  intermission-exit mask (`g_main.c:1822`, read at `cg_scoreboard.c:209`). QL
  reuses the *same* stat for warmup readiness. No protocol change, and the
  scoreboard already paints a "READY" marker from it.
- **`cg_predict.c:804`** already exempts `STAT_CLIENTS_READY` from prediction
  error checks, so a mid-warmup mask change won't trip a prediction warning.
- **Free eFlags bits** from `0x00100000` upward - room for `EF_READY`.
- **Free configstrings 28-31**, between `CS_ROUND_NUMBER` (26) / `CS_ITEMS` (27)
  and `CS_MODELS` (32), if we want the count/eligible/percent snapshot.

## Deliberate divergences

### Bots are always ready

**This is the one divergence we know we want up front.**

`G_WarmupReadyToStart()` iterates every `CON_CONNECTED` client and counts it as
eligible with no `SVF_BOT` exclusion. Nothing outside training mode ever readies
a bot - `BotUpdateTrainingReadyState()` (`ai_main.c:875`) is gated on
`g_training`. So with the retail default `sv_warmupReadyPercentage 0.51`, one
human among eight bots yields a ratio of 0.11 and **the match can never start**.

That is precisely the listen-server-with-bots case this mod is played in most of
the time, so we diverge deliberately. Two workable shapes, and they are
equivalent in outcome:

- treat a bot as permanently ready (`G_ClientIsReady()` returns `qtrue` for
  `SVF_BOT`), or
- exclude bots from `eligibleCount` entirely.

Prefer **treating bots as always ready**: it keeps `eligibleCount` meaning "how
many players are in the match", which is what the HUD's `count/eligible`
display and the scoreboard mask both want to show. Excluding them would make a
bot-heavy server report "1/1 ready" while nine bodies stand around, which reads
as a bug.

Whether SRP's reconstruction is incomplete here or retail really does have this
hole is unknown. Either way, do not "restore" it.

### Warmup end stays in place, not a map_restart

QL ends warmup by restarting the map: `G_RequestWarmupMapRestart()`
(`g_main.c:7654`) adds 10 s to `warmupTime`, sets `g_restarted 1`, and issues
`map_restart 0`. Ours transitions in place in `G_WarmupEnd()`.

Keep ours. QL's model exists because a restart is how it re-runs
`G_InitWeaponConfig` and friends; our round layer is built around in-place
transitions and `Arena_BeginRound()` already does the equivalent work. Porting
the restart would drag the whole round cycle with it for no gain.

## Round 1 is not a round begin, and that is the same problem

Added after `da2c8fa` restored `Arena_ForceRespawnDead()` at warmup end. The
round-1-versus-rounds-2+ asymmetry that change left in place is not a separate
bug - it is this same missing state machine seen from the other side.

Our two round-start paths:

**Round 1.** `CheckTournament` arms `level.warmupTime` (`g_main.c:2344`). Nothing
respawns anyone. The countdown runs. `G_WarmupEnd` respawns the dead and frozen,
zeroes `warmupTime`, and claims `level.roundNumber = 1` (`g_main.c:2119`).

**Rounds 2+.** `Arena_EndRound` sets `level.arenaRoundQueued` (`g_newgame.c:296`).
`Arena_CheckRules` waits out `ARENA_ROUND_DELAY_TIME` (2000 ms) or
`g_freezeRoundDelay` (4000 ms), then calls `Arena_BeginRound`
(`g_newgame.c:163`), which respawns everyone, increments `level.roundNumber`
(`g_newgame.c:185`), and arms `level.warmupTime` *again*. The countdown runs.
`G_WarmupEnd` then does the same go-live it does for round 1.

Three things fall out of that, and all three are the warmup state being asked to
mean two different things:

1. **`level.warmupTime > 0` is overloaded.** For round 1 it means "pre-match
   warmup"; for rounds 2+ it means "inter-round countdown". Nothing in the value
   distinguishes them - the only tell is whether `level.roundNumber` is still 0.
   That is exactly the test QL's cgame uses to pick "Freeze Tag / Starts in: N"
   over "Round Begins in / 3", which is a hint that the distinction wants a name
   rather than an inference.
2. **`level.roundNumber` has two owners.** `G_WarmupEnd` claims round 1;
   `Arena_BeginRound` claims every round after. Two functions writing one counter,
   each correct only because the other checks `== 0` first.
3. **Nobody puts players on spawn points before a countdown starts.** Round 1
   never did; rounds 2+ do it in `Arena_BeginRound`, but players can still walk
   during the countdown - `PMF_NOSHOOT` blocks firing, not movement - so they
   drift off their spawns before the round goes live either way. That drift is
   what `474034b` was really reacting to when it reached for `respawnAll` at
   warmup end, and it is why fixing it there was the wrong seam.

QL keeps these separate:

- **`level.roundState`** - an explicit enum, `ROUNDSTATE_INACTIVE` /
  `ROUNDSTATE_WARMUP` / `ROUNDSTATE_ACTIVE` / `ROUNDSTATE_COMPLETE`
  (`g_local.h:697`), set at every transition. The phase is stored, never derived
  from a timestamp's sign.
- **`level.roundTransitionTime` + `g_roundWarmupDelay`** - the *round* countdown,
  a separate timer from `level.warmupTime`. `level.warmupTime` stays the match
  warmup and nothing else. Note `g_roundWarmupDelay` is milliseconds, being a QL
  addition, while `g_warmup` is seconds - the unit rule in `QL_CVAR_SYNC.md`
  again, and the reason retail ships both `g_warmup 10` and
  `g_roundWarmupDelay 10000`.
- **`level.roundNumber` is derived, not incremented** - e.g.
  `level.roundNumber = level.teamScores[TEAM_RED] + level.teamScores[TEAM_BLUE] + 1`
  (`g_active.c:3262`). It cannot drift and it cannot have two owners.

None of that is a prerequisite for step 1 below, and none of it should be
attempted alongside it. But it means the asymmetry should not be "fixed" by
special-casing round 1 in `G_WarmupEnd` - that would be the same mistake
`474034b` made one layer up. The fix is a real round phase, and it belongs after
the warmup path stops being the thing that carries it.

## Staging

Three independently valuable steps, in dependency order.

1. **`G_SetWarmupTime()` funnel, alone.** No ready-up, no new cvars, no cgame
   change. Replace all eight raw writes; make the function the only way to touch
   `level.warmupTime`. Retires the missing-publish bug class outright and is very
   likely the whole fix for the currently-missing countdown text.
2. **Client countdown consolidation.** Fold `CG_WarmupEvents()` into
   `CG_DrawWarmup()` so the count and the sound come from one place, and add the
   `roundNumber > 0` -> "Round Begins in" + bare-number branch.
3. **Ready-up proper.** The latch, `EF_READY`, the four commands, `g_doWarmup` /
   `sv_warmupReadyPercentage` / `g_warmupDelay`, bots always ready, and the
   waiting-status / ready-prompt HUD lines.

Step 1 is worth doing on its own even if 2 and 3 never happen.

## Open questions

- Do `g_warmupDelay` and `g_warmupReadyDelay` really read as seconds in retail,
  against the otherwise-consistent "QL additions are milliseconds" rule? SRP
  reads both as `* 1000`.
- Should the ready-up cvars be factory cvars? `g_warmup` already is
  (`bg_newgame.h:49`). `g_doWarmup` and `sv_warmupReadyPercentage` probably
  should be; `sv_warmupReadyPercentage` being `CVAR_LATCH` in QL complicates
  that, since factories apply at level load.
- The `ft` factory in `src/assets/scripts/factories.txt` sets no `g_warmup`, so
  a factory apply restores the compiled default of 20 s. `ift` sets 10. Worth
  deciding what Freeze Tag should actually use before step 1 changes how
  visible the countdown is.
