// cg_olddraw.c
//
// OLD HUD DRAWING FOR WHEN TA HUD IS DISABLED
// ~Dimmskii

#include "cg_local.h"
#include "../ui/ui_shared.h"

// ~Dimmskii
// Forward declarations. These file-local helpers are DEFINED further down,
// after CG_DrawStatusBar_Old which calls them. Without these prototypes the
// q3lcc VM compiler gives each unprototyped call an implicit int() decl and
// pushes the (int) x argument, while the real definition reads that stack
// slot as a float. The bit pattern of e.g. int 285 reinterpreted as float32
// is a denormal (~4e-43 == 0.0), so the head/flag drew at x=0 (screen left)
// while every other status-bar element - which calls functions already
// prototyped in cg_local.h - passed its float coordinates correctly. Vanilla
// ioq3 avoids this by defining these before CG_DrawStatusBar; the port
// reordered them below their caller. Any future helper added below its caller
// in this file needs the same treatment.
static void CG_DrawStatusBarHead_Old( float x );
static void CG_DrawStatusBarFlag_Old( float x, int team );
// END Dimmskii


/*
==============
CG_DrawField_Old

Draws large numbers for status bar and powerups
==============
*/
static void CG_DrawField_Old (int x, int y, int width, int value) {
	char	num[16], *ptr;
	int		l;
	int		frame;

	if ( width < 1 ) {
		return;
	}

	// draw number string
	if ( width > 5 ) {
		width = 5;
	}

	switch ( width ) {
	case 1:
		value = value > 9 ? 9 : value;
		value = value < 0 ? 0 : value;
		break;
	case 2:
		value = value > 99 ? 99 : value;
		value = value < -9 ? -9 : value;
		break;
	case 3:
		value = value > 999 ? 999 : value;
		value = value < -99 ? -99 : value;
		break;
	case 4:
		value = value > 9999 ? 9999 : value;
		value = value < -999 ? -999 : value;
		break;
	}

	Com_sprintf (num, sizeof(num), "%i", value);
	l = strlen(num);
	if (l > width)
		l = width;
	x += 2 + CHAR_WIDTH*(width - l);

	ptr = num;
	while (*ptr && l)
	{
		if (*ptr == '-')
			frame = STAT_MINUS;
		else
			frame = *ptr -'0';

		CG_DrawPic( x,y, CHAR_WIDTH, CHAR_HEIGHT, cgs.media.numberShaders[frame] );
		x += CHAR_WIDTH;
		ptr++;
		l--;
	}
}


