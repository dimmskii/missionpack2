// By Dimmskii

// g_newgame.c
//
// Factory storage/parsing/inheritance now lives in bg_newgame.c/.h
// (bg_factories, bg_numFactories, BG_LoadFactoriesFile,
// BG_ResolveFactoryInheritance, BG_FindFactoryById) since it's shared,
// module-agnostic machinery. What stays server-side here is: scanning
// scripts/*.factories (needs trap_FS_GetFileList, which cgame lacks - see
// bg_newgame.h), and actually applying a factory's cvars to the engine.
//
// G_LoadFactories is the canonical (re-)load entrypoint, called at map
// init. G_ApplySelectedFactory is split out separately so the "which
// factory does g_factory currently name, and apply it" step can be
// re-run later (e.g. after g_factory changes mid-game) without repeating
// the full file load.
void G_LoadFactories( void );
void G_ApplySelectedFactory( void );



// CA and FFA Arena gamemode stuff

#define	ARENA_ROUND_DELAY_TIME	2000

void 		Arena_BeginRound(void);
void 		Arena_EndRound(team_t winningTeam);
void 		Arena_TimeoutRound(void);
void 		Arena_CheckRules(void);
void 		Arena_ForceRespawnDead(void);

qboolean	Arena_MatchDecided(void);

int getHealthSoftLimit( void );
