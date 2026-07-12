#define ITEM_TYPE_TEXT 0                  // simple text
#define ITEM_TYPE_BUTTON 1                // button, basically text with a border 
#define ITEM_TYPE_RADIOBUTTON 2           // toggle button, may be grouped 
#define ITEM_TYPE_CHECKBOX 3              // check box
#define ITEM_TYPE_EDITFIELD 4             // editable text, associated with a cvar
#define ITEM_TYPE_COMBO 5                 // drop down list
#define ITEM_TYPE_LISTBOX 6               // scrollable list  
#define ITEM_TYPE_MODEL 7                 // model
#define ITEM_TYPE_OWNERDRAW 8             // owner draw, name specs what it is
#define ITEM_TYPE_NUMERICFIELD 9          // editable text, associated with a cvar
#define ITEM_TYPE_SLIDER 10               // mouse speed, volume, etc.
#define ITEM_TYPE_YESNO 11                // yes no cvar setting
#define ITEM_TYPE_MULTI 12                // multiple list setting, enumerated
#define ITEM_TYPE_BIND 13		              // multiple list setting, enumerated
#define ITEM_TYPE_SLIDER_COLOR 14         // TODO: QL Stub - Implement this
#define ITEM_TYPE_PRESET 15               // TODO: QL Stub - Implement this
#define ITEM_TYPE_PRESETLIST 16           // TODO: QL Stub - Implement this
    
#define ITEM_ALIGN_LEFT 0                 // left alignment
#define ITEM_ALIGN_CENTER 1               // center alignment
#define ITEM_ALIGN_RIGHT 2                // right alignment

#define	WIDESCREEN_STRETCH 0              // TODO: QL Stub - Implement this
#define	WIDESCREEN_LEFT 1                 // TODO: QL Stub - Implement this
#define	WIDESCREEN_CENTER 2               // TODO: QL Stub - Implement this
#define	WIDESCREEN_RIGHT 3                // TODO: QL Stub - Implement this

#define	FONT_DEFAULT 0                    // TODO: QL Stub - Implement this
#define	FONT_SANS 1                       // TODO: QL Stub - Implement this
#define	FONT_MONO 2                       // TODO: QL Stub - Implement this

#define ITEM_TEXTSTYLE_NORMAL 0           // normal text
#define ITEM_TEXTSTYLE_BLINK 1            // fast blinking
#define ITEM_TEXTSTYLE_PULSE 2            // slow pulsing
#define ITEM_TEXTSTYLE_SHADOWED 3         // drop shadow ( need a color for this )
#define ITEM_TEXTSTYLE_OUTLINED 4         // drop shadow ( need a color for this )
#define ITEM_TEXTSTYLE_OUTLINESHADOWED 5  // drop shadow ( need a color for this )
#define ITEM_TEXTSTYLE_SHADOWEDMORE 6         // drop shadow ( need a color for this )
                          
#define WINDOW_BORDER_NONE 0              // no border
#define WINDOW_BORDER_FULL 1              // full border based on border color ( single pixel )
#define WINDOW_BORDER_HORZ 2              // horizontal borders only
#define WINDOW_BORDER_VERT 3              // vertical borders only 
#define WINDOW_BORDER_KCGRADIENT 4        // horizontal border using the gradient bars
  
#define WINDOW_STYLE_EMPTY 0              // no background
#define WINDOW_STYLE_FILLED 1             // filled with background color
#define WINDOW_STYLE_GRADIENT 2           // gradient bar based on background color 
#define WINDOW_STYLE_SHADER   3           // gradient bar based on background color 
#define WINDOW_STYLE_TEAMCOLOR 4          // team color
#define WINDOW_STYLE_CINEMATIC 5          // cinematic

#define MENU_TRUE 1                       // uh.. true
#define MENU_FALSE 0                      // and false

#define HUD_VERTICAL				0x00
#define HUD_HORIZONTAL				0x01

// list box element types
#define LISTBOX_TEXT  0x00
#define LISTBOX_IMAGE 0x01

// list feeders
#define FEEDER_HEADS						0x00			// model heads
#define FEEDER_MAPS							0x01			// text maps based on game type
#define FEEDER_SERVERS						0x02			// servers
#define FEEDER_CLANS						0x03			// clan names
#define FEEDER_ALLMAPS						0x04			// all maps available, in graphic format
#define FEEDER_REDTEAM_LIST					0x05			// red team members
#define FEEDER_BLUETEAM_LIST				0x06			// blue team members
#define FEEDER_PLAYER_LIST					0x07			// players
#define FEEDER_TEAM_LIST					0x08			// team members for team voting
#define FEEDER_MODS							0x09			// team members for team voting
#define FEEDER_DEMOS 						0x0a			// team members for team voting
#define FEEDER_SCOREBOARD					0x0b			// team members for team voting
#define FEEDER_Q3HEADS		 				0x0c			// model heads
#define FEEDER_SERVERSTATUS					0x0d			// server status
#define FEEDER_FINDPLAYER					0x0e			// find player
#define FEEDER_CINEMATICS					0x0f			// cinematics
#define FEEDER_MAPS_NEW						0x10			// new maps feeder
#define FEEDER_ENDSCOREBOARD				0x11			// TODO: QL Stub - Implement this
#define FEEDER_REDTEAM_STATS				0x12			// TODO: QL Stub - Implement this
#define FEEDER_BLUETEAM_STATS				0x13			// TODO: QL Stub - Implement this
#define FEEDER_CVMAPS						0x14			// TODO: QL Stub - Implement this

