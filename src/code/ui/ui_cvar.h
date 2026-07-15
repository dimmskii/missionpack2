#ifdef EXTERN_UI_CVAR
	#define UI_CVAR( vmCvar, cvarName, defaultString, cvarFlags ) extern vmCvar_t vmCvar;
#endif

#ifdef DECLARE_UI_CVAR
	#define UI_CVAR( vmCvar, cvarName, defaultString, cvarFlags ) vmCvar_t vmCvar;
#endif

#ifdef UI_CVAR_LIST
	#define UI_CVAR( vmCvar, cvarName, defaultString, cvarFlags ) { & vmCvar, cvarName, defaultString, cvarFlags },
#endif

//UI_CVAR( ui_ffa_fraglimit, "ui_ffa_fraglimit", "20", CVAR_ARCHIVE )
//UI_CVAR( ui_ffa_timelimit, "ui_ffa_timelimit", "0", CVAR_ARCHIVE )

//UI_CVAR( ui_tourney_fraglimit, "ui_tourney_fraglimit", "0", CVAR_ARCHIVE )
//UI_CVAR( ui_tourney_timelimit, "ui_tourney_timelimit", "15", CVAR_ARCHIVE )

//UI_CVAR( ui_team_fraglimit, "ui_team_fraglimit", "0", CVAR_ARCHIVE )
//UI_CVAR( ui_team_timelimit, "ui_team_timelimit", "20", CVAR_ARCHIVE )
//UI_CVAR( ui_team_friendly, "ui_team_friendly",  "1", CVAR_ARCHIVE )

//UI_CVAR( ui_ctf_capturelimit, "ui_ctf_capturelimit", "8", CVAR_ARCHIVE )
//UI_CVAR( ui_ctf_timelimit, "ui_ctf_timelimit", "30", CVAR_ARCHIVE )
//UI_CVAR( ui_ctf_friendly, "ui_ctf_friendly",  "0", CVAR_ARCHIVE )

//UI_CVAR( ui_arenasFile, "g_arenasFile", "", CVAR_INIT|CVAR_ROM )
//UI_CVAR( ui_botsFile, "g_botsFile", "", CVAR_INIT|CVAR_ROM )
//UI_CVAR( ui_spScores1, "g_spScores1", "", CVAR_ARCHIVE | CVAR_ROM )
//UI_CVAR( ui_spScores2, "g_spScores2", "", CVAR_ARCHIVE | CVAR_ROM )
//UI_CVAR( ui_spScores3, "g_spScores3", "", CVAR_ARCHIVE | CVAR_ROM )
//UI_CVAR( ui_spScores4, "g_spScores4", "", CVAR_ARCHIVE | CVAR_ROM )
//UI_CVAR( ui_spScores5, "g_spScores5", "", CVAR_ARCHIVE | CVAR_ROM )
//UI_CVAR( ui_spAwards, "g_spAwards", "", CVAR_ARCHIVE | CVAR_ROM )
//UI_CVAR( ui_spVideos, "g_spVideos", "", CVAR_ARCHIVE | CVAR_ROM )
//UI_CVAR( ui_spSkill, "g_spSkill", "2", CVAR_ARCHIVE )

//UI_CVAR( ui_spSelection, "ui_spSelection", "", CVAR_ROM )

//UI_CVAR( ui_browserMaster, "ui_browserMaster", "0", CVAR_ARCHIVE )
//UI_CVAR( ui_browserGameType, "ui_browserGameType", "0", CVAR_ARCHIVE )
//UI_CVAR( ui_browserSortKey, "ui_browserSortKey", "4", CVAR_ARCHIVE )
UI_CVAR( ui_browserShowFull, "ui_browserShowFull", "1", CVAR_ARCHIVE )
UI_CVAR( ui_browserShowEmpty, "ui_browserShowEmpty", "1", CVAR_ARCHIVE )

UI_CVAR( ui_brassTime, "cg_brassTime", "2500", CVAR_ARCHIVE )
UI_CVAR( ui_drawCrosshair, "cg_drawCrosshair", "4", CVAR_ARCHIVE )
UI_CVAR( ui_drawCrosshairNames, "cg_drawCrosshairNames", "1", CVAR_ARCHIVE )
UI_CVAR( ui_marks, "cg_marks", "1", CVAR_ARCHIVE )

