#include "../common/jsmndr.h"
#include "g_local.h"

#define MAX_JSON_FILE_SIZE 65536
static char jsonFileBuffer[MAX_JSON_FILE_SIZE];

#define MAX_FACTORY_TOKENS 2048
#define GFACTORY_MAX_DESC_LEN 128

gfactory_t	g_factories[MAX_GFACTORIES];
int			g_numFactories = 0;

// Backing storage for the gfactory_t pointer fields above. jsonFileBuffer
// gets reused on every load and JSON tokens aren't null-terminated in
// place, so every parsed string needs to be copied out somewhere that
// outlives the parse and is safe to hand around as a real C string.
static char g_factoryIdStorage[MAX_GFACTORIES][GFACTORY_MAX_CVAR_VALUE_LEN];
static char g_factoryTitleStorage[MAX_GFACTORIES][GFACTORY_MAX_CVAR_VALUE_LEN];
static char g_factoryAuthorStorage[MAX_GFACTORIES][GFACTORY_MAX_CVAR_VALUE_LEN];
static char g_factoryDescStorage[MAX_GFACTORIES][GFACTORY_MAX_DESC_LEN];
static char g_factoryCvarStorage[MAX_GFACTORIES][GFACTORY_CVARS_COUNT][GFACTORY_MAX_CVAR_VALUE_LEN];

// Each factory's raw "basegt" string, kept around after parsing so
// G_ResolveFactoryInheritance can do its own pass once every factory has
// been loaded (a basegt may name a factory that appears later in the
// file).
static char g_factoryBasegtStorage[MAX_GFACTORIES][GFACTORY_MAX_CVAR_VALUE_LEN];

void ParseFactories( const char *json, int len );



/*
=================
s_gametypeSpawnNames

Mapping of gametype enum values to the spawn string tokens used by
worldspawn "gametype" filters.
=================
*/
const char *const s_gametypeSpawnNames[GT_MAX_GAME_TYPE][MAX_GAMETYPE_NAME_ALIASES] = {
	{ "ffa", NULL, NULL },                          /* GT_FFA */
	{ "tournament", "duel", NULL },                 /* GT_TOURNAMENT */
	{ "single", "race", NULL },                     /* GT_SINGLE_PLAYER */
	{ "team", "tdm", NULL },                        /* GT_TEAM */
	{ "clanarena", "ca", NULL },                    /* GT_CLAN_ARENA */
	{ "ctf", NULL, NULL },                          /* GT_CTF */
	{ "oneflag", "1fctf", NULL },                   /* GT_1FCTF */
	{ "obelisk", "overload", NULL },                /* GT_OBELISK */
	{ "harvester", "har", NULL },                   /* GT_HARVESTER */
	{ "freeze", "freezetag", "ft" },                /* GT_FREEZE */
	{ "domination", "dom", NULL },                  /* GT_DOMINATION */
	{ "attackdefend", "ad", NULL },                 /* GT_ATTACK_DEFEND */
	{ "redrover", "rr", NULL },                     /* GT_RED_ROVER */
	{ "teamtournament", NULL, NULL },               /* GT_TEAMTOURNAMENT */
	{ "arena", "lms", NULL }                		/* GT_ARENA */
};

/*
=================
G_GametypeFromSpawnName

Reverse lookup of s_gametypeSpawnNames - returns the GT_ enum whose alias
list contains name (case-insensitive), or -1 if nothing matches.
=================
*/
static int G_GametypeFromSpawnName( const char *name ) {
	int gt, a;
	for ( gt = 0; gt < GT_MAX_GAME_TYPE; gt++ ) {
		for ( a = 0; a < MAX_GAMETYPE_NAME_ALIASES; a++ ) {
			if ( s_gametypeSpawnNames[gt][a] && !Q_stricmp( s_gametypeSpawnNames[gt][a], name ) ) {
				return gt;
			}
		}
	}
	return -1;
}

/*
=================
G_FactoryCvarIndex

Returns the index of cvarName in GFACTORY_CVARS, or -1 if it isn't one of
the permitted factory cvars.
=================
*/
static int G_FactoryCvarIndex( const char *cvarName ) {
	int i;
	for ( i = 0; i < GFACTORY_CVARS_COUNT; i++ ) {
		if ( !Q_stricmp( GFACTORY_CVARS[i], cvarName ) ) {
			return i;
		}
	}
	return -1;
}

/*
=================
G_FindFactoryById

Returns the parsed factory whose "id" matches (case-insensitive), or NULL.
=================
*/
static gfactory_t *G_FindFactoryById( const char *id ) {
	int i;
	for ( i = 0; i < g_numFactories; i++ ) {
		if ( !Q_stricmp( g_factories[i].id, id ) ) {
			return &g_factories[i];
		}
	}
	return NULL;
}