// display flags
#define CG_SHOW_BLUE_TEAM_HAS_REDFLAG     0x00000001
#define CG_SHOW_RED_TEAM_HAS_BLUEFLAG     0x00000002
#define CG_SHOW_ANYTEAMGAME               0x00000004
#define CG_SHOW_HARVESTER                 0x00000008
#define CG_SHOW_ONEFLAG                   0x00000010
#define CG_SHOW_CTF                       0x00000020
#define CG_SHOW_OBELISK                   0x00000040
#define CG_SHOW_HEALTHCRITICAL            0x00000080
// Gap from single player
#define CG_SHOW_TOURNAMENT                0x00000200
#define CG_SHOW_DURINGINCOMINGVOICE       0x00000400
#define CG_SHOW_IF_PLAYER_HAS_FLAG				0x00000800
#define CG_SHOW_LANPLAYONLY								0x00001000
#define CG_SHOW_MINED											0x00002000
#define CG_SHOW_HEALTHOK			            0x00004000
#define CG_SHOW_TEAMINFO			            0x00008000
#define CG_SHOW_NOTEAMINFO		            0x00010000
#define CG_SHOW_OTHERTEAMHASFLAG          0x00020000
#define CG_SHOW_YOURTEAMHASENEMYFLAG      0x00040000
#define CG_SHOW_ANYNONTEAMGAME            0x00080000
#define CG_SHOW_ANYARENAGAME              0x00100000  // UA
#define CG_SHOW_ANYNONARENAGAME           0x00200000  // UA

#define CG_SHOW_TEAM_ARENA   		0x00100004		 // CG_SHOW_ANYTEAMGAME | CG_SHOW_ANYARENAGAME
#define CG_SHOW_FFA_ARENA    	 	0x00180000		 // CG_SHOW_ANYNONTEAMGAME | CG_SHOW_ANYARENAGAME
#define CG_SHOW_NONTEAM_NONARENA	0x00280000		 // CG_SHOW_ANYNONTEAMGAME | CG_SHOW_ANYNONARENAGAME --  FIXME: Think of better name. We can change it later up to a reasonable point. It's a UA-specific feature. 

#define CG_SHOW_INTERMISSION              0x00400000  // TODO: QL Stub - Implement this
#define CG_SHOW_NOTINTERMISSION           0x00800000  // TODO: QL Stub - Implement this

#define CG_SHOW_IF_NOT_WARMUP             0x01000000  // TODO: QL Stub - Implement this
#define CG_SHOW_IF_WARMUP                 0x02000000  // TODO: QL Stub - Implement this

#define CG_SHOW_2DONLY					  0x10000000

#define CG_SHOW_NEVER                    0x00080004 // ~Dimmskii - Never show = CG_SHOW_ANYTEAMGAME | CG_SHOW_ANYNONTEAMGAME


#define CG_SHOW_DUEL              CG_SHOW_TOURNAMENT  // ~DIMMSKII - QL-TA compat hack
#define CG_SHOW_CLAN_ARENA        CG_SHOW_TEAM_ARENA  // ~Dimmskii - QL Compat


#define CG_SHOW_SINGLEPLAYER          CG_SHOW_NEVER  // ~Dimmskii - Never show
#define CG_SHOW_DOMINATION            CG_SHOW_NEVER  // ~Dimmskii - QL Compat - Never show

#define CG_SHOW_IF_BLUE_IS_FIRST_PLACE     CG_SHOW_NEVER  // TODO: QL Stub - MAKE ROOM FOR and) Implement this
#define CG_SHOW_IF_MSG_PRESENT             CG_SHOW_NEVER  // TODO: QL Stub - MAKE ROOM FOR and) Implement this
#define CG_SHOW_IF_NOTICE_PRESENT          CG_SHOW_NEVER  // TODO: QL Stub - MAKE ROOM FOR and) Implement this
#define CG_SHOW_IF_CHAT_VISIBLE            CG_SHOW_NEVER  // TODO: QL Stub - MAKE ROOM FOR and) Implement this
#define CG_SHOW_IF_PLYR_IS_FIRST_PLACE     CG_SHOW_NEVER  // TODO: QL Stub - MAKE ROOM FOR and) Implement this
#define CG_SHOW_IF_PLYR_IS_NOT_FIRST_PLACE CG_SHOW_NEVER  // TODO: QL Stub - MAKE ROOM FOR and) Implement this
#define CG_SHOW_IF_RED_IS_FIRST_PLACE      CG_SHOW_NEVER  // TODO: QL Stub - MAKE ROOM FOR and) Implement this
#define CG_SHOW_IF_PLYR_IS_ON_RED          CG_SHOW_NEVER  // TODO: QL Stub - MAKE ROOM FOR and) Implement this
#define CG_SHOW_IF_PLYR_IS_ON_BLUE         CG_SHOW_NEVER  // TODO: QL Stub - MAKE ROOM FOR and) Implement this
#define CG_SHOW_PLAYERS_REMAINING          CG_SHOW_NEVER  // TODO: QL Stub - MAKE ROOM FOR and) Implement this