//UI_CVAR( ui_server1, "server1", "", CVAR_ARCHIVE )
//UI_CVAR( ui_server2, "server2", "", CVAR_ARCHIVE )
//UI_CVAR( ui_server3, "server3", "", CVAR_ARCHIVE )
//UI_CVAR( ui_server4, "server4", "", CVAR_ARCHIVE )
//UI_CVAR( ui_server5, "server5", "", CVAR_ARCHIVE )
//UI_CVAR( ui_server6, "server6", "", CVAR_ARCHIVE )
//UI_CVAR( ui_server7, "server7", "", CVAR_ARCHIVE )
//UI_CVAR( ui_server8, "server8", "", CVAR_ARCHIVE )
//UI_CVAR( ui_server9, "server9", "", CVAR_ARCHIVE )
//UI_CVAR( ui_server10, "server10", "", CVAR_ARCHIVE )
//UI_CVAR( ui_server11, "server11", "", CVAR_ARCHIVE )
//UI_CVAR( ui_server12, "server12", "", CVAR_ARCHIVE )
//UI_CVAR( ui_server13, "server13", "", CVAR_ARCHIVE )
//UI_CVAR( ui_server14, "server14", "", CVAR_ARCHIVE )
//UI_CVAR( ui_server15, "server15", "", CVAR_ARCHIVE )
//UI_CVAR( ui_server16, "server16", "", CVAR_ARCHIVE )
//UI_CVAR( ui_cdkeychecked, "ui_cdkeychecked", "0", CVAR_ROM )
UI_CVAR( ui_new, "ui_new", "0", CVAR_TEMP )
UI_CVAR( ui_debug, "ui_debug", "0", CVAR_TEMP )
UI_CVAR( ui_initialized, "ui_initialized", "0", CVAR_TEMP )
UI_CVAR( ui_teamName, "ui_teamName", "Pagans", CVAR_ARCHIVE )
UI_CVAR( ui_opponentName, "ui_opponentName", "Stroggs", CVAR_ARCHIVE )
//UI_CVAR( ui_redteam, "ui_redteam", "Stroggs", CVAR_ARCHIVE )
//UI_CVAR( ui_blueteam, "ui_blueteam", "Pagans", CVAR_ARCHIVE )
// ~Dimmskii
UI_CVAR( ui_redteam, "ui_redteam", "Red", CVAR_ARCHIVE )
UI_CVAR( ui_blueteam, "ui_blueteam", "Blue", CVAR_ARCHIVE )
// END Dimmskii
UI_CVAR( ui_dedicated, "ui_dedicated", "0", CVAR_ARCHIVE )
//UI_CVAR( ui_gameType, "ui_gametype", "3", CVAR_ARCHIVE )
UI_CVAR( ui_gameType, "ui_gametype", "0", CVAR_ARCHIVE )	// ~Dimmskii
UI_CVAR( ui_joinGameType, "ui_joinGametype", "0", CVAR_ARCHIVE )
//UI_CVAR( ui_netGameType, "ui_netGametype", "3", CVAR_ARCHIVE )
//UI_CVAR( ui_actualNetGameType, "ui_actualNetGametype", "3", CVAR_ARCHIVE )
UI_CVAR( ui_netGameType, "ui_netGametype", "0", CVAR_ARCHIVE )				// ~Dimmskii
UI_CVAR( ui_actualNetGameType, "ui_actualNetGametype", "0", CVAR_ARCHIVE )	// ~Dimmskii
//UI_CVAR( ui_redteam1, "ui_redteam1", "0", CVAR_ARCHIVE )
//UI_CVAR( ui_redteam2, "ui_redteam2", "0", CVAR_ARCHIVE )
//UI_CVAR( ui_redteam3, "ui_redteam3", "0", CVAR_ARCHIVE )
// ~Dimmskii
UI_CVAR( ui_redteam1, "ui_redteam1", "7", CVAR_ARCHIVE )
UI_CVAR( ui_redteam2, "ui_redteam2", "17", CVAR_ARCHIVE )
UI_CVAR( ui_redteam3, "ui_redteam3", "3", CVAR_ARCHIVE )
// END Dimmskii
UI_CVAR( ui_redteam4, "ui_redteam4", "0", CVAR_ARCHIVE )
UI_CVAR( ui_redteam5, "ui_redteam5", "0", CVAR_ARCHIVE )
//UI_CVAR( ui_blueteam1, "ui_blueteam1", "0", CVAR_ARCHIVE )
//UI_CVAR( ui_blueteam2, "ui_blueteam2", "0", CVAR_ARCHIVE )
//UI_CVAR( ui_blueteam3, "ui_blueteam3", "0", CVAR_ARCHIVE )
// ~Dimmskii
UI_CVAR( ui_blueteam1, "ui_blueteam1", "1", CVAR_ARCHIVE )
UI_CVAR( ui_blueteam2, "ui_blueteam2", "2", CVAR_ARCHIVE )
UI_CVAR( ui_blueteam3, "ui_blueteam3", "8", CVAR_ARCHIVE )
// END Dimmskii
UI_CVAR( ui_blueteam4, "ui_blueteam4", "0", CVAR_ARCHIVE )
UI_CVAR( ui_blueteam5, "ui_blueteam5", "0", CVAR_ARCHIVE )
// ~Dimmskii
UI_CVAR( ui_redteam6, "ui_redteam6", "0", CVAR_ARCHIVE )
UI_CVAR( ui_redteam7, "ui_redteam7", "0", CVAR_ARCHIVE )
UI_CVAR( ui_blueteam6, "ui_blueteam6", "0", CVAR_ARCHIVE )
UI_CVAR( ui_blueteam7, "ui_blueteam7", "0", CVAR_ARCHIVE )
// END Dimmskii
UI_CVAR( ui_netSource, "ui_netSource", "0", CVAR_ARCHIVE )
UI_CVAR( ui_menuFiles, "ui_menuFiles", "ui/menus.txt", CVAR_ARCHIVE )
UI_CVAR( ui_currentTier, "ui_currentTier", "0", CVAR_ARCHIVE )
UI_CVAR( ui_currentMap, "ui_currentMap", "0", CVAR_ARCHIVE )
UI_CVAR( ui_currentNetMap, "ui_currentNetMap", "0", CVAR_ARCHIVE )
UI_CVAR( ui_mapIndex, "ui_mapIndex", "0", CVAR_ARCHIVE )
UI_CVAR( ui_currentOpponent, "ui_currentOpponent", "0", CVAR_ARCHIVE )
UI_CVAR( ui_selectedPlayer, "cg_selectedPlayer", "0", CVAR_ARCHIVE )
UI_CVAR( ui_selectedPlayerName, "cg_selectedPlayerName", "", CVAR_ARCHIVE )
UI_CVAR( ui_lastServerRefresh_0, "ui_lastServerRefresh_0", "", CVAR_ARCHIVE )
UI_CVAR( ui_lastServerRefresh_1, "ui_lastServerRefresh_1", "", CVAR_ARCHIVE )
UI_CVAR( ui_lastServerRefresh_2, "ui_lastServerRefresh_2", "", CVAR_ARCHIVE )
UI_CVAR( ui_lastServerRefresh_3, "ui_lastServerRefresh_3", "", CVAR_ARCHIVE )
UI_CVAR( ui_singlePlayerActive, "ui_singlePlayerActive", "0", 0 )
UI_CVAR( ui_scoreAccuracy, "ui_scoreAccuracy", "0", CVAR_ARCHIVE )
UI_CVAR( ui_scoreImpressives, "ui_scoreImpressives", "0", CVAR_ARCHIVE )
UI_CVAR( ui_scoreExcellents, "ui_scoreExcellents", "0", CVAR_ARCHIVE )
UI_CVAR( ui_scoreCaptures, "ui_scoreCaptures", "0", CVAR_ARCHIVE )
UI_CVAR( ui_scoreDefends, "ui_scoreDefends", "0", CVAR_ARCHIVE )
UI_CVAR( ui_scoreAssists, "ui_scoreAssists", "0", CVAR_ARCHIVE )
UI_CVAR( ui_scoreGauntlets, "ui_scoreGauntlets", "0",CVAR_ARCHIVE )
UI_CVAR( ui_scoreScore, "ui_scoreScore", "0", CVAR_ARCHIVE )
UI_CVAR( ui_scorePerfect, "ui_scorePerfect", "0", CVAR_ARCHIVE )
UI_CVAR( ui_scoreTeam, "ui_scoreTeam", "0 to 0", CVAR_ARCHIVE )
UI_CVAR( ui_scoreBase, "ui_scoreBase", "0", CVAR_ARCHIVE )
UI_CVAR( ui_scoreTime, "ui_scoreTime", "00:00", CVAR_ARCHIVE )
UI_CVAR( ui_scoreTimeBonus, "ui_scoreTimeBonus", "0", CVAR_ARCHIVE )
UI_CVAR( ui_scoreSkillBonus, "ui_scoreSkillBonus", "0", CVAR_ARCHIVE )
UI_CVAR( ui_scoreShutoutBonus, "ui_scoreShutoutBonus", "0", CVAR_ARCHIVE )
//UI_CVAR( ui_fragLimit, "ui_fragLimit", "10", 0 )
//UI_CVAR( ui_captureLimit, "ui_captureLimit", "5", 0 )
UI_CVAR( ui_smallFont, "ui_smallFont", "0.25", CVAR_ARCHIVE )
UI_CVAR( ui_bigFont, "ui_bigFont", "0.4", CVAR_ARCHIVE )
UI_CVAR( ui_findPlayer, "ui_findPlayer", "Sarge", CVAR_ARCHIVE )
//UI_CVAR( ui_Q3Model, "ui_q3model", "0", CVAR_ARCHIVE ) // ~Dimmskii - Missionpack 2 only has normal models + pm/bright skins
//UI_CVAR( ui_hudFiles, "cg_hudFiles", "ui/mpp.txt", CVAR_ARCHIVE )
UI_CVAR( ui_hudFiles, "cg_hudFiles", "ui/hud.txt", CVAR_ARCHIVE ) // ~Dimmskii
UI_CVAR( ui_recordSPDemo, "ui_recordSPDemo", "0", CVAR_ARCHIVE )
//UI_CVAR( ui_teamArenaFirstRun, "ui_teamArenaFirstRun", "0", CVAR_ARCHIVE )
//UI_CVAR( ui_realWarmUp, "g_warmup", "20", CVAR_ARCHIVE )
//UI_CVAR( ui_realCaptureLimit, "capturelimit", "8", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART )
UI_CVAR( ui_serverStatusTimeOut, "ui_serverStatusTimeOut", "7000", CVAR_ARCHIVE )

