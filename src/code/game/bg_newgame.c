#include "q_shared.h"
#include "bg_public.h"
#include "../common/jsmndr.h"

/*
===============
GT_IsTeam

Returns whether or not gametype is team-based. See GT_ enums in bg_public.h
===============
*/
qboolean GT_IsTeam( int gt ) {
	if (gt < GT_TEAM || gt > GT_MAX_TEAM) {
		return qfalse;
	}
	return qtrue;
}

/*
===============
GT_IsDMGame

Returns whether or not gametype is frag-based. See GT_ enums in bg_public.h
Should be equivalent of gt <= GT_TEAM
===============
*/
qboolean GT_IsDMGame( int gt ) {
	if (gt > GT_TEAM) {
		return qfalse;
	}
	return qtrue;
}

/*
===============
GT_IsArenaGame

The *elimination* gametypes: a dead player is out of the round and becomes a
following spectator, items don't spawn, and bodies go to the bodyque.

Freeze Tag is deliberately NOT here. It shares the round structure (see
GT_IsRoundBased) but not the eliminated-player model - a frozen player stays in
the world as a thawable body, so the dead-spectator machinery, the item
stripping and the bodyque handling must all skip it.
===============
*/
qboolean GT_IsArenaGame( int gt ) {
	if (gt == GT_CLAN_ARENA || gt == GT_ARENA) {
		return qtrue;
	}
	return qfalse;
}

/*
===============
GT_IsRoundBased

Gametypes played as a series of rounds rather than one continuous match: warmup
between rounds, a roundlimit and roundtimelimit instead of a fraglimit, scores
that survive the round reset.

This is the wider set - everything GT_IsArenaGame covers, plus Freeze Tag. New
round-based gametypes (Red Rover, Team Tournament) belong here, and only here
unless they also eliminate players.
===============
*/
qboolean GT_IsRoundBased( int gt ) {
	if ( GT_IsArenaGame( gt ) || gt == GT_FREEZE ) {
		return qtrue;
	}
	return qfalse;
}

/*
===============
GT_IsFlagGame

Returns whether or not gametype is flag-based. See GT_ enums in bg_public.h
Should be equivalent of pre-QL (i.e. MPP) gt >= GT_CTF. Matters a lot with bots.
===============
*/
qboolean GT_IsFlagGame( int gt ) {
	if (gt < GT_CTF || gt > GT_HARVESTER) {
		return qfalse;
	}
	return qtrue;
}

#define MAX_JSON_FILE_SIZE 65536
static char jsonFileBuffer[MAX_JSON_FILE_SIZE];

#define MAX_FACTORY_TOKENS 2048
#define GFACTORY_MAX_DESC_LEN 128

gfactory_t	bg_factories[MAX_GFACTORIES];
int			bg_numFactories = 0;

// Backing storage for the gfactory_t pointer fields above. jsonFileBuffer
// gets reused on every load and JSON tokens aren't null-terminated in
// place, so every parsed string needs to be copied out somewhere that
// outlives the parse and is safe to hand around as a real C string.
static char bg_factoryIdStorage[MAX_GFACTORIES][GFACTORY_MAX_CVAR_VALUE_LEN];
static char bg_factoryTitleStorage[MAX_GFACTORIES][GFACTORY_MAX_CVAR_VALUE_LEN];
static char bg_factoryAuthorStorage[MAX_GFACTORIES][GFACTORY_MAX_CVAR_VALUE_LEN];
static char bg_factoryDescStorage[MAX_GFACTORIES][GFACTORY_MAX_DESC_LEN];
static char bg_factoryCvarStorage[MAX_GFACTORIES][GFACTORY_CVARS_COUNT][GFACTORY_MAX_CVAR_VALUE_LEN];

// Each factory's raw "basegt" string, kept around after parsing so
// BG_ResolveFactoryInheritance can do its own pass once every factory has
// been loaded (a basegt may name a factory that appears later, or in a
// different file).
static char bg_factoryBasegtStorage[MAX_GFACTORIES][GFACTORY_MAX_CVAR_VALUE_LEN];

static void BG_ParseFactories( const char *json, int len );

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
BG_GametypeFromSpawnName