/*
================
CG_DrawStatusBar_Old
================
*/
#define STATUSBAR_HEIGHT_OLD 60
// ~Dimmskii - exported (see cg_local.h) so CG_Draw2D (cg_draw.c) can call
// into it for the debug old-hud overlay. Everything else in this file stays
// static/internal to cg_olddraw.c.
void CG_DrawStatusBar_Old( void ) {
	int			color;
	centity_t	*cent;
	playerState_t	*ps;
	int			value;
	vec4_t		hcolor;
	vec3_t		angles;
	vec3_t		origin;
	float		y;
	qhandle_t	handle;

	static float colors[4][4] = { 
//		{ 0.2, 1.0, 0.2, 1.0 } , { 1.0, 0.2, 0.2, 1.0 }, {0.5, 0.5, 0.5, 1} };
		{ 1.0f, 0.69f, 0.0f, 1.0f },    // normal
		{ 1.0f, 0.2f, 0.2f, 1.0f },     // low health
		{ 0.5f, 0.5f, 0.5f, 1.0f },     // weapon firing
		{ 1.0f, 1.0f, 1.0f, 1.0f } };   // health > 100

	if ( cg_drawStatus.integer == 0 ) {
		return;
	}

	// draw the team background
	CG_DrawTeamBackground( cgs.screenXmin, cgs.screenYmax - STATUSBAR_HEIGHT_OLD + 1,
		cgs.screenXmax - cgs.screenXmin + 1, STATUSBAR_HEIGHT_OLD, 
		0.33f, cg.snap->ps.persistant[ PERS_TEAM ] );

	y = cgs.screenYmax + 1 - ICON_SIZE;

	cent = &cg_entities[cg.snap->ps.clientNum];
	ps = &cg.snap->ps;

	VectorClear( angles );

	// draw any 3D icons first, so the changes back to 2D are minimized
	if ( cent->currentState.weapon && cg_weapons[ cent->currentState.weapon ].ammoModel ) {
		origin[0] = 70;
		origin[1] = 0;
		origin[2] = 0;
		angles[YAW] = 90 + 20 * sin( ( cg.time % TMOD_1000 ) / 1000.0 );
		CG_Draw3DModel( CHAR_WIDTH*3 + TEXT_ICON_SPACE, y, ICON_SIZE, ICON_SIZE,
					   cg_weapons[ cent->currentState.weapon ].ammoModel, 0, origin, angles );
	}

	CG_DrawStatusBarHead_Old( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE );

	if( cg.predictedPlayerState.powerups[PW_REDFLAG] ) {
		CG_DrawStatusBarFlag_Old( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_RED );
	} else if( cg.predictedPlayerState.powerups[PW_BLUEFLAG] ) {
		CG_DrawStatusBarFlag_Old( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_BLUE );
	} else if( cg.predictedPlayerState.powerups[PW_NEUTRALFLAG] ) {
		CG_DrawStatusBarFlag_Old( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_FREE );
	}

	if ( ps->stats[ STAT_ARMOR ] ) {
		origin[0] = 90;
		origin[1] = 0;
		origin[2] = -10;
		angles[YAW] = ( cg.time & 2047 ) * 360 / 2048.0;
		CG_Draw3DModel( 370 + CHAR_WIDTH*3 + TEXT_ICON_SPACE, y, ICON_SIZE, ICON_SIZE,
					   cgs.media.armorModel, 0, origin, angles );
	}

	if( cgs.gametype == GT_HARVESTER ) {
		origin[0] = 90;
		origin[1] = 0;
		origin[2] = -10;
		angles[YAW] = ( cg.time & 2047 ) * 360 / 2048.0;
		if( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
			handle = cgs.media.redCubeModel;
		} else {
			handle = cgs.media.blueCubeModel;
		}
		CG_Draw3DModel( 640 - (TEXT_ICON_SPACE + ICON_SIZE), 416, ICON_SIZE, ICON_SIZE, handle, 0, origin, angles );
	}

	//
	// ammo
	//
	if ( cent->currentState.weapon ) {
		value = ps->ammo[cent->currentState.weapon];
		if ( value > -1 ) {
			if ( cg.predictedPlayerState.weaponstate == WEAPON_FIRING
				&& cg.predictedPlayerState.weaponTime > 100 ) {
				// draw as dark grey when reloading
				color = 2;	// dark grey
			} else {
				if ( value >= 0 ) {
					color = 0;	// yellow
				} else {
					color = 1;	// red
				}
			}
#ifdef USE_NEW_FONT_RENDERER
			CG_SelectFont( 1 );
			CG_DrawString( CHAR_WIDTH*3, y, va( "%i", value ), colors[ color ], CHAR_WIDTH, CHAR_HEIGHT, 0, DS_RIGHT | DS_PROPORTIONAL );
			CG_SelectFont( 0 );
#else
			trap_R_SetColor( colors[color] );
			CG_DrawField_Old( 0, y, 3, value );
#endif
			trap_R_SetColor( NULL );

			// if we didn't draw a 3D icon, draw a 2D icon for ammo
			if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
				qhandle_t	icon;

				icon = cg_weapons[ cg.predictedPlayerState.weapon ].ammoIcon;
				if ( icon ) {
					CG_DrawPic( CHAR_WIDTH*3 + TEXT_ICON_SPACE, y, ICON_SIZE, ICON_SIZE, icon );
				}
			}
		}
	}

	//
	// health
	//
	value = ps->stats[STAT_HEALTH];
	if ( value > 100 ) {
		color = 3; // white
	} else if ( value > 25 ) {
		color = 0; 	// yellow
	} else if (value > 0) {
		color = (cg.time >> 8) & 1;	// red/yellow flashing
	} else {
		color = 1; // red
	}

