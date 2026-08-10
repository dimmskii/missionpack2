// g_freeze.c -- Freeze Tag mechanic
//
// By Dimmskii
//
// Ported down from QL-SRP's g_freeze.c, reduced to the core freeze/thaw model.
// Two deliberate departures from QL-SRP:
//
//   1. The mechanic is gated on G_FreezeEnabled() (gametype GT_FREEZE OR the
//      g_freeze cvar), never on the gametype directly, so freeze can be switched
//      on inside any round-based gametype.
//   2. The round lifecycle is NOT ported. QL-SRP carries its own 17-function
//      round layer in g_active.c; we drive freeze from the existing Arena_*
//      round flow in g_newgame.c instead, which QL-SRP effectively does too
//      (its G_CAFZCheckExitRules shares Clan Arena and Freeze logic).
//
// A frozen player stays *alive* at health 1 and keeps normal physics - they
// collide, fall, slide under friction and can be pushed, but cannot drive
// themselves, because ClientThink_real strips their movement input. See the
// note there for why it is done that way.
//
// The client learns someone is frozen from the PW_NUM_POWERUPS marker bit
// mirrored into ps.powerups / s.powerups, so nothing here touches protocol.

#include "g_local.h"

// Freeze Tag tracing is compiled out unless the module is built -DDEBUG (CMake
// -DQ3_DEBUG_VM=ON, or debug.bat), the same switch ai_cmd.c has always used.
// Kept in rather than stripped after bring-up: the freeze/thaw state machine is
// invisible from the console otherwise, and these are the exact prints that were
// used to verify it. Written as plain #ifdef blocks, not a variadic macro -
// q3lcc is C89-era and nothing else in the tree relies on __VA_ARGS__.


/*
=============
G_FreezeSetClientFrozenPowerupMarker

Mirrors the synthetic frozen marker through the playerstate and the entitystate
so the client can render a frozen player without a new protocol field.
=============
*/
static void G_FreezeSetClientFrozenPowerupMarker( gentity_t *ent, qboolean frozen ) {
	if ( !ent || !ent->client ) {
		return;
	}

	if ( frozen ) {
		ent->client->ps.powerups[PW_NUM_POWERUPS] = INT_MAX;
		ent->s.powerups |= ( 1 << PW_NUM_POWERUPS );
		ent->s.time2 = 100;
	} else {
		ent->client->ps.powerups[PW_NUM_POWERUPS] = 0;
		ent->s.powerups &= ~( 1 << PW_NUM_POWERUPS );
		ent->s.time2 = 0;
	}
}

/*
=============
G_FreezeThawTotal

Thaw duration in ms, with QL-SRP's fallback when the cvar is unset.
=============
*/
static int G_FreezeThawTotal( void ) {
	int		thawTime;

	thawTime = g_freezeThawTime.integer;
	if ( thawTime <= 0 ) {
		thawTime = 2000;
	}

	return thawTime;
}

/*
=============
G_FreezeUpdateThawProgress

Publishes thaw remaining as 0-100 so the client can pick a shell stage.

QL buckets this into thirds on ps.eFlags using EF_DEAD and EF_TICKING, but
BG_PlayerStateToEntityState rebuilds EF_DEAD from health every frame and a frozen
player has health 1, so that bit never survives to other clients. time2 is unused
on player entitystates and carries the same three buckets intact.
=============
*/
static void G_FreezeUpdateThawProgress( gentity_t *ent, int thawTotal ) {
	int		remaining;

	if ( !ent || !ent->client || thawTotal <= 0 ) {
		return;
	}

	remaining = ent->client->freezeThawTimeRemaining;
	if ( remaining < 0 ) {
		remaining = 0;
	} else if ( remaining > thawTotal ) {
		remaining = thawTotal;
	}

	ent->s.time2 = ( remaining * 100 ) / thawTotal;
}

/*
=============
G_FreezeIsFrozen

The one question the rest of the game asks. Safe on any entity.
=============
*/
qboolean G_FreezeIsFrozen( const gentity_t *ent ) {
	if ( !ent || !ent->client ) {
		return qfalse;
	}
	return ent->client->freezeFrozen;
}

