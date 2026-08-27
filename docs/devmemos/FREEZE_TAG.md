# Freeze Tag: implementation notes

Honest notes on how freeze is built here, what came from QL, what didn't, and
what we changed on purpose. Written mostly so the deliberate divergences don't
get "fixed" back into QL's shape by someone reading QL-SRP and assuming it's
authoritative. It frequently isn't - see the defects section.

## Where it lives

- `src/code/game/g_freeze.c` - the whole mechanic. Ours outright.
- `src/code/game/g_newgame.c` - the two gates, and the round layer freeze shares
  with Clan Arena and Arena.
- `src/code/game/g_combat.c` - the death intercept call site and the damage
  zeroing for frozen bodies.
- `src/code/cgame/cg_players.c`, `cg_effects.c`, `cg_localents.c`, `cg_event.c` -
  shell, shatter, ice trails/marks, thaw events.

## The two gates

Every freeze decision goes through one of these. **No raw `== GT_FREEZE` tests
anywhere else** - that inconsistency is precisely what makes QL-SRP hard to
follow (15 predicate calls against ~12 raw checks that bypass it).

- **`G_FreezeEnabled()`** - is the mechanic active at all. True for `GT_FREEZE`
  *or* the `g_freeze` cvar in any other gametype. This is our extension; QL's
  equivalent is literally `g_gametype.integer == GT_FREEZE`.
- **`G_FreezeIsNativeGametype()`** - is this the mode we owe QL behavioural
  parity. True only for `GT_FREEZE`. Used where QL's behaviour is a quirk of
  freeze being the *only* death state, which stops being true the moment freeze
  is switched on inside a gametype that has normal deaths and respawns.

## Ported faithfully

- **The frozen marker.** `ps.powerups[PW_NUM_POWERUPS] = INT_MAX` plus the
  entity-state bit, identical to QL-SRP `g_freeze.c:99-104`. No protocol change:
  `PW_NUM_POWERUPS` is 15, `MAX_POWERUPS` is 16, and
  `BG_PlayerStateToEntityState` propagates the whole array, so the marker reaches
  clients for free. We use `|=` rather than `=` on the entity state so a flag bit
  survives the same frame - moot either way, since that field is rebuilt from the
  playerstate every frame.
- **Environmental classification.** No attacker or a non-client attacker is
  environmental, and so is any death inside `CONTENTS_NODROP` however it got
  there. Same as QL-SRP `g_client.c:310-322, 425-430`.
- **Thaw line of sight.** `MASK_SOLID` ray from body to helper, same
  `fraction < 1.0f && entityNum != helper` test, same `g_freezeThawThroughSurface`
  escape hatch. QL-SRP `g_freeze.c:365`.
- **All 13 freeze cvars**, names and defaults.
- **Round structure shared with CA.** QL shares it too (`G_CAFZCheckExitRules`),
  so we reuse our own `Arena_*` layer rather than porting its 17-function
  duplicate.

## QL-SRP defects (verified - do not "restore" these)

QL-SRP is a decompilation. These are places it does not describe retail, and in
some cases does not compile:

- **Ice melt stages.** `cg_players.c:3327` picks `ice1/2/3` from
  `state->generic1 & 2` / `& 1`, but **nothing in its `g_freeze.c` ever writes
  `generic1`** - zero occurrences. Server-side that field is Harvester skulls and
  Red Rover infection. So retail-as-reconstructed always draws `ice3` and never
  melts. We carry thaw progress as a percentage in `s.time2` instead, which is
  free on players and only otherwise written by dropped items.
- **`thawThroughRespawn`.** `g_freeze.c:269` computes it from the frozen marker,
  which is unconditionally set at that point, so the `GibEntity( ent ); return;`
  branch always wins and the ~20 lines below it - health restore, armor, spawn
  protection, `EV_THAW_PLAYER`, `respawn1.wav` - are unreachable. It would gib
  every teammate thaw. The call is also `GibEntity( ent )` against
  `void GibEntity( gentity_t*, int )` with no prototype visible to that file, so
  it does not compile. **Not resurrected.** Best guess at intent is that the
  condition selected the environmental case; unverifiable, so not acted on.
- **`PM_FREEZE` early return in `PmoveSingle`**, which contradicts its own
  `PM_Friction` `PM_FREEZE` case in the same tree. Taking it produces zero-bbox
  ghosts. We removed it and run full physics on frozen bodies.
