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
void 		Arena_FreezeSurvivorWeapons(void);
void 		Arena_ResetMatchScores(void);
void 		Arena_ThawWeapons(void);

qboolean	Arena_MatchDecided(void);


// FREEZE TAG

// The single gate for the freeze/thaw mechanic. Everything - server and client
// alike - asks this rather than testing the gametype, so freeze can be switched
// on inside other round-based gametypes via g_freeze.
qboolean	G_FreezeEnabled(void);
qboolean	G_FreezeIsNativeGametype(void);

// g_freeze.c
qboolean	G_FreezeIsFrozen( const gentity_t *ent );
void		G_FreezeInitClient( gentity_t *ent );
void		G_FreezeFreezeClient( gentity_t *ent, qboolean environmental );
void		G_FreezeThawClient( gentity_t *ent, qboolean wasAuto, int helperNum );
void		G_FreezeRunFrame( void );
qboolean	G_FreezeHandlePlayerDeath( gentity_t *self, gentity_t *attacker, int meansOfDeath );
void		G_FreezeThawWinningTeam( team_t winner );
qboolean	G_FreezeResetClientsForRound( void );
void		G_FreezeCheckTeamWipe( void );

int getHealthSoftLimit( void );
