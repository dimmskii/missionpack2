#ifdef EXTERN_CG_CVAR
	#define CG_CVAR( vmCvar, cvarName, defaultString, cvarFlags ) extern vmCvar_t vmCvar;
#endif

#ifdef DECLARE_CG_CVAR
	#define CG_CVAR( vmCvar, cvarName, defaultString, cvarFlags ) vmCvar_t vmCvar;
#endif

#ifdef CG_CVAR_LIST
	#define CG_CVAR( vmCvar, cvarName, defaultString, cvarFlags ) { & vmCvar, cvarName, defaultString, cvarFlags },
#endif

CG_CVAR( cg_ignore, "cg_ignore", "0", 0 ) // used for debugging
CG_CVAR( cg_autoswitch, "cg_autoswitch", "1", CVAR_ARCHIVE )
CG_CVAR( cg_drawGun, "cg_drawGun", "1", CVAR_ARCHIVE )
CG_CVAR( cg_zoomFov, "cg_zoomfov", "22.5", CVAR_ARCHIVE )
CG_CVAR( cg_fov, "cg_fov", "90", CVAR_ARCHIVE )
CG_CVAR( cg_viewsize, "cg_viewsize", "100", CVAR_ARCHIVE )
CG_CVAR( cg_shadows, "cg_shadows", "1", CVAR_ARCHIVE )
CG_CVAR( cg_gibs, "cg_gibs", "1", CVAR_ARCHIVE )
CG_CVAR( cg_draw2D, "cg_draw2D", "1", CVAR_ARCHIVE )
CG_CVAR( cg_drawStatus, "cg_drawStatus", "1", CVAR_ARCHIVE )
CG_CVAR( cg_drawTimer, "cg_drawTimer", "0", CVAR_ARCHIVE )
CG_CVAR( cg_drawFPS, "cg_drawFPS", "0", CVAR_ARCHIVE )
CG_CVAR( cg_drawSnapshot, "cg_drawSnapshot", "0", CVAR_ARCHIVE  )
CG_CVAR( cg_draw3dIcons, "cg_draw3dIcons", "1", CVAR_ARCHIVE )
CG_CVAR( cg_drawIcons, "cg_drawIcons", "1", CVAR_ARCHIVE )
CG_CVAR( cg_drawAmmoWarning, "cg_drawAmmoWarning", "1", CVAR_ARCHIVE )
CG_CVAR( cg_drawAttacker, "cg_drawAttacker", "1", CVAR_ARCHIVE )
CG_CVAR( cg_drawSpeed, "cg_drawSpeed", "0", CVAR_ARCHIVE )
CG_CVAR( cg_drawCrosshair, "cg_drawCrosshair", "4", CVAR_ARCHIVE )
CG_CVAR( cg_drawCrosshairNames, "cg_drawCrosshairNames", "1", CVAR_ARCHIVE )
CG_CVAR( cg_crosshairColor, "cg_crosshairColor", "7", CVAR_ARCHIVE )
CG_CVAR( cg_drawRewards, "cg_drawRewards", "1", CVAR_ARCHIVE )
CG_CVAR( cg_drawWeaponSelect, "cg_drawWeaponSelect", "1", CVAR_ARCHIVE )
CG_CVAR( cg_crosshairSize, "cg_crosshairSize", "24", CVAR_ARCHIVE )
CG_CVAR( cg_crosshairHealth, "cg_crosshairHealth", "1", CVAR_ARCHIVE )
CG_CVAR( cg_crosshairX, "cg_crosshairX", "0", CVAR_ARCHIVE )
CG_CVAR( cg_crosshairY, "cg_crosshairY", "0", CVAR_ARCHIVE )
CG_CVAR( cg_brassTime, "cg_brassTime", "2500", CVAR_ARCHIVE )
CG_CVAR( cg_simpleItems, "cg_simpleItems", "0", CVAR_ARCHIVE )
CG_CVAR( cg_addMarks, "cg_marks", "1", CVAR_ARCHIVE )
CG_CVAR( cg_lagometer, "cg_lagometer", "1", CVAR_ARCHIVE )
CG_CVAR( cg_railTrailTime, "cg_railTrailTime", "400", CVAR_ARCHIVE  )
CG_CVAR( cg_railTrailRadius, "cg_railTrailRadius", "0", CVAR_ARCHIVE  )
CG_CVAR( cg_gun_frame, "cg_gun_frame", "", CVAR_ROM )
CG_CVAR( cg_gun_x, "cg_gunX", "0", CVAR_ARCHIVE )
CG_CVAR( cg_gun_y, "cg_gunY", "0", CVAR_ARCHIVE )
CG_CVAR( cg_gun_z, "cg_gunZ", "0", CVAR_ARCHIVE )
CG_CVAR( cg_centertime, "cg_centertime", "3", CVAR_CHEAT )
CG_CVAR( cg_runpitch, "cg_runpitch", "0.002", CVAR_ARCHIVE )
CG_CVAR( cg_runroll, "cg_runroll", "0.005", CVAR_ARCHIVE )
CG_CVAR( cg_bobup , "cg_bobup", "0.005", CVAR_ARCHIVE )
CG_CVAR( cg_bobpitch, "cg_bobpitch", "0.002", CVAR_ARCHIVE )
CG_CVAR( cg_bobroll, "cg_bobroll", "0.002", CVAR_ARCHIVE )
CG_CVAR( cg_swingSpeed, "cg_swingSpeed", "0.3", CVAR_CHEAT )
CG_CVAR( cg_animSpeed, "cg_animspeed", "1", CVAR_CHEAT )
CG_CVAR( cg_debugAnim, "cg_debuganim", "0", CVAR_CHEAT )
CG_CVAR( cg_debugPosition, "cg_debugposition", "0", CVAR_CHEAT )
CG_CVAR( cg_debugEvents, "cg_debugevents", "0", CVAR_CHEAT )
CG_CVAR( cg_errorDecay, "cg_errordecay", "100", 0 )
CG_CVAR( cg_nopredict, "cg_nopredict", "0", 0 )
CG_CVAR( cg_noPlayerAnims, "cg_noplayeranims", "0", CVAR_CHEAT )
CG_CVAR( cg_showmiss, "cg_showmiss", "0", 0 )
CG_CVAR( cg_footsteps, "cg_footsteps", "1", CVAR_CHEAT )
CG_CVAR( cg_tracerChance, "cg_tracerchance", "0.4", CVAR_CHEAT )
CG_CVAR( cg_tracerWidth, "cg_tracerwidth", "1", CVAR_CHEAT )
CG_CVAR( cg_tracerLength, "cg_tracerlength", "100", CVAR_CHEAT )
CG_CVAR( cg_thirdPersonRange, "cg_thirdPersonRange", "40", CVAR_CHEAT )
CG_CVAR( cg_thirdPersonAngle, "cg_thirdPersonAngle", "0", CVAR_CHEAT )
CG_CVAR( cg_thirdPerson, "cg_thirdPerson", "0", 0 )
CG_CVAR( cg_teamChatTime, "cg_teamChatTime", "3000", CVAR_ARCHIVE  )
CG_CVAR( cg_teamChatHeight, "cg_teamChatHeight", "0", CVAR_ARCHIVE  )
CG_CVAR( cg_forceModel, "cg_forceModel", "0", CVAR_ARCHIVE  )
CG_CVAR( cg_predictItems, "cg_predictItems", "1", CVAR_ARCHIVE )
//#ifdef MISSIONPACK
CG_CVAR( cg_deferPlayers, "cg_deferPlayers", "0", CVAR_ARCHIVE )
//#else
//CG_CVAR( cg_deferPlayers, "cg_deferPlayers", "1", CVAR_ARCHIVE )
//#endif
//CG_CVAR( cg_drawTeamOverlay, "cg_drawTeamOverlay", "0", CVAR_ARCHIVE )
CG_CVAR( cg_drawTeamOverlay, "cg_drawTeamOverlay", "1", CVAR_ARCHIVE ) // ~Dimmskii
CG_CVAR( cg_teamOverlayUserinfo, "teamoverlay", "0", CVAR_ROM | CVAR_USERINFO )
CG_CVAR( cg_stats, "cg_stats", "0", 0 )
CG_CVAR( cg_drawFriend, "cg_drawFriend", "1", CVAR_ARCHIVE )
CG_CVAR( cg_teamChatsOnly, "cg_teamChatsOnly", "0", CVAR_ARCHIVE )
//#ifdef MISSIONPACK
CG_CVAR( cg_noVoiceChats, "cg_noVoiceChats", "0", CVAR_ARCHIVE )
CG_CVAR( cg_noVoiceText, "cg_noVoiceText", "0", CVAR_ARCHIVE )
//#endif
// the following variables are created in other parts of the system,
// but we also reference them here
CG_CVAR( cg_buildScript, "com_buildScript", "0", 0 )	// force loading of all possible data amd error on failures
CG_CVAR( cg_paused, "cl_paused", "0", CVAR_ROM )
CG_CVAR( cg_blood, "com_blood", "1", CVAR_ARCHIVE )
//#ifdef MISSIONPACK
CG_CVAR( cg_redTeamName, "g_redteam", "", CVAR_SERVERINFO | CVAR_USERINFO )
CG_CVAR( cg_blueTeamName, "g_blueteam", "", CVAR_SERVERINFO | CVAR_USERINFO )
CG_CVAR( cg_currentSelectedPlayer, "cg_currentSelectedPlayer", "0", CVAR_ARCHIVE )
CG_CVAR( cg_currentSelectedPlayerName, "cg_currentSelectedPlayerName", "", CVAR_ARCHIVE )
CG_CVAR( cg_singlePlayer, "ui_singlePlayerActive", "0", CVAR_USERINFO )
CG_CVAR( cg_enableDust, "g_enableDust", "0", CVAR_SERVERINFO )
CG_CVAR( cg_enableBreath, "g_enableBreath", "0", CVAR_SERVERINFO )
CG_CVAR( cg_singlePlayerActive, "ui_singlePlayerActive", "0", CVAR_USERINFO )
CG_CVAR( cg_recordSPDemo, "ui_recordSPDemo", "0", CVAR_ARCHIVE )
CG_CVAR( cg_recordSPDemoName, "ui_recordSPDemoName", "", CVAR_ARCHIVE )
CG_CVAR( cg_obeliskRespawnDelay, "g_obeliskRespawnDelay", "10", CVAR_SERVERINFO )
//CG_CVAR( cg_hudFiles, "cg_hudFiles", "ui/mpp.txt", CVAR_ARCHIVE )
CG_CVAR( cg_hudFiles, "cg_hudFiles", "", CVAR_ARCHIVE ) // ~Dimmskii -- Default empty (""), which means show our improved vhud (vanilla hud) instead of TA .menu stuff. Grumpy old people love this one.
//#endif
CG_CVAR( cg_cameraOrbit, "cg_cameraOrbit", "0", CVAR_CHEAT )
CG_CVAR( cg_cameraOrbitDelay, "cg_cameraOrbitDelay", "50", CVAR_ARCHIVE )
CG_CVAR( cg_timescaleFadeEnd, "cg_timescaleFadeEnd", "1", 0 )
CG_CVAR( cg_timescaleFadeSpeed, "cg_timescaleFadeSpeed", "0", 0 )
CG_CVAR( cg_timescale, "timescale", "1", 0 )
CG_CVAR( cg_scorePlum, "cg_scorePlums", "1", CVAR_USERINFO | CVAR_ARCHIVE )
CG_CVAR( cg_smoothClients, "cg_smoothClients", "0", CVAR_USERINFO | CVAR_ARCHIVE )
CG_CVAR( cg_cameraMode, "com_cameraMode", "0", CVAR_CHEAT )
CG_CVAR( cg_noTaunt, "cg_noTaunt", "0", CVAR_ARCHIVE )
CG_CVAR( cg_noProjectileTrail, "cg_noProjectileTrail", "0", CVAR_ARCHIVE )
CG_CVAR( cg_smallFont, "ui_smallFont", "0.25", CVAR_ARCHIVE )
CG_CVAR( cg_bigFont, "ui_bigFont", "0.4", CVAR_ARCHIVE )
CG_CVAR( cg_oldRail, "cg_oldRail", "1", CVAR_ARCHIVE )
CG_CVAR( cg_oldRocket, "cg_oldRocket", "1", CVAR_ARCHIVE )
CG_CVAR( cg_oldPlasma, "cg_oldPlasma", "1", CVAR_ARCHIVE )
CG_CVAR( cg_trueLightning, "cg_trueLightning", "0.0", CVAR_ARCHIVE )
CG_CVAR( cg_kickScale, "cg_kickScale", "0", CVAR_ARCHIVE )
CG_CVAR( cg_hitSounds, "cg_hitSounds", "0", CVAR_ARCHIVE )
//CG_CVAR( cg_enemyModel, "cg_enemyModel", "", CVAR_ARCHIVE )
//CG_CVAR( cg_enemyColors, "cg_enemyColors", "", CVAR_ARCHIVE )
//CG_CVAR( cg_teamModel, "cg_teamModel", "", CVAR_ARCHIVE )
//CG_CVAR( cg_teamColors, "cg_teamColors", "", CVAR_ARCHIVE )