// ownerdrawflag2 -- currently, if put into ownerdrawflag, it will do nothing -- TODO: Should this be read as separate token? Need menu file examples of these.
#define	CG_SHOW_IF_PLYR1					CG_SHOW_NEVER //0x00000001  // TODO: QL Stub - Implement this
#define	CG_SHOW_IF_PLYR2					CG_SHOW_NEVER //0x00000002  // TODO: QL Stub - Implement this
#define	CG_SHOW_IF_G_FIRED					CG_SHOW_NEVER //0x00000004  // TODO: QL Stub - Implement this
#define	CG_SHOW_IF_MG_FIRED					CG_SHOW_NEVER //0x00000008  // TODO: QL Stub - Implement this
#define	CG_SHOW_IF_SG_FIRED					CG_SHOW_NEVER //0x00000010  // TODO: QL Stub - Implement this
#define	CG_SHOW_IF_GL_FIRED					CG_SHOW_NEVER //0x00000020  // TODO: QL Stub - Implement this
#define	CG_SHOW_IF_RL_FIRED					CG_SHOW_NEVER //0x00000040  // TODO: QL Stub - Implement this
#define	CG_SHOW_IF_LG_FIRED					CG_SHOW_NEVER //0x00000080  // TODO: QL Stub - Implement this
#define	CG_SHOW_IF_RG_FIRED					CG_SHOW_NEVER //0x00000100  // TODO: QL Stub - Implement this
#define	CG_SHOW_IF_PG_FIRED					CG_SHOW_NEVER //0x00000200  // TODO: QL Stub - Implement this
#define	CG_SHOW_IF_BFG_FIRED				CG_SHOW_NEVER //0x00000400  // TODO: QL Stub - Implement this
#define	CG_SHOW_IF_CG_FIRED					CG_SHOW_NEVER //0x00000800  // TODO: QL Stub - Implement this
#define	CG_SHOW_IF_NG_FIRED					CG_SHOW_NEVER //0x00001000  // TODO: QL Stub - Implement this
#define	CG_SHOW_IF_PL_FIRED					CG_SHOW_NEVER //0x00002000  // TODO: QL Stub - Implement this
#define	CG_SHOW_IF_HMG_FIRED				CG_SHOW_NEVER //0x00004000  // TODO: QL Stub - Implement this
#define CG_SHOW_IF_PLYR_IS_ON_RED_OR_SPEC   CG_SHOW_NEVER //0x00008000  // TODO: QL Stub - Implement this
#define CG_SHOW_IF_PLYR_IS_ON_BLUE_OR_SPEC	CG_SHOW_NEVER //0x00010000  // TODO: QL Stub - Implement this
#define CG_SHOW_IF_PLYR_IS_ON_RED_NO_SPEC   CG_SHOW_NEVER //0x00020000  // TODO: QL Stub - Implement this
#define CG_SHOW_IF_PLYR_IS_ON_BLUE_NO_SPEC  CG_SHOW_NEVER //0x00040000  // TODO: QL Stub - Implement this
#define CG_SHOW_IF_LOADOUT_ENABLED			CG_SHOW_NEVER //0x00080000  // TODO: QL Stub - Implement this
#define CG_SHOW_IF_LOADOUT_DISABLED			CG_SHOW_NEVER //0x00100000  // TODO: QL Stub - Implement this
#define CG_SHOW_IF_1ST_PLYR_FOLLOWED		CG_SHOW_NEVER //0x00200000  // TODO: QL Stub - Implement this
#define CG_SHOW_IF_2ND_PLYR_FOLLOWED		CG_SHOW_NEVER //0x00400000  // TODO: QL Stub - Implement this


// ui ownerdrawflag
#define UI_SHOW_LEADER				            0x00000001
#define UI_SHOW_NOTLEADER			            0x00000002
#define UI_SHOW_FAVORITESERVERS						0x00000004
#define UI_SHOW_ANYNONTEAMGAME						0x00000008
#define UI_SHOW_ANYTEAMGAME								0x00000010
#define UI_SHOW_NEWHIGHSCORE							0x00000020
#define UI_SHOW_DEMOAVAILABLE							0x00000040
#define UI_SHOW_NEWBESTTIME								0x00000080
#define UI_SHOW_FFA												0x00000100
#define UI_SHOW_NOTFFA										0x00000200
//#define UI_SHOW_NETANYNONTEAMGAME	 				0x00000400
#define UI_SHOW_NETANYNONTEAMGAME   UI_SHOW_ANYNONTEAMGAME  // ~Dimmskii - Aliased. ui_actualNetGameType, ui_netGameType should now always equal to ui_gameType
//#define UI_SHOW_NETANYTEAMGAME		 				0x00000800
#define UI_SHOW_NETANYTEAMGAME      UI_SHOW_ANYTEAMGAME     // ~Dimmskii - Aliased. ui_actualNetGameType, ui_netGameType should now always equal to ui_gameType
#define UI_SHOW_NOTFAVORITESERVERS				0x00001000
#define UI_SHOW_ARENAGAME				0x00002000
#define UI_SHOW_NOTARENAGAME				0x00004000
#define UI_SHOW_IF_LOADOUT_ENABLED			0x00008000  // TODO: QL Stub - Implement this
#define UI_SHOW_IF_LOADOUT_DISABLED			0x00010000  // TODO: QL Stub - Implement this
#define UI_SHOW_IF_NOT_INTERMISSION			0x00020000  // TODO: QL Stub - Implement this
#define UI_SHOW_IF_WARMUP					0x00040000  // TODO: QL Stub - Implement this
#define UI_SHOW_IF_NOT_WARMUP				0x00080000  // TODO: QL Stub - Implement this

#define UI_SHOW_ANYTEAMGAME_NOTARENAGAME 		0x00004010 	//UI_SHOW_ANYTEAMGAME | UI_SHOW_NOTARENAGAME
#define UI_SHOW_ANYNONTEAMGAME_NOTARENAGAME 	0x00004008 	//UI_SHOW_ANYNONTEAMGAME | UI_SHOW_NOTARENAGAME