#ifdef USE_NEW_FONT_RENDERER
	CG_SelectFont( 1 );
	CG_DrawString( 185 + CHAR_WIDTH*3, y, va( "%i", value ), colors[ color ], CHAR_WIDTH, CHAR_HEIGHT, 0, DS_RIGHT | DS_PROPORTIONAL );
	CG_SelectFont( 0 );
#else
	trap_R_SetColor( colors[ color ] );
	// stretch the health up when taking damage
	CG_DrawField_Old( 185, y, 3, value );
#endif
	
	CG_ColorForHealth( hcolor );
	trap_R_SetColor( hcolor );

	//
	// armor
	//
	value = ps->stats[STAT_ARMOR];
	if ( value > 0 ) {
#ifdef USE_NEW_FONT_RENDERER
		CG_SelectFont( 1 );
		CG_DrawString( 370 + CHAR_WIDTH*3, y, va( "%i", value ), colors[ color ], CHAR_WIDTH, CHAR_HEIGHT, 0, DS_RIGHT | DS_PROPORTIONAL );
		CG_SelectFont( 0 );
#else
		trap_R_SetColor( colors[0] );
		CG_DrawField_Old( 370, y, 3, value );
#endif
		trap_R_SetColor( NULL );
		// if we didn't draw a 3D icon, draw a 2D icon for armor
		if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
			CG_DrawPic( 370 + CHAR_WIDTH*3 + TEXT_ICON_SPACE, y, ICON_SIZE, ICON_SIZE, cgs.media.armorIcon );
		}
	}

	//
	// cubes
	//
	if( cgs.gametype == GT_HARVESTER ) {
		value = ps->generic1;
		if( value > 99 ) {
			value = 99;
		}
		trap_R_SetColor( colors[0] );
		CG_DrawField_Old (640 - (CHAR_WIDTH*2 + TEXT_ICON_SPACE + ICON_SIZE), y, 2, value);
		trap_R_SetColor( NULL );
		// if we didn't draw a 3D icon, draw a 2D icon for armor
		if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
			if( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
				handle = cgs.media.redCubeIcon;
			} else {
				handle = cgs.media.blueCubeIcon;
			}
			CG_DrawPic( 640 - (TEXT_ICON_SPACE + ICON_SIZE), y, ICON_SIZE, ICON_SIZE, handle );
		}
	}
}


/*
================
CG_DrawStatusBarHead_Old

================
*/
static void CG_DrawStatusBarHead_Old( float x ) {
	vec3_t		angles;
	float		size, stretch;
	float		frac;

	VectorClear( angles );

	if ( cg.damageTime && cg.time - cg.damageTime < DAMAGE_TIME ) {
		frac = (float)(cg.time - cg.damageTime ) / DAMAGE_TIME;
		size = ICON_SIZE * 1.25 * ( 1.5 - frac * 0.5 );

		stretch = size - ICON_SIZE * 1.25;
		// kick in the direction of damage
		x -= stretch * 0.5 + cg.damageX * stretch * 0.5;

		cg.headStartYaw = 180 + cg.damageX * 45;

		cg.headEndYaw = 180 + 20 * cos( crandom()*M_PI );
		cg.headEndPitch = 5 * cos( crandom()*M_PI );

		cg.headStartTime = cg.time;
		cg.headEndTime = cg.time + 100 + random() * 2000;
	} else {
		if ( cg.time >= cg.headEndTime ) {
			// select a new head angle
			cg.headStartYaw = cg.headEndYaw;
			cg.headStartPitch = cg.headEndPitch;
			cg.headStartTime = cg.headEndTime;
			cg.headEndTime = cg.time + 100 + random() * 2000;

			cg.headEndYaw = 180 + 20 * cos( crandom()*M_PI );
			cg.headEndPitch = 5 * cos( crandom()*M_PI );
		}

		size = ICON_SIZE * 1.25;
	}

	// if the server was frozen for a while we may have a bad head start time
	if ( cg.headStartTime > cg.time ) {
		cg.headStartTime = cg.time;
	}

	frac = ( cg.time - cg.headStartTime ) / (float)( cg.headEndTime - cg.headStartTime );
	frac = frac * frac * ( 3 - 2 * frac );
	angles[YAW] = cg.headStartYaw + ( cg.headEndYaw - cg.headStartYaw ) * frac;
	angles[PITCH] = cg.headStartPitch + ( cg.headEndPitch - cg.headStartPitch ) * frac;

	CG_DrawHead( x, cgs.screenYmax + 1 - size, size, size, cg.snap->ps.clientNum, angles );
}