// ~Dimmskii -- QL force model/skin split replaces the packed cg_enemyModel/cg_teamModel above
CG_CVAR( cg_forceEnemyModel, "cg_forceEnemyModel", "", CVAR_ARCHIVE )
CG_CVAR( cg_forceEnemySkin, "cg_forceEnemySkin", "", CVAR_ARCHIVE )
CG_CVAR( cg_forceTeamModel, "cg_forceTeamModel", "", CVAR_ARCHIVE )
CG_CVAR( cg_forceTeamSkin, "cg_forceTeamSkin", "", CVAR_ARCHIVE )
// only used by QL's team preview ownerdraws, which we don't have - registered so QL configs don't error
CG_CVAR( cg_forceRedTeamModel, "cg_forceRedTeamModel", "", CVAR_ARCHIVE )
CG_CVAR( cg_forceBlueTeamModel, "cg_forceBlueTeamModel", "", CVAR_ARCHIVE )
// END Dimmskii

// ~Dimmskii -- QL-style per-part hex model colors replace the packed CPMA strings above; empty = team auto
CG_CVAR( cg_enemyHeadColor, "cg_enemyHeadColor", "0x2a8000FF", CVAR_ARCHIVE )
CG_CVAR( cg_enemyUpperColor, "cg_enemyUpperColor", "0x2a8000FF", CVAR_ARCHIVE )
CG_CVAR( cg_enemyLowerColor, "cg_enemyLowerColor", "0x2a8000FF", CVAR_ARCHIVE )
CG_CVAR( cg_teamHeadColor, "cg_teamHeadColor", "", CVAR_ARCHIVE )
CG_CVAR( cg_teamUpperColor, "cg_teamUpperColor", "", CVAR_ARCHIVE )
CG_CVAR( cg_teamLowerColor, "cg_teamLowerColor", "", CVAR_ARCHIVE )
// END Dimmskii

