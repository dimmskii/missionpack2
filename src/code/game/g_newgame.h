// By Dimmskii

// g_newgame.c
#define MAX_GAMETYPE_NAME_ALIASES 3
extern const char *const s_gametypeSpawnNames[GT_MAX_GAME_TYPE][MAX_GAMETYPE_NAME_ALIASES];

// Factories parsed from scripts/factories.txt. Server side only for now -
// client visibility (e.g. exposing the active factory via serverinfo) is a
// later problem.
extern gfactory_t	g_factories[MAX_GFACTORIES];
extern int			g_numFactories;

void G_LoadFactories( void );