/*
=============
G_FreezeInitClient

Clears frozen state without emitting any thaw effects. Used on spawn and round
start, where the player is being rebuilt rather than rescued.
=============
*/
void G_FreezeInitClient( gentity_t *ent ) {
	gclient_t	*client;

	if ( !ent || !ent->client ) {
		return;
	}

	client = ent->client;
	client->freezeFrozen = qfalse;
	client->freezeTime = 0;
	client->freezeThawTimeRemaining = 0;
	client->freezeLastHelper = -1;
	client->freezeAutoThawTime = 0;
	client->freezeEnvRespawnTime = 0;

	G_FreezeSetClientFrozenPowerupMarker( ent, qfalse );
}

/*
=============
G_FreezeAwardThawAssist

Credits the player who completed the thaw. thawsReceived is tracked on the
thawed player so a scoreboard can show both sides later if we want it.
=============
*/
static void G_FreezeAwardThawAssist( gentity_t *ent, int helperNum ) {
	gentity_t	*helper;

	if ( ent && ent->client ) {
		ent->client->matchStats.thawsReceived++;
	}

	if ( helperNum < 0 || helperNum >= level.maxclients ) {
		return;
	}

	helper = &g_entities[helperNum];
	if ( !helper->inuse || !helper->client ) {
		return;
	}

	helper->client->matchStats.thawsGiven++;
}

/*
=============
G_FreezeFreezeClient

Death replacement: the player is immobilised instead of killed. Health stays at
1 rather than 0 so nothing in the codebase mistakes a frozen player for a corpse.
=============
*/
void G_FreezeFreezeClient( gentity_t *ent, qboolean environmental ) {
	gclient_t	*client;
	int			thawTime;

	if ( !ent || !ent->client ) {
		return;
	}

	client = ent->client;
	if ( client->freezeFrozen ) {
		return;
	}

	client->freezeFrozen = qtrue;
	client->freezeTime = level.time;
	client->freezeLastHelper = -1;
	client->matchStats.timesFrozen++;

	thawTime = g_freezeThawTime.integer;
	if ( thawTime <= 0 ) {
		thawTime = 3000;
	}
	client->freezeThawTimeRemaining = thawTime;

	client->freezeAutoThawTime = 0;
	if ( g_freezeAutoThawTime.integer > 0 ) {
		client->freezeAutoThawTime = level.time + g_freezeAutoThawTime.integer;
	}

	// An environmental freeze (lava, void, crusher) is unreachable by definition -
	// nobody can walk over there to thaw it - so it respawns on its own instead of
	// deadlocking the round. QL-SRP does the same via environmentalRespawnDelay.
	client->freezeEnvRespawnTime = 0;
	if ( environmental && g_freezeEnvironmentalRespawnDelay.integer > 0 ) {
		client->freezeEnvRespawnTime = level.time + g_freezeEnvironmentalRespawnDelay.integer;
	}

	G_FreezeSetClientFrozenPowerupMarker( ent, qtrue );

#ifdef DEBUG
	G_Printf( "[FZ] froze client %i, thaw needs %i ms\n",
		(int)( ent - g_entities ), client->freezeThawTimeRemaining );
#endif

	// PM_FREEZE no longer returns early out of PmoveSingle, so the body still ducks,
	// falls and slides - it just can't drive itself. ClientThink_real re-asserts this
	// every frame; setting it here makes the freeze take effect on the same frame.
	client->ps.pm_type = PM_FREEZE;

	client->ps.eFlags &= ~( EF_DEAD | EF_TICKING );
	ent->health = 1;
	client->ps.stats[STAT_HEALTH] = 1;

	// takedamage stays on so knockback still applies; G_Damage zeroes the actual
	// health loss for frozen players. Momentum is left alone so the body carries
	// on and settles under friction rather than stopping dead in the air.
}

/*
=============
G_FreezeThawClient

Restores a frozen player in place. wasAuto suppresses the reward/effects for
timer-driven thaws, matching QL-SRP.
=============
*/
void G_FreezeThawClient( gentity_t *ent, qboolean wasAuto, int helperNum ) {
	gclient_t	*client;
	gentity_t	*tent;

	if ( !ent || !ent->client || !ent->client->freezeFrozen ) {
		return;
	}

	client = ent->client;
	client->freezeFrozen = qfalse;
	client->freezeTime = 0;
	client->freezeThawTimeRemaining = 0;
	client->freezeLastHelper = -1;
	client->freezeAutoThawTime = 0;
	client->freezeEnvRespawnTime = 0;

	G_FreezeSetClientFrozenPowerupMarker( ent, qfalse );

	client->ps.pm_type = PM_NORMAL;
	client->ps.eFlags &= ~( EF_DEAD | EF_TICKING );
	ent->takedamage = qtrue;

	ent->health = client->ps.stats[STAT_MAX_HEALTH];
	client->ps.stats[STAT_HEALTH] = ent->health;

	if ( !wasAuto ) {
		G_FreezeAwardThawAssist( ent, helperNum );
	}

	tent = G_TempEntity( client->ps.origin, EV_THAW_PLAYER );
	tent->s.otherEntityNum = ent->s.number;

#ifdef DEBUG
	G_Printf( "[FZ] thawed client %i by %i (auto %i)\n",
		(int)( ent - g_entities ), helperNum, wasAuto );
#endif
}