// ~Dimmskii
UI_CVAR( ui_missionStr, "ui_missionStr", "exec missions/demo1.cfg", 0 )
UI_CVAR( ui_serverFilterType, "ui_serverFilterType", "-1", 0 )
UI_CVAR( ui_hostGameFactory, "ui_hostGameFactory", "0", 0 )
UI_CVAR( ui_realSmoothClients, "g_smoothClients", "1", CVAR_ARCHIVE )

// Below this line are UI cvars to be transformed into real factory cvars on menuscript 'StartServer' run
// These cvars are archived so that selecting "Custom" factory will recall the user's custom rules
UI_CVAR( ui_fraglimit, "ui_fraglimit", "50", CVAR_ARCHIVE )
UI_CVAR( ui_roundlimit, "ui_roundlimit", "10", CVAR_ARCHIVE )
UI_CVAR( ui_capturelimit, "ui_capturelimit", "10", CVAR_ARCHIVE )
UI_CVAR( ui_timelimit, "ui_timelimit", "15", CVAR_ARCHIVE )
UI_CVAR( ui_roundtimelimit, "ui_roundtimelimit", "180", CVAR_ARCHIVE )
UI_CVAR( ui_warmup, "ui_warmup", "15", CVAR_ARCHIVE )

// Below this line factory cont'd -- "Customize" gamerules separate menu
UI_CVAR( ui_instagib, "ui_instagib", "0", CVAR_ARCHIVE )
UI_CVAR( ui_fastWeaponSwitch, "ui_fastWeaponSwitch", "0", CVAR_ARCHIVE )
UI_CVAR( ui_noSelfDamage, "ui_noSelfDamage", "0", CVAR_ARCHIVE )
UI_CVAR( ui_itemTimers, "ui_itemTimers", "0", CVAR_ARCHIVE )
UI_CVAR( ui_allowHandicap, "ui_allowHandicap", "0", CVAR_ARCHIVE )