// Per-factory bookkeeping for G_ResolveFactoryInheritance's recursion -
// which factories are fully resolved, and which are currently being
// resolved (so a basegt cycle can be detected and broken instead of
// recursing forever). Reset at the start of every G_ResolveFactoryInheritance
// call.
static qboolean g_factoryResolved[MAX_GFACTORIES];
static qboolean g_factoryResolving[MAX_GFACTORIES];

/*
=================
G_ResolveFactoryInheritanceFor

Resolves a single factory's inheritance from its "basegt":

  - basegt missing/empty/non-string: no inheritance at all.
  - basegt equal to this factory's own id (self-referencing): treated as a
    canonical/base gametype rather than a derived variant - g_gametype is
    inferred from s_gametypeSpawnNames via G_GametypeFromSpawnName(),
    unless this factory's own "cvars" already set one explicitly.
  - basegt naming another loaded factory: every GFACTORY_CVARS slot this
    factory didn't set itself is backfilled from that factory's own
    cvar_values. That base is resolved first (recursively), so this is
    deep/transitive - inheriting from a factory that itself inherits from
    something else picks up the whole chain.
  - basegt naming something that isn't any loaded factory's id: no
    inheritance, just a console warning.

g_factoryResolving guards against basegt cycles (A's basegt is B, B's is
A, ...): if we're asked to resolve a factory that's already mid-resolution
on the current call stack, we stop and treat it as no inheritance rather
than recursing forever.
=================
*/
static void G_ResolveFactoryInheritanceFor( int idx ) {
	gfactory_t *factory;
	const char *basegt;
	gfactory_t *base;
	int i;

	if ( g_factoryResolved[idx] ) {
		return;
	}
	if ( g_factoryResolving[idx] ) {
		Com_Printf( "G_ResolveFactoryInheritance: basegt cycle detected at factory '%s', "
		            "not inheriting anything.\n", g_factories[idx].id );
		return;
	}
	g_factoryResolving[idx] = qtrue;

	factory = &g_factories[idx];
	basegt = g_factoryBasegtStorage[idx];

	if ( !basegt[0] ) {
		// basegt missing/empty/non-string - no inheritance.
		goto done;
	}

	if ( !Q_stricmp( factory->id, basegt ) ) {
		// Self-referencing - infer g_gametype via the alias cludge table,
		// unless this factory's own cvars already set one explicitly.
		int gtCvarIdx = G_FactoryCvarIndex( "g_gametype" );
		if ( gtCvarIdx >= 0 && factory->cvar_values[gtCvarIdx] == NULL ) {
			int gt = G_GametypeFromSpawnName( basegt );
			if ( gt >= 0 ) {
				Com_sprintf( g_factoryCvarStorage[idx][gtCvarIdx],
				             GFACTORY_MAX_CVAR_VALUE_LEN, "%d", gt );
				factory->cvar_values[gtCvarIdx] = g_factoryCvarStorage[idx][gtCvarIdx];
			} else {
				Com_Printf( "G_ResolveFactoryInheritance: self-referencing factory '%s' has "
				            "no s_gametypeSpawnNames alias for basegt '%s', leaving "
				            "g_gametype unset.\n", factory->id, basegt );
			}
		}
		goto done;
	}

	base = G_FindFactoryById( basegt );
	if ( !base ) {
		// basegt doesn't match any loaded factory - no inheritance.
		Com_Printf( "G_ResolveFactoryInheritance: factory '%s' has basegt '%s' which doesn't "
		            "match any loaded factory, not inheriting anything.\n", factory->id, basegt );
		goto done;
	}

	G_ResolveFactoryInheritanceFor( (int)( base - g_factories ) );
	for ( i = 0; i < GFACTORY_CVARS_COUNT; i++ ) {
		if ( factory->cvar_values[i] == NULL && base->cvar_values[i] != NULL ) {
			factory->cvar_values[i] = base->cvar_values[i];
		}
	}

done:
	g_factoryResolving[idx] = qfalse;
	g_factoryResolved[idx] = qtrue;
}

