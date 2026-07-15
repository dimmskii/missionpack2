// bg_newgame.h -- New gametype wiring shared header file -- included from bg_public.h
// 
// By Dimmskii
// 

typedef enum {
	GT_FFA,				// free for all
	GT_TOURNAMENT,	// one on one tournament
	GT_SINGLE_PLAYER,	// race replaces the original single player slot

	//-- team games go after this --

	GT_TEAM,			// team deathmatch
	GT_CLAN_ARENA,	// clan arena
	GT_CTF,				// capture the flag
	GT_1FCTF,
	GT_OBELISK,
	GT_HARVESTER,
	GT_FREEZE,
	GT_DOMINATION,
	GT_ATTACK_DEFEND,
	GT_RED_ROVER,
	GT_TEAMTOURNAMENT,

	//-- team games go before this --
	
	GT_ARENA,
	GT_MAX_GAME_TYPE
} gametype_t;

// Quake Live repurposes the single-player slot for Race.
#define GT_RACE			GT_SINGLE_PLAYER
#define GT_CA			GT_CLAN_ARENA
#define GT_TEAMARENA	GT_CLAN_ARENA	// Old UA temporary compat
#define GT_FREEZETAG	GT_FREEZE		// Old UA temporary compat

#define GT_MAX_TEAM	GT_TEAMTOURNAMENT


// QL Factory cvars
static const char *GFACTORY_CVARS[] = {
	// General gameplay params
    "g_gametype",           // GT_ enum Gametype
    "fraglimit",
    "timelimit",
	"roundlimit",
	"roundtimelimit",
	"capturelimit",
	"g_warmup",
	"dmflags",
	"g_instagib",
	"g_fastWeaponSwitch",
	"g_friendlyFire",
	"g_noSelfDamage",
	"g_allowHandicap",
	
	"removeammo",
	"removeitem",
	"removepowerup",
	"removeweapon",
	
	"g_railJump",
	"g_railJumpDamage",
	
	"g_forcerespawn",
	"g_1FRespawn",
	
	"g_gravity",
	"g_speed",
	"g_knockback",
	"g_quadDamageFactor",
	
	"g_teamVisibility",
	"g_itemTimers",
	"g_allSpec",
	
	// Starting things
	"g_startingHealth",
	"g_startingHealthBonus",
	"g_startingArmor",
	
	// Weapon and loadout related
	"g_startingWeapons",
	"g_startingWeapon",
	
	// Starting ammo
	"g_startingAmmo_mg",
	"g_startingAmmo_sg",
	"g_startingAmmo_gl",
	"g_startingAmmo_rl",
	"g_startingAmmo_lg",
	"g_startingAmmo_rg",
	"g_startingAmmo_pg",
	"g_startingAmmo_bfg",
	"g_startingAmmo_ng",
	"g_startingAmmo_pl",
	"g_startingAmmo_cg",
	"g_startingAmmo_hmg",
	
	// Pickup respawns
	"g_weaponRespawn",
	"g_ammoRespawn",
	"g_armorRespawn",
	"g_healthRespawn",
	"g_megahealthRespawn",
	"g_powerupRespawn",
	"g_holdableRespawn",
	
	// Direct hit damage cvars
	"g_damage_g",
	"g_damage_mg",
	"g_damage_sg",
	"g_damage_gl",
	"g_damage_rl",
	"g_damage_lg",
	"g_damage_rg",
	"g_damage_pg",
	"g_damage_bfg",
	"g_damage_gh",
	"g_damage_ng",
	"g_damage_pl",
	"g_damage_cg",
	"g_damage_hmg",
	
	// Splash damage and radius cvars
	"g_splashdamage_gl",
	"g_splashdamage_rl",
	"g_splashdamage_pg",
	"g_splashdamage_bfg",
	"g_splashdamage_pl",
	
	"g_splashradius_gl",
	"g_splashradius_rl",
	"g_splashradius_pg",
	"g_splashradius_bfg",
	"g_splashradius_pl",
	
	// Weapon reload times
	"weapon_reload_gauntlet",
	"weapon_reload_mg",
	"weapon_reload_sg",
	"weapon_reload_gl",
	"weapon_reload_rl",
	"weapon_reload_lg",
	"weapon_reload_rg",
	"weapon_reload_pg",
	"weapon_reload_bfg",
	"weapon_reload_hook",
	"weapon_reload_ng",
	"weapon_reload_prox",
	"weapon_reload_cg",
	"weapon_reload_hmg",
	
	// SG Settings
	"g_sgPellets",
	"g_sgPelletSpread",
	
	// RL Settings
	"g_velocity_rl",
	
	// Grapple settings
	"g_grappleDelayTime",
	"g_grappleHoldTime",
	"g_grappleSpeed",
	"g_grapplePull",
	
	// NG Settings
	"g_nailBounce",
	
	// PL Settings
	"g_proxMineTimeout",
	
	// Obelisk (Overload)
	"g_obeliskHealth",
	"g_obeliskRegenPeriod",
	"g_obeliskRegenAmount",
	"g_obeliskRespawnDelay",
	
    NULL                    // Null-terminator for safe iteration loops
};

#define GFACTORY_MAX_CVAR_VALUE_LEN 64
#define GFACTORY_CVARS_COUNT       102 	/* Total elements in GFACTORY_CVARS excluding NULL */

// QL-Compatible game factories
typedef struct {
	const char		*id;
	char			*title;
	char			*author;
	char			*description;

	// Indexed the same as GFACTORY_CVARS. NULL means this factory does not
	// set that cvar (left at whatever value it already had); non-NULL
	// points at a null-terminated value string.
	char			*cvar_values[GFACTORY_CVARS_COUNT];

} gfactory_t;

#define MAX_GFACTORIES 32		// Max game factories possible to register

#define MAX_GAMETYPE_NAME_ALIASES 3
extern const char *const s_gametypeSpawnNames[GT_MAX_GAME_TYPE][MAX_GAMETYPE_NAME_ALIASES];

// Factories parsed from scripts/factories.txt plus any scripts/*.factories
// add-ons. Shared storage/loading so any module can parse these files -
// currently the canonical entrypoint is server-side (G_LoadFactories in
// g_newgame.c), with a UI-side loader (e.g. UI_LoadFactories) able to
// reuse the same parsing/inheritance machinery. Note bg_newgame.c can't
// itself enumerate scripts/*.factories (that needs trap_FS_GetFileList,
// which cgame doesn't have) - each module's own wrapper does that scan
// and calls BG_LoadFactoriesFile per matched file.
extern gfactory_t	bg_factories[MAX_GFACTORIES];
extern int			bg_numFactories;

void        BG_LoadFactoriesFile( const char *filename );
void        BG_ResolveFactoryInheritance( void );
gfactory_t *BG_FindFactoryById( const char *id );

// Returns the index of cvarName in GFACTORY_CVARS (case-insensitive), or
// -1 if it isn't one of the permitted factory cvars.
int         BG_FactoryCvarIndex( const char *cvarName );