UI_CVAR( ui_friendlyFire, "ui_friendlyFire", "0", CVAR_ARCHIVE )
UI_CVAR( ui_teamVisibility, "ui_teamVisibility", "1", CVAR_ARCHIVE )
UI_CVAR( ui_allSpec, "ui_allSpec", "0", CVAR_ARCHIVE )
UI_CVAR( ui_1FRespawn, "ui_1FRespawn", "0", CVAR_ARCHIVE )

//dmflags deconstructed
UI_CVAR( ui_dmflags_noFalling, "ui_dmflags_noFalling", "0", CVAR_ARCHIVE )
UI_CVAR( ui_dmflags_fixedFov, "ui_dmflags_fixedFov", "0", CVAR_ARCHIVE )
UI_CVAR( ui_dmflags_noFootsteps, "ui_dmflags_noFootsteps", "0", CVAR_ARCHIVE )

// g_startingWeapons deconstructed
UI_CVAR( ui_wpflags_g, "ui_wpflags_g", "1", CVAR_ARCHIVE )
UI_CVAR( ui_wpflags_mg, "ui_wpflags_mg", "1", CVAR_ARCHIVE )
UI_CVAR( ui_wpflags_sg, "ui_wpflags_sg", "0", CVAR_ARCHIVE )
UI_CVAR( ui_wpflags_gl, "ui_wpflags_gl", "0", CVAR_ARCHIVE )
UI_CVAR( ui_wpflags_rl, "ui_wpflags_rl", "0", CVAR_ARCHIVE )
UI_CVAR( ui_wpflags_lg, "ui_wpflags_lg", "0", CVAR_ARCHIVE )
UI_CVAR( ui_wpflags_rg, "ui_wpflags_rg", "0", CVAR_ARCHIVE )
UI_CVAR( ui_wpflags_pg, "ui_wpflags_pg", "0", CVAR_ARCHIVE )
UI_CVAR( ui_wpflags_bfg, "ui_wpflags_bfg", "0", CVAR_ARCHIVE )
UI_CVAR( ui_wpflags_grapple, "ui_wpflags_grapple", "0", CVAR_ARCHIVE )
UI_CVAR( ui_wpflags_ng, "ui_wpflags_ng", "0", CVAR_ARCHIVE )
UI_CVAR( ui_wpflags_pl, "ui_wpflags_pl", "0", CVAR_ARCHIVE )
UI_CVAR( ui_wpflags_cg, "ui_wpflags_cg", "0", CVAR_ARCHIVE )
UI_CVAR( ui_wpflags_hmg, "ui_wpflags_hmg", "0", CVAR_ARCHIVE )