- **`EF_DEAD` as a thaw-progress carrier.** Cannot survive -
  `BG_PlayerStateToEntityState` rebuilds `EF_DEAD` from health every frame in
  both trees, and frozen players sit at health 1.

## Deliberate divergences

- **The gate is widened.** `g_freeze` can enable the mechanic in any gametype.
  QL has only `GT_FREEZE`. Everything QL has no opinion about takes our defaults.
- **Damage is zeroed late, not `takedamage = qfalse`.** QL's early return also
  kills the knockback, and a frozen body has to stay shovable. See the comment at
  the `take = 0` site. This is why frozen players are still `takedamage` true
  here, which matters for anything reading that field.
- **Environmental deaths outside `GT_FREEZE` kill outright.** In `GT_FREEZE` they
  freeze and recover on `g_freezeEnvironmentalRespawnDelay`, as QL does. In a
  gametype with normal respawns, freezing a body in the void would hand out a
  free life and strand it, so the death is left to the gametype's own machinery -
  out until round end in round-based modes, a normal respawn otherwise.
- **Frozen bodies are mortal to hazards outside `GT_FREEZE`**, same reasoning:
  otherwise a body pushed into lava is indestructible *and* unreachable, and only
  the 120-second auto-thaw ever resolves it.
- **Overhead marker.** QL floats an `RT_SPRITE` above frozen players. We have our
  own POI system and use it instead; the body shell is a `customShader` pass.

## Traps already paid for

Listed so they don't get reintroduced:

- **`FL_NO_KNOCKBACK`** is stamped by `G_Damage` one line before `die()` and
  cleared *only* by `ClientSpawn` - which a frozen player never reaches. Cleared
  explicitly on freeze, or the body absorbs every later hit.
- **`PMF_NOSHOOT`** is stamped by `ClientSpawn` for round-based gametypes and
  cleared only by `G_WarmupEnd` / `Arena_ThawWeapons`. Any mid-round respawn
  strands it. Now gated on `level.warmupTime != 0` as well as the cvar.
- **`Team_PlayerCountFighting`, never `...Alive`**, in round-end tests. Frozen
  players are health 1, so an alive-count round check never fires.
- **Round timeout** resolves on living count first, then health, never armor -
  and excludes frozen bodies from both tallies.
- **Hit sounds** need an explicit frozen exclusion; the `health > 0` test alone
  does not cover a body sitting at 1.
- **`GFACTORY_CVARS_COUNT`** must match the array by count, not by hope. It was
  104 against 111 entries, which silently made every freeze cvar non-functional
  as a factory cvar.

## Full-team freeze in the roundless team gametypes

Freezing a whole team is the point of the mechanic, and in `GT_FREEZE` or CA the
round layer resolves it: `Arena_CheckRules` ends the round and awards the win.
Switch `g_freeze` on in CTF, 1FCTF, Harvester, Obelisk, TDM, Domination and
there is no round to end. The wiped team simply stops existing until the
`g_freezeAutoThawTime` timer expires, and the side that pulled it off gets
nothing for it.

`G_FreezeCheckTeamWipe` is the filler rule for exactly those modes - ticked from
`G_RunFrame` beside `G_FreezeRunFrame`, gated on
`GT_IsTeam && !GT_IsRoundBased`. When a team has at least one frozen member and
nobody left fighting, frozen players are thawed per `g_freezeTeamWipeRespawn` and
the other side scores `g_freezeTeamWipeScore`. Respawn defaults to 2 and score to
1; either can be zeroed independently, and zeroing both disables the rule
outright.

`g_freezeTeamWipeRespawn` selects **who gets thawed**, clamped to 0-2:

| value | thaws |
|---|---|
| 0 | nobody - the wiped side waits out `g_freezeAutoThawTime` |
| 1 | the wiped side only |
| 2 | every frozen player, including the winning side's own (default) |

Mode 2 is the default because a wipe is a board reset, and leaving the winners'
frozen teammates iced through it is arbitrary - the wipe already resolved the
fight, so both sides should start the next one on even footing.

Details worth knowing:

- **The "at least one frozen" requirement is load-bearing.** Without it an empty
  team, or one that merely got shot rather than frozen, reads as wiped and scores
  for the other side every single frame.
- **A mutual wipe scores for nobody.** Both sides reset, no points - neither team
  did anything the other did not.