/*
================
CG_DrawStatusBarFlag_Old

================
*/
static void CG_DrawStatusBarFlag_Old( float x, int team ) {
	CG_DrawFlagModel( x, cgs.screenYmax + 1 - ICON_SIZE, ICON_SIZE, ICON_SIZE, team, qfalse );
}


// ~Dimmskii - moved from cg_draw.c's commented-out #ifndef MISSIONPACK
// CG_DrawScores/CG_DrawPowerups/CG_DrawLowerRight block (lower-right corner:
// small two-score display + active powerup icons/timers). Two real fixes
// applied while porting, not just an uncomment: the original raw
// cgs.gametype >= GT_TEAM / >= GT_CTF comparisons assumed the old linear
// gametype_t ordering (team games all >= GT_TEAM, flag games all >= GT_CTF)
// and are wrong against our current reshuffled enum (e.g. solo GT_ARENA=14
// is >= GT_TEAM=3 but isn't a team game) - swapped for the GT_IsTeam/
// GT_IsFlagGame helpers already used elsewhere in this codebase for exactly
// this reason. GT_IsFlagGame's own doc comment (bg_newgame.c) confirms it's
// "the equivalent of pre-QL (i.e. MPP) gt >= GT_CTF", so this is a faithful
// port, not a behavior change.

#define POWERUP_BLINKS_OLD			5
#define POWERUP_BLINK_TIME_OLD		1000
#define PULSE_TIME_OLD				200
#define PULSE_SCALE_OLD				1.5			// amount to scale up the icons when activating