// Start ammo
UI_CVAR( ui_startingAmmo_mg, "ui_startingAmmo_mg", "50", CVAR_ARCHIVE )
UI_CVAR( ui_startingAmmo_sg, "ui_startingAmmo_sg", "10", CVAR_ARCHIVE )
UI_CVAR( ui_startingAmmo_gl, "ui_startingAmmo_gl", "5", CVAR_ARCHIVE )
UI_CVAR( ui_startingAmmo_rl, "ui_startingAmmo_rl", "5", CVAR_ARCHIVE )
UI_CVAR( ui_startingAmmo_lg, "ui_startingAmmo_lg", "60", CVAR_ARCHIVE )
UI_CVAR( ui_startingAmmo_rg, "ui_startingAmmo_rg", "10", CVAR_ARCHIVE )
UI_CVAR( ui_startingAmmo_pg, "ui_startingAmmo_pg", "30", CVAR_ARCHIVE )
UI_CVAR( ui_startingAmmo_bfg, "ui_startingAmmo_bfg", "15", CVAR_ARCHIVE )
UI_CVAR( ui_startingAmmo_ng, "ui_startingAmmo_ng", "20", CVAR_ARCHIVE )
UI_CVAR( ui_startingAmmo_pl, "ui_startingAmmo_pl", "10", CVAR_ARCHIVE )
UI_CVAR( ui_startingAmmo_cg, "ui_startingAmmo_cg", "100", CVAR_ARCHIVE )
UI_CVAR( ui_startingAmmo_hmg, "ui_startingAmmo_hmg", "50", CVAR_ARCHIVE )

// TODO: Implement into frontend
// Remaining GFACTORY_CVARS with no UI representation yet. Defaults below
// mirror each cvar's registered default in g_cvar.h/bg_cvar.h.