CG_CVAR( cg_deadBodyDarken, "cg_deadBodyDarken", "1", CVAR_ARCHIVE )
CG_CVAR( cg_fovAdjust, "cg_fovAdjust", "0", CVAR_ARCHIVE )
CG_CVAR( cg_followKiller, "cg_followKiller", "0", CVAR_ARCHIVE )

//  ~DIMMSKII
// All POIs
CG_CVAR( cg_poiTextBgAlpha, "cg_poiTextBgAlpha", "0.3", CVAR_ARCHIVE )
CG_CVAR( cg_poiMaxDist, "cg_poiMaxDist", "32768", CVAR_ARCHIVE )

// QL HUD compat: read-only shadow of cgs.gametype, mirrored in
// CG_ParseServerinfo (ported from QL-SRP's cg_gametype). Our gametype_t
// already matches QL's numbering directly through GT_TEAMTOURNAMENT(13), so
// showCvar literals from a real QL .menu file (e.g. hud.menu's Round panel:
// cvarTest "cg_gametype" showCvar { "12" }) work unmodified.
CG_CVAR( cg_gametype, "cg_gametype", "0", CVAR_ROM )

// Teammate POIs
CG_CVAR( cg_teammatePOIs, "cg_teammatePOIs", "1", CVAR_ROM ) // Read-only QL compat CG cvar cg_teammatePOIs = (cg_drawFriend.int>1)
CG_CVAR( cg_teammateNames, "cg_teammateNames", "1", CVAR_ARCHIVE ) // 0=Off 1=Targeted 2=Always. No effect unless cg_drawFriend is 2 (cg_teammatePOIs is 1)
CG_CVAR( cg_teammatePOIsIconSize, "cg_teammatePOIsIconSize", "8", CVAR_ARCHIVE ) // No effect unless cg_drawFriend is 2 (cg_teammatePOIs is 1)
CG_CVAR( cg_teammatePOIsIconMinSize, "cg_teammatePOIsIconMinSize", "4", CVAR_ARCHIVE ) // No effect unless cg_drawFriend is 2 (cg_teammatePOIs is 1)
CG_CVAR( cg_teammatePOIsIconMaxSize, "cg_teammatePOIsIconMaxSize", "12", CVAR_ARCHIVE ) // No effect unless cg_drawFriend is 2 (cg_teammatePOIs is 1)