/*
=================
CG_DrawScores_Old

Draw the small two score display
=================
*/
static float CG_DrawScores_Old( float y ) {
	const char	*s;
	int			s1, s2, score;
	int			x, x0, w;
	int			v;
	vec4_t		color;
	float		y1;
	gitem_t		*item;

	s1 = cgs.scores1;
	s2 = cgs.scores2;

	y -=  BIGCHAR_HEIGHT + 8 - 4;

	y1 = y;

	// draw from the right side to left
	if ( GT_IsTeam( cgs.gametype ) ) { // ~Dimmskii - was: cgs.gametype >= GT_TEAM
		x0 = cgs.screenXmax + 1;
		color[0] = 0.0f;
		color[1] = 0.1f;
		color[2] = 1.0f;
		color[3] = 0.33f;
		// second score
		s = va( "%2i", s2 );
		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
		x = x0 - w;
		CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
			CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
		}
		CG_DrawString( x0-4, y, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT );

		if ( cgs.gametype == GT_CTF ) {
			// Display flag status
			item = BG_FindItemForPowerup( PW_BLUEFLAG );

			if (item) {
				y1 = y - BIGCHAR_HEIGHT - 8;
				if( cgs.blueflag >= 0 && cgs.blueflag <= 2 ) {
					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.blueFlagShader[cgs.blueflag] );
				}
			}
		}
		color[0] = 1.0f;
		color[1] = 0.0f;
		color[2] = 0.0f;
		color[3] = 0.33f;
		// first score
		x0 = x;
		s = va( "%2i", s1 );
		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
		x -= w;
		CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
			CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
		}

		CG_DrawString( x0-4, y, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT );

		if ( cgs.gametype == GT_CTF ) {
			// Display flag status
			item = BG_FindItemForPowerup( PW_REDFLAG );

			if (item) {
				y1 = y - BIGCHAR_HEIGHT - 8;
				if( cgs.redflag >= 0 && cgs.redflag <= 2 ) {
					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.redFlagShader[cgs.redflag] );
				}
			}
		}

		if ( cgs.gametype == GT_1FCTF ) {
			// Display flag status
			item = BG_FindItemForPowerup( PW_NEUTRALFLAG );

			if (item) {
				y1 = y - BIGCHAR_HEIGHT - 8;
				if( cgs.flagStatus >= 0 && cgs.flagStatus <= 3 ) {
					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.flagShader[cgs.flagStatus] );
				}
			}
		}

		// Determine which team score limits to draw in light of having 999999 gametypes
		if ( GT_IsArenaGame( cgs.gametype ) ) {
			v = cgs.roundlimit;
		} else if ( GT_IsFlagGame( cgs.gametype ) ) {
			v = cgs.capturelimit;
		} else {
			v = cgs.fraglimit;
		}
		if ( v ) {
			s = va( "%2i", v );
			CG_DrawString( x-4, y, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT );
		}

	} else {
		qboolean	spectator;

		x = cgs.screenXmax + 1;

		//score = cg.snap->ps.persistant[PERS_SCORE];
		
// ~Dimmskii -- Determine scores the way we have them set up until we properly add all ql-based game pers stats in like gents
		if ( GT_IsArenaGame( cgs.gametype ) ) {
			// cgs.scores1/2 arrive as PERS_SCORE, which in arena is damage+frags,
			// not the meaningful stat. Recompute the top-two round wins on the spot
			// from the (best-effort, possibly stale between scoreboard refreshes)
			// client scores table so the VQ3 score cards show wins, not damage.
			// Proper fix is server-side CS_SCORES gating in the later QL pers-stat
			// restructuring.
			int i;
			s1 = SCORE_NOT_PRESENT;
			s2 = SCORE_NOT_PRESENT;
			for ( i = 0; i < cg.numScores; i++ ) {
				int rw;
				if ( cg.scores[i].team == TEAM_SPECTATOR ) {
					continue;
				}
				rw = cg.scores[i].roundWins;
				if ( s1 == SCORE_NOT_PRESENT || rw > s1 ) {
					s2 = s1;
					s1 = rw;
				} else if ( s2 == SCORE_NOT_PRESENT || rw > s2 ) {
					s2 = rw;
				}
			}
			score = cg.snap->ps.persistant[PERS_ROUNDWINS];
		} else {
			score = cg.snap->ps.persistant[PERS_SCORE];
		}
// END Dimmskii
		
		spectator = ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR );

		// always show your score in the second box if not in first place
		if ( s1 != score ) {
			s2 = score;
		}
		if ( s2 != SCORE_NOT_PRESENT ) {
			x0 = x;
			s = va( "%2i", s2 );
			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
			x -= w;
			if ( !spectator && score == s2 && score != s1 ) {
				color[0] = 1.0f;
				color[1] = 0.0f;
				color[2] = 0.0f;
				color[3] = 0.33f;
				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
				CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
			} else {
				color[0] = 0.5f;
				color[1] = 0.5f;
				color[2] = 0.5f;
				color[3] = 0.33f;
				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
			}
			CG_DrawString( x0-4, y, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT );
		}

		// first place
		if ( s1 != SCORE_NOT_PRESENT ) {
			x0 = x;
			s = va( "%2i", s1 );
			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
			x -= w;
			if ( !spectator && score == s1 ) {
				color[0] = 0.0f;
				color[1] = 0.1f;
				color[2] = 1.0f;
				color[3] = 0.33f;
				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
				CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
			} else {
				color[0] = 0.5f;
				color[1] = 0.5f;
				color[2] = 0.5f;
				color[3] = 0.33f;
				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
			}
			CG_DrawString( x0-4, y, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT );
		}

		if ( cgs.fraglimit ) {
			//s = va( "%2i", cgs.fraglimit );
			s = va( "%2i", (GT_IsArenaGame(cgs.gametype) ? cgs.roundlimit : cgs.fraglimit) );	// ~Dimmskii
			CG_DrawString( x-4, y, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT );
		}
	}

	return y1 - 8;
}