// General gameplay params
UI_CVAR( ui_removeammo, "ui_removeammo", "0", CVAR_ARCHIVE )
UI_CVAR( ui_removeitem, "ui_removeitem", "0", CVAR_ARCHIVE )
UI_CVAR( ui_removepowerup, "ui_removepowerup", "0", CVAR_ARCHIVE )
UI_CVAR( ui_removeweapon, "ui_removeweapon", "0", CVAR_ARCHIVE )
UI_CVAR( ui_railJump, "ui_railJump", "0", CVAR_ARCHIVE )
UI_CVAR( ui_railJumpDamage, "ui_railJumpDamage", "100", CVAR_ARCHIVE )
UI_CVAR( ui_forcerespawn, "ui_forcerespawn", "20", CVAR_ARCHIVE )
UI_CVAR( ui_gravity, "ui_gravity", "800", CVAR_ARCHIVE )
UI_CVAR( ui_speed, "ui_speed", "320", CVAR_ARCHIVE )
UI_CVAR( ui_knockback, "ui_knockback", "1000", CVAR_ARCHIVE )
UI_CVAR( ui_quadDamageFactor, "ui_quadDamageFactor", "3", CVAR_ARCHIVE )

// Starting things
UI_CVAR( ui_startingHealth, "ui_startingHealth", "0", CVAR_ARCHIVE )
UI_CVAR( ui_startingHealthBonus, "ui_startingHealthBonus", "0", CVAR_ARCHIVE )
UI_CVAR( ui_startingArmor, "ui_startingArmor", "0", CVAR_ARCHIVE )
UI_CVAR( ui_startingWeapon, "ui_startingWeapon", "", CVAR_ARCHIVE )

// Pickup respawns
UI_CVAR( ui_weaponRespawn, "ui_weaponRespawn", "5", CVAR_ARCHIVE )
UI_CVAR( ui_ammoRespawn, "ui_ammoRespawn", "5", CVAR_ARCHIVE )
UI_CVAR( ui_armorRespawn, "ui_armorRespawn", "25", CVAR_ARCHIVE )
UI_CVAR( ui_healthRespawn, "ui_healthRespawn", "35", CVAR_ARCHIVE )
UI_CVAR( ui_megahealthRespawn, "ui_megahealthRespawn", "35", CVAR_ARCHIVE )
UI_CVAR( ui_powerupRespawn, "ui_powerupRespawn", "120", CVAR_ARCHIVE )
UI_CVAR( ui_holdableRespawn, "ui_holdableRespawn", "60", CVAR_ARCHIVE )

// Direct hit damage cvars
UI_CVAR( ui_damage_g, "ui_damage_g", "50", CVAR_ARCHIVE )
UI_CVAR( ui_damage_mg, "ui_damage_mg", "7", CVAR_ARCHIVE )
UI_CVAR( ui_damage_sg, "ui_damage_sg", "10", CVAR_ARCHIVE )
UI_CVAR( ui_damage_gl, "ui_damage_gl", "100", CVAR_ARCHIVE )
UI_CVAR( ui_damage_rl, "ui_damage_rl", "100", CVAR_ARCHIVE )
UI_CVAR( ui_damage_lg, "ui_damage_lg", "8", CVAR_ARCHIVE )
UI_CVAR( ui_damage_rg, "ui_damage_rg", "100", CVAR_ARCHIVE )
UI_CVAR( ui_damage_pg, "ui_damage_pg", "20", CVAR_ARCHIVE )
UI_CVAR( ui_damage_bfg, "ui_damage_bfg", "100", CVAR_ARCHIVE )
UI_CVAR( ui_damage_gh, "ui_damage_gh", "10", CVAR_ARCHIVE )
UI_CVAR( ui_damage_ng, "ui_damage_ng", "20", CVAR_ARCHIVE )
UI_CVAR( ui_damage_pl, "ui_damage_pl", "0", CVAR_ARCHIVE )
UI_CVAR( ui_damage_cg, "ui_damage_cg", "7", CVAR_ARCHIVE )
UI_CVAR( ui_damage_hmg, "ui_damage_hmg", "8", CVAR_ARCHIVE )