// owner draw types
// ideally these should be done outside of this file but
// this makes it much easier for the macro expansion to 
// convert them for the designers ( from the .menu files )
#define CG_OWNERDRAW_BASE 1
#define CG_PLAYER_ARMOR_ICON 1              
#define CG_PLAYER_ARMOR_VALUE 2
#define CG_PLAYER_HEAD 3
#define CG_PLAYER_HEALTH 4
#define CG_PLAYER_AMMO_ICON 5
#define CG_PLAYER_AMMO_VALUE 6
#define CG_SELECTEDPLAYER_HEAD 7
#define CG_SELECTEDPLAYER_NAME 8
#define CG_SELECTEDPLAYER_LOCATION 9
#define CG_SELECTEDPLAYER_STATUS 10
#define CG_SELECTEDPLAYER_WEAPON 11
#define CG_SELECTEDPLAYER_POWERUP 12

#define CG_FLAGCARRIER_HEAD 13
#define CG_FLAGCARRIER_NAME 14
#define CG_FLAGCARRIER_LOCATION 15
#define CG_FLAGCARRIER_STATUS 16
#define CG_FLAGCARRIER_WEAPON 17
#define CG_FLAGCARRIER_POWERUP 18

#define CG_PLAYER_ITEM 19
#define CG_PLAYER_SCORE 20

#define CG_PLAYER_ROUNDWINS 21		// Arena wins

#define CG_BLUE_FLAGHEAD 22
#define CG_BLUE_FLAGSTATUS 23
#define CG_BLUE_FLAGNAME 24
#define CG_RED_FLAGHEAD 25
#define CG_RED_FLAGSTATUS 26
#define CG_RED_FLAGNAME 27

#define CG_BLUE_SCORE 28
#define CG_RED_SCORE 29
#define CG_RED_NAME 30
#define CG_BLUE_NAME 31
#define CG_HARVESTER_SKULLS 32					// only shows in harvester
#define CG_ONEFLAG_STATUS 33						// only shows in one flag
#define CG_PLAYER_LOCATION 34
#define CG_TEAM_COLOR 35
#define CG_CTF_POWERUP 36
                                        
#define CG_AREA_POWERUP	37
#define CG_AREA_LAGOMETER	38            // painted with old system
#define CG_PLAYER_HASFLAG 39            
#define CG_GAME_TYPE 40                 // not done

#define CG_SELECTEDPLAYER_ARMOR 41      
#define CG_SELECTEDPLAYER_HEALTH 42
#define CG_PLAYER_STATUS 43
#define CG_FRAGGED_MSG 44               // painted with old system
#define CG_PROXMINED_MSG 45             // painted with old system
#define CG_AREA_FPSINFO 46              // painted with old system
#define CG_AREA_SYSTEMCHAT 47           // painted with old system
#define CG_AREA_TEAMCHAT 48             // painted with old system
#define CG_AREA_CHAT 49                 // painted with old system
#define CG_GAME_STATUS 50
#define CG_KILLER 51
#define CG_PLAYER_ARMOR_ICON2D 52              
#define CG_PLAYER_AMMO_ICON2D 53
#define CG_ACCURACY 54
#define CG_ASSISTS 55
#define CG_DEFEND 56
#define CG_EXCELLENT 57
#define CG_IMPRESSIVE 58
#define CG_PERFECT 59
#define CG_GAUNTLET 60
#define CG_SPECTATORS 61
#define CG_TEAMINFO 62
#define CG_VOICE_HEAD 63
#define CG_VOICE_NAME 64
#define CG_PLAYER_HASFLAG2D 65            
#define CG_HARVESTER_SKULLS2D 66					// only shows in harvester
#define CG_CAPFRAGLIMIT 67	 
#define CG_1STPLACE 68
#define CG_2NDPLACE 69
#define CG_CAPTURES 70
#define CG_MAP_NAME 71