// Powerup POIs
CG_CVAR( cg_powerupPOIs, "cg_powerupPOIs", "0", CVAR_ARCHIVE )
CG_CVAR( cg_powerupPOIsTimers, "cg_powerupPOIsTimers", "1", CVAR_ARCHIVE ) // No effect unless cg_powerupPOIs is 1
CG_CVAR( cg_powerupPOIsIconSize, "cg_powerupPOIsIconSize", "24", CVAR_ARCHIVE ) // No effect unless cg_powerupPOIs is 1
CG_CVAR( cg_powerupPOIsIconMinSize, "cg_powerupPOIsIconMinSize", "4", CVAR_ARCHIVE ) // No effect unless cg_powerupPOIs is 1
CG_CVAR( cg_powerupPOIsIconMaxSize, "cg_powerupPOIsIconMaxSize", "12", CVAR_ARCHIVE ) // No effect unless cg_powerupPOIs is 1

// Flag POIs
CG_CVAR( cg_flagPOIs, "cg_flagPOIs", "0", CVAR_ARCHIVE )
CG_CVAR( cg_flagPOIsTexts, "cg_flagPOIsTexts", "0", CVAR_ARCHIVE ) // No effect unless cg_flagPOIs is 1
CG_CVAR( cg_flagPOIsIconSize, "cg_flagPOIsIconSize", "24", CVAR_ARCHIVE ) // No effect unless cg_flagPOIs is 1
CG_CVAR( cg_flagPOIsIconMinSize, "cg_flagPOIsIconMinSize", "10", CVAR_ARCHIVE ) // No effect unless cg_flagPOIs is 1
CG_CVAR( cg_flagPOIsIconMaxSize, "cg_flagPOIsIconMaxSize", "24", CVAR_ARCHIVE ) // No effect unless cg_flagPOIs is 1

// Item timers
CG_CVAR( cg_itemTimers, "cg_itemTimers", "1", CVAR_ARCHIVE ) //  No longer handled with POI code TODO: Has no effect. Implement this.

// Sound
CG_CVAR( cg_killBeep, "cg_killBeep", "0", CVAR_ARCHIVE ) // QL-style kill confirmation beep on frag (sound/world/bell_01.ogg)
// END Dimmskii

#undef CG_CVAR
