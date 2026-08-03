#include "g_local.h"

/*
=================
G_ApplyFactory

Resets every GFACTORY_CVARS entry to its registered default, then overlays
this factory's specific cvar_values on top. The reset pass means switching
factories never leaves a cvar the new factory doesn't mention stuck at
whatever the previously applied factory left it at.
=================
*/
static void G_ApplyFactory( const gfactory_t *factory ) {
	int i;
	if ( !factory ) {
		return;
	}
	Com_Printf( "G_ApplyFactory: applying '%s' (%s)\n", factory->id, factory->title );

	for ( i = 0; i < GFACTORY_CVARS_COUNT; i++ ) {
		const char *defaultString = G_GetCvarDefaultString( GFACTORY_CVARS[i] );
		if ( defaultString ) {
			trap_Cvar_Set( GFACTORY_CVARS[i], defaultString );
		} else {
			Com_Printf( "G_ApplyFactory: no registered default for gfactory cvar '%s'.\n", GFACTORY_CVARS[i] );
		}
	}

	for ( i = 0; i < GFACTORY_CVARS_COUNT; i++ ) {
		if ( factory->cvar_values[i] != NULL ) {
			trap_Cvar_Set( GFACTORY_CVARS[i], factory->cvar_values[i] );
		}
	}
}

/*
=================
G_ApplySelectedFactory

Looks up whichever factory g_factory currently names (falling back to
bg_factories[0] if it doesn't match any loaded factory) and applies it via
G_ApplyFactory. Split out from G_LoadFactories so this "which factory does
g_factory name right now, and apply it" step can be re-run on its own
later (e.g. after g_factory changes mid-game) without repeating the full
file load/parse/inheritance pass.
=================
*/
void G_ApplySelectedFactory( void ) {
	// g_factory is CVAR_LATCH - like g_gametype, a change only takes effect
	// on the next map init. Force the register here (ahead of
	// G_RegisterCvars(), which runs after G_LoadFactories) so
	// g_factory.string is actually populated with either the engine's
	// already-set value (server.cfg/+set) or the "ffa" default - reading it
	// before any registration would just see an empty, unregistered cvar.
	trap_Cvar_Register( &g_factory, "g_factory", "ffa", CVAR_SERVERINFO | CVAR_USERINFO | CVAR_LATCH );

	// An empty g_factory means "just expose the parsed factory list (e.g.
	// for the UI's host game screen), don't force any cvars" - under no
	// circumstance do we touch any cvar in that case.
	if ( !g_factory.string[0] ) {
		Com_Printf( "G_ApplySelectedFactory: g_factory is empty, skipping factory application.\n" );
		return;
	}

	if ( bg_numFactories > 0 ) {
		gfactory_t *selected = BG_FindFactoryById( g_factory.string );
		if ( !selected ) {
			Com_Printf( "G_ApplySelectedFactory: g_factory '%s' not found, defaulting to '%s'.\n",
			            g_factory.string, bg_factories[0].id );
			selected = &bg_factories[0];
		}
		G_ApplyFactory( selected );
	}
}

/*
=================
G_LoadFactories

Canonical server-side (re-)load entrypoint. The actual file reading,
parsing, and basegt inheritance resolution now live in bg_newgame.c/.h as
shared, module-agnostic machinery (BG_LoadFactoriesFile,
BG_ResolveFactoryInheritance) - this just scans scripts/*.factories
(trap_FS_GetFileList isn't available to cgame, so that scan can't live in
bg_newgame.c) and then applies whatever g_factory currently selects.
=================
*/
void G_LoadFactories( void ) {
	char dirlist[4096];
	char *dirptr;
	char filename[128];
	int numdirs, dirlen, i;

	bg_numFactories = 0;

	BG_LoadFactoriesFile( "scripts/factories.txt" );

	// Third-party/add-on factory definitions: any scripts/*.factories file
	// gets parsed and appended after the base list. Load order (whatever
	// the engine's directory listing gives, alphabetical in practice)
	// doesn't matter for correctness - BG_ResolveFactoryInheritance below
	// is a second pass over the fully combined list, run once everything
	// from every file has been loaded.
	numdirs = trap_FS_GetFileList( "scripts", ".factories", dirlist, sizeof( dirlist ) );
	dirptr = dirlist;
	for ( i = 0; i < numdirs; i++, dirptr += dirlen + 1 ) {
		dirlen = (int)strlen( dirptr );
		Com_sprintf( filename, sizeof( filename ), "scripts/%s", dirptr );
		BG_LoadFactoriesFile( filename );
	}

	// Second pass: every factory from every file is loaded now, so basegt
	// inheritance can be resolved (a basegt may name a factory that
	// appears later or in a different file, or one that itself still
	// needs its own basegt resolved first).
	BG_ResolveFactoryInheritance();

	Com_Printf( "G_LoadFactories: %d factories loaded.\n", bg_numFactories );

	G_ApplySelectedFactory();
}




