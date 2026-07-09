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

void ParseFactories( const char *json, int len );

/*
=================
G_SpawnGametypeAliases

Mapping of gametype enum values to the spawn string tokens used by
worldspawn "gametype" filters.
=================
*/

#define MAX_GAMETYPE_NAME_ALIASES 3

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

/*
=================
G_ApplyFactory

Resets every GFACTORY_CVARS entry to its registered default, then overlays
this factory's specific cvar_values on top. The reset pass means switching
factories never leaves a cvar the new factory doesn't mention stuck at
whatever the previously applied factory left it at. ~Dimmskii
=================
*/
static void G_ApplyFactory( const gfactory_t *factory ) {
	int i;
	if ( !factory ) {
		return;
	}
	Com_Printf( "G_ApplyFactory: applying '%s' (%s)\n", factory->id, factory->title );

	// ~Dimmskii
	for ( i = 0; i < GFACTORY_CVARS_COUNT; i++ ) {
		const char *defaultString = G_GetCvarDefaultString( GFACTORY_CVARS[i] );
		if ( defaultString ) {
			trap_Cvar_Set( GFACTORY_CVARS[i], defaultString );
		} else {
			Com_Printf( "G_ApplyFactory: no registered default for gfactory cvar '%s'.\n", GFACTORY_CVARS[i] );
		}
	}
	// END Dimmskii

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

	Com_Printf( "G_LoadFactories: %d factories loaded.\n", g_numFactories );

	// g_factory is CVAR_LATCH - like g_gametype, a change only takes effect
	// on the next map init, which is exactly when this function runs. Force
	// the register here (ahead of G_RegisterCvars(), which runs after us)
	// so g_factory.string is actually populated with either the engine's
	// already-set value (server.cfg/+set) or the "ffa" default - reading it
	// before any registration would just see an empty, unregistered cvar.
	trap_Cvar_Register( &g_factory, "g_factory", "ffa", CVAR_SERVERINFO | CVAR_USERINFO | CVAR_LATCH );

	// ~Dimmskii
	// An empty g_factory means "just expose the parsed factory list (e.g.
	// for the UI's host game screen), don't force any cvars" - factories
	// are still fully loaded above, we just skip lookup/apply entirely so
	// no cvar is touched under any circumstance.
	if ( !g_factory.string[0] ) {
		Com_Printf( "G_LoadFactories: g_factory is empty, skipping factory application.\n" );
		return;
	}
	// END Dimmskii

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
		char basegt[GFACTORY_MAX_CVAR_VALUE_LEN];

		// Only care about objects directly inside the root array
		if ( tokens[i].parent != 0 || tokens[i].type != JSON_OBJECT ) {
			continue;
		}

		if ( g_numFactories >= MAX_GFACTORIES ) {
			Com_Printf( "ParseFactories: Too many factories in factories.txt, "
			            "truncating at %d.\n", MAX_GFACTORIES );
			break;
		}

		basegt[0] = '\0';
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
				jsmndr_copy_token( basegt, sizeof( basegt ), json, &tokens[valIdx] );
			}
			// any other unrecognized fields are intentionally ignored for now.
		}

		// QL reverse-compat shim: a factory whose "basegt" is itself (e.g.
		// id "ca", basegt "ca") is, by happenstance, a base/canonical
		// gametype rather than a derived variant (practice, instagib,
		// vampiric, ...) - naively presume basegt names the same gametype
		// s_gametypeSpawnNames already knows and force the GT_ enum into
		// this factory's g_gametype slot, unless its own "cvars" already
		// set one explicitly.
		if ( basegt[0] && !Q_stricmp( g_factoryIdStorage[g_numFactories], basegt ) ) {
			int gtCvarIdx = G_FactoryCvarIndex( "g_gametype" );
			if ( gtCvarIdx >= 0 && factory->cvar_values[gtCvarIdx] == NULL ) {
				int gt = G_GametypeFromSpawnName( basegt );
				if ( gt >= 0 ) {
					Com_sprintf( g_factoryCvarStorage[g_numFactories][gtCvarIdx],
					             GFACTORY_MAX_CVAR_VALUE_LEN, "%d", gt );
					factory->cvar_values[gtCvarIdx] = g_factoryCvarStorage[g_numFactories][gtCvarIdx];
				} else {
					Com_Printf( "ParseFactories: self-referencing factory '%s' has no "
					            "s_gametypeSpawnNames alias for basegt '%s', leaving "
					            "g_gametype unset.\n", factory->id, basegt );
				}
			}
		}

		g_numFactories++;
	}
}