/*
================
CG_DrawPowerups_Old
================
*/
static float CG_DrawPowerups_Old( float y ) {
	int		sorted[MAX_POWERUPS];
	int		sortedTime[MAX_POWERUPS];
	int		i, j, k;
	int		active;
	playerState_t	*ps;
	int		t;
	gitem_t	*item;
	int		x;
	int		color;
	float	size;
	float	f;
	static const float colors[2][4] = {
		{ 0.2f, 1.0f, 0.2f, 1.0f },
		{ 1.0f, 0.2f, 0.2f, 1.0f }
	};

	ps = &cg.snap->ps;

	if ( ps->stats[STAT_HEALTH] <= 0 ) {
		return y;
	}

	// sort the list by time remaining
	active = 0;
	for ( i = 0 ; i < MAX_POWERUPS ; i++ ) {
		if ( !ps->powerups[ i ] ) {
			continue;
		}
		t = ps->powerups[ i ] - cg.time;
		// ZOID--don't draw if the power up has unlimited time (999 seconds)
		// This is true of the CTF flags
		if ( t < 0 || t > 999000) {
			continue;
		}

		// insert into the list
		for ( j = 0 ; j < active ; j++ ) {
			if ( sortedTime[j] >= t ) {
				for ( k = active - 1 ; k >= j ; k-- ) {
					sorted[k+1] = sorted[k];
					sortedTime[k+1] = sortedTime[k];
				}
				break;
			}
		}
		sorted[j] = i;
		sortedTime[j] = t;
		active++;
	}

	// draw the icons and timers
	x = cgs.screenXmax + 1 - ICON_SIZE - CHAR_WIDTH * 2;
	for ( i = 0 ; i < active ; i++ ) {
		item = BG_FindItemForPowerup( sorted[i] );

		if ( item ) {

			color = 1;

			y -= ICON_SIZE;

			trap_R_SetColor( colors[color] );
			CG_DrawField_Old( x, y, 2, sortedTime[ i ] / 1000 );

			t = ps->powerups[ sorted[i] ];
			if ( t - cg.time >= POWERUP_BLINKS_OLD * POWERUP_BLINK_TIME_OLD ) {
				trap_R_SetColor( NULL );
			} else {
				vec4_t	modulate;

				f = (float)( t - cg.time ) / POWERUP_BLINK_TIME_OLD;
				f -= (int)f;
				modulate[0] = modulate[1] = modulate[2] = modulate[3] = f;
				trap_R_SetColor( modulate );
			}

			if ( cg.powerupActive == sorted[i] &&
				cg.time - cg.powerupTime < PULSE_TIME_OLD ) {
				f = 1.0 - ( (float)( cg.time - cg.powerupTime ) / PULSE_TIME_OLD );
				size = ICON_SIZE * ( 1.0 + ( PULSE_SCALE_OLD - 1.0 ) * f );
			} else {
				size = ICON_SIZE;
			}

			CG_DrawPic( cgs.screenXmax + 1 - size, y + ICON_SIZE / 2 - size / 2,
				size, size, trap_R_RegisterShader( item->icon ) );
		} // if ( item )
	}
	trap_R_SetColor( NULL );

	return y;
}

/*
=====================
CG_DrawLowerRight_Old

Entry point: small two-score display (top of this section) + active
powerup icons/timers, optionally preceded by the team overlay if
cg_drawTeamOverlay is 2. Exported (see cg_local.h).
=====================
*/
void CG_DrawLowerRight_Old( void ) {
	float	y;

	y = cgs.screenYmax + 1 - STATUSBAR_HEIGHT_OLD;

	if ( GT_IsTeam( cgs.gametype ) && cg_drawTeamOverlay.integer == 2 ) { // ~Dimmskii - was: cgs.gametype >= GT_TEAM
		y = CG_DrawTeamOverlay( y, qtrue, qfalse );
	}

	y = CG_DrawScores_Old( y );
	y = CG_DrawPowerups_Old( y );
}


// End Dimmskii