// ARENA / CA GAMETYPE LOGIC


void Arena_BeginRound( void ) {
	int			i;
	gclient_t	*client;

	// Reset spectator follow state for dead arena players before respawning
	for ( i = 0; i < level.maxclients; i++ ) {
		client = &level.clients[i];
		if ( client->pers.connected != CON_CONNECTED ) {
			continue;
		}
		if ( client->sess.sessionTeam == TEAM_SPECTATOR ) {
			continue;
		}
		client->sess.spectatorState = SPECTATOR_NOT;
		client->sess.spectatorClient = i;
		client->ps.pm_flags &= ~PMF_FOLLOW;
	}

	// Begin new round code
	level.warmupTime = level.time + g_warmup.integer * 1000;
	trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
// ~Dimmskii
	level.roundNumber++;
	trap_SetConfigstring( CS_ROUND_NUMBER, va("%i", level.roundNumber) );
// END Dimmskii

	respawnAll();
	CalculateRanks(); // Make sure scoreboard is sorted immediately? -- AKA Fix my scores please fresh out of spec mod
}

/*
=============
Arena_ResetMatchScores

Wipes match scoring when a segment ends - the server drops below two players and
CheckTournament falls back to "Waiting for players", so whatever was being played
is abandoned. G_WarmupEnd can't do this for arena the way it does for every other
gametype: it runs at the end of EVERY round's warmup, so resetting there would
stop anyone ever accumulating round wins.

CalculateRanks re-publishes CS_SCORES1/2 itself, correctly for both the team and
non-team cases, so don't set those configstrings here.
=============
*/
void Arena_ResetMatchScores( void ) {
	int			i;
	gclient_t	*client;

	memset( level.teamScores, 0, sizeof( level.teamScores ) );

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		client = level.clients + i;
		if ( client->pers.connected == CON_DISCONNECTED ) {
			continue;
		}
		client->ps.persistant[PERS_ROUNDWINS] = 0;
		client->ps.persistant[PERS_SCORE] = 0;
		client->ps.persistant[PERS_CAPTURES] = 0;
		client->ps.persistant[PERS_IMPRESSIVE_COUNT] = 0;
		client->ps.persistant[PERS_EXCELLENT_COUNT] = 0;
		client->ps.persistant[PERS_DEFEND_COUNT] = 0;
		client->ps.persistant[PERS_ASSIST_COUNT] = 0;
		client->ps.persistant[PERS_GAUNTLET_FRAG_COUNT] = 0;
	}

	CalculateRanks();
}

/*
=============
Arena_ThawWeapons

Lifts the weapon freeze while no round is running. Counterpart to
Arena_FreezeSurvivorWeapons - see the call in Arena_CheckRules for why it runs
per frame instead of once.
=============
*/
void Arena_ThawWeapons( void ) {
	int			i;
	gclient_t	*client;

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		client = level.clients + i;
		if ( client->pers.connected != CON_CONNECTED ) {
			continue;
		}
		if ( client->sess.sessionTeam == TEAM_SPECTATOR ) {
			continue;
		}
		client->ps.pm_flags &= ~PMF_NOSHOOT;
	}
}