// CG owner draw types continued (from QL)
#define CG_SERVER_SETTINGS 72                     // TODO: QL Stub - Implement this
#define CG_STARTING_WEAPONS 73                    // TODO: QL Stub - Implement this
#define CG_GAME_LIMIT 74                          // TODO: QL Stub - Implement this
#define CG_GAME_TYPE_ICON 75                      // TODO: QL Stub - Implement this
#define CG_GAME_TYPE_MAP 76                       // TODO: QL Stub - Implement this
#define CG_MATCH_DETAILS 77                       // TODO: QL Stub - Implement this
#define CG_MATCH_END_CONDITION 78                 // TODO: QL Stub - Implement this
#define CG_MATCH_STATUS 79                        // TODO: QL Stub - Implement this
#define CG_LEVELTIMER 80                          // TODO: QL Stub - Implement this
#define CG_ROUND 81                               // TODO: QL Stub - Implement this
#define CG_ROUNDTIMER 82                          // TODO: QL Stub - Implement this
#define CG_OVERTIME 83                            // TODO: QL Stub - Implement this
#define CG_LOCALTIME 84                           // TODO: QL Stub - Implement this
#define CG_PLAYER_COUNTS 85                       // TODO: QL Stub - Implement this
#define CG_VOTEGAMETYPE1 86                       // TODO: QL Stub - Implement this
#define CG_VOTEGAMETYPE2 87                       // TODO: QL Stub - Implement this
#define CG_VOTEGAMETYPE3 88                       // TODO: QL Stub - Implement this
#define CG_VOTEMAP1 89                            // TODO: QL Stub - Implement this
#define CG_VOTEMAP2 90                            // TODO: QL Stub - Implement this
#define CG_VOTEMAP3 91                            // TODO: QL Stub - Implement this
#define CG_VOTESHOT1 92                           // TODO: QL Stub - Implement this
#define CG_VOTESHOT2 93                           // TODO: QL Stub - Implement this
#define CG_VOTESHOT3 94                           // TODO: QL Stub - Implement this
#define CG_VOTENAME1 95                           // TODO: QL Stub - Implement this
#define CG_VOTENAME2 96                           // TODO: QL Stub - Implement this
#define CG_VOTENAME3 97                           // TODO: QL Stub - Implement this
#define CG_VOTECOUNT1 98                          // TODO: QL Stub - Implement this
#define CG_VOTECOUNT2 99                          // TODO: QL Stub - Implement this
#define CG_VOTECOUNT3 100                         // TODO: QL Stub - Implement this
#define CG_VOTETIMER 101                          // TODO: QL Stub - Implement this
#define CG_SPEC_MESSAGES 102                      // TODO: QL Stub - Implement this
#define CG_PLAYERMODEL 103                        // TODO: QL Stub - Implement this
#define CG_PLAYER_ARMOR_BAR_100 104               // ~Dimmskii - QL Implemented!
#define CG_PLAYER_ARMOR_BAR_200 105               // ~Dimmskii - QL Implemented!
#define CG_ARMORTIERED_COLORIZED 106              // ~Dimmskii - QL Implemented!
#define CG_PLAYER_HEALTH_BAR_100 107              // ~Dimmskii - QL Implemented!
#define CG_PLAYER_HEALTH_BAR_200 108              // ~Dimmskii - QL Implemented!
#define CG_RACE_STATUS 109                        // TODO: QL Stub - Implement this
#define CG_RACE_TIMES 110                         // TODO: QL Stub - Implement this
#define CG_PLAYER_HASKEY 111                      // TODO: QL Stub - Implement this
#define CG_COMBOKILLS 112                         // TODO: QL Stub - Implement this
#define CG_RAMPAGES 113                           // TODO: QL Stub - Implement this
#define CG_MIDAIRS 114                            // TODO: QL Stub - Implement this
#define CG_MOST_VALUABLE_OFFENSIVE_PLYR 115       // TODO: QL Stub - Implement this
#define CG_MOST_VALUABLE_DEFENSIVE_PLYR 116       // TODO: QL Stub - Implement this
#define CG_MOST_VALUABLE_PLYR 117                 // TODO: QL Stub - Implement this
#define CG_BEST_ITEMCONTROL_PLYR 118              // TODO: QL Stub - Implement this
#define CG_MOST_ACCURATE_PLYR 119                 // TODO: QL Stub - Implement this
#define CG_MOST_DAMAGEDEALT_PLYR 120              // TODO: QL Stub - Implement this
#define CG_MATCH_WINNER 121                       // TODO: QL Stub - Implement this
#define CG_1ST_PLACE_SCORE 122                    // TODO: QL Stub - Implement this
#define CG_1STPLACE_PLYR_MODEL 123                // TODO: QL Stub - Implement this
#define CG_2ND_PLACE_SCORE 124                    // TODO: QL Stub - Implement this
#define CG_PLAYER_OBIT 125                        // TODO: QL Stub - Implement this
#define CG_AREA_NEW_CHAT 126                      // TODO: QL Stub - Implement this
#define CG_PLYR_END_GAME_SCORE 127                // TODO: QL Stub - Implement this
#define CG_PLYR_BEST_WEAPON_NAME 128              // TODO: QL Stub - Implement this
#define CG_SELECTED_PLYR_TEAM_COLOR 129           // TODO: QL Stub - Implement this
#define CG_SELECTED_PLYR_ACCURACY 130             // TODO: QL Stub - Implement this
#define CG_FOLLOW_PLAYER_NAME 131                 // TODO: QL Stub - Implement this
#define CG_FOLLOW_PLAYER_NAME_EX 132              // TODO: QL Stub - Implement this
#define CG_SPEEDOMETER 133                        // TODO: QL Stub - Implement this
#define CG_WP_VERTICAL 134                        // TODO: QL Stub - Implement this
#define CG_ACC_VERTICAL 135                       // TODO: QL Stub - Implement this
#define CG_TEAM_COLORIZED 136                     // ~Dimmskii - QL Implemented!
#define CG_TEAM_PLYR_COUNT 137                    // TODO: QL Stub - Implement this
#define CG_ENEMY_PLYR_COUNT 138                   // TODO: QL Stub - Implement this
#define CG_1STPLACE_PLYR_MODEL_ACTIVE 139         // TODO: QL Stub - Implement this
#define CG_1ST_PLYR 140                           // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_READY 141                     // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_SCORE 142                     // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_FRAGS 143                     // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_DEATHS 144                    // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_DMG 145                       // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_TIME 146                      // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_PING 147                      // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_WINS 148                      // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_ACC 149                       // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_FLAG 150                      // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_AVATAR 151                    // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_TIMEOUT_COUNT 152             // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_HEALTH_ARMOR 153              // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_FRAGS_G 154                   // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_FRAGS_MG 155                  // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_FRAGS_SG 156                  // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_FRAGS_GL 157                  // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_FRAGS_RL 158                  // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_FRAGS_LG 159                  // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_FRAGS_RG 160                  // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_FRAGS_PG 161                  // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_FRAGS_BFG 162                 // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_FRAGS_CG 163                  // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_FRAGS_NG 164                  // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_FRAGS_PL 165                  // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_FRAGS_HMG 166                 // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_HITS_MG 167                   // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_HITS_SG 168                   // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_HITS_GL 169                   // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_HITS_RL 170                   // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_HITS_LG 171                   // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_HITS_RG 172                   // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_HITS_PG 173                   // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_HITS_BFG 174                  // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_HITS_CG 175                   // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_HITS_NG 176                   // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_HITS_PL 177                   // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_HITS_HMG 178                  // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_SHOTS_MG 179                  // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_SHOTS_SG 180                  // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_SHOTS_GL 181                  // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_SHOTS_RL 182                  // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_SHOTS_LG 183                  // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_SHOTS_RG 184                  // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_SHOTS_PG 185                  // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_SHOTS_BFG 186                 // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_SHOTS_CG 187                  // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_SHOTS_NG 188                  // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_SHOTS_PL 189                  // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_SHOTS_HMG 190                 // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_DMG_G 191                     // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_DMG_MG 192                    // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_DMG_SG 193                    // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_DMG_GL 194                    // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_DMG_RL 195                    // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_DMG_LG 196                    // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_DMG_RG 197                    // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_DMG_PG 198                    // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_DMG_BFG 199                   // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_DMG_CG 200                   // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_DMG_NG 201                    // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_DMG_PL 202                    // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_DMG_HMG 203                   // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_ACC_MG 204                    // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_ACC_SG 205                    // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_ACC_GL 206                    // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_ACC_RL 207                    // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_ACC_LG 208                    // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_ACC_RG 209                    // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_ACC_PG 210                    // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_ACC_BFG 211                   // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_ACC_CG 212                    // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_ACC_NG 213                    // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_ACC_PL 214                    // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_ACC_HMG 215                   // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_PICKUPS 216                   // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_PICKUPS_RA 217                // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_PICKUPS_YA 218                // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_PICKUPS_GA 219                // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_PICKUPS_MH 220                // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_AVG_PICKUP_TIME_RA 221        // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_AVG_PICKUP_TIME_YA 222        // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_AVG_PICKUP_TIME_GA 223        // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_AVG_PICKUP_TIME_MH 224        // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_EXCELLENT 225                 // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_IMPRESSIVE 226                // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_HUMILIATION 227               // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_PR 228                        // TODO: QL Stub - Implement this
#define CG_1ST_PLYR_TIER 229                      // TODO: QL Stub - Implement this
#define CG_2ND_PLYR 230                           // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_READY 231                     // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_SCORE 232                     // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_FRAGS 233                     // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_DEATHS 234                    // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_DMG 235                       // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_TIME 236                      // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_PING 237                      // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_WINS 238                      // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_ACC 239                       // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_FLAG 240                      // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_AVATAR 241                    // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_TIMEOUT_COUNT 242             // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_HEALTH_ARMOR 243              // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_FRAGS_G 244                   // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_FRAGS_MG 245                  // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_FRAGS_SG 246                  // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_FRAGS_GL 247                  // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_FRAGS_RL 248                  // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_FRAGS_LG 249                  // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_FRAGS_RG 250                  // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_FRAGS_PG 251                  // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_FRAGS_BFG 252                 // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_FRAGS_CG 253                  // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_FRAGS_NG 254                  // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_FRAGS_PL 255                  // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_FRAGS_HMG 256                 // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_HITS_MG 257                   // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_HITS_SG 258                   // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_HITS_GL 259                   // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_HITS_RL 260                   // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_HITS_LG 261                   // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_HITS_RG 262                   // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_HITS_PG 263                   // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_HITS_BFG 264                  // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_HITS_CG 265                   // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_HITS_NG 266                   // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_HITS_PL 267                   // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_HITS_HMG 268                  // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_SHOTS_MG 269                  // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_SHOTS_SG 270                  // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_SHOTS_GL 271                  // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_SHOTS_RL 272                  // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_SHOTS_LG 273                  // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_SHOTS_RG 274                  // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_SHOTS_PG 275                  // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_SHOTS_BFG 276                 // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_SHOTS_CG 277                  // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_SHOTS_NG 278                  // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_SHOTS_PL 279                  // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_SHOTS_HMG 280                 // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_DMG_G 281                     // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_DMG_MG 282                    // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_DMG_SG 283                    // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_DMG_GL 284                    // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_DMG_RL 285                    // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_DMG_LG 286                    // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_DMG_RG 287                    // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_DMG_PG 288                    // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_DMG_BFG 289                   // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_DMG_CG 290                    // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_DMG_NG 291                    // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_DMG_PL 292                    // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_DMG_HMG 293                   // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_ACC_MG 294                    // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_ACC_SG 295                    // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_ACC_GL 296                    // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_ACC_RL 297                    // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_ACC_LG 298                    // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_ACC_RG 299                    // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_ACC_PG 300                    // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_ACC_BFG 301                   // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_ACC_CG 302                    // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_ACC_NG 303                    // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_ACC_PL 304                    // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_ACC_HMG 305                   // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_PICKUPS 306                   // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_PICKUPS_RA 307                // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_PICKUPS_YA 308                // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_PICKUPS_GA 309                // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_PICKUPS_MH 310                // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_AVG_PICKUP_TIME_RA 311        // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_AVG_PICKUP_TIME_YA 312        // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_AVG_PICKUP_TIME_GA 313        // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_AVG_PICKUP_TIME_MH 314        // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_EXCELLENT 315                 // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_IMPRESSIVE 316                // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_HUMILIATION 317               // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_PR 318                        // TODO: QL Stub - Implement this
#define CG_2ND_PLYR_TIER 319                      // TODO: QL Stub - Implement this
#define CG_RED_OWNED_FLAGS 320                    // TODO: QL Stub - Implement this
#define CG_RED_AVG_PING 321                       // TODO: QL Stub - Implement this
#define CG_RED_BASESTATUS 322                     // TODO: QL Stub - Implement this
#define CG_RED_PLAYER_COUNT 323                   // TODO: QL Stub - Implement this
#define CG_RED_CLAN_PLYRS 324                     // TODO: QL Stub - Implement this
#define CG_RED_TIMEOUT_COUNT 325                  // TODO: QL Stub - Implement this
#define CG_RED_TEAM_MAP_PICKUPS 326               // TODO: QL Stub - Implement this
#define CG_RED_TEAM_PICKUPS_RA 327                // TODO: QL Stub - Implement this
#define CG_RED_TEAM_PICKUPS_YA 328                // TODO: QL Stub - Implement this
#define CG_RED_TEAM_PICKUPS_GA 329                // TODO: QL Stub - Implement this
#define CG_RED_TEAM_PICKUPS_MH 330                // TODO: QL Stub - Implement this
#define CG_RED_TEAM_PICKUPS_QUAD 331              // TODO: QL Stub - Implement this
#define CG_RED_TEAM_PICKUPS_BS 332                // TODO: QL Stub - Implement this
#define CG_RED_TEAM_TIMEHELD_QUAD 333             // TODO: QL Stub - Implement this
#define CG_RED_TEAM_TIMEHELD_BS 334               // TODO: QL Stub - Implement this
#define CG_RED_TEAM_PICKUPS_FLAG 335              // TODO: QL Stub - Implement this
#define CG_RED_TEAM_PICKUPS_MEDKIT 336            // TODO: QL Stub - Implement this
#define CG_RED_TEAM_PICKUPS_REGEN 337             // TODO: QL Stub - Implement this
#define CG_RED_TEAM_PICKUPS_HASTE 338             // TODO: QL Stub - Implement this
#define CG_RED_TEAM_PICKUPS_INVIS 339             // TODO: QL Stub - Implement this
#define CG_RED_TEAM_TIMEHELD_FLAG 340             // TODO: QL Stub - Implement this
#define CG_RED_TEAM_TIMEHELD_REGEN 341            // TODO: QL Stub - Implement this
#define CG_RED_TEAM_TIMEHELD_HASTE 342            // TODO: QL Stub - Implement this
#define CG_RED_TEAM_TIMEHELD_INVIS 343            // TODO: QL Stub - Implement this
#define CG_BLUE_OWNED_FLAGS 344                   // TODO: QL Stub - Implement this
#define CG_BLUE_AVG_PING 345                      // TODO: QL Stub - Implement this
#define CG_BLUE_BASESTATUS 346                    // TODO: QL Stub - Implement this
#define CG_BLUE_PLAYER_COUNT 347                  // TODO: QL Stub - Implement this
#define CG_BLUE_CLAN_PLYRS 348                    // TODO: QL Stub - Implement this
#define CG_BLUE_TIMEOUT_COUNT 349                 // TODO: QL Stub - Implement this
#define CG_BLUE_TEAM_MAP_PICKUPS 350              // TODO: QL Stub - Implement this
#define CG_BLUE_TEAM_PICKUPS_RA 351               // TODO: QL Stub - Implement this
#define CG_BLUE_TEAM_PICKUPS_YA 352               // TODO: QL Stub - Implement this
#define CG_BLUE_TEAM_PICKUPS_GA 353               // TODO: QL Stub - Implement this
#define CG_BLUE_TEAM_PICKUPS_MH 354               // TODO: QL Stub - Implement this
#define CG_BLUE_TEAM_PICKUPS_QUAD 355             // TODO: QL Stub - Implement this
#define CG_BLUE_TEAM_PICKUPS_BS 356               // TODO: QL Stub - Implement this
#define CG_BLUE_TEAM_TIMEHELD_QUAD 357            // TODO: QL Stub - Implement this
#define CG_BLUE_TEAM_TIMEHELD_BS 358              // TODO: QL Stub - Implement this
#define CG_BLUE_TEAM_PICKUPS_FLAG 359             // TODO: QL Stub - Implement this
#define CG_BLUE_TEAM_PICKUPS_MEDKIT 360           // TODO: QL Stub - Implement this
#define CG_BLUE_TEAM_PICKUPS_REGEN 361            // TODO: QL Stub - Implement this
#define CG_BLUE_TEAM_PICKUPS_HASTE 362            // TODO: QL Stub - Implement this
#define CG_BLUE_TEAM_PICKUPS_INVIS 363            // TODO: QL Stub - Implement this
#define CG_BLUE_TEAM_TIMEHELD_FLAG 364            // TODO: QL Stub - Implement this
#define CG_BLUE_TEAM_TIMEHELD_REGEN 365           // TODO: QL Stub - Implement this
#define CG_BLUE_TEAM_TIMEHELD_HASTE 366           // TODO: QL Stub - Implement this
#define CG_BLUE_TEAM_TIMEHELD_INVIS 367           // TODO: QL Stub - Implement this
#define CG_FLAG_STATUS 368                        // TODO: QL Stub - Implement this
#define CG_HEALTH_COLORIZED 369                   // TODO: QL Stub - Implement this
#define CG_MATCH_STATE 370                        // TODO: QL Stub - Implement this