- **Scoring is latched per team** (`level.freezeTeamWipeScored`). With
  `g_freezeTeamWipeRespawn 0` the wiped team stays frozen, so the wipe condition
  stays true and an unlatched award would fire every frame forever. The latch
  clears the moment that team has somebody fighting again. Modes 1 and 2 clear
  the condition immediately, so mode 0 is the only one that actually needs it -
  don't drop the latch after testing only the other two.
- **It reuses the team score**, which in CTF is the capture count. That is a real
  conflation: a scoreboard showing 3 will not say whether that was three captures
  or two captures and a freeze-out. Living with it for now because the alternative
  is a separate per-team stat and a scoreboard column; revisit if these hybrid
  modes get played seriously.
- Attack&Defend and Red Rover are treated as roundless here because
  `GT_IsRoundBased` doesn't list them. If they ever gain real round structure
  they should move to the round path and out of this rule.

## Beyond QL: proposed cvar expansion

None of these exist yet. Listed as proposals, in rough order of how much they'd
actually buy.

### `g_freezeMortalBodies` - the one that matters

**Can the world destroy a frozen body?**

- `0` - no. Indestructible; hazards do nothing; recovery is by timer only. This
  is QL, and would be the `GT_FREEZE` default.
- `1` - yes. Hazard damage kills the body, environmental deaths kill outright,
  normal death rules apply. Would be the default everywhere else.

This is worth calling out because **it could replace the `GT_FREEZE` split
entirely.** Right now `G_FreezeIsNativeGametype()` is consulted at two call sites
(`g_combat.c` damage zeroing, `g_freeze.c` death intercept) and both are asking
the same question in different words: *is a frozen body destructible?* Turn that
into one cvar whose **default is derived from the gametype at level load**, and
the branching collapses - the code reads a cvar, the gametype test happens once
in a defaults table instead of at every decision point, and a server can pick
either behaviour in either mode. That is strictly better than what we have, and
the only reason it isn't done is that the split earned its keep first.

Naming note: `g_freezeGibVoided` was the working name, but it's too narrow on
both axes - it names one *disposal method* (gib) and one *hazard* (the void),
while the real question covers lava, crushers, trigger_hurt and any future
hazard, and the disposal method should just be whatever the gametype already does
to a corpse. `g_freezeMortalBodies` says the actual thing.

### Flag handling on freeze

Freezing drops any carried flag (`G_FreezeDropFlags`), because the death
intercept returns before `player_die` reaches `TossClientItems` and an ice statue
holding the enemy flag for a whole round is not a mechanic anyone asked for. It
mirrors `player_die`: drop it where the body fell, or return it outright if the
body is in a `CONTENTS_NODROP` volume.

Note this only matters for our extension - QL has no Freeze-CTF, so retail never
had to answer it. The behaviour is a choice, and *drop* was chosen because it is
what a normal death does.

**Proposal, out of scope here but adjacent:** alongside bringing `g_dropWeapon`
and `g_dropPowerups` in line with QL, the same question deserves a knob for
flags - `g_dropFlag` / `g_returnFlag`, or one tri-state - covering drop where you
died, return to base immediately, or keep the current split where nodrop returns
and everywhere else drops. Whatever shape it takes it belongs with the other two
drop cvars rather than in the freeze block, since it is a CTF rule that freeze
merely happens to trigger. Freeze would then just call it instead of deciding for
itself.

### Smaller knobs, all currently hardcoded

- **`g_freezeBodyFriction`** - the frozen-body slide. Hardcoded `0.25` in
  `PM_Friction` to match retail. Cheap to expose, immediately felt.
- **`g_freezeThawRate`** - ms of thaw credited per helper per frame. Currently
  `level.msec * helpers`, i.e. strictly linear in helper count.
- **`g_freezeMaxHelpers`** - cap on that multiplier, so a five-man stack doesn't
  thaw in a fifth of the time.
- **`g_freezeRefreezeRate`** - the ice creeping back when helpers leave.
  Currently `level.msec`, exactly the solo thaw rate.
- **`g_freezeShellStages`** - the melt is three stages because retail ships three
  shaders. Nothing in the code cares about the number except the thresholds.
- **`g_freezeThawOnLastAlive`** - auto-thaw a team's last frozen player when they
  would otherwise be a guaranteed loss. Pure invention, but the kind of thing
  that makes small-server FT less miserable.