/*
=============
Arena_FreezeSurvivorWeapons

Round decided: take weapons away from everyone still alive so nobody can shoot
during the ARENA_ROUND_DELAY_TIME gap before the next round starts. Cleared
again by G_WarmupEnd when the new round goes live.
=============
*/
void Arena_FreezeSurvivorWeapons( void ) {
	int			i;
	gentity_t	*ent;

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		ent = g_entities + i;
		if ( !ent->inuse || !ent->client ) {
			continue;
		}
		if ( ent->client->pers.connected != CON_CONNECTED ) {
			continue;
		}
		if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
			continue;
		}
		if ( ent->health <= 0 ) {
			continue;
		}
		ent->client->ps.pm_flags |= PMF_NOSHOOT;
	}
}

vec3_t zeroVec3 = {0, 0, 0};
void Arena_EndRound( team_t winningTeam ) {

	Arena_FreezeSurvivorWeapons();

	if ( winningTeam == TEAM_RED || winningTeam == TEAM_BLUE ) { // CA
		AddTeamScore(zeroVec3, winningTeam, 1);
		trap_SetConfigstring( CS_SCORES1, va("%i", level.teamScores[TEAM_RED]) );
		trap_SetConfigstring( CS_SCORES2, va("%i", level.teamScores[TEAM_BLUE]) );
		CalculateRanks(); // Make sure clan arena scoreboard is sorted immediately
	} else if ( winningTeam != TEAM_SPECTATOR ) { // FFA
		int			i, aliveCount;
		gentity_t	*clientEnt;
		gentity_t	*clientEntWon;
	
		// Loop through all clients
		aliveCount = 0;
		for ( i = 0 ; i < level.maxclients ; i++ ) {
			clientEnt = g_entities + i;
			if ( !clientEnt->inuse )
				continue;
			
			// If not spectator and alive, add arena score
			if ( clientEnt->client->sess.sessionTeam != TEAM_SPECTATOR && clientEnt->health > 0 ) {
				clientEntWon = clientEnt;
				aliveCount ++;
			}
		}
		
		if (aliveCount == 1) { // We only award FFA arena point if exactly one person remains in the round (to conider: we assume it's a timeout draw otherwise)
			clientEntWon->client->ps.persistant[PERS_ROUNDWINS] ++;
			//clientEntWon->client->ps.persistant[PERS_CAPTURES] ++; // Temp hack to display
			CalculateRanks(); // Make sure FFA arena scoreboard is sorted immediately
			if ( g_roundlimit.integer ) {
				if ( clientEntWon->client->ps.persistant[PERS_ROUNDWINS] >= g_roundlimit.integer ) {
					level.arenaRoundQueued = level.time; // Stops CheckExitRules from re-triggering the round timeout every frame
					return; // Round enqueue after winning preventative measure
				}
			}
		}
	}
	
	if ( g_roundlimit.integer ) {
		if ( level.teamScores[TEAM_RED] >= g_roundlimit.integer || level.teamScores[TEAM_BLUE] >= g_roundlimit.integer ) {
			level.arenaRoundQueued = level.time; // Stops CheckExitRules from re-triggering the round timeout every frame
			return; // Round enqueue after winning preventative measure
		}
	}
	
	level.arenaRoundQueued = level.time;
	
}

void Arena_TimeoutRound( void ) {
	int totalRed, totalBlue;
	
	totalRed = Team_CountTotalHealth(TEAM_RED,qfalse)+Team_CountTotalArmor(TEAM_RED,qfalse);
	totalBlue = Team_CountTotalHealth(TEAM_BLUE,qfalse)+Team_CountTotalArmor(TEAM_BLUE,qfalse);
	
	// Decided Team Arena round end
	if ( totalRed > totalBlue ) {
		Arena_EndRound( TEAM_RED );
		return;
	} else if ( totalBlue > totalRed ) {
		Arena_EndRound( TEAM_BLUE );
		return;
	}
	
	Arena_EndRound( TEAM_FREE ); // FFA Arena and undecided Team Arena round end
}