// UI owner draw types  -- MUST COME AFTER UI_OWNERDRAW_BASE!
#define UI_OWNERDRAW_BASE 371
#define UI_HANDICAP 371
#define UI_EFFECTS 372
#define UI_PLAYERMODEL 373
#define UI_CLANNAME 374
#define UI_CLANLOGO 375
#define UI_GAMETYPE 376
#define UI_MAPPREVIEW 377
#define UI_SKILL 378
#define UI_BLUETEAMNAME 379
#define UI_REDTEAMNAME 380
#define UI_BLUETEAM1 381
#define UI_BLUETEAM2 382
#define UI_BLUETEAM3 383
#define UI_BLUETEAM4 384
#define UI_BLUETEAM5 385
#define UI_BLUETEAM6 386
#define UI_BLUETEAM7 387
#define UI_REDTEAM1 388
#define UI_REDTEAM2 389
#define UI_REDTEAM3 390
#define UI_REDTEAM4 391
#define UI_REDTEAM5 392
#define UI_REDTEAM6 393
#define UI_REDTEAM7 394
#define UI_NETSOURCE 395
#define UI_NETMAPPREVIEW 396
#define UI_NETFILTER 397
#define UI_TIER 398
#define UI_OPPONENTMODEL 399
#define UI_TIERMAP1 400
#define UI_TIERMAP2 401
#define UI_TIERMAP3 402
#define UI_PLAYERLOGO 403
#define UI_OPPONENTLOGO 404
#define UI_PLAYERLOGO_METAL 405
#define UI_OPPONENTLOGO_METAL 406
#define UI_PLAYERLOGO_NAME 407
#define UI_OPPONENTLOGO_NAME 408
#define UI_TIER_MAPNAME 409
#define UI_TIER_GAMETYPE 410
#define UI_ALLMAPS_SELECTION 411
#define UI_OPPONENT_NAME 412
#define UI_VOTE_KICK 413
#define UI_BOTNAME 414
#define UI_BOTSKILL 415
#define UI_REDBLUE 416
#define UI_CROSSHAIR 417
#define UI_SELECTEDPLAYER 418
#define UI_MAPCINEMATIC 419
//#define UI_NETGAMETYPE 249
#define UI_NETGAMETYPE UI_GAMETYPE      // ~Dimmskii - Aliased. ui_actualNetGameType, ui_netGameType should now always equal to ui_gameType
#define UI_NETMAPCINEMATIC 420
#define UI_SERVERREFRESHDATE 421
#define UI_SERVERMOTD 422
#define UI_GLINFO  423
#define UI_KEYBINDSTATUS 424
#define UI_CLANCINEMATIC 425
#define UI_MAP_TIMETOBEAT 426
#define UI_JOINGAMETYPE 427
#define UI_PREVIEWCINEMATIC 428
#define UI_STARTMAPCINEMATIC 429
#define UI_MAPS_SELECTION 430
#define UI_ADVERT 431                             // TODO: QL Stub - Implement this
#define UI_CROSSHAIR_COLOR 432                    // TODO: QL Stub - Implement this
#define UI_NEXTMAP 433                            // TODO: QL Stub - Implement this
#define UI_VOTESTRING 434                         // TODO: QL Stub - Implement this
#define UI_TEAMPLAYERMODEL 435                    // TODO: QL Stub - Implement this
#define UI_ENEMYPLAYERMODEL 436                   // TODO: QL Stub - Implement this
#define UI_REDTEAMMODEL 437                       // TODO: QL Stub - Implement this
#define UI_BLUETEAMMODEL 438                      // TODO: QL Stub - Implement this
#define UI_SERVER_SETTINGS 439                    // TODO: QL Stub - Implement this
#define UI_STARTING_WEAPONS 440                   // TODO: QL Stub - Implement this
#define UI_HOSTGAMEFACTORY 441		// ~Dimmskii
#define UI_GAMEFACTORYINFO 442		// ~Dimmskii