/*
=================
G_ResolveFactoryInheritance

Second pass over g_factories[], run once every factory has been parsed by
ParseFactories. See G_ResolveFactoryInheritanceFor for the per-factory
resolution rules.
=================
*/
static void G_ResolveFactoryInheritance( void ) {
	int i;
	for ( i = 0; i < g_numFactories; i++ ) {
		g_factoryResolved[i] = qfalse;
		g_factoryResolving[i] = qfalse;
	}
	for ( i = 0; i < g_numFactories; i++ ) {
		G_ResolveFactoryInheritanceFor( i );
	}
}

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
G_LoadFactories
=================
*/
void G_LoadFactories( void ) {
    fileHandle_t f;
    int len;

    // Open file using the early engine file system trap
    len = trap_FS_FOpenFile( "scripts/factories.txt", &f, FS_READ );
    if ( f == 0 || len <= 0 ) {
        Com_Printf( "G_LoadFactories: scripts/factories.txt not found or empty.\n" );
        if ( f ) {
            trap_FS_FCloseFile( f );
        }
        return;
    }

    if ( len >= MAX_JSON_FILE_SIZE ) {
        Com_Printf( "G_LoadFactories: File exceeds max safe QVM memory buffer size!\n" );
        trap_FS_FCloseFile( f );
        return;
    }

    // Read the complete text payload into memory
    trap_FS_Read( jsonFileBuffer, len, f );
    jsonFileBuffer[len] = '\0'; // Mandatory null termination
    trap_FS_FCloseFile( f );

    Com_Printf( "G_LoadFactories: Loaded %d bytes. Parsing tokens...\n", len );

    // Parse the factories
    ParseFactories( jsonFileBuffer, len );

	// Second pass: every factory is loaded now, so basegt inheritance can
	// be resolved (a basegt may name a factory that appears later in the
	// file, or one that itself still needs its own basegt resolved first).
	G_ResolveFactoryInheritance();

	Com_Printf( "G_LoadFactories: %d factories loaded.\n", g_numFactories );

	// g_factory is CVAR_LATCH - like g_gametype, a change only takes effect
	// on the next map init, which is exactly when this function runs. Force
	// the register here (ahead of G_RegisterCvars(), which runs after us)
	// so g_factory.string is actually populated with either the engine's
	// already-set value (server.cfg/+set) or the "ffa" default - reading it
	// before any registration would just see an empty, unregistered cvar.
	trap_Cvar_Register( &g_factory, "g_factory", "ffa", CVAR_SERVERINFO | CVAR_USERINFO | CVAR_LATCH );

	// An empty g_factory means "just expose the parsed factory list (e.g.
	// for the UI's host game screen), don't force any cvars" - factories
	// are still fully loaded above, we just skip lookup/apply entirely so
	// no cvar is touched under any circumstance.
	if ( !g_factory.string[0] ) {
		Com_Printf( "G_LoadFactories: g_factory is empty, skipping factory application.\n" );
		return;
	}

	if ( g_numFactories > 0 ) {
		gfactory_t *selected = G_FindFactoryById( g_factory.string );
		if ( !selected ) {
			Com_Printf( "G_LoadFactories: g_factory '%s' not found, defaulting to '%s'.\n",
			            g_factory.string, g_factories[0].id );
			selected = &g_factories[0];
		}
		G_ApplyFactory( selected );
	}
}