// Splash damage and radius cvars
UI_CVAR( ui_splashdamage_gl, "ui_splashdamage_gl", "100", CVAR_ARCHIVE )
UI_CVAR( ui_splashdamage_rl, "ui_splashdamage_rl", "100", CVAR_ARCHIVE )
UI_CVAR( ui_splashdamage_pg, "ui_splashdamage_pg", "15", CVAR_ARCHIVE )
UI_CVAR( ui_splashdamage_bfg, "ui_splashdamage_bfg", "100", CVAR_ARCHIVE )
UI_CVAR( ui_splashdamage_pl, "ui_splashdamage_pl", "100", CVAR_ARCHIVE )
UI_CVAR( ui_splashradius_gl, "ui_splashradius_gl", "150", CVAR_ARCHIVE )
UI_CVAR( ui_splashradius_rl, "ui_splashradius_rl", "120", CVAR_ARCHIVE )
UI_CVAR( ui_splashradius_pg, "ui_splashradius_pg", "20", CVAR_ARCHIVE )
UI_CVAR( ui_splashradius_bfg, "ui_splashradius_bfg", "120", CVAR_ARCHIVE )
UI_CVAR( ui_splashradius_pl, "ui_splashradius_pl", "150", CVAR_ARCHIVE )

// Weapon reload times
UI_CVAR( ui_weapon_reload_gauntlet, "ui_weapon_reload_gauntlet", "400", CVAR_ARCHIVE )
UI_CVAR( ui_weapon_reload_mg, "ui_weapon_reload_mg", "100", CVAR_ARCHIVE )
UI_CVAR( ui_weapon_reload_sg, "ui_weapon_reload_sg", "1000", CVAR_ARCHIVE )
UI_CVAR( ui_weapon_reload_gl, "ui_weapon_reload_gl", "800", CVAR_ARCHIVE )
UI_CVAR( ui_weapon_reload_rl, "ui_weapon_reload_rl", "800", CVAR_ARCHIVE )
UI_CVAR( ui_weapon_reload_lg, "ui_weapon_reload_lg", "50", CVAR_ARCHIVE )
UI_CVAR( ui_weapon_reload_rg, "ui_weapon_reload_rg", "1500", CVAR_ARCHIVE )
UI_CVAR( ui_weapon_reload_pg, "ui_weapon_reload_pg", "100", CVAR_ARCHIVE )
UI_CVAR( ui_weapon_reload_bfg, "ui_weapon_reload_bfg", "200", CVAR_ARCHIVE )
UI_CVAR( ui_weapon_reload_hook, "ui_weapon_reload_hook", "400", CVAR_ARCHIVE )
UI_CVAR( ui_weapon_reload_ng, "ui_weapon_reload_ng", "1000", CVAR_ARCHIVE )
UI_CVAR( ui_weapon_reload_prox, "ui_weapon_reload_prox", "800", CVAR_ARCHIVE )
UI_CVAR( ui_weapon_reload_cg, "ui_weapon_reload_cg", "30", CVAR_ARCHIVE )
UI_CVAR( ui_weapon_reload_hmg, "ui_weapon_reload_hmg", "75", CVAR_ARCHIVE )

// SG Settings
UI_CVAR( ui_sgPellets, "ui_sgPellets", "11", CVAR_ARCHIVE )
UI_CVAR( ui_sgPelletSpread, "ui_sgPelletSpread", "700", CVAR_ARCHIVE )

// RL Settings
UI_CVAR( ui_velocity_rl, "ui_velocity_rl", "900", CVAR_ARCHIVE )

// Grapple settings
UI_CVAR( ui_grappleDelayTime, "ui_grappleDelayTime", "400", CVAR_ARCHIVE )
UI_CVAR( ui_grappleHoldTime, "ui_grappleHoldTime", "0", CVAR_ARCHIVE )
UI_CVAR( ui_grappleSpeed, "ui_grappleSpeed", "1600", CVAR_ARCHIVE )
UI_CVAR( ui_grapplePull, "ui_grapplePull", "800", CVAR_ARCHIVE )

// NG Settings
UI_CVAR( ui_nailBounce, "ui_nailBounce", "1", CVAR_ARCHIVE )

// PL Settings
UI_CVAR( ui_proxMineTimeout, "ui_proxMineTimeout", "20000", CVAR_ARCHIVE )

// Obelisk (Overload)
UI_CVAR( ui_obeliskHealth, "ui_obeliskHealth", "2500", CVAR_ARCHIVE )
UI_CVAR( ui_obeliskRegenPeriod, "ui_obeliskRegenPeriod", "1", CVAR_ARCHIVE )
UI_CVAR( ui_obeliskRegenAmount, "ui_obeliskRegenAmount", "15", CVAR_ARCHIVE )
UI_CVAR( ui_obeliskRespawnDelay, "ui_obeliskRespawnDelay", "10", CVAR_ARCHIVE )
// END Dimmskii

#undef UI_CVAR