#define VOICECHAT_GETFLAG			"getflag"				// command someone to get the flag
#define VOICECHAT_OFFENSE			"offense"				// command someone to go on offense
#define VOICECHAT_DEFEND			"defend"				// command someone to go on defense
#define VOICECHAT_DEFENDFLAG		"defendflag"			// command someone to defend the flag
#define VOICECHAT_PATROL			"patrol"				// command someone to go on patrol (roam)
#define VOICECHAT_CAMP				"camp"					// command someone to camp (we don't have sounds for this one)
#define VOICECHAT_FOLLOWME			"followme"				// command someone to follow you
#define VOICECHAT_RETURNFLAG		"returnflag"			// command someone to return our flag
#define VOICECHAT_FOLLOWFLAGCARRIER	"followflagcarrier"		// command someone to follow the flag carrier
#define VOICECHAT_YES				"yes"					// yes, affirmative, etc.
#define VOICECHAT_NO				"no"					// no, negative, etc.
#define VOICECHAT_ONGETFLAG			"ongetflag"				// I'm getting the flag
#define VOICECHAT_ONOFFENSE			"onoffense"				// I'm on offense
#define VOICECHAT_ONDEFENSE			"ondefense"				// I'm on defense
#define VOICECHAT_ONPATROL			"onpatrol"				// I'm on patrol (roaming)
#define VOICECHAT_ONCAMPING			"oncamp"				// I'm camping somewhere
#define VOICECHAT_ONFOLLOW			"onfollow"				// I'm following
#define VOICECHAT_ONFOLLOWCARRIER	"onfollowcarrier"		// I'm following the flag carrier
#define VOICECHAT_ONRETURNFLAG		"onreturnflag"			// I'm returning our flag
#define VOICECHAT_INPOSITION		"inposition"			// I'm in position
#define VOICECHAT_IHAVEFLAG			"ihaveflag"				// I have the flag
#define VOICECHAT_BASEATTACK		"baseattack"			// the base is under attack
#define VOICECHAT_ENEMYHASFLAG		"enemyhasflag"			// the enemy has our flag (CTF)
#define VOICECHAT_STARTLEADER		"startleader"			// I'm the leader
#define VOICECHAT_STOPLEADER		"stopleader"			// I resign leadership
#define VOICECHAT_TRASH				"trash"					// lots of trash talk
#define VOICECHAT_WHOISLEADER		"whoisleader"			// who is the team leader
#define VOICECHAT_WANTONDEFENSE		"wantondefense"			// I want to be on defense
#define VOICECHAT_WANTONOFFENSE		"wantonoffense"			// I want to be on offense
#define VOICECHAT_KILLINSULT		"kill_insult"			// I just killed you
#define VOICECHAT_TAUNT				"taunt"					// I want to taunt you
#define VOICECHAT_DEATHINSULT		"death_insult"			// you just killed me
#define VOICECHAT_KILLGAUNTLET		"kill_gauntlet"			// I just killed you with the gauntlet
#define VOICECHAT_PRAISE			"praise"				// you did something good