/*
=================
ParseFactories

factories.txt is a top-level JSON array of factory objects:
[ { "id": ..., "title": ..., "author": ..., "description": ...,
    "basegt": ..., "cvars": { "<cvar>": "<value>", ... } }, ... ]

Only "cvars" entries that are also listed in GFACTORY_CVARS are accepted;
anything else just warns to the console and is dropped.
=================
*/
void ParseFactories( const char *json, int len ) {
    jsmndr_parser parser;
    static jsmndrtok_t tokens[MAX_FACTORY_TOKENS]; // Keep off the tiny QVM thread stack frame
    int num_toks;
	int i;

    jsmndr_init( &parser );
    num_toks = jsmndr_parse( &parser, json, len, tokens, MAX_FACTORY_TOKENS );

    if ( num_toks <= 0 ) {
        Com_Printf( "ParseFactories Error: Failed parsing tokens (Code: %d)\n", num_toks );
        return;
    }

	if ( tokens[0].type != JSON_ARRAY ) {
		Com_Printf( "ParseFactories Error: factories.txt root must be a JSON array.\n" );
		return;
	}

	g_numFactories = 0;

	for ( i = 1; i < num_toks; i++ ) {
		gfactory_t *factory;
		int j;

		// Only care about objects directly inside the root array
		if ( tokens[i].parent != 0 || tokens[i].type != JSON_OBJECT ) {
			continue;
		}

		if ( g_numFactories >= MAX_GFACTORIES ) {
			Com_Printf( "ParseFactories: Too many factories in factories.txt, "
			            "truncating at %d.\n", MAX_GFACTORIES );
			break;
		}

		g_factoryBasegtStorage[g_numFactories][0] = '\0';
		factory = &g_factories[g_numFactories];
		factory->id = g_factoryIdStorage[g_numFactories];
		factory->title = g_factoryTitleStorage[g_numFactories];
		factory->author = g_factoryAuthorStorage[g_numFactories];
		factory->description = g_factoryDescStorage[g_numFactories];
		g_factoryIdStorage[g_numFactories][0] = '\0';
		g_factoryTitleStorage[g_numFactories][0] = '\0';
		g_factoryAuthorStorage[g_numFactories][0] = '\0';
		g_factoryDescStorage[g_numFactories][0] = '\0';
		for ( j = 0; j < GFACTORY_CVARS_COUNT; j++ ) {
			factory->cvar_values[j] = NULL;
		}

		// Walk this factory object's direct fields (key/value pairs)
		for ( j = i + 1; j < num_toks; j++ ) {
			int valIdx;

			if ( tokens[j].parent != i || tokens[j].type != JSON_STRING ) {
				continue;
			}

			valIdx = j + 1;

			if ( JSON_ValueEquals( json, &tokens[j], "id" ) ) {
				jsmndr_copy_token( g_factoryIdStorage[g_numFactories], GFACTORY_MAX_CVAR_VALUE_LEN, json, &tokens[valIdx] );
			} else if ( JSON_ValueEquals( json, &tokens[j], "title" ) ) {
				jsmndr_copy_token( g_factoryTitleStorage[g_numFactories], GFACTORY_MAX_CVAR_VALUE_LEN, json, &tokens[valIdx] );
			} else if ( JSON_ValueEquals( json, &tokens[j], "author" ) ) {
				jsmndr_copy_token( g_factoryAuthorStorage[g_numFactories], GFACTORY_MAX_CVAR_VALUE_LEN, json, &tokens[valIdx] );
			} else if ( JSON_ValueEquals( json, &tokens[j], "description" ) ) {
				jsmndr_copy_token( g_factoryDescStorage[g_numFactories], GFACTORY_MAX_DESC_LEN, json, &tokens[valIdx] );
			} else if ( JSON_ValueEquals( json, &tokens[j], "cvars" ) ) {
				int k;
				if ( tokens[valIdx].type != JSON_OBJECT ) {
					Com_Printf( "ParseFactories: 'cvars' is not an object, skipping.\n" );
					continue;
				}
				for ( k = valIdx + 1; k < num_toks; k++ ) {
					char cvarName[GFACTORY_MAX_CVAR_VALUE_LEN];
					int cvarIdx;
					int cvarValIdx;

					if ( tokens[k].parent != valIdx || tokens[k].type != JSON_STRING ) {
						continue;
					}
					cvarValIdx = k + 1;

					jsmndr_copy_token( cvarName, sizeof( cvarName ), json, &tokens[k] );
					cvarIdx = G_FactoryCvarIndex( cvarName );
					if ( cvarIdx < 0 ) {
						Com_Printf( "Invalid gfactory cvar: %s\n", cvarName );
						k++; // still skip the value token
						continue;
					}
					jsmndr_copy_token( g_factoryCvarStorage[g_numFactories][cvarIdx],
					                 GFACTORY_MAX_CVAR_VALUE_LEN, json, &tokens[cvarValIdx] );
					factory->cvar_values[cvarIdx] = g_factoryCvarStorage[g_numFactories][cvarIdx];

					k++; // skip the value token on the next iteration
				}
			} else if ( JSON_ValueEquals( json, &tokens[j], "basegt" ) ) {
				// Only a JSON string counts as a basegt reference - anything
				// else (missing, number, object, array, null, ...) means no
				// inheritance, handled by G_ResolveFactoryInheritance.
				if ( tokens[valIdx].type == JSON_STRING ) {
					jsmndr_copy_token( g_factoryBasegtStorage[g_numFactories], GFACTORY_MAX_CVAR_VALUE_LEN, json, &tokens[valIdx] );
				} else {
					Com_Printf( "ParseFactories: factory '%s' has a non-string \"basegt\", ignoring.\n",
					            g_factoryIdStorage[g_numFactories] );
				}
			}
			// any other unrecognized fields are intentionally ignored for now.
		}

		g_numFactories++;
	}
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

	respawnAll();
	CalculateRanks(); // Make sure scoreboard is sorted immediately? -- AKA Fix my scores please fresh out of spec mod
}

vec3_t zeroVec3 = {0, 0, 0};
void Arena_EndRound( team_t winningTeam ) {
	
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

void Arena_CheckRules( void ) {
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