/*
=============
G_FreezeThawWinningTeam

Round end: the winners' frozen players are thawed and respawned as part of
winning, rather than waiting for the round reset. Mirrors QL-SRP's
G_FreezeThawWinningPlayers, gated the same way on g_freezeThawWinningTeam.
=============
*/
void G_FreezeThawWinningTeam( team_t winner ) {
	int			i;
	gentity_t	*ent;

	if ( !G_FreezeEnabled() || !g_freezeThawWinningTeam.integer ) {
		return;
	}
	if ( winner != TEAM_RED && winner != TEAM_BLUE ) {
		return;
	}

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		ent = &g_entities[i];
		if ( !ent->inuse || !ent->client ) {
			continue;
		}
		if ( ent->client->sess.sessionTeam != winner ) {
			continue;
		}
		if ( !ent->client->freezeFrozen ) {
			continue;
		}

		// respawn rather than thaw in place: QL puts the winners back on spawn
		// points ready for the next round, not wherever they were frozen
		G_FreezeInitClient( ent );
		respawn( ent );
#ifdef DEBUG
		G_Printf( "[FZ] round win thaw+respawn client %i\n", i );
#endif
	}
}

/*
=============
G_FreezeClientCanHelpThaw

A helper must be a live, unfrozen, non-spectating teammate within the thaw
radius. Non-team gametypes running g_freeze have everyone on TEAM_FREE, so the
team test degrades to "anybody", which is the sane reading there.
=============
*/
static qboolean G_FreezeClientCanHelpThaw( const gentity_t *ent, const gentity_t *helper, float thawRadiusSq ) {
	vec3_t	delta;

	if ( !helper->inuse || !helper->client || helper == ent ) {
		return qfalse;
	}
	if ( helper->client->pers.connected != CON_CONNECTED ) {
		return qfalse;
	}
	if ( helper->client->sess.sessionTeam == TEAM_SPECTATOR ) {
		return qfalse;
	}
	if ( helper->client->freezeFrozen || helper->health <= 0 ) {
		return qfalse;
	}
	if ( helper->client->sess.sessionTeam != ent->client->sess.sessionTeam ) {
		return qfalse;
	}

	VectorSubtract( helper->client->ps.origin, ent->client->ps.origin, delta );
	if ( VectorLengthSquared( delta ) > thawRadiusSq ) {
		return qfalse;
	}

	return qtrue;
}

/*
=============
G_FreezeCountThawHelpers

Number of teammates currently thawing this player; helperOut receives one of
them so the thaw can be credited. More helpers thaw proportionally faster.
=============
*/
static int G_FreezeCountThawHelpers( const gentity_t *ent, int *helperOut ) {
	int			i, count;
	float		radius, radiusSq;
	gentity_t	*helper;

	count = 0;
	if ( helperOut ) {
		*helperOut = -1;
	}

	radius = (float)g_freezeThawRadius.integer;
	if ( radius <= 0.0f ) {
		radius = 96.0f;
	}
	radiusSq = radius * radius;

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		helper = &g_entities[i];
		if ( !G_FreezeClientCanHelpThaw( ent, helper, radiusSq ) ) {
			continue;
		}
		count++;
		if ( helperOut && *helperOut < 0 ) {
			*helperOut = i;
		}
	}

	return count;
}