/*
=============
Arena_MatchDecided

True once a side/player has already reached g_roundlimit. Lets callers in the
round-timeout path know the match outcome is final so they don't keep
re-triggering round-end logic (and re-broadcasting/re-scoring) while waiting
for CheckExitRules to queue the intermission.
=============
*/
qboolean Arena_MatchDecided( void ) {
	if ( !g_roundlimit.integer ) {
		return qfalse;
	}

	if ( g_gametype.integer == GT_ARENA ) {
		int			i;
		gclient_t	*cl;

		for ( i = 0 ; i < level.maxclients ; i++ ) {
			cl = level.clients + i;
			if ( cl->pers.connected != CON_CONNECTED ) {
				continue;
			}
			if ( cl->sess.sessionTeam != TEAM_FREE ) {
				continue;
			}
			if ( cl->ps.persistant[PERS_ROUNDWINS] >= g_roundlimit.integer ) {
				return qtrue;
			}
		}
		return qfalse;
	} else if ( g_gametype.integer == GT_CLAN_ARENA || g_gametype.integer == GT_FREEZE ) {
		return ( level.teamScores[TEAM_RED] >= g_roundlimit.integer || level.teamScores[TEAM_BLUE] >= g_roundlimit.integer );
	}

	return qfalse;
}

/*
=============
Arena_ForceRespawnDead

Round-start revive: anyone still dead goes straight back in, ignoring
respawnTime / g_forcerespawn / attack-button gating (all of which live in
ClientThink_real, not respawn()). A round must never begin with a player dead -
they'd lose it without ever playing it. Only the dead are touched, so living
players keep the positions they held during warmup.
=============
*/
void Arena_ForceRespawnDead( void ) {
	int			i;
	gentity_t	*ent;

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		ent = g_entities + i;
		if ( !ent->inuse || !ent->client ) {
			continue;
		}
		if ( ent->client->pers.connected != CON_CONNECTED ) {
			continue;
		}
		if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
			continue;
		}
		if ( ent->health > 0 ) {
			continue;
		}
		respawn( ent );
	}
}

void Arena_CheckRules( void ) {
	// "Waiting for players": no round is running, so nothing should be holding a
	// weapon freeze. ClientSpawn re-sets PMF_NOSHOOT on every spawn and
	// G_WarmupEnd - the only place it is cleared - is unreachable while waiting,
	// so this has to run per frame rather than once on the transition.
	if ( level.warmupTime < 0 ) {
		Arena_ThawWeapons();
	}

	if ( level.warmupTime || level.intermissiontime || level.intermissionQueued ) {
		return;
	}
	
	if ( level.numPlayingClients < 2 ) {
		return;
	}
	
	if ( level.arenaRoundQueued ) {
		if ( level.time - level.arenaRoundQueued >= ARENA_ROUND_DELAY_TIME ) {
			// Don't spin up a new round once the match is already decided;
			// CheckExitRules will queue the intermission shortly.
			if ( Arena_MatchDecided() ) {
				return;
			}
			level.arenaRoundQueued = 0;
			Arena_BeginRound();
		}
		return;
	}
	
	if ( g_gametype.integer == GT_ARENA ) {
		// Check if one person remains on FFA team
		if ( Team_PlayerCountAlive(TEAM_FREE) < 2 ) {
			Arena_EndRound( TEAM_FREE ); // The round wins the round
		}
	} else if ( g_gametype.integer == GT_CLAN_ARENA || g_gametype.integer == GT_FREEZE ) {
		// Check if either team has no players remaining ; if so, call Arena_EndRound
		if ( Team_PlayerCountAlive(TEAM_RED) < 1 ) {
			Arena_EndRound( TEAM_BLUE ); // Blue wins the round
		} else if ( Team_PlayerCountAlive(TEAM_BLUE) < 1 ) {
			Arena_EndRound( TEAM_RED ); // Red wins the round
		}
	} 
}




//   MISC THINGS   //

#define	DEFAULT_HEALTH_SOFT_LIMIT	100

/*
===========
getHealthSoftLimit

Returns whatever HEALTH_SOFT_LIMIT was used for.
Also, some places still had hard-coded literal
int 100.
============
*/
int getHealthSoftLimit( void ) {
	if (g_startingHealth.integer < 1) {
		return DEFAULT_HEALTH_SOFT_LIMIT;
	}
	return g_startingHealth.integer;
}
