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
	} else {
		ent->client->ps.powerups[PW_NUM_POWERUPS] = 0;
		ent->s.powerups &= ~( 1 << PW_NUM_POWERUPS );
	}
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
void G_FreezeFreezeClient( gentity_t *ent ) {
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

	G_FreezeSetClientFrozenPowerupMarker( ent, qtrue );

#ifdef DEBUG
	G_Printf( "[FZ] froze client %i, thaw needs %i ms\n",
		(int)( ent - g_entities ), client->freezeThawTimeRemaining );
#endif

	// pm_type is left alone on purpose - immobilisation is done by stripping input
	// in ClientThink_real, so physics keep running. See the note at that strip.
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

	G_FreezeSetClientFrozenPowerupMarker( ent, qfalse );

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

		// auto-thaw is a safety valve for a stranded frozen player
		if ( client->freezeAutoThawTime > 0 && level.time >= client->freezeAutoThawTime ) {
			G_FreezeThawClient( ent, qtrue, -1 );
			continue;
		}

		helpers = G_FreezeCountThawHelpers( ent, &helperNum );
		if ( helpers <= 0 ) {
			continue;
		}

		client->freezeLastHelper = helperNum;
		client->freezeThawTimeRemaining -= level.msec * helpers;

		if ( client->freezeThawTimeRemaining <= 0 ) {
			G_FreezeThawClient( ent, qfalse, helperNum );
			continue;
		}

		// let the thawee (and onlookers) see progress
		if ( ( level.time % 500 ) < level.msec ) {
			gentity_t *tent = G_TempEntity( client->ps.origin, EV_THAW_TICK );
			tent->s.otherEntityNum = ent->s.number;
		}
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

	switch ( meansOfDeath ) {
	case MOD_WATER:
	case MOD_SLIME:
	case MOD_LAVA:
	case MOD_CRUSH:
	case MOD_FALLING:
	case MOD_SUICIDE:
	case MOD_TRIGGER_HURT:
		return qfalse;
	default:
		break;
	}

#ifdef DEBUG
	G_Printf( "[FZ] death->freeze: client %i mod %i (gt %i, g_freeze %i)\n",
		(int)( self - g_entities ), meansOfDeath, g_gametype.integer, g_freeze.integer );
#endif

	G_FreezeFreezeClient( self );

	// keep the killer's credit identical to a normal frag
	if ( attacker && attacker->client && attacker != self ) {
		attacker->client->lastkilled_client = self->s.number;
	}

	return qtrue;
}