Reverse lookup of s_gametypeSpawnNames - returns the GT_ enum whose alias
list contains name (case-insensitive), or -1 if nothing matches.
=================
*/
static int BG_GametypeFromSpawnName( const char *name ) {
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
BG_FactoryCvarIndex

Returns the index of cvarName in GFACTORY_CVARS, or -1 if it isn't one of
the permitted factory cvars.
=================
*/
int BG_FactoryCvarIndex( const char *cvarName ) {
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
BG_FindFactoryById

Returns the parsed factory whose "id" matches (case-insensitive), or NULL.
=================
*/
gfactory_t *BG_FindFactoryById( const char *id ) {
	int i;
	for ( i = 0; i < bg_numFactories; i++ ) {
		if ( !Q_stricmp( bg_factories[i].id, id ) ) {
			return &bg_factories[i];
		}
	}
	return NULL;
}

// Per-factory bookkeeping for BG_ResolveFactoryInheritance's recursion -
// which factories are fully resolved, and which are currently being
// resolved (so a basegt cycle can be detected and broken instead of
// recursing forever). Reset at the start of every BG_ResolveFactoryInheritance
// call.
static qboolean bg_factoryResolved[MAX_GFACTORIES];
static qboolean bg_factoryResolving[MAX_GFACTORIES];

/*
=================
BG_ResolveFactoryInheritanceFor

Resolves a single factory's inheritance from its "basegt":

  - basegt missing/empty/non-string: no inheritance at all.
  - basegt equal to this factory's own id (self-referencing): treated as a
    canonical/base gametype rather than a derived variant - g_gametype is
    inferred from s_gametypeSpawnNames via BG_GametypeFromSpawnName(),
    unless this factory's own "cvars" already set one explicitly.
  - basegt naming another loaded factory: every GFACTORY_CVARS slot this
    factory didn't set itself is backfilled from that factory's own
    cvar_values. That base is resolved first (recursively), so this is
    deep/transitive - inheriting from a factory that itself inherits from
    something else picks up the whole chain.
  - basegt naming something that isn't any loaded factory's id: no
    inheritance, just a console warning.

bg_factoryResolving guards against basegt cycles (A's basegt is B, B's is
A, ...): if we're asked to resolve a factory that's already mid-resolution
on the current call stack, we stop and treat it as no inheritance rather
than recursing forever.
=================
*/
static void BG_ResolveFactoryInheritanceFor( int idx ) {
	gfactory_t *factory;
	const char *basegt;
	gfactory_t *base;
	int i;

	if ( bg_factoryResolved[idx] ) {
		return;
	}
	if ( bg_factoryResolving[idx] ) {
		Com_Printf( "BG_ResolveFactoryInheritance: basegt cycle detected at factory '%s', "
		            "not inheriting anything.\n", bg_factories[idx].id );
		return;
	}
	bg_factoryResolving[idx] = qtrue;

	factory = &bg_factories[idx];
	basegt = bg_factoryBasegtStorage[idx];

	if ( !basegt[0] ) {
		// basegt missing/empty/non-string - no inheritance.
		goto done;
	}

	if ( !Q_stricmp( factory->id, basegt ) ) {
		// Self-referencing - infer g_gametype via the alias cludge table,
		// unless this factory's own cvars already set one explicitly.
		int gtCvarIdx = BG_FactoryCvarIndex( "g_gametype" );
		if ( gtCvarIdx >= 0 && factory->cvar_values[gtCvarIdx] == NULL ) {
			int gt = BG_GametypeFromSpawnName( basegt );
			if ( gt >= 0 ) {
				Com_sprintf( bg_factoryCvarStorage[idx][gtCvarIdx],
				             GFACTORY_MAX_CVAR_VALUE_LEN, "%d", gt );
				factory->cvar_values[gtCvarIdx] = bg_factoryCvarStorage[idx][gtCvarIdx];
			} else {
				Com_Printf( "BG_ResolveFactoryInheritance: self-referencing factory '%s' has "
				            "no s_gametypeSpawnNames alias for basegt '%s', leaving "
				            "g_gametype unset.\n", factory->id, basegt );
			}
		}
		goto done;
	}

	base = BG_FindFactoryById( basegt );
	if ( !base ) {
		// basegt doesn't match any loaded factory - no inheritance.
		Com_Printf( "BG_ResolveFactoryInheritance: factory '%s' has basegt '%s' which doesn't "
		            "match any loaded factory, not inheriting anything.\n", factory->id, basegt );
		goto done;
	}

	BG_ResolveFactoryInheritanceFor( (int)( base - bg_factories ) );
	for ( i = 0; i < GFACTORY_CVARS_COUNT; i++ ) {
		if ( factory->cvar_values[i] == NULL && base->cvar_values[i] != NULL ) {
			factory->cvar_values[i] = base->cvar_values[i];
		}
	}

done:
	bg_factoryResolving[idx] = qfalse;
	bg_factoryResolved[idx] = qtrue;
}

/*
=================
BG_ResolveFactoryInheritance

Second pass over bg_factories[], run once every factory (base file plus
any add-ons) has been parsed. See BG_ResolveFactoryInheritanceFor for the
per-factory resolution rules.
=================
*/
void BG_ResolveFactoryInheritance( void ) {
	int i;
	for ( i = 0; i < bg_numFactories; i++ ) {
		bg_factoryResolved[i] = qfalse;
		bg_factoryResolving[i] = qfalse;
	}
	for ( i = 0; i < bg_numFactories; i++ ) {
		BG_ResolveFactoryInheritanceFor( i );
	}
}

/*
=================
BG_LoadFactoriesFile

Reads filename and, if found, parses it as a factories.txt-shaped JSON
array via BG_ParseFactories, appending onto bg_factories[] from whatever
bg_numFactories currently is. Callers form a load sequence and are
responsible for resetting bg_numFactories to 0 before the first call, and
for calling BG_ResolveFactoryInheritance once after the whole sequence.
=================
*/
void BG_LoadFactoriesFile( const char *filename ) {
	fileHandle_t f;
	int len;

	len = trap_FS_FOpenFile( filename, &f, FS_READ );
	if ( f == 0 || len <= 0 ) {
		Com_Printf( "BG_LoadFactoriesFile: %s not found or empty.\n", filename );
		if ( f ) {
			trap_FS_FCloseFile( f );
		}
		return;
	}

	if ( len >= MAX_JSON_FILE_SIZE ) {
		Com_Printf( "BG_LoadFactoriesFile: %s exceeds max safe QVM memory buffer size!\n", filename );
		trap_FS_FCloseFile( f );
		return;
	}

	trap_FS_Read( jsonFileBuffer, len, f );
	jsonFileBuffer[len] = '\0'; // Mandatory null termination
	trap_FS_FCloseFile( f );

	Com_Printf( "BG_LoadFactoriesFile: Loaded %d bytes from %s. Parsing tokens...\n", len, filename );

	BG_ParseFactories( jsonFileBuffer, len );
}

/*
=================
BG_ParseFactories

json is a top-level JSON array of factory objects (scripts/factories.txt
or a scripts/*.factories add-on, both share this shape):
[ { "id": ..., "title": ..., "author": ..., "description": ...,
    "basegt": ..., "cvars": { "<cvar>": "<value>", ... } }, ... ]

Only "cvars" entries that are also listed in GFACTORY_CVARS are accepted;
anything else just warns to the console and is dropped.

Appends onto bg_factories[] starting from the current bg_numFactories -
does not reset it, so a load sequence can call this once per file (see
BG_LoadFactoriesFile).
=================
*/
static void BG_ParseFactories( const char *json, int len ) {
    jsmndr_parser parser;
    static jsmndrtok_t tokens[MAX_FACTORY_TOKENS]; // Keep off the tiny QVM thread stack frame
    int num_toks;
	int i;

    jsmndr_init( &parser );
    num_toks = jsmndr_parse( &parser, json, len, tokens, MAX_FACTORY_TOKENS );

    if ( num_toks <= 0 ) {
        Com_Printf( "BG_ParseFactories Error: Failed parsing tokens (Code: %d)\n", num_toks );
        return;
    }

	if ( tokens[0].type != JSON_ARRAY ) {
		Com_Printf( "BG_ParseFactories Error: factories.txt root must be a JSON array.\n" );
		return;
	}

	for ( i = 1; i < num_toks; i++ ) {
		gfactory_t *factory;
		int j;

		// Only care about objects directly inside the root array
		if ( tokens[i].parent != 0 || tokens[i].type != JSON_OBJECT ) {
			continue;
		}

		if ( bg_numFactories >= MAX_GFACTORIES ) {
			Com_Printf( "BG_ParseFactories: Too many factories, "
			            "truncating at %d.\n", MAX_GFACTORIES );
			break;
		}

		bg_factoryBasegtStorage[bg_numFactories][0] = '\0';
		factory = &bg_factories[bg_numFactories];
		factory->id = bg_factoryIdStorage[bg_numFactories];
		factory->title = bg_factoryTitleStorage[bg_numFactories];
		factory->author = bg_factoryAuthorStorage[bg_numFactories];
		factory->description = bg_factoryDescStorage[bg_numFactories];
		bg_factoryIdStorage[bg_numFactories][0] = '\0';
		bg_factoryTitleStorage[bg_numFactories][0] = '\0';
		bg_factoryAuthorStorage[bg_numFactories][0] = '\0';
		bg_factoryDescStorage[bg_numFactories][0] = '\0';
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
				jsmndr_copy_token( bg_factoryIdStorage[bg_numFactories], GFACTORY_MAX_CVAR_VALUE_LEN, json, &tokens[valIdx] );
			} else if ( JSON_ValueEquals( json, &tokens[j], "title" ) ) {
				jsmndr_copy_token( bg_factoryTitleStorage[bg_numFactories], GFACTORY_MAX_CVAR_VALUE_LEN, json, &tokens[valIdx] );
			} else if ( JSON_ValueEquals( json, &tokens[j], "author" ) ) {
				jsmndr_copy_token( bg_factoryAuthorStorage[bg_numFactories], GFACTORY_MAX_CVAR_VALUE_LEN, json, &tokens[valIdx] );
			} else if ( JSON_ValueEquals( json, &tokens[j], "description" ) ) {
				jsmndr_copy_token( bg_factoryDescStorage[bg_numFactories], GFACTORY_MAX_DESC_LEN, json, &tokens[valIdx] );
			} else if ( JSON_ValueEquals( json, &tokens[j], "cvars" ) ) {
				int k;
				if ( tokens[valIdx].type != JSON_OBJECT ) {
					Com_Printf( "BG_ParseFactories: 'cvars' is not an object, skipping.\n" );
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
					cvarIdx = BG_FactoryCvarIndex( cvarName );
					if ( cvarIdx < 0 ) {
						Com_Printf( "Invalid gfactory cvar: %s\n", cvarName );
						k++; // still skip the value token
						continue;
					}
					jsmndr_copy_token( bg_factoryCvarStorage[bg_numFactories][cvarIdx],
					                 GFACTORY_MAX_CVAR_VALUE_LEN, json, &tokens[cvarValIdx] );
					factory->cvar_values[cvarIdx] = bg_factoryCvarStorage[bg_numFactories][cvarIdx];

					k++; // skip the value token on the next iteration
				}
			} else if ( JSON_ValueEquals( json, &tokens[j], "basegt" ) ) {
				// Only a JSON string counts as a basegt reference - anything
				// else (missing, number, object, array, null, ...) means no
				// inheritance, handled by BG_ResolveFactoryInheritance.
				if ( tokens[valIdx].type == JSON_STRING ) {
					jsmndr_copy_token( bg_factoryBasegtStorage[bg_numFactories], GFACTORY_MAX_CVAR_VALUE_LEN, json, &tokens[valIdx] );
				} else {
					Com_Printf( "BG_ParseFactories: factory '%s' has a non-string \"basegt\", ignoring.\n",
					            bg_factoryIdStorage[bg_numFactories] );
				}
			}
			// any other unrecognized fields are intentionally ignored for now.
		}

		bg_numFactories++;
	}
}