/*
=============
G_FreezeRunFrame

Ticks every frozen client: nearby teammates burn down the thaw timer, and the
optional auto-thaw fires on its own. Called once per server frame; cheap enough
to run unconditionally because it exits immediately when nobody is frozen.
=============
*/
void G_FreezeRunFrame( void ) {
	int			i, helpers, helperNum;
	int			thawTotal, oldSec, newSec;
	gentity_t	*ent;
	gclient_t	*client;

	if ( !G_FreezeEnabled() ) {
		return;
	}

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		ent = &g_entities[i];
		if ( !ent->inuse || !ent->client ) {
			continue;
		}

		client = ent->client;
		if ( !client->freezeFrozen ) {
			continue;
		}

		// an environmentally frozen body is unreachable - respawn it outright
		// rather than thawing it in place inside the lava it died in
		if ( client->freezeEnvRespawnTime > 0 && level.time >= client->freezeEnvRespawnTime ) {
			G_FreezeInitClient( ent );
			respawn( ent );
#ifdef DEBUG
			G_Printf( "[FZ] env respawn client %i\n", (int)( ent - g_entities ) );
#endif
			continue;
		}

		// auto-thaw is a safety valve for a stranded frozen player
		if ( client->freezeAutoThawTime > 0 && level.time >= client->freezeAutoThawTime ) {
			G_FreezeThawClient( ent, qtrue, -1 );
			continue;
		}

		thawTotal = G_FreezeThawTotal();
		if ( client->freezeThawTimeRemaining <= 0 || client->freezeThawTimeRemaining > thawTotal ) {
			client->freezeThawTimeRemaining = thawTotal;
		}

		helpers = G_FreezeCountThawHelpers( ent, &helperNum );
		if ( helpers > 0 ) {
			oldSec = client->freezeThawTimeRemaining / 1000;

			client->freezeLastHelper = helperNum;
			client->freezeThawTimeRemaining -= level.msec * helpers;

			if ( client->freezeThawTimeRemaining <= 0 ) {
				G_FreezeThawClient( ent, qfalse, helperNum );
				continue;
			}

			// one tick per whole second crossed, matching QL-SRP
			newSec = client->freezeThawTimeRemaining / 1000;
			if ( oldSec > 0 && oldSec != newSec ) {
				gentity_t *tent = G_TempEntity( client->ps.origin, EV_THAW_TICK );
				tent->s.otherEntityNum = ent->s.number;
			}
		} else {
			// nobody helping, so the ice creeps back rather than a half-done thaw
			// sitting there indefinitely. QL-SRP regenerates at the same rate.
			client->freezeLastHelper = -1;
			client->freezeThawTimeRemaining += level.msec;
			if ( client->freezeThawTimeRemaining > thawTotal ) {
				client->freezeThawTimeRemaining = thawTotal;
			}
		}

		G_FreezeUpdateThawProgress( ent, thawTotal );
	}
}

/*
=============
G_FreezeHandlePlayerDeath

Death intercept. Returns qtrue when the death was converted into a freeze, in
which case the caller must not run the normal death path at all.

Environmental deaths (lava, void, crushing) still kill outright - freezing a
player inside a hazard would strand them there permanently with no way for a
teammate to reach them.
=============
*/
qboolean G_FreezeHandlePlayerDeath( gentity_t *self, gentity_t *attacker, int meansOfDeath ) {
	qboolean	environmental;

	if ( !G_FreezeEnabled() ) {
		return qfalse;
	}
	if ( !self || !self->client ) {
		return qfalse;
	}
	if ( self->client->sess.sessionTeam == TEAM_SPECTATOR ) {
		return qfalse;
	}
	// already frozen: a frozen player takes no damage, but be defensive
	if ( self->client->freezeFrozen ) {
		return qtrue;
	}

	// EVERY death freezes, including lava, void and suicide - matching QL-SRP,
	// which classifies rather than excludes. A death with no player attacker is
	// environmental, and so is any death inside a NODROP volume (the void), since
	// a body there is unreachable however it got there. Environmental freezes are
	// respawned on a timer by G_FreezeRunFrame instead of waiting for a thaw that
	// can never come.
	environmental = qfalse;
	if ( !attacker || !attacker->client ) {
		environmental = qtrue;
	}
	if ( trap_PointContents( self->r.currentOrigin, -1 ) & CONTENTS_NODROP ) {
		environmental = qtrue;
	}

#ifdef DEBUG
	G_Printf( "[FZ] death->freeze: client %i mod %i env %i (gt %i, g_freeze %i)\n",
		(int)( self - g_entities ), meansOfDeath, environmental,
		g_gametype.integer, g_freeze.integer );
#endif

	G_FreezeFreezeClient( self, environmental );

	// keep the killer's credit identical to a normal frag
	if ( attacker && attacker->client && attacker != self ) {
		attacker->client->lastkilled_client = self->s.number;
	}

	return qtrue;
}
