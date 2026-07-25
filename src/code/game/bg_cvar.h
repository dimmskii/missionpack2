// By Dimmskii
// bg_cvar.h -- cvars shared between the game (server) and cgame (client) VMs
//
// bg_*.c is compiled separately into both the game VM and the cgame VM, so a
// plain global can't be "shared" between them -- each VM needs its own
// vmCvar_t mirror registered via trap_Cvar_Register(). Both mirrors share the
// same cvar name so bg_pmove.c can read one consistent symbol regardless of
// which VM it was linked into. These used to carry CVAR_SERVERINFO so the
// engine would auto-sync the client copy, but that bloated the 1 KB serverinfo
// budget; they are now flags=0 and the server publishes them via the
// CS_WEAPON_RELOAD_TIMES configstring, which the client parses back into these
// cvars (CG_ParseWeaponReloadConfigString). See docs/devmemos/QL_CVAR_SYNC.md.

#ifdef EXTERN_BG_CVAR
	#define BG_CVAR( vmCvar, cvarName, defaultString, cvarFlags ) extern vmCvar_t vmCvar;
#endif

#ifdef DECLARE_BG_CVAR
	#define BG_CVAR( vmCvar, cvarName, defaultString, cvarFlags ) vmCvar_t vmCvar;
#endif

// used to append these entries into the game VM's gameCvarTable (7-field cvarTable_t)
#ifdef BG_CVAR_LIST_G
	#define BG_CVAR( vmCvar, cvarName, defaultString, cvarFlags ) { & vmCvar, cvarName, defaultString, cvarFlags, 0, qfalse, qfalse },
#endif

// used to append these entries into the cgame VM's cvarTable (4-field cvarTable_t)
#ifdef BG_CVAR_LIST_CG
	#define BG_CVAR( vmCvar, cvarName, defaultString, cvarFlags ) { & vmCvar, cvarName, defaultString, cvarFlags },
#endif

// Cvars for bg_pmove
BG_CVAR( weapon_reload_gauntlet, "weapon_reload_gauntlet", "400", 0 )
BG_CVAR( weapon_reload_mg, "weapon_reload_mg", "100", 0 )
BG_CVAR( weapon_reload_sg, "weapon_reload_sg", "1000", 0 )
BG_CVAR( weapon_reload_gl, "weapon_reload_gl", "800", 0 )
BG_CVAR( weapon_reload_rl, "weapon_reload_rl", "800", 0 )
BG_CVAR( weapon_reload_lg, "weapon_reload_lg", "50", 0 )
BG_CVAR( weapon_reload_rg, "weapon_reload_rg", "1500", 0 )
BG_CVAR( weapon_reload_pg, "weapon_reload_pg", "100", 0 )
BG_CVAR( weapon_reload_bfg, "weapon_reload_bfg", "200", 0 )
BG_CVAR( weapon_reload_hook, "weapon_reload_hook", "400", 0 )
BG_CVAR( weapon_reload_ng, "weapon_reload_ng", "1000", 0 )
BG_CVAR( weapon_reload_prox, "weapon_reload_prox", "800", 0 )
BG_CVAR( weapon_reload_cg, "weapon_reload_cg", "30", 0 )
BG_CVAR( weapon_reload_hmg, "weapon_reload_hmg", "75", 0 )

#undef BG_CVAR
