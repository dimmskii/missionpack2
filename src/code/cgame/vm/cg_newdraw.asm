data
export drawTeamOverlayModificationCount
align 4
LABELV drawTeamOverlayModificationCount
byte 4 -1
export CG_InitTeamChat
code
proc CG_InitTeamChat 0 12
file "../cg_newdraw.c"
line 22
;1:
;2:#ifndef MISSIONPACK // bk001204
;3:#error This file not be used for classic Q3A.
;4:#endif
;5:
;6:#include "cg_local.h"
;7:#include "../ui/ui_shared.h"
;8:
;9:extern displayContextDef_t cgDC;
;10:
;11:
;12:// set in CG_ParseTeamInfo
;13:
;14://static int sortedTeamPlayers[TEAM_MAXOVERLAY];
;15://static int numSortedTeamPlayers;
;16:int drawTeamOverlayModificationCount = -1;
;17:
;18://static char systemChat[256];
;19://static char teamChat1[256];
;20://static char teamChat2[256];
;21:
;22:void CG_InitTeamChat() {
line 23
;23:  memset(teamChat1, 0, sizeof(teamChat1));
ADDRGP4 teamChat1
ARGP4
CNSTI4 0
ARGI4
CNSTU4 256
ARGU4
ADDRGP4 memset
CALLP4
pop
line 24
;24:  memset(teamChat2, 0, sizeof(teamChat2));
ADDRGP4 teamChat2
ARGP4
CNSTI4 0
ARGI4
CNSTU4 256
ARGU4
ADDRGP4 memset
CALLP4
pop
line 25
;25:  memset(systemChat, 0, sizeof(systemChat));
ADDRGP4 systemChat
ARGP4
CNSTI4 0
ARGI4
CNSTU4 256
ARGU4
ADDRGP4 memset
CALLP4
pop
line 26
;26:}
LABELV $81
endproc CG_InitTeamChat 0 12
export CG_SetPrintString
proc CG_SetPrintString 0 8
line 28
;27:
;28:void CG_SetPrintString(int type, const char *p) {
line 29
;29:  if (type == SYSTEM_PRINT) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $83
line 30
;30:    strcpy(systemChat, p);
ADDRGP4 systemChat
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 31
;31:  } else {
ADDRGP4 $84
JUMPV
LABELV $83
line 32
;32:    strcpy(teamChat2, teamChat1);
ADDRGP4 teamChat2
ARGP4
ADDRGP4 teamChat1
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 33
;33:    strcpy(teamChat1, p);
ADDRGP4 teamChat1
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 34
;34:  }
LABELV $84
line 35
;35:}
LABELV $82
endproc CG_SetPrintString 0 8
export CG_CheckOrderPending
proc CG_CheckOrderPending 28 12
line 37
;36:
;37:void CG_CheckOrderPending() {
line 38
;38:	if (cgs.gametype < GT_CTF) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 4
GEI4 $86
line 39
;39:		return;
ADDRGP4 $85
JUMPV
LABELV $86
line 41
;40:	}
;41:	if (cgs.orderPending) {
ADDRGP4 cgs+148716
INDIRI4
CNSTI4 0
EQI4 $89
line 44
;42:		//clientInfo_t *ci = cgs.clientinfo + sortedTeamPlayers[cg_currentSelectedPlayer.integer];
;43:		const char *p1, *p2, *b;
;44:		p1 = p2 = b = NULL;
ADDRLP4 12
CNSTP4 0
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 45
;45:		switch (cgs.currentOrder) {
ADDRLP4 16
ADDRGP4 cgs+148712
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
LTI4 $92
ADDRLP4 16
INDIRI4
CNSTI4 7
GTI4 $92
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $120-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $120
address $95
address $99
address $103
address $107
address $114
address $117
address $111
code
LABELV $95
line 47
;46:			case TEAMTASK_OFFENSE:
;47:				p1 = VOICECHAT_ONOFFENSE;
ADDRLP4 8
ADDRGP4 $96
ASGNP4
line 48
;48:				p2 = VOICECHAT_OFFENSE;
ADDRLP4 4
ADDRGP4 $97
ASGNP4
line 49
;49:				b = "+button7; wait; -button7";
ADDRLP4 0
ADDRGP4 $98
ASGNP4
line 50
;50:			break;
ADDRGP4 $93
JUMPV
LABELV $99
line 52
;51:			case TEAMTASK_DEFENSE:
;52:				p1 = VOICECHAT_ONDEFENSE;
ADDRLP4 8
ADDRGP4 $100
ASGNP4
line 53
;53:				p2 = VOICECHAT_DEFEND;
ADDRLP4 4
ADDRGP4 $101
ASGNP4
line 54
;54:				b = "+button8; wait; -button8";
ADDRLP4 0
ADDRGP4 $102
ASGNP4
line 55
;55:			break;					
ADDRGP4 $93
JUMPV
LABELV $103
line 57
;56:			case TEAMTASK_PATROL:
;57:				p1 = VOICECHAT_ONPATROL;
ADDRLP4 8
ADDRGP4 $104
ASGNP4
line 58
;58:				p2 = VOICECHAT_PATROL;
ADDRLP4 4
ADDRGP4 $105
ASGNP4
line 59
;59:				b = "+button9; wait; -button9";
ADDRLP4 0
ADDRGP4 $106
ASGNP4
line 60
;60:			break;
ADDRGP4 $93
JUMPV
LABELV $107
line 62
;61:			case TEAMTASK_FOLLOW: 
;62:				p1 = VOICECHAT_ONFOLLOW;
ADDRLP4 8
ADDRGP4 $108
ASGNP4
line 63
;63:				p2 = VOICECHAT_FOLLOWME;
ADDRLP4 4
ADDRGP4 $109
ASGNP4
line 64
;64:				b = "+button10; wait; -button10";
ADDRLP4 0
ADDRGP4 $110
ASGNP4
line 65
;65:			break;
ADDRGP4 $93
JUMPV
LABELV $111
line 67
;66:			case TEAMTASK_CAMP:
;67:				p1 = VOICECHAT_ONCAMPING;
ADDRLP4 8
ADDRGP4 $112
ASGNP4
line 68
;68:				p2 = VOICECHAT_CAMP;
ADDRLP4 4
ADDRGP4 $113
ASGNP4
line 69
;69:			break;
ADDRGP4 $93
JUMPV
LABELV $114
line 71
;70:			case TEAMTASK_RETRIEVE:
;71:				p1 = VOICECHAT_ONGETFLAG;
ADDRLP4 8
ADDRGP4 $115
ASGNP4
line 72
;72:				p2 = VOICECHAT_RETURNFLAG;
ADDRLP4 4
ADDRGP4 $116
ASGNP4
line 73
;73:			break;
ADDRGP4 $93
JUMPV
LABELV $117
line 75
;74:			case TEAMTASK_ESCORT:
;75:				p1 = VOICECHAT_ONFOLLOWCARRIER;
ADDRLP4 8
ADDRGP4 $118
ASGNP4
line 76
;76:				p2 = VOICECHAT_FOLLOWFLAGCARRIER;
ADDRLP4 4
ADDRGP4 $119
ASGNP4
line 77
;77:			break;
LABELV $92
LABELV $93
line 80
;78:		}
;79:
;80:		if (cg_currentSelectedPlayer.integer == numSortedTeamPlayers) {
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
ADDRGP4 numSortedTeamPlayers
INDIRI4
NEI4 $122
line 82
;81:			// to everyone
;82:			trap_SendConsoleCommand(va("cmd vsay_team %s\n", p2));
ADDRGP4 $125
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 83
;83:		} else {
ADDRGP4 $123
JUMPV
LABELV $122
line 85
;84:			// for the player self
;85:			if (sortedTeamPlayers[cg_currentSelectedPlayer.integer] == cg.snap->ps.clientNum && p1) {
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $126
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $126
line 86
;86:				trap_SendConsoleCommand(va("teamtask %i\n", cgs.currentOrder));
ADDRGP4 $130
ARGP4
ADDRGP4 cgs+148712
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 88
;87:				//trap_SendConsoleCommand(va("cmd say_team %s\n", p2));
;88:				trap_SendConsoleCommand(va("cmd vsay_team %s\n", p1));
ADDRGP4 $125
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 89
;89:			} else if (p2) {
ADDRGP4 $127
JUMPV
LABELV $126
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $132
line 91
;90:				//trap_SendConsoleCommand(va("cmd say_team %s, %s\n", ci->name,p));
;91:				trap_SendConsoleCommand(va("cmd vtell %d %s\n", sortedTeamPlayers[cg_currentSelectedPlayer.integer], p2));
ADDRGP4 $134
ARGP4
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 92
;92:			}
LABELV $132
LABELV $127
line 93
;93:		}
LABELV $123
line 94
;94:		if (b) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $136
line 95
;95:			trap_SendConsoleCommand(b);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 96
;96:		}
LABELV $136
line 97
;97:		cgs.orderPending = qfalse;
ADDRGP4 cgs+148716
CNSTI4 0
ASGNI4
line 98
;98:	}
LABELV $89
line 99
;99:}
LABELV $85
endproc CG_CheckOrderPending 28 12
proc CG_SetSelectedPlayerName 8 8
line 101
;100:
;101:static void CG_SetSelectedPlayerName() {
line 102
;102:  if (cg_currentSelectedPlayer.integer >= 0 && cg_currentSelectedPlayer.integer < numSortedTeamPlayers) {
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
CNSTI4 0
LTI4 $140
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
ADDRGP4 numSortedTeamPlayers
INDIRI4
GEI4 $140
line 103
;103:		clientInfo_t *ci = cgs.clientinfo + sortedTeamPlayers[cg_currentSelectedPlayer.integer];
ADDRLP4 0
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 104
;104:	  if (ci) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $141
line 105
;105:			trap_Cvar_Set("cg_selectedPlayerName", ci->name);
ADDRGP4 $148
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 106
;106:			trap_Cvar_Set("cg_selectedPlayer", va("%d", sortedTeamPlayers[cg_currentSelectedPlayer.integer]));
ADDRGP4 $150
ARGP4
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $149
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 107
;107:			cgs.currentOrder = ci->teamTask;
ADDRGP4 cgs+148712
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
ASGNI4
line 108
;108:	  }
line 109
;109:	} else {
ADDRGP4 $141
JUMPV
LABELV $140
line 110
;110:		trap_Cvar_Set("cg_selectedPlayerName", "Everyone");
ADDRGP4 $148
ARGP4
ADDRGP4 $153
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 111
;111:	}
LABELV $141
line 112
;112:}
LABELV $139
endproc CG_SetSelectedPlayerName 8 8
export CG_GetSelectedPlayer
proc CG_GetSelectedPlayer 0 0
line 113
;113:int CG_GetSelectedPlayer( void ) {
line 114
;114:	if (cg_currentSelectedPlayer.integer < 0 || cg_currentSelectedPlayer.integer >= numSortedTeamPlayers) {
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
CNSTI4 0
LTI4 $159
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
ADDRGP4 numSortedTeamPlayers
INDIRI4
LTI4 $155
LABELV $159
line 115
;115:		cg_currentSelectedPlayer.integer = 0;
ADDRGP4 cg_currentSelectedPlayer+12
CNSTI4 0
ASGNI4
line 116
;116:	}
LABELV $155
line 117
;117:	return cg_currentSelectedPlayer.integer;
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
RETI4
LABELV $154
endproc CG_GetSelectedPlayer 0 0
export CG_SelectNextPlayer
proc CG_SelectNextPlayer 4 0
line 120
;118:}
;119:
;120:void CG_SelectNextPlayer( void ) {
line 121
;121:	CG_CheckOrderPending();
ADDRGP4 CG_CheckOrderPending
CALLV
pop
line 122
;122:	if (cg_currentSelectedPlayer.integer >= 0 && cg_currentSelectedPlayer.integer < numSortedTeamPlayers) {
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
CNSTI4 0
LTI4 $163
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
ADDRGP4 numSortedTeamPlayers
INDIRI4
GEI4 $163
line 123
;123:		cg_currentSelectedPlayer.integer++;
ADDRLP4 0
ADDRGP4 cg_currentSelectedPlayer+12
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 124
;124:	} else {
ADDRGP4 $164
JUMPV
LABELV $163
line 125
;125:		cg_currentSelectedPlayer.integer = 0;
ADDRGP4 cg_currentSelectedPlayer+12
CNSTI4 0
ASGNI4
line 126
;126:	}
LABELV $164
line 127
;127:	CG_SetSelectedPlayerName();
ADDRGP4 CG_SetSelectedPlayerName
CALLV
pop
line 128
;128:}
LABELV $162
endproc CG_SelectNextPlayer 4 0
export CG_SelectPrevPlayer
proc CG_SelectPrevPlayer 4 0
line 130
;129:
;130:void CG_SelectPrevPlayer( void ) {
line 131
;131:	CG_CheckOrderPending();
ADDRGP4 CG_CheckOrderPending
CALLV
pop
line 132
;132:	if (cg_currentSelectedPlayer.integer > 0 && cg_currentSelectedPlayer.integer < numSortedTeamPlayers) {
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
CNSTI4 0
LEI4 $170
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
ADDRGP4 numSortedTeamPlayers
INDIRI4
GEI4 $170
line 133
;133:		cg_currentSelectedPlayer.integer--;
ADDRLP4 0
ADDRGP4 cg_currentSelectedPlayer+12
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 134
;134:	} else {
ADDRGP4 $171
JUMPV
LABELV $170
line 135
;135:		cg_currentSelectedPlayer.integer = numSortedTeamPlayers;
ADDRGP4 cg_currentSelectedPlayer+12
ADDRGP4 numSortedTeamPlayers
INDIRI4
ASGNI4
line 136
;136:	}
LABELV $171
line 137
;137:	CG_SetSelectedPlayerName();
ADDRGP4 CG_SetSelectedPlayerName
CALLV
pop
line 138
;138:}
LABELV $169
endproc CG_SelectPrevPlayer 4 0
proc CG_DrawPlayerArmorIcon 36 32
line 141
;139:
;140:
;141:static void CG_DrawPlayerArmorIcon( rectDef_t *rect, qboolean draw2D ) {
line 147
;142:	centity_t	*cent;
;143:	playerState_t	*ps;
;144:	vec3_t		angles;
;145:	vec3_t		origin;
;146:
;147:  if ( cg_drawStatus.integer == 0 ) {
ADDRGP4 cg_drawStatus+12
INDIRI4
CNSTI4 0
NEI4 $177
line 148
;148:		return;
ADDRGP4 $176
JUMPV
LABELV $177
line 151
;149:	}
;150:
;151:	cent = &cg_entities[cg.snap->ps.clientNum];
ADDRLP4 12
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 152
;152:	ps = &cg.snap->ps;
ADDRLP4 16
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 154
;153:
;154:	if ( draw2D || ( !cg_draw3dIcons.integer && cg_drawIcons.integer) ) { // bk001206 - parentheses
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $186
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
NEI4 $182
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $182
LABELV $186
line 155
;155:		CG_DrawPic( rect->x, rect->y + rect->h/2 + 1, rect->w, rect->h, cgs.media.armorIcon );
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1056964608
MULF4
ADDF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 cgs+148772+156
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 156
;156:  } else if (cg_draw3dIcons.integer) {
ADDRGP4 $183
JUMPV
LABELV $182
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
EQI4 $189
line 157
;157:	  VectorClear( angles );
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRLP4 0+4
CNSTF4 0
ASGNF4
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 158
;158:    origin[0] = 90;
ADDRLP4 20
CNSTF4 1119092736
ASGNF4
line 159
;159:  	origin[1] = 0;
ADDRLP4 20+4
CNSTF4 0
ASGNF4
line 160
;160:  	origin[2] = -10;
ADDRLP4 20+8
CNSTF4 3240099840
ASGNF4
line 161
;161:  	angles[YAW] = ( cg.time & 2047 ) * 360 / 2048.0;
ADDRLP4 0+4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 2047
BANDI4
CNSTI4 360
MULI4
CVIF4 4
CNSTF4 973078528
MULF4
ASGNF4
line 163
;162:  
;163:    CG_Draw3DModel( rect->x, rect->y, rect->w, rect->h, cgs.media.armorModel, 0, origin, angles );
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 cgs+148772+152
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 20
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 164
;164:  }
LABELV $189
LABELV $183
line 166
;165:
;166:}
LABELV $176
endproc CG_DrawPlayerArmorIcon 36 32
proc CG_DrawPlayerArmorValue 36 32
line 168
;167:
;168:static void CG_DrawPlayerArmorValue(rectDef_t *rect, float scale, vec4_t color, qhandle_t shader, int textStyle) {
line 174
;169:	char	num[16];
;170:  int value;
;171:	centity_t	*cent;
;172:	playerState_t	*ps;
;173:
;174:  cent = &cg_entities[cg.snap->ps.clientNum];
ADDRLP4 24
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 175
;175:	ps = &cg.snap->ps;
ADDRLP4 20
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 177
;176:
;177:	value = ps->stats[STAT_ARMOR];
ADDRLP4 0
ADDRLP4 20
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ASGNI4
line 180
;178:  
;179:
;180:	if (shader) {
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $203
line 181
;181:		trap_R_SetColor( color );
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 182
;182:		CG_DrawPic(rect->x, rect->y, rect->w, rect->h, shader);
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 183
;183:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 184
;184:	} else {
ADDRGP4 $204
JUMPV
LABELV $203
line 185
;185:		Com_sprintf (num, sizeof(num), "%i", value);
ADDRLP4 4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $205
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 186
;186:		value = CG_Text_Width(num, scale, 0);
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 28
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 28
INDIRI4
ASGNI4
line 187
;187:		CG_Text_Paint(rect->x + (rect->w - value) / 2, rect->y + rect->h, scale, color, num, 0, 0, textStyle);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
SUBF4
CNSTF4 1056964608
MULF4
ADDF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 188
;188:	}
LABELV $204
line 189
;189:}
LABELV $200
endproc CG_DrawPlayerArmorValue 36 32
proc CG_DrawPlayerAmmoIcon 44 32
line 201
;190:
;191:#ifndef MISSIONPACK // bk001206 
;192:static float healthColors[4][4] = { 
;193://		{ 0.2, 1.0, 0.2, 1.0 } , { 1.0, 0.2, 0.2, 1.0 }, {0.5, 0.5, 0.5, 1} };
;194:  // bk0101016 - float const
;195:  { 1.0f, 0.69f, 0.0f, 1.0f } ,		// normal
;196:  { 1.0f, 0.2f, 0.2f, 1.0f },		// low health
;197:  { 0.5f, 0.5f, 0.5f, 1.0f},		// weapon firing
;198:  { 1.0f, 1.0f, 1.0f, 1.0f } };		// health > 100
;199:#endif
;200:
;201:static void CG_DrawPlayerAmmoIcon( rectDef_t *rect, qboolean draw2D ) {
line 207
;202:	centity_t	*cent;
;203:	playerState_t	*ps;
;204:	vec3_t		angles;
;205:	vec3_t		origin;
;206:
;207:	cent = &cg_entities[cg.snap->ps.clientNum];
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 208
;208:	ps = &cg.snap->ps;
ADDRLP4 4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 210
;209:
;210:	if ( draw2D || (!cg_draw3dIcons.integer && cg_drawIcons.integer) ) { // bk001206 - parentheses
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $213
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
NEI4 $209
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $209
LABELV $213
line 212
;211:	  qhandle_t	icon;
;212:    icon = cg_weapons[ cg.predictedPlayerState.weapon ].ammoIcon;
ADDRLP4 32
ADDRGP4 cg+107636+144
INDIRI4
CNSTI4 136
MULI4
ADDRGP4 cg_weapons+72
ADDP4
INDIRI4
ASGNI4
line 213
;213:		if ( icon ) {
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $210
line 214
;214:		  CG_DrawPic( rect->x, rect->y, rect->w, rect->h, icon );
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 215
;215:		}
line 216
;216:  } else if (cg_draw3dIcons.integer) {
ADDRGP4 $210
JUMPV
LABELV $209
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
EQI4 $219
line 217
;217:  	if ( cent->currentState.weapon && cg_weapons[ cent->currentState.weapon ].ammoModel ) {
ADDRLP4 32
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 0
EQI4 $222
ADDRLP4 32
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 136
MULI4
ADDRGP4 cg_weapons+76
ADDP4
INDIRI4
CNSTI4 0
EQI4 $222
line 218
;218:	    VectorClear( angles );
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 8+4
CNSTF4 0
ASGNF4
ADDRLP4 8+8
CNSTF4 0
ASGNF4
line 219
;219:	  	origin[0] = 70;
ADDRLP4 20
CNSTF4 1116471296
ASGNF4
line 220
;220:  		origin[1] = 0;
ADDRLP4 20+4
CNSTF4 0
ASGNF4
line 221
;221:  		origin[2] = 0;
ADDRLP4 20+8
CNSTF4 0
ASGNF4
line 222
;222:  		angles[YAW] = 90 + 20 * sin( cg.time / 1000.0 );
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ARGF4
ADDRLP4 36
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 36
INDIRF4
CNSTF4 1101004800
MULF4
CNSTF4 1119092736
ADDF4
ASGNF4
line 223
;223:  		CG_Draw3DModel( rect->x, rect->y, rect->w, rect->h, cg_weapons[ cent->currentState.weapon ].ammoModel, 0, origin, angles );
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 136
MULI4
ADDRGP4 cg_weapons+76
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 20
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 224
;224:  	}
LABELV $222
line 225
;225:  }
LABELV $219
LABELV $210
line 226
;226:}
LABELV $206
endproc CG_DrawPlayerAmmoIcon 44 32
proc CG_DrawPlayerAmmoValue 36 32
line 228
;227:
;228:static void CG_DrawPlayerAmmoValue(rectDef_t *rect, float scale, vec4_t color, qhandle_t shader, int textStyle) {
line 234
;229:	char	num[16];
;230:	int value;
;231:	centity_t	*cent;
;232:	playerState_t	*ps;
;233:
;234:	cent = &cg_entities[cg.snap->ps.clientNum];
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 235
;235:	ps = &cg.snap->ps;
ADDRLP4 4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 237
;236:
;237:	if ( cent->currentState.weapon ) {
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 0
EQI4 $235
line 238
;238:		value = ps->ammo[cent->currentState.weapon];
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ASGNI4
line 239
;239:		if ( value > -1 ) {
ADDRLP4 8
INDIRI4
CNSTI4 -1
LEI4 $237
line 240
;240:			if (shader) {
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $239
line 241
;241:		    trap_R_SetColor( color );
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 242
;242:				CG_DrawPic(rect->x, rect->y, rect->w, rect->h, shader);
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 243
;243:			  trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 244
;244:			} else {
ADDRGP4 $240
JUMPV
LABELV $239
line 245
;245:				Com_sprintf (num, sizeof(num), "%i", value);
ADDRLP4 12
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $205
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 246
;246:				value = CG_Text_Width(num, scale, 0);
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 28
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 28
INDIRI4
ASGNI4
line 247
;247:				CG_Text_Paint(rect->x + (rect->w - value) / 2, rect->y + rect->h, scale, color, num, 0, 0, textStyle);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 8
INDIRI4
CVIF4 4
SUBF4
CNSTF4 1056964608
MULF4
ADDF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 248
;248:			}
LABELV $240
line 249
;249:		}
LABELV $237
line 250
;250:	}
LABELV $235
line 252
;251:
;252:}
LABELV $232
endproc CG_DrawPlayerAmmoValue 36 32
proc CG_DrawPlayerHead 52 24
line 256
;253:
;254:
;255:
;256:static void CG_DrawPlayerHead(rectDef_t *rect, qboolean draw2D) {
line 260
;257:	vec3_t		angles;
;258:	float		size, stretch;
;259:	float		frac;
;260:	float		x = rect->x;
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 262
;261:
;262:	VectorClear( angles );
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 4+4
CNSTF4 0
ASGNF4
ADDRLP4 4+8
CNSTF4 0
ASGNF4
line 264
;263:
;264:	if ( cg.damageTime && cg.time - cg.damageTime < DAMAGE_TIME ) {
ADDRGP4 cg+125808
INDIRI4
CNSTI4 0
EQI4 $244
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+125808
INDIRI4
SUBI4
CNSTI4 500
GEI4 $244
line 265
;265:		frac = (float)(cg.time - cg.damageTime ) / DAMAGE_TIME;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+125808
INDIRI4
SUBI4
CVIF4 4
CNSTF4 990057071
MULF4
ASGNF4
line 266
;266:		size = rect->w * 1.25 * ( 1.5 - frac * 0.5 );
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1067450368
MULF4
CNSTF4 1069547520
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
MULF4
SUBF4
MULF4
ASGNF4
line 268
;267:
;268:		stretch = size - rect->w * 1.25;
ADDRLP4 24
ADDRLP4 20
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1067450368
MULF4
SUBF4
ASGNF4
line 270
;269:		// kick in the direction of damage
;270:		x -= stretch * 0.5 + cg.damageX * stretch * 0.5;
ADDRLP4 28
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRLP4 28
INDIRF4
CNSTF4 1056964608
MULF4
ADDRGP4 cg+125812
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
CNSTF4 1056964608
MULF4
ADDF4
SUBF4
ASGNF4
line 272
;271:
;272:		cg.headStartYaw = 180 + cg.damageX * 45;
ADDRGP4 cg+125844
ADDRGP4 cg+125812
INDIRF4
CNSTF4 1110704128
MULF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 274
;273:
;274:		cg.headEndYaw = 180 + 20 * cos( crandom()*M_PI );
ADDRLP4 32
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1086918619
MULF4
ARGF4
ADDRLP4 36
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+125832
ADDRLP4 36
INDIRF4
CNSTF4 1101004800
MULF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 275
;275:		cg.headEndPitch = 5 * cos( crandom()*M_PI );
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1086918619
MULF4
ARGF4
ADDRLP4 44
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+125828
ADDRLP4 44
INDIRF4
CNSTF4 1084227584
MULF4
ASGNF4
line 277
;276:
;277:		cg.headStartTime = cg.time;
ADDRGP4 cg+125848
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 278
;278:		cg.headEndTime = cg.time + 100 + random() * 2000;
ADDRLP4 48
ADDRGP4 rand
CALLI4
ASGNI4
ADDRGP4 cg+125836
ADDRGP4 cg+107604
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
ADDRLP4 48
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1031406068
MULF4
ADDF4
CVFI4 4
ASGNI4
line 279
;279:	} else {
ADDRGP4 $245
JUMPV
LABELV $244
line 280
;280:		if ( cg.time >= cg.headEndTime ) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+125836
INDIRI4
LTI4 $260
line 282
;281:			// select a new head angle
;282:			cg.headStartYaw = cg.headEndYaw;
ADDRGP4 cg+125844
ADDRGP4 cg+125832
INDIRF4
ASGNF4
line 283
;283:			cg.headStartPitch = cg.headEndPitch;
ADDRGP4 cg+125840
ADDRGP4 cg+125828
INDIRF4
ASGNF4
line 284
;284:			cg.headStartTime = cg.headEndTime;
ADDRGP4 cg+125848
ADDRGP4 cg+125836
INDIRI4
ASGNI4
line 285
;285:			cg.headEndTime = cg.time + 100 + random() * 2000;
ADDRLP4 28
ADDRGP4 rand
CALLI4
ASGNI4
ADDRGP4 cg+125836
ADDRGP4 cg+107604
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
ADDRLP4 28
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1031406068
MULF4
ADDF4
CVFI4 4
ASGNI4
line 287
;286:
;287:			cg.headEndYaw = 180 + 20 * cos( crandom()*M_PI );
ADDRLP4 32
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1086918619
MULF4
ARGF4
ADDRLP4 36
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+125832
ADDRLP4 36
INDIRF4
CNSTF4 1101004800
MULF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 288
;288:			cg.headEndPitch = 5 * cos( crandom()*M_PI );
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1086918619
MULF4
ARGF4
ADDRLP4 44
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+125828
ADDRLP4 44
INDIRF4
CNSTF4 1084227584
MULF4
ASGNF4
line 289
;289:		}
LABELV $260
line 291
;290:
;291:		size = rect->w * 1.25;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1067450368
MULF4
ASGNF4
line 292
;292:	}
LABELV $245
line 295
;293:
;294:	// if the server was frozen for a while we may have a bad head start time
;295:	if ( cg.headStartTime > cg.time ) {
ADDRGP4 cg+125848
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $274
line 296
;296:		cg.headStartTime = cg.time;
ADDRGP4 cg+125848
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 297
;297:	}
LABELV $274
line 299
;298:
;299:	frac = ( cg.time - cg.headStartTime ) / (float)( cg.headEndTime - cg.headStartTime );
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+125848
INDIRI4
SUBI4
CVIF4 4
ADDRGP4 cg+125836
INDIRI4
ADDRGP4 cg+125848
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 300
;300:	frac = frac * frac * ( 3 - 2 * frac );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1077936128
ADDRLP4 0
INDIRF4
CNSTF4 1073741824
MULF4
SUBF4
MULF4
ASGNF4
line 301
;301:	angles[YAW] = cg.headStartYaw + ( cg.headEndYaw - cg.headStartYaw ) * frac;
ADDRLP4 4+4
ADDRGP4 cg+125844
INDIRF4
ADDRGP4 cg+125832
INDIRF4
ADDRGP4 cg+125844
INDIRF4
SUBF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 302
;302:	angles[PITCH] = cg.headStartPitch + ( cg.headEndPitch - cg.headStartPitch ) * frac;
ADDRLP4 4
ADDRGP4 cg+125840
INDIRF4
ADDRGP4 cg+125828
INDIRF4
ADDRGP4 cg+125840
INDIRF4
SUBF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 304
;303:
;304:	CG_DrawHead( x, rect->y, rect->w, rect->h, cg.snap->ps.clientNum, angles );
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 CG_DrawHead
CALLV
pop
line 305
;305:}
LABELV $241
endproc CG_DrawPlayerHead 52 24
proc CG_DrawSelectedPlayerHealth 36 32
line 307
;306:
;307:static void CG_DrawSelectedPlayerHealth( rectDef_t *rect, float scale, vec4_t color, qhandle_t shader, int textStyle ) {
line 312
;308:	clientInfo_t *ci;
;309:	int value;
;310:	char num[16];
;311:
;312:  ci = cgs.clientinfo + sortedTeamPlayers[CG_GetSelectedPlayer()];
ADDRLP4 24
ADDRGP4 CG_GetSelectedPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 313
;313:  if (ci) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $294
line 314
;314:		if (shader) {
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $296
line 315
;315:			trap_R_SetColor( color );
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 316
;316:			CG_DrawPic(rect->x, rect->y, rect->w, rect->h, shader);
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 317
;317:			trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 318
;318:		} else {
ADDRGP4 $297
JUMPV
LABELV $296
line 319
;319:			Com_sprintf (num, sizeof(num), "%i", ci->health);
ADDRLP4 4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $205
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 320
;320:		  value = CG_Text_Width(num, scale, 0);
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 28
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 28
INDIRI4
ASGNI4
line 321
;321:		  CG_Text_Paint(rect->x + (rect->w - value) / 2, rect->y + rect->h, scale, color, num, 0, 0, textStyle);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 20
INDIRI4
CVIF4 4
SUBF4
CNSTF4 1056964608
MULF4
ADDF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 322
;322:		}
LABELV $297
line 323
;323:	}
LABELV $294
line 324
;324:}
LABELV $292
endproc CG_DrawSelectedPlayerHealth 36 32
proc CG_DrawSelectedPlayerArmor 36 32
line 326
;325:
;326:static void CG_DrawSelectedPlayerArmor( rectDef_t *rect, float scale, vec4_t color, qhandle_t shader, int textStyle ) {
line 330
;327:	clientInfo_t *ci;
;328:	int value;
;329:	char num[16];
;330:  ci = cgs.clientinfo + sortedTeamPlayers[CG_GetSelectedPlayer()];
ADDRLP4 24
ADDRGP4 CG_GetSelectedPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 331
;331:  if (ci) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $300
line 332
;332:    if (ci->armor > 0) {
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
LEI4 $302
line 333
;333:			if (shader) {
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $304
line 334
;334:				trap_R_SetColor( color );
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 335
;335:				CG_DrawPic(rect->x, rect->y, rect->w, rect->h, shader);
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 336
;336:				trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 337
;337:			} else {
ADDRGP4 $305
JUMPV
LABELV $304
line 338
;338:				Com_sprintf (num, sizeof(num), "%i", ci->armor);
ADDRLP4 4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $205
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 339
;339:				value = CG_Text_Width(num, scale, 0);
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 28
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 28
INDIRI4
ASGNI4
line 340
;340:				CG_Text_Paint(rect->x + (rect->w - value) / 2, rect->y + rect->h, scale, color, num, 0, 0, textStyle);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 20
INDIRI4
CVIF4 4
SUBF4
CNSTF4 1056964608
MULF4
ADDF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 341
;341:			}
LABELV $305
line 342
;342:		}
LABELV $302
line 343
;343: 	}
LABELV $300
line 344
;344:}
LABELV $298
endproc CG_DrawSelectedPlayerArmor 36 32
export CG_StatusHandle
proc CG_StatusHandle 8 0
line 346
;345:
;346:qhandle_t CG_StatusHandle(int task) {
line 347
;347:	qhandle_t h = cgs.media.assaultShader;
ADDRLP4 0
ADDRGP4 cgs+148772+1172
INDIRI4
ASGNI4
line 348
;348:	switch (task) {
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
LTI4 $309
ADDRLP4 4
INDIRI4
CNSTI4 7
GTI4 $309
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $334-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $334
address $311
address $314
address $317
address $320
address $326
address $329
address $323
code
LABELV $311
line 350
;349:		case TEAMTASK_OFFENSE :
;350:			h = cgs.media.assaultShader;
ADDRLP4 0
ADDRGP4 cgs+148772+1172
INDIRI4
ASGNI4
line 351
;351:			break;
ADDRGP4 $310
JUMPV
LABELV $314
line 353
;352:		case TEAMTASK_DEFENSE :
;353:			h = cgs.media.defendShader;
ADDRLP4 0
ADDRGP4 cgs+148772+1184
INDIRI4
ASGNI4
line 354
;354:			break;
ADDRGP4 $310
JUMPV
LABELV $317
line 356
;355:		case TEAMTASK_PATROL :
;356:			h = cgs.media.patrolShader;
ADDRLP4 0
ADDRGP4 cgs+148772+1168
INDIRI4
ASGNI4
line 357
;357:			break;
ADDRGP4 $310
JUMPV
LABELV $320
line 359
;358:		case TEAMTASK_FOLLOW :
;359:			h = cgs.media.followShader;
ADDRLP4 0
ADDRGP4 cgs+148772+1180
INDIRI4
ASGNI4
line 360
;360:			break;
ADDRGP4 $310
JUMPV
LABELV $323
line 362
;361:		case TEAMTASK_CAMP :
;362:			h = cgs.media.campShader;
ADDRLP4 0
ADDRGP4 cgs+148772+1176
INDIRI4
ASGNI4
line 363
;363:			break;
ADDRGP4 $310
JUMPV
LABELV $326
line 365
;364:		case TEAMTASK_RETRIEVE :
;365:			h = cgs.media.retrieveShader; 
ADDRLP4 0
ADDRGP4 cgs+148772+1192
INDIRI4
ASGNI4
line 366
;366:			break;
ADDRGP4 $310
JUMPV
LABELV $329
line 368
;367:		case TEAMTASK_ESCORT :
;368:			h = cgs.media.escortShader; 
ADDRLP4 0
ADDRGP4 cgs+148772+1196
INDIRI4
ASGNI4
line 369
;369:			break;
ADDRGP4 $310
JUMPV
LABELV $309
line 371
;370:		default : 
;371:			h = cgs.media.assaultShader;
ADDRLP4 0
ADDRGP4 cgs+148772+1172
INDIRI4
ASGNI4
line 372
;372:			break;
LABELV $310
line 374
;373:	}
;374:	return h;
ADDRLP4 0
INDIRI4
RETI4
LABELV $306
endproc CG_StatusHandle 8 0
proc CG_DrawSelectedPlayerStatus 16 20
line 377
;375:}
;376:
;377:static void CG_DrawSelectedPlayerStatus( rectDef_t *rect ) {
line 378
;378:	clientInfo_t *ci = cgs.clientinfo + sortedTeamPlayers[CG_GetSelectedPlayer()];
ADDRLP4 4
ADDRGP4 CG_GetSelectedPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 379
;379:	if (ci) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $338
line 381
;380:		qhandle_t h;
;381:		if (cgs.orderPending) {
ADDRGP4 cgs+148716
INDIRI4
CNSTI4 0
EQI4 $340
line 383
;382:			// blink the icon
;383:			if ( cg.time > cgs.orderTime - 2500 && (cg.time >> 9 ) & 1 ) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+148720
INDIRI4
CNSTI4 2500
SUBI4
LEI4 $343
ADDRGP4 cg+107604
INDIRI4
CNSTI4 9
RSHI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $343
line 384
;384:				return;
ADDRGP4 $336
JUMPV
LABELV $343
line 386
;385:			}
;386:			h = CG_StatusHandle(cgs.currentOrder);
ADDRGP4 cgs+148712
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 CG_StatusHandle
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 387
;387:		}	else {
ADDRGP4 $341
JUMPV
LABELV $340
line 388
;388:			h = CG_StatusHandle(ci->teamTask);
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 CG_StatusHandle
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 389
;389:		}
LABELV $341
line 390
;390:		CG_DrawPic( rect->x, rect->y, rect->w, rect->h, h );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 391
;391:	}
LABELV $338
line 392
;392:}
LABELV $336
endproc CG_DrawSelectedPlayerStatus 16 20
proc CG_DrawPlayerStatus 16 20
line 395
;393:
;394:
;395:static void CG_DrawPlayerStatus( rectDef_t *rect ) {
line 396
;396:	clientInfo_t *ci = &cgs.clientinfo[cg.snap->ps.clientNum];
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 397
;397:	if (ci) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $352
line 398
;398:		qhandle_t h = CG_StatusHandle(ci->teamTask);
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_StatusHandle
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 399
;399:		CG_DrawPic( rect->x, rect->y, rect->w, rect->h, h);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 400
;400:	}
LABELV $352
line 401
;401:}
LABELV $349
endproc CG_DrawPlayerStatus 16 20
proc CG_DrawSelectedPlayerName 16 32
line 404
;402:
;403:
;404:static void CG_DrawSelectedPlayerName( rectDef_t *rect, float scale, vec4_t color, qboolean voice, int textStyle) {
line 406
;405:	clientInfo_t *ci;
;406:  ci = cgs.clientinfo + ((voice) ? cgs.currentVoiceClient : sortedTeamPlayers[CG_GetSelectedPlayer()]);
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $358
ADDRLP4 4
ADDRGP4 cgs+148724
INDIRI4
ASGNI4
ADDRGP4 $359
JUMPV
LABELV $358
ADDRLP4 8
ADDRGP4 CG_GetSelectedPlayer
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
ASGNI4
LABELV $359
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 407
;407:  if (ci) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $360
line 408
;408:    CG_Text_Paint(rect->x, rect->y + rect->h, scale, color, ci->name, 0, 0, textStyle);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 409
;409:  }
LABELV $360
line 410
;410:}
LABELV $354
endproc CG_DrawSelectedPlayerName 16 32
proc CG_DrawSelectedPlayerLocation 24 32
line 412
;411:
;412:static void CG_DrawSelectedPlayerLocation( rectDef_t *rect, float scale, vec4_t color, int textStyle ) {
line 414
;413:	clientInfo_t *ci;
;414:  ci = cgs.clientinfo + sortedTeamPlayers[CG_GetSelectedPlayer()];
ADDRLP4 4
ADDRGP4 CG_GetSelectedPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 415
;415:  if (ci) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $364
line 416
;416:		const char *p = CG_ConfigString(CS_LOCATIONS + ci->location);
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 608
ADDI4
ARGI4
ADDRLP4 12
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 417
;417:		if (!p || !*p) {
ADDRLP4 16
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $368
ADDRLP4 16
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $366
LABELV $368
line 418
;418:			p = "unknown";
ADDRLP4 8
ADDRGP4 $369
ASGNP4
line 419
;419:		}
LABELV $366
line 420
;420:    CG_Text_Paint(rect->x, rect->y + rect->h, scale, color, p, 0, 0, textStyle);
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 421
;421:  }
LABELV $364
line 422
;422:}
LABELV $362
endproc CG_DrawSelectedPlayerLocation 24 32
proc CG_DrawPlayerLocation 20 32
line 424
;423:
;424:static void CG_DrawPlayerLocation( rectDef_t *rect, float scale, vec4_t color, int textStyle  ) {
line 425
;425:	clientInfo_t *ci = &cgs.clientinfo[cg.snap->ps.clientNum];
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 426
;426:  if (ci) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $373
line 427
;427:		const char *p = CG_ConfigString(CS_LOCATIONS + ci->location);
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 608
ADDI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 428
;428:		if (!p || !*p) {
ADDRLP4 12
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $377
ADDRLP4 12
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $375
LABELV $377
line 429
;429:			p = "unknown";
ADDRLP4 4
ADDRGP4 $369
ASGNP4
line 430
;430:		}
LABELV $375
line 431
;431:    CG_Text_Paint(rect->x, rect->y + rect->h, scale, color, p, 0, 0, textStyle);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 432
;432:  }
LABELV $373
line 433
;433:}
LABELV $370
endproc CG_DrawPlayerLocation 20 32
proc CG_DrawSelectedPlayerWeapon 12 20
line 437
;434:
;435:
;436:
;437:static void CG_DrawSelectedPlayerWeapon( rectDef_t *rect ) {
line 440
;438:	clientInfo_t *ci;
;439:
;440:  ci = cgs.clientinfo + sortedTeamPlayers[CG_GetSelectedPlayer()];
ADDRLP4 4
ADDRGP4 CG_GetSelectedPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 441
;441:  if (ci) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $380
line 442
;442:	  if ( cg_weapons[ci->curWeapon].weaponIcon ) {
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 136
MULI4
ADDRGP4 cg_weapons+68
ADDP4
INDIRI4
CNSTI4 0
EQI4 $382
line 443
;443:	    CG_DrawPic( rect->x, rect->y, rect->w, rect->h, cg_weapons[ci->curWeapon].weaponIcon );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 136
MULI4
ADDRGP4 cg_weapons+68
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 444
;444:		} else {
ADDRGP4 $383
JUMPV
LABELV $382
line 445
;445:  	  CG_DrawPic( rect->x, rect->y, rect->w, rect->h, cgs.media.deferShader);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 cgs+148772+164
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 446
;446:    }
LABELV $383
line 447
;447:  }
LABELV $380
line 448
;448:}
LABELV $378
endproc CG_DrawSelectedPlayerWeapon 12 20
proc CG_DrawPlayerScore 28 32
line 450
;449:
;450:static void CG_DrawPlayerScore( rectDef_t *rect, float scale, vec4_t color, qhandle_t shader, int textStyle ) {
line 452
;451:  char num[16];
;452:  int value = cg.snap->ps.persistant[PERS_SCORE];
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ASGNI4
line 454
;453:
;454:	if (shader) {
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $390
line 455
;455:		trap_R_SetColor( color );
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 456
;456:		CG_DrawPic(rect->x, rect->y, rect->w, rect->h, shader);
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 457
;457:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 458
;458:	} else {
ADDRGP4 $391
JUMPV
LABELV $390
line 459
;459:		Com_sprintf (num, sizeof(num), "%i", value);
ADDRLP4 4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $205
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 460
;460:		value = CG_Text_Width(num, scale, 0);
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 20
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
ASGNI4
line 461
;461:	  CG_Text_Paint(rect->x + (rect->w - value) / 2, rect->y + rect->h, scale, color, num, 0, 0, textStyle);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
SUBF4
CNSTF4 1056964608
MULF4
ADDF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 462
;462:	}
LABELV $391
line 463
;463:}
LABELV $388
endproc CG_DrawPlayerScore 28 32
proc CG_DrawPlayerItem 32 32
line 465
;464:
;465:static void CG_DrawPlayerItem( rectDef_t *rect, float scale, qboolean draw2D) {
line 469
;466:	int		value;
;467:  vec3_t origin, angles;
;468:
;469:	value = cg.snap->ps.stats[STAT_HOLDABLE_ITEM];
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ASGNI4
line 470
;470:	if ( value ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $394
line 471
;471:		CG_RegisterItemVisuals( value );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 473
;472:
;473:		if (qtrue) {
line 474
;474:		  CG_RegisterItemVisuals( value );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 475
;475:		  CG_DrawPic( rect->x, rect->y, rect->w, rect->h, cg_items[ value ].icon );
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 28
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 476
;476:		} else {
ADDRGP4 $397
JUMPV
LABELV $396
line 477
;477: 			VectorClear( angles );
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 4+4
CNSTF4 0
ASGNF4
ADDRLP4 4+8
CNSTF4 0
ASGNF4
line 478
;478:			origin[0] = 90;
ADDRLP4 16
CNSTF4 1119092736
ASGNF4
line 479
;479:  		origin[1] = 0;
ADDRLP4 16+4
CNSTF4 0
ASGNF4
line 480
;480:   		origin[2] = -10;
ADDRLP4 16+8
CNSTF4 3240099840
ASGNF4
line 481
;481:  		angles[YAW] = ( cg.time & 2047 ) * 360 / 2048.0;
ADDRLP4 4+4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 2047
BANDI4
CNSTI4 360
MULI4
CVIF4 4
CNSTF4 973078528
MULF4
ASGNF4
line 482
;482:			CG_Draw3DModel(rect->x, rect->y, rect->w, rect->h, cg_items[ value ].models[0], 0, origin, angles );
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 28
MULI4
ADDRGP4 cg_items+4
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 483
;483:		}
LABELV $397
line 484
;484:	}
LABELV $394
line 486
;485:
;486:}
LABELV $392
endproc CG_DrawPlayerItem 32 32
proc CG_DrawSelectedPlayerPowerup 36 20
line 489
;487:
;488:
;489:static void CG_DrawSelectedPlayerPowerup( rectDef_t *rect, qboolean draw2D ) {
line 494
;490:	clientInfo_t *ci;
;491:  int j;
;492:  float x, y;
;493:
;494:  ci = cgs.clientinfo + sortedTeamPlayers[CG_GetSelectedPlayer()];
ADDRLP4 16
ADDRGP4 CG_GetSelectedPlayer
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 495
;495:  if (ci) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $408
line 496
;496:    x = rect->x;
ADDRLP4 8
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 497
;497:    y = rect->y;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 499
;498:
;499:		for (j = 0; j < PW_NUM_POWERUPS; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $410
line 500
;500:			if (ci->powerups & (1 << j)) {
ADDRLP4 4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $414
line 502
;501:				gitem_t	*item;
;502:				item = BG_FindItemForPowerup( j );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 24
INDIRP4
ASGNP4
line 503
;503:				if (item) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $416
line 504
;504:				  CG_DrawPic( x, y, rect->w, rect->h, trap_R_RegisterShader( item->icon ) );
ADDRLP4 20
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 505
;505:					x += 3;
ADDRLP4 8
ADDRLP4 8
INDIRF4
CNSTF4 1077936128
ADDF4
ASGNF4
line 506
;506:					y += 3;
ADDRLP4 12
ADDRLP4 12
INDIRF4
CNSTF4 1077936128
ADDF4
ASGNF4
line 507
;507:          return;
ADDRGP4 $406
JUMPV
LABELV $416
line 509
;508:				}
;509:			}
LABELV $414
line 510
;510:		}
LABELV $411
line 499
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 15
LTI4 $410
line 512
;511:
;512:  }
LABELV $408
line 513
;513:}
LABELV $406
endproc CG_DrawSelectedPlayerPowerup 36 20
proc CG_DrawSelectedPlayerHead 80 32
line 516
;514:
;515:
;516:static void CG_DrawSelectedPlayerHead( rectDef_t *rect, qboolean draw2D, qboolean voice ) {
line 524
;517:	clipHandle_t	cm;
;518:	clientInfo_t	*ci;
;519:	float			len;
;520:	vec3_t			origin;
;521:	vec3_t			mins, maxs, angles;
;522:
;523:
;524:  ci = cgs.clientinfo + ((voice) ? cgs.currentVoiceClient : sortedTeamPlayers[CG_GetSelectedPlayer()]);
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $422
ADDRLP4 60
ADDRGP4 cgs+148724
INDIRI4
ASGNI4
ADDRGP4 $423
JUMPV
LABELV $422
ADDRLP4 64
ADDRGP4 CG_GetSelectedPlayer
CALLI4
ASGNI4
ADDRLP4 60
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
ASGNI4
LABELV $423
ADDRLP4 0
ADDRLP4 60
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 526
;525:
;526:  if (ci) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $424
line 527
;527:  	if ( cg_draw3dIcons.integer ) {
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
EQI4 $426
line 528
;528:	  	cm = ci->headModel;
ADDRLP4 52
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ASGNI4
line 529
;529:  		if ( !cm ) {
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $429
line 530
;530:  			return;
ADDRGP4 $418
JUMPV
LABELV $429
line 534
;531:	  	}
;532:
;533:  		// offset the origin y and z to center the head
;534:  		trap_R_ModelBounds( cm, mins, maxs );
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 536
;535:
;536:	  	origin[2] = -0.5 * ( mins[2] + maxs[2] );
ADDRLP4 4+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 28+8
INDIRF4
ADDF4
CNSTF4 3204448256
MULF4
ASGNF4
line 537
;537:  		origin[1] = 0.5 * ( mins[1] + maxs[1] );
ADDRLP4 4+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 28+4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ASGNF4
line 541
;538:
;539:	  	// calculate distance so the head nearly fills the box
;540:  		// assume heads are taller than wide
;541:  		len = 0.7 * ( maxs[2] - mins[2] );		
ADDRLP4 56
ADDRLP4 28+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
CNSTF4 1060320051
MULF4
ASGNF4
line 542
;542:  		origin[0] = len / 0.268;	// len / tan( fov/2 )
ADDRLP4 4
ADDRLP4 56
INDIRF4
CNSTF4 1081003604
MULF4
ASGNF4
line 545
;543:
;544:  		// allow per-model tweaking
;545:  		VectorAdd( origin, ci->headOffset, origin );
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 400
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRF4
ADDF4
ASGNF4
line 547
;546:
;547:    	angles[PITCH] = 0;
ADDRLP4 40
CNSTF4 0
ASGNF4
line 548
;548:    	angles[YAW] = 180;
ADDRLP4 40+4
CNSTF4 1127481344
ASGNF4
line 549
;549:    	angles[ROLL] = 0;
ADDRLP4 40+8
CNSTF4 0
ASGNF4
line 551
;550:  	
;551:      CG_Draw3DModel( rect->x, rect->y, rect->w, rect->h, ci->headModel, ci->headSkin, origin, angles );
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
INDIRF4
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 40
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 552
;552:  	} else if ( cg_drawIcons.integer ) {
ADDRGP4 $427
JUMPV
LABELV $426
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $445
line 553
;553:	  	CG_DrawPic( rect->x, rect->y, rect->w, rect->h, ci->modelIcon );
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
INDIRF4
ARGF4
ADDRLP4 68
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 68
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 68
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 554
;554:  	}
LABELV $445
LABELV $427
line 557
;555:
;556:  	// if they are deferred, draw a cross out
;557:  	if ( ci->deferred ) {
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
EQI4 $448
line 558
;558:  		CG_DrawPic( rect->x, rect->y, rect->w, rect->h, cgs.media.deferShader );
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
INDIRF4
ARGF4
ADDRLP4 68
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 68
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 68
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 cgs+148772+164
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 559
;559:  	}
LABELV $448
line 560
;560:  }
LABELV $424
line 562
;561:
;562:}
LABELV $418
endproc CG_DrawSelectedPlayerHead 80 32
proc CG_DrawPlayerHealth 32 32
line 565
;563:
;564:
;565:static void CG_DrawPlayerHealth(rectDef_t *rect, float scale, vec4_t color, qhandle_t shader, int textStyle ) {
line 570
;566:	playerState_t	*ps;
;567:  int value;
;568:	char	num[16];
;569:
;570:	ps = &cg.snap->ps;
ADDRLP4 4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 572
;571:
;572:	value = ps->stats[STAT_HEALTH];
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 574
;573:
;574:	if (shader) {
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $454
line 575
;575:		trap_R_SetColor( color );
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 576
;576:		CG_DrawPic(rect->x, rect->y, rect->w, rect->h, shader);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 577
;577:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 578
;578:	} else {
ADDRGP4 $455
JUMPV
LABELV $454
line 579
;579:		Com_sprintf (num, sizeof(num), "%i", value);
ADDRLP4 8
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $205
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 580
;580:		value = CG_Text_Width(num, scale, 0);
ADDRLP4 8
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 24
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRI4
ASGNI4
line 581
;581:		CG_Text_Paint(rect->x + (rect->w - value) / 2, rect->y + rect->h, scale, color, num, 0, 0, textStyle);
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
SUBF4
CNSTF4 1056964608
MULF4
ADDF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 582
;582:	}
LABELV $455
line 583
;583:}
LABELV $452
endproc CG_DrawPlayerHealth 32 32
proc CG_DrawRedScore 28 32
line 586
;584:
;585:
;586:static void CG_DrawRedScore(rectDef_t *rect, float scale, vec4_t color, qhandle_t shader, int textStyle ) {
line 589
;587:	int value;
;588:	char num[16];
;589:	if ( cgs.scores1 == SCORE_NOT_PRESENT ) {
ADDRGP4 cgs+34824
INDIRI4
CNSTI4 -9999
NEI4 $457
line 590
;590:		Com_sprintf (num, sizeof(num), "-");
ADDRLP4 0
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $460
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 591
;591:	}
ADDRGP4 $458
JUMPV
LABELV $457
line 592
;592:	else {
line 593
;593:		Com_sprintf (num, sizeof(num), "%i", cgs.scores1);
ADDRLP4 0
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $205
ARGP4
ADDRGP4 cgs+34824
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 594
;594:	}
LABELV $458
line 595
;595:	value = CG_Text_Width(num, scale, 0);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 20
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 20
INDIRI4
ASGNI4
line 596
;596:	CG_Text_Paint(rect->x + rect->w - value, rect->y + rect->h, scale, color, num, 0, 0, textStyle);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
ADDRLP4 16
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 597
;597:}
LABELV $456
endproc CG_DrawRedScore 28 32
proc CG_DrawBlueScore 28 32
line 599
;598:
;599:static void CG_DrawBlueScore(rectDef_t *rect, float scale, vec4_t color, qhandle_t shader, int textStyle ) {
line 603
;600:	int value;
;601:	char num[16];
;602:
;603:	if ( cgs.scores2 == SCORE_NOT_PRESENT ) {
ADDRGP4 cgs+34828
INDIRI4
CNSTI4 -9999
NEI4 $463
line 604
;604:		Com_sprintf (num, sizeof(num), "-");
ADDRLP4 0
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $460
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 605
;605:	}
ADDRGP4 $464
JUMPV
LABELV $463
line 606
;606:	else {
line 607
;607:		Com_sprintf (num, sizeof(num), "%i", cgs.scores2);
ADDRLP4 0
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $205
ARGP4
ADDRGP4 cgs+34828
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 608
;608:	}
LABELV $464
line 609
;609:	value = CG_Text_Width(num, scale, 0);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 20
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 20
INDIRI4
ASGNI4
line 610
;610:	CG_Text_Paint(rect->x + rect->w - value, rect->y + rect->h, scale, color, num, 0, 0, textStyle);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
ADDRLP4 16
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 611
;611:}
LABELV $462
endproc CG_DrawBlueScore 28 32
proc CG_DrawRedName 4 32
line 614
;612:
;613:// FIXME: team name support (fixed by Kr3m leaving here)
;614:static void CG_DrawRedName(rectDef_t *rect, float scale, vec4_t color, int textStyle ) {
line 615
;615:  CG_Text_Paint(rect->x, rect->y + rect->h, scale, color, cgs.redTeam , 0, 0, textStyle);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 cgs+31572
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 616
;616:}
LABELV $467
endproc CG_DrawRedName 4 32
proc CG_DrawBlueName 4 32
line 618
;617:
;618:static void CG_DrawBlueName(rectDef_t *rect, float scale, vec4_t color, int textStyle ) {
line 619
;619:  CG_Text_Paint(rect->x, rect->y + rect->h, scale, color, cgs.blueTeam, 0, 0, textStyle);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 cgs+31636
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 620
;620:}
LABELV $469
endproc CG_DrawBlueName 4 32
proc CG_DrawBlueFlagName 12 32
line 622
;621:
;622:static void CG_DrawBlueFlagName(rectDef_t *rect, float scale, vec4_t color, int textStyle ) {
line 624
;623:  int i;
;624:  for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $475
JUMPV
LABELV $472
line 625
;625:	  if ( cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_RED  && cgs.clientinfo[i].powerups & ( 1<< PW_BLUEFLAG )) {
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
INDIRI4
CNSTI4 0
EQI4 $477
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $477
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+108
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $477
line 626
;626:      CG_Text_Paint(rect->x, rect->y + rect->h, scale, color, cgs.clientinfo[i].name, 0, 0, textStyle);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+4
ADDP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 627
;627:      return;
ADDRGP4 $471
JUMPV
LABELV $477
line 629
;628:    }
;629:  }
LABELV $473
line 624
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $475
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+31504
INDIRI4
LTI4 $472
line 630
;630:}
LABELV $471
endproc CG_DrawBlueFlagName 12 32
data
align 4
LABELV $494
byte 4 0
byte 4 0
byte 4 1065353216
byte 4 1065353216
align 4
LABELV $501
byte 4 0
byte 4 0
byte 4 1065353216
byte 4 1065353216
code
proc CG_DrawBlueFlagStatus 28 20
line 632
;631:
;632:static void CG_DrawBlueFlagStatus(rectDef_t *rect, qhandle_t shader) {
line 633
;633:	if (cgs.gametype != GT_CTF && cgs.gametype != GT_1FCTF) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 4
EQI4 $487
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 5
EQI4 $487
line 634
;634:		if (cgs.gametype == GT_HARVESTER) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 7
NEI4 $486
line 635
;635:		  vec4_t color = {0, 0, 1, 1};
ADDRLP4 0
ADDRGP4 $494
INDIRB
ASGNB 16
line 636
;636:		  trap_R_SetColor(color);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 637
;637:	    CG_DrawPic( rect->x, rect->y, rect->w, rect->h, cgs.media.blueCubeIcon );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 cgs+148772+32
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 638
;638:		  trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 639
;639:		}
line 640
;640:		return;
ADDRGP4 $486
JUMPV
LABELV $487
line 642
;641:	}
;642:  if (shader) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $497
line 643
;643:		CG_DrawPic( rect->x, rect->y, rect->w, rect->h, shader );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 644
;644:  } else {
ADDRGP4 $498
JUMPV
LABELV $497
line 645
;645:	  gitem_t *item = BG_FindItemForPowerup( PW_BLUEFLAG );
CNSTI4 8
ARGI4
ADDRLP4 4
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 646
;646:    if (item) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $499
line 647
;647:		  vec4_t color = {0, 0, 1, 1};
ADDRLP4 8
ADDRGP4 $501
INDIRB
ASGNB 16
line 648
;648:		  trap_R_SetColor(color);
ADDRLP4 8
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 649
;649:	    if( cgs.blueflag >= 0 && cgs.blueflag <= 2 ) {
ADDRGP4 cgs+34836
INDIRI4
CNSTI4 0
LTI4 $502
ADDRGP4 cgs+34836
INDIRI4
CNSTI4 2
GTI4 $502
line 650
;650:		    CG_DrawPic( rect->x, rect->y, rect->w, rect->h, cgs.media.flagShaders[cgs.blueflag] );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 cgs+34836
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+148772+1208
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 651
;651:			} else {
ADDRGP4 $503
JUMPV
LABELV $502
line 652
;652:		    CG_DrawPic( rect->x, rect->y, rect->w, rect->h, cgs.media.flagShaders[0] );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 cgs+148772+1208
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 653
;653:			}
LABELV $503
line 654
;654:		  trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 655
;655:	  }
LABELV $499
line 656
;656:  }
LABELV $498
line 657
;657:}
LABELV $486
endproc CG_DrawBlueFlagStatus 28 20
proc CG_DrawBlueFlagHead 28 24
line 659
;658:
;659:static void CG_DrawBlueFlagHead(rectDef_t *rect) {
line 661
;660:  int i;
;661:  for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $515
JUMPV
LABELV $512
line 662
;662:	  if ( cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_RED  && cgs.clientinfo[i].powerups & ( 1<< PW_BLUEFLAG )) {
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
INDIRI4
CNSTI4 0
EQI4 $517
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $517
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+108
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $517
line 664
;663:      vec3_t angles;
;664:      VectorClear( angles );
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 8+4
CNSTF4 0
ASGNF4
ADDRLP4 8+8
CNSTF4 0
ASGNF4
line 665
;665: 		  angles[YAW] = 180 + 20 * sin( cg.time / 650.0 );;
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
CNSTF4 986293812
MULF4
ARGF4
ADDRLP4 20
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 20
INDIRF4
CNSTF4 1101004800
MULF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 666
;666:      CG_DrawHead( rect->x, rect->y, rect->w, rect->h, 0,angles );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 CG_DrawHead
CALLV
pop
line 667
;667:      return;
ADDRGP4 $511
JUMPV
LABELV $517
line 669
;668:    }
;669:  }
LABELV $513
line 661
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $515
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+31504
INDIRI4
LTI4 $512
line 670
;670:}
LABELV $511
endproc CG_DrawBlueFlagHead 28 24
proc CG_DrawRedFlagName 12 32
line 672
;671:
;672:static void CG_DrawRedFlagName(rectDef_t *rect, float scale, vec4_t color, int textStyle ) {
line 674
;673:  int i;
;674:  for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $532
JUMPV
LABELV $529
line 675
;675:	  if ( cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_BLUE  && cgs.clientinfo[i].powerups & ( 1<< PW_REDFLAG )) {
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
INDIRI4
CNSTI4 0
EQI4 $534
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+36
ADDP4
INDIRI4
CNSTI4 2
NEI4 $534
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+108
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $534
line 676
;676:      CG_Text_Paint(rect->x, rect->y + rect->h, scale, color, cgs.clientinfo[i].name, 0, 0, textStyle);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+4
ADDP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 677
;677:      return;
ADDRGP4 $528
JUMPV
LABELV $534
line 679
;678:    }
;679:  }
LABELV $530
line 674
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $532
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+31504
INDIRI4
LTI4 $529
line 680
;680:}
LABELV $528
endproc CG_DrawRedFlagName 12 32
data
align 4
LABELV $551
byte 4 1065353216
byte 4 0
byte 4 0
byte 4 1065353216
align 4
LABELV $558
byte 4 1065353216
byte 4 0
byte 4 0
byte 4 1065353216
code
proc CG_DrawRedFlagStatus 28 20
line 682
;681:
;682:static void CG_DrawRedFlagStatus(rectDef_t *rect, qhandle_t shader) {
line 683
;683:	if (cgs.gametype != GT_CTF && cgs.gametype != GT_1FCTF) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 4
EQI4 $544
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 5
EQI4 $544
line 684
;684:		if (cgs.gametype == GT_HARVESTER) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 7
NEI4 $543
line 685
;685:		  vec4_t color = {1, 0, 0, 1};
ADDRLP4 0
ADDRGP4 $551
INDIRB
ASGNB 16
line 686
;686:		  trap_R_SetColor(color);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 687
;687:	    CG_DrawPic( rect->x, rect->y, rect->w, rect->h, cgs.media.redCubeIcon );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 cgs+148772+28
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 688
;688:		  trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 689
;689:		}
line 690
;690:		return;
ADDRGP4 $543
JUMPV
LABELV $544
line 692
;691:	}
;692:  if (shader) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $554
line 693
;693:		CG_DrawPic( rect->x, rect->y, rect->w, rect->h, shader );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 694
;694:  } else {
ADDRGP4 $555
JUMPV
LABELV $554
line 695
;695:	  gitem_t *item = BG_FindItemForPowerup( PW_REDFLAG );
CNSTI4 7
ARGI4
ADDRLP4 4
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 696
;696:    if (item) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $556
line 697
;697:		  vec4_t color = {1, 0, 0, 1};
ADDRLP4 8
ADDRGP4 $558
INDIRB
ASGNB 16
line 698
;698:		  trap_R_SetColor(color);
ADDRLP4 8
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 699
;699:	    if( cgs.redflag >= 0 && cgs.redflag <= 2) {
ADDRGP4 cgs+34832
INDIRI4
CNSTI4 0
LTI4 $559
ADDRGP4 cgs+34832
INDIRI4
CNSTI4 2
GTI4 $559
line 700
;700:		    CG_DrawPic( rect->x, rect->y, rect->w, rect->h, cgs.media.flagShaders[cgs.redflag] );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 cgs+34832
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+148772+1208
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 701
;701:			} else {
ADDRGP4 $560
JUMPV
LABELV $559
line 702
;702:		    CG_DrawPic( rect->x, rect->y, rect->w, rect->h, cgs.media.flagShaders[0] );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 cgs+148772+1208
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 703
;703:			}
LABELV $560
line 704
;704:		  trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 705
;705:	  }
LABELV $556
line 706
;706:  }
LABELV $555
line 707
;707:}
LABELV $543
endproc CG_DrawRedFlagStatus 28 20
proc CG_DrawRedFlagHead 28 24
line 709
;708:
;709:static void CG_DrawRedFlagHead(rectDef_t *rect) {
line 711
;710:  int i;
;711:  for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $572
JUMPV
LABELV $569
line 712
;712:	  if ( cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_BLUE  && cgs.clientinfo[i].powerups & ( 1<< PW_REDFLAG )) {
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
INDIRI4
CNSTI4 0
EQI4 $574
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+36
ADDP4
INDIRI4
CNSTI4 2
NEI4 $574
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+108
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $574
line 714
;713:      vec3_t angles;
;714:      VectorClear( angles );
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 8+4
CNSTF4 0
ASGNF4
ADDRLP4 8+8
CNSTF4 0
ASGNF4
line 715
;715: 		  angles[YAW] = 180 + 20 * sin( cg.time / 650.0 );;
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
CNSTF4 986293812
MULF4
ARGF4
ADDRLP4 20
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 20
INDIRF4
CNSTF4 1101004800
MULF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 716
;716:      CG_DrawHead( rect->x, rect->y, rect->w, rect->h, 0,angles );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 CG_DrawHead
CALLV
pop
line 717
;717:      return;
ADDRGP4 $568
JUMPV
LABELV $574
line 719
;718:    }
;719:  }
LABELV $570
line 711
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $572
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+31504
INDIRI4
LTI4 $569
line 720
;720:}
LABELV $568
endproc CG_DrawRedFlagHead 28 24
proc CG_HarvesterSkulls 60 32
line 722
;721:
;722:static void CG_HarvesterSkulls(rectDef_t *rect, float scale, vec4_t color, qboolean force2D, int textStyle ) {
line 726
;723:	char num[16];
;724:	vec3_t origin, angles;
;725:	qhandle_t handle;
;726:	int value = cg.snap->ps.generic1;
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
ASGNI4
line 728
;727:
;728:	if (cgs.gametype != GT_HARVESTER) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 7
EQI4 $587
line 729
;729:		return;
ADDRGP4 $585
JUMPV
LABELV $587
line 732
;730:	}
;731:
;732:	if( value > 99 ) {
ADDRLP4 0
INDIRI4
CNSTI4 99
LEI4 $590
line 733
;733:		value = 99;
ADDRLP4 0
CNSTI4 99
ASGNI4
line 734
;734:	}
LABELV $590
line 736
;735:
;736:	Com_sprintf (num, sizeof(num), "%i", value);
ADDRLP4 4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $205
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 737
;737:	value = CG_Text_Width(num, scale, 0);
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 48
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 48
INDIRI4
ASGNI4
line 738
;738:	CG_Text_Paint(rect->x + (rect->w - value), rect->y + rect->h, scale, color, num, 0, 0, textStyle);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
SUBF4
ADDF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 740
;739:
;740:	if (cg_drawIcons.integer) {
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $592
line 741
;741:		if (!force2D && cg_draw3dIcons.integer) {
ADDRFP4 12
INDIRI4
CNSTI4 0
NEI4 $595
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
EQI4 $595
line 742
;742:			VectorClear(angles);
ADDRLP4 20
CNSTF4 0
ASGNF4
ADDRLP4 20+4
CNSTF4 0
ASGNF4
ADDRLP4 20+8
CNSTF4 0
ASGNF4
line 743
;743:			origin[0] = 90;
ADDRLP4 32
CNSTF4 1119092736
ASGNF4
line 744
;744:			origin[1] = 0;
ADDRLP4 32+4
CNSTF4 0
ASGNF4
line 745
;745:			origin[2] = -10;
ADDRLP4 32+8
CNSTF4 3240099840
ASGNF4
line 746
;746:			angles[YAW] = ( cg.time & 2047 ) * 360 / 2048.0;
ADDRLP4 20+4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 2047
BANDI4
CNSTI4 360
MULI4
CVIF4 4
CNSTF4 973078528
MULF4
ASGNF4
line 747
;747:			if( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $604
line 748
;748:				handle = cgs.media.redCubeModel;
ADDRLP4 44
ADDRGP4 cgs+148772+20
INDIRI4
ASGNI4
line 749
;749:			} else {
ADDRGP4 $605
JUMPV
LABELV $604
line 750
;750:				handle = cgs.media.blueCubeModel;
ADDRLP4 44
ADDRGP4 cgs+148772+24
INDIRI4
ASGNI4
line 751
;751:			}
LABELV $605
line 752
;752:			CG_Draw3DModel( rect->x, rect->y, 35, 35, handle, 0, origin, angles );
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
CNSTF4 1108082688
ARGF4
CNSTF4 1108082688
ARGF4
ADDRLP4 44
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 32
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 753
;753:		} else {
ADDRGP4 $596
JUMPV
LABELV $595
line 754
;754:			if( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $611
line 755
;755:				handle = cgs.media.redCubeIcon;
ADDRLP4 44
ADDRGP4 cgs+148772+28
INDIRI4
ASGNI4
line 756
;756:			} else {
ADDRGP4 $612
JUMPV
LABELV $611
line 757
;757:				handle = cgs.media.blueCubeIcon;
ADDRLP4 44
ADDRGP4 cgs+148772+32
INDIRI4
ASGNI4
line 758
;758:			}
LABELV $612
line 759
;759:			CG_DrawPic( rect->x + 3, rect->y + 16, 20, 20, handle );
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
INDIRF4
CNSTF4 1077936128
ADDF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
ARGF4
CNSTF4 1101004800
ARGF4
CNSTF4 1101004800
ARGF4
ADDRLP4 44
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 760
;760:		}
LABELV $596
line 761
;761:	}
LABELV $592
line 762
;762:}
LABELV $585
endproc CG_HarvesterSkulls 60 32
data
align 4
LABELV $628
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
code
proc CG_OneFlagStatus 32 20
line 764
;763:
;764:static void CG_OneFlagStatus(rectDef_t *rect) {
line 765
;765:	if (cgs.gametype != GT_1FCTF) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 5
EQI4 $619
line 766
;766:		return;
ADDRGP4 $618
JUMPV
LABELV $619
line 767
;767:	} else {
line 768
;768:		gitem_t *item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
CNSTI4 9
ARGI4
ADDRLP4 4
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 769
;769:		if (item) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $622
line 770
;770:			if( cgs.flagStatus >= 0 && cgs.flagStatus <= 4 ) {
ADDRGP4 cgs+34840
INDIRI4
CNSTI4 0
LTI4 $624
ADDRGP4 cgs+34840
INDIRI4
CNSTI4 4
GTI4 $624
line 771
;771:				vec4_t color = {1, 1, 1, 1};
ADDRLP4 8
ADDRGP4 $628
INDIRB
ASGNB 16
line 772
;772:				int index = 0;
ADDRLP4 24
CNSTI4 0
ASGNI4
line 773
;773:				if (cgs.flagStatus == FLAG_TAKEN_RED) {
ADDRGP4 cgs+34840
INDIRI4
CNSTI4 2
NEI4 $629
line 774
;774:					color[1] = color[2] = 0;
ADDRLP4 28
CNSTF4 0
ASGNF4
ADDRLP4 8+8
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 28
INDIRF4
ASGNF4
line 775
;775:					index = 1;
ADDRLP4 24
CNSTI4 1
ASGNI4
line 776
;776:				} else if (cgs.flagStatus == FLAG_TAKEN_BLUE) {
ADDRGP4 $630
JUMPV
LABELV $629
ADDRGP4 cgs+34840
INDIRI4
CNSTI4 3
NEI4 $634
line 777
;777:					color[0] = color[1] = 0;
ADDRLP4 28
CNSTF4 0
ASGNF4
ADDRLP4 8+4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 8
ADDRLP4 28
INDIRF4
ASGNF4
line 778
;778:					index = 1;
ADDRLP4 24
CNSTI4 1
ASGNI4
line 779
;779:				} else if (cgs.flagStatus == FLAG_DROPPED) {
ADDRGP4 $635
JUMPV
LABELV $634
ADDRGP4 cgs+34840
INDIRI4
CNSTI4 4
NEI4 $638
line 780
;780:					index = 2;
ADDRLP4 24
CNSTI4 2
ASGNI4
line 781
;781:				}
LABELV $638
LABELV $635
LABELV $630
line 782
;782:			  trap_R_SetColor(color);
ADDRLP4 8
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 783
;783:				CG_DrawPic( rect->x, rect->y, rect->w, rect->h, cgs.media.flagShaders[index] );
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+148772+1208
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 784
;784:			}
LABELV $624
line 785
;785:		}
LABELV $622
line 786
;786:	}
line 787
;787:}
LABELV $618
endproc CG_OneFlagStatus 32 20
proc CG_DrawCTFPowerUp 8 20
line 790
;788:
;789:
;790:static void CG_DrawCTFPowerUp(rectDef_t *rect) {
line 793
;791:	int		value;
;792:
;793:	if (cgs.gametype < GT_CTF) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 4
GEI4 $644
line 794
;794:		return;
ADDRGP4 $643
JUMPV
LABELV $644
line 796
;795:	}
;796:	value = cg.snap->ps.stats[STAT_PERSISTANT_POWERUP];
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ASGNI4
line 797
;797:	if ( value ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $648
line 798
;798:		CG_RegisterItemVisuals( value );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 799
;799:		CG_DrawPic( rect->x, rect->y, rect->w, rect->h, cg_items[ value ].icon );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 28
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 800
;800:	}
LABELV $648
line 801
;801:}
LABELV $643
endproc CG_DrawCTFPowerUp 8 20
proc CG_DrawTeamColor 4 24
line 805
;802:
;803:
;804:
;805:static void CG_DrawTeamColor(rectDef_t *rect, vec4_t color) {
line 806
;806:	CG_DrawTeamBackground(rect->x, rect->y, rect->w, rect->h, color[3], cg.snap->ps.persistant[PERS_TEAM]);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawTeamBackground
CALLV
pop
line 807
;807:}
LABELV $651
endproc CG_DrawTeamColor 4 24
proc CG_DrawAreaPowerUp 228 32
line 809
;808:
;809:static void CG_DrawAreaPowerUp(rectDef_t *rect, int align, float special, float scale, vec4_t color) {
line 821
;810:	char num[16];
;811:	int		sorted[MAX_POWERUPS];
;812:	int		sortedTime[MAX_POWERUPS];
;813:	int		i, j, k;
;814:	int		active;
;815:	playerState_t	*ps;
;816:	int		t;
;817:	gitem_t	*item;
;818:	float	f;
;819:	rectDef_t r2;
;820:	float *inc;
;821:	r2.x = rect->x;
ADDRLP4 148
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 822
;822:	r2.y = rect->y;
ADDRLP4 148+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 823
;823:	r2.w = rect->w;
ADDRLP4 148+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 824
;824:	r2.h = rect->h;
ADDRLP4 148+12
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 826
;825:
;826:	inc = (align == HUD_VERTICAL) ? &r2.y : &r2.x;
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $659
ADDRLP4 196
ADDRLP4 148+4
ASGNP4
ADDRGP4 $660
JUMPV
LABELV $659
ADDRLP4 196
ADDRLP4 148
ASGNP4
LABELV $660
ADDRLP4 192
ADDRLP4 196
INDIRP4
ASGNP4
line 828
;827:
;828:	ps = &cg.snap->ps;
ADDRLP4 164
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 830
;829:
;830:	if ( ps->stats[STAT_HEALTH] <= 0 ) {
ADDRLP4 164
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $662
line 831
;831:		return;
ADDRGP4 $653
JUMPV
LABELV $662
line 835
;832:	}
;833:
;834:	// sort the list by time remaining
;835:	active = 0;
ADDRLP4 136
CNSTI4 0
ASGNI4
line 836
;836:	for ( i = 0 ; i < MAX_POWERUPS ; i++ ) {
ADDRLP4 144
CNSTI4 0
ASGNI4
LABELV $664
line 837
;837:		if ( !ps->powerups[ i ] ) {
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 164
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $668
line 838
;838:			continue;
ADDRGP4 $665
JUMPV
LABELV $668
line 840
;839:		}
;840:		t = ps->powerups[ i ] - cg.time;
ADDRLP4 140
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 164
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
ASGNI4
line 843
;841:		// ZOID--don't draw if the power up has unlimited time (999 seconds)
;842:		// This is true of the CTF flags
;843:		if ( t <= 0 || t >= 999000) {
ADDRLP4 140
INDIRI4
CNSTI4 0
LEI4 $673
ADDRLP4 140
INDIRI4
CNSTI4 999000
LTI4 $671
LABELV $673
line 844
;844:			continue;
ADDRGP4 $665
JUMPV
LABELV $671
line 848
;845:		}
;846:
;847:		// insert into the list
;848:		for ( j = 0 ; j < active ; j++ ) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $677
JUMPV
LABELV $674
line 849
;849:			if ( sortedTime[j] >= t ) {
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ADDRLP4 140
INDIRI4
LTI4 $678
line 850
;850:				for ( k = active - 1 ; k >= j ; k-- ) {
ADDRLP4 0
ADDRLP4 136
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $683
JUMPV
LABELV $680
line 851
;851:					sorted[k+1] = sorted[k];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68+4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
INDIRI4
ASGNI4
line 852
;852:					sortedTime[k+1] = sortedTime[k];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ASGNI4
line 853
;853:				}
LABELV $681
line 850
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $683
ADDRLP4 0
INDIRI4
ADDRLP4 132
INDIRI4
GEI4 $680
line 854
;854:				break;
ADDRGP4 $676
JUMPV
LABELV $678
line 856
;855:			}
;856:		}
LABELV $675
line 848
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $677
ADDRLP4 132
INDIRI4
ADDRLP4 136
INDIRI4
LTI4 $674
LABELV $676
line 857
;857:		sorted[j] = i;
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
ADDRLP4 144
INDIRI4
ASGNI4
line 858
;858:		sortedTime[j] = t;
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 140
INDIRI4
ASGNI4
line 859
;859:		active++;
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 860
;860:	}
LABELV $665
line 836
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 16
LTI4 $664
line 863
;861:
;862:	// draw the icons and timers
;863:	for ( i = 0 ; i < active ; i++ ) {
ADDRLP4 144
CNSTI4 0
ASGNI4
ADDRGP4 $689
JUMPV
LABELV $686
line 864
;864:		item = BG_FindItemForPowerup( sorted[i] );
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
INDIRI4
ARGI4
ADDRLP4 200
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 168
ADDRLP4 200
INDIRP4
ASGNP4
line 866
;865:
;866:		if (item) {
ADDRLP4 168
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $690
line 867
;867:			t = ps->powerups[ sorted[i] ];
ADDRLP4 140
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 164
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ASGNI4
line 868
;868:			if ( t - cg.time >= POWERUP_BLINKS * POWERUP_BLINK_TIME ) {
ADDRLP4 140
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CNSTI4 5000
LTI4 $692
line 869
;869:				trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 870
;870:			} else {
ADDRGP4 $693
JUMPV
LABELV $692
line 873
;871:				vec4_t	modulate;
;872:
;873:				f = (float)( t - cg.time ) / POWERUP_BLINK_TIME;
ADDRLP4 188
ADDRLP4 140
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CVIF4 4
CNSTF4 981668463
MULF4
ASGNF4
line 874
;874:				f -= (int)f;
ADDRLP4 188
ADDRLP4 188
INDIRF4
ADDRLP4 188
INDIRF4
CVFI4 4
CVIF4 4
SUBF4
ASGNF4
line 875
;875:				modulate[0] = modulate[1] = modulate[2] = modulate[3] = f;
ADDRLP4 204+12
ADDRLP4 188
INDIRF4
ASGNF4
ADDRLP4 204+8
ADDRLP4 188
INDIRF4
ASGNF4
ADDRLP4 204+4
ADDRLP4 188
INDIRF4
ASGNF4
ADDRLP4 204
ADDRLP4 188
INDIRF4
ASGNF4
line 876
;876:				trap_R_SetColor( modulate );
ADDRLP4 204
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 877
;877:			}
LABELV $693
line 879
;878:
;879:			CG_DrawPic( r2.x, r2.y, r2.w * .75, r2.h, trap_R_RegisterShader( item->icon ) );
ADDRLP4 168
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 204
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 148
INDIRF4
ARGF4
ADDRLP4 148+4
INDIRF4
ARGF4
ADDRLP4 148+8
INDIRF4
CNSTF4 1061158912
MULF4
ARGF4
ADDRLP4 148+12
INDIRF4
ARGF4
ADDRLP4 204
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 881
;880:
;881:			Com_sprintf (num, sizeof(num), "%i", sortedTime[i] / 1000);
ADDRLP4 172
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $205
ARGP4
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
CNSTI4 1000
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 882
;882:			CG_Text_Paint(r2.x + (r2.w * .75) + 3 , r2.y + r2.h, scale, color, num, 0, 0, 0);
ADDRLP4 148
INDIRF4
ADDRLP4 148+8
INDIRF4
CNSTF4 1061158912
MULF4
ADDF4
CNSTF4 1077936128
ADDF4
ARGF4
ADDRLP4 148+4
INDIRF4
ADDRLP4 148+12
INDIRF4
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 172
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 883
;883:			*inc += r2.w + special;
ADDRLP4 192
INDIRP4
ADDRLP4 192
INDIRP4
INDIRF4
ADDRLP4 148+8
INDIRF4
ADDRFP4 8
INDIRF4
ADDF4
ADDF4
ASGNF4
line 884
;884:		}
LABELV $690
line 886
;885:
;886:	}
LABELV $687
line 863
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $689
ADDRLP4 144
INDIRI4
ADDRLP4 136
INDIRI4
LTI4 $686
line 887
;887:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 889
;888:
;889:}
LABELV $653
endproc CG_DrawAreaPowerUp 228 32
export CG_GetValue
proc CG_GetValue 36 0
line 891
;890:
;891:float CG_GetValue(int ownerDraw) {
line 896
;892:	centity_t	*cent;
;893: 	clientInfo_t *ci;
;894:	playerState_t	*ps;
;895:
;896:  cent = &cg_entities[cg.snap->ps.clientNum];
ADDRLP4 4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 897
;897:	ps = &cg.snap->ps;
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 899
;898:
;899:  switch (ownerDraw) {
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 20
EQI4 $719
ADDRLP4 12
INDIRI4
CNSTI4 20
GTI4 $727
LABELV $726
ADDRLP4 16
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 2
EQI4 $715
ADDRLP4 16
INDIRI4
CNSTI4 4
EQI4 $721
ADDRLP4 16
INDIRI4
CNSTI4 6
EQI4 $716
ADDRGP4 $710
JUMPV
LABELV $727
ADDRLP4 20
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 27
EQI4 $724
ADDRLP4 20
INDIRI4
CNSTI4 28
EQI4 $722
ADDRLP4 20
INDIRI4
CNSTI4 27
LTI4 $710
LABELV $728
ADDRLP4 24
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 40
EQI4 $711
ADDRLP4 24
INDIRI4
CNSTI4 41
EQI4 $713
ADDRGP4 $710
JUMPV
LABELV $711
line 901
;900:  case CG_SELECTEDPLAYER_ARMOR:
;901:    ci = cgs.clientinfo + sortedTeamPlayers[CG_GetSelectedPlayer()];
ADDRLP4 28
ADDRGP4 CG_GetSelectedPlayer
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 902
;902:    return ci->armor;
ADDRLP4 8
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CVIF4 4
RETF4
ADDRGP4 $706
JUMPV
line 903
;903:    break;
LABELV $713
line 905
;904:  case CG_SELECTEDPLAYER_HEALTH:
;905:    ci = cgs.clientinfo + sortedTeamPlayers[CG_GetSelectedPlayer()];
ADDRLP4 32
ADDRGP4 CG_GetSelectedPlayer
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 32
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 906
;906:    return ci->health;
ADDRLP4 8
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CVIF4 4
RETF4
ADDRGP4 $706
JUMPV
line 907
;907:    break;
LABELV $715
line 909
;908:  case CG_PLAYER_ARMOR_VALUE:
;909:		return ps->stats[STAT_ARMOR];
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CVIF4 4
RETF4
ADDRGP4 $706
JUMPV
line 910
;910:    break;
LABELV $716
line 912
;911:  case CG_PLAYER_AMMO_VALUE:
;912:		if ( cent->currentState.weapon ) {
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 0
EQI4 $710
line 913
;913:		  return ps->ammo[cent->currentState.weapon];
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CVIF4 4
RETF4
ADDRGP4 $706
JUMPV
line 915
;914:		}
;915:    break;
LABELV $719
line 917
;916:  case CG_PLAYER_SCORE:
;917:	  return cg.snap->ps.persistant[PERS_SCORE];
ADDRGP4 cg+36
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
CVIF4 4
RETF4
ADDRGP4 $706
JUMPV
line 918
;918:    break;
LABELV $721
line 920
;919:  case CG_PLAYER_HEALTH:
;920:		return ps->stats[STAT_HEALTH];
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CVIF4 4
RETF4
ADDRGP4 $706
JUMPV
line 921
;921:    break;
LABELV $722
line 923
;922:  case CG_RED_SCORE:
;923:		return cgs.scores1;
ADDRGP4 cgs+34824
INDIRI4
CVIF4 4
RETF4
ADDRGP4 $706
JUMPV
line 924
;924:    break;
LABELV $724
line 926
;925:  case CG_BLUE_SCORE:
;926:		return cgs.scores2;
ADDRGP4 cgs+34828
INDIRI4
CVIF4 4
RETF4
ADDRGP4 $706
JUMPV
line 927
;927:    break;
line 929
;928:  default:
;929:    break;
LABELV $710
line 931
;930:  }
;931:	return -1;
CNSTF4 3212836864
RETF4
LABELV $706
endproc CG_GetValue 36 0
export CG_OtherTeamHasFlag
proc CG_OtherTeamHasFlag 4 0
line 934
;932:}
;933:
;934:qboolean CG_OtherTeamHasFlag() {
line 935
;935:	if (cgs.gametype == GT_CTF || cgs.gametype == GT_1FCTF) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 4
EQI4 $734
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 5
NEI4 $730
LABELV $734
line 936
;936:		int team = cg.snap->ps.persistant[PERS_TEAM];
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ASGNI4
line 937
;937:		if (cgs.gametype == GT_1FCTF) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 5
NEI4 $736
line 938
;938:			if (team == TEAM_RED && cgs.flagStatus == FLAG_TAKEN_BLUE) {
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $739
ADDRGP4 cgs+34840
INDIRI4
CNSTI4 3
NEI4 $739
line 939
;939:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $729
JUMPV
LABELV $739
line 940
;940:			} else if (team == TEAM_BLUE && cgs.flagStatus == FLAG_TAKEN_RED) {
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $742
ADDRGP4 cgs+34840
INDIRI4
CNSTI4 2
NEI4 $742
line 941
;941:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $729
JUMPV
LABELV $742
line 942
;942:			} else {
line 943
;943:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $729
JUMPV
LABELV $736
line 945
;944:			}
;945:		} else {
line 946
;946:			if (team == TEAM_RED && cgs.redflag == FLAG_TAKEN) {
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $745
ADDRGP4 cgs+34832
INDIRI4
CNSTI4 1
NEI4 $745
line 947
;947:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $729
JUMPV
LABELV $745
line 948
;948:			} else if (team == TEAM_BLUE && cgs.blueflag == FLAG_TAKEN) {
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $748
ADDRGP4 cgs+34836
INDIRI4
CNSTI4 1
NEI4 $748
line 949
;949:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $729
JUMPV
LABELV $748
line 950
;950:			} else {
line 951
;951:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $729
JUMPV
LABELV $730
line 955
;952:			}
;953:		}
;954:	}
;955:	return qfalse;
CNSTI4 0
RETI4
LABELV $729
endproc CG_OtherTeamHasFlag 4 0
export CG_YourTeamHasFlag
proc CG_YourTeamHasFlag 4 0
line 958
;956:}
;957:
;958:qboolean CG_YourTeamHasFlag() {
line 959
;959:	if (cgs.gametype == GT_CTF || cgs.gametype == GT_1FCTF) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 4
EQI4 $756
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 5
NEI4 $752
LABELV $756
line 960
;960:		int team = cg.snap->ps.persistant[PERS_TEAM];
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ASGNI4
line 961
;961:		if (cgs.gametype == GT_1FCTF) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 5
NEI4 $758
line 962
;962:			if (team == TEAM_RED && cgs.flagStatus == FLAG_TAKEN_RED) {
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $761
ADDRGP4 cgs+34840
INDIRI4
CNSTI4 2
NEI4 $761
line 963
;963:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $751
JUMPV
LABELV $761
line 964
;964:			} else if (team == TEAM_BLUE && cgs.flagStatus == FLAG_TAKEN_BLUE) {
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $764
ADDRGP4 cgs+34840
INDIRI4
CNSTI4 3
NEI4 $764
line 965
;965:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $751
JUMPV
LABELV $764
line 966
;966:			} else {
line 967
;967:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $751
JUMPV
LABELV $758
line 969
;968:			}
;969:		} else {
line 970
;970:			if (team == TEAM_RED && cgs.blueflag == FLAG_TAKEN) {
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $767
ADDRGP4 cgs+34836
INDIRI4
CNSTI4 1
NEI4 $767
line 971
;971:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $751
JUMPV
LABELV $767
line 972
;972:			} else if (team == TEAM_BLUE && cgs.redflag == FLAG_TAKEN) {
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $770
ADDRGP4 cgs+34832
INDIRI4
CNSTI4 1
NEI4 $770
line 973
;973:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $751
JUMPV
LABELV $770
line 974
;974:			} else {
line 975
;975:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $751
JUMPV
LABELV $752
line 979
;976:			}
;977:		}
;978:	}
;979:	return qfalse;
CNSTI4 0
RETI4
LABELV $751
endproc CG_YourTeamHasFlag 4 0
export CG_OwnerDrawVisible
proc CG_OwnerDrawVisible 4 0
line 984
;980:}
;981:
;982:// THINKABOUTME: should these be exclusive or inclusive.. 
;983:// 
;984:qboolean CG_OwnerDrawVisible(int flags) {
line 986
;985:
;986:	if (flags & CG_SHOW_TEAMINFO) {
ADDRFP4 0
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $774
line 987
;987:		return (cg_currentSelectedPlayer.integer == numSortedTeamPlayers);
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
ADDRGP4 numSortedTeamPlayers
INDIRI4
NEI4 $778
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $779
JUMPV
LABELV $778
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $779
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $773
JUMPV
LABELV $774
line 990
;988:	}
;989:
;990:	if (flags & CG_SHOW_NOTEAMINFO) {
ADDRFP4 0
INDIRI4
CNSTI4 65536
BANDI4
CNSTI4 0
EQI4 $780
line 991
;991:		return !(cg_currentSelectedPlayer.integer == numSortedTeamPlayers);
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
ADDRGP4 numSortedTeamPlayers
INDIRI4
EQI4 $784
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $785
JUMPV
LABELV $784
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $785
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $773
JUMPV
LABELV $780
line 994
;992:	}
;993:
;994:	if (flags & CG_SHOW_OTHERTEAMHASFLAG) {
ADDRFP4 0
INDIRI4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $786
line 995
;995:		return CG_OtherTeamHasFlag();
ADDRLP4 0
ADDRGP4 CG_OtherTeamHasFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $773
JUMPV
LABELV $786
line 998
;996:	}
;997:
;998:	if (flags & CG_SHOW_YOURTEAMHASENEMYFLAG) {
ADDRFP4 0
INDIRI4
CNSTI4 262144
BANDI4
CNSTI4 0
EQI4 $788
line 999
;999:		return CG_YourTeamHasFlag();
ADDRLP4 0
ADDRGP4 CG_YourTeamHasFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $773
JUMPV
LABELV $788
line 1002
;1000:	}
;1001:
;1002:	if (flags & (CG_SHOW_BLUE_TEAM_HAS_REDFLAG | CG_SHOW_RED_TEAM_HAS_BLUEFLAG)) {
ADDRFP4 0
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $790
line 1003
;1003:		if (flags & CG_SHOW_BLUE_TEAM_HAS_REDFLAG && (cgs.redflag == FLAG_TAKEN || cgs.flagStatus == FLAG_TAKEN_RED)) {
ADDRFP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $792
ADDRGP4 cgs+34832
INDIRI4
CNSTI4 1
EQI4 $796
ADDRGP4 cgs+34840
INDIRI4
CNSTI4 2
NEI4 $792
LABELV $796
line 1004
;1004:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $773
JUMPV
LABELV $792
line 1005
;1005:		} else if (flags & CG_SHOW_RED_TEAM_HAS_BLUEFLAG && (cgs.blueflag == FLAG_TAKEN || cgs.flagStatus == FLAG_TAKEN_BLUE)) {
ADDRFP4 0
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $797
ADDRGP4 cgs+34836
INDIRI4
CNSTI4 1
EQI4 $801
ADDRGP4 cgs+34840
INDIRI4
CNSTI4 3
NEI4 $797
LABELV $801
line 1006
;1006:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $773
JUMPV
LABELV $797
line 1008
;1007:		}
;1008:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $773
JUMPV
LABELV $790
line 1011
;1009:	}
;1010:
;1011:	if (flags & CG_SHOW_ANYTEAMGAME) {
ADDRFP4 0
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $802
line 1012
;1012:		if( cgs.gametype >= GT_TEAM) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $804
line 1013
;1013:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $773
JUMPV
LABELV $804
line 1015
;1014:		}
;1015:	}
LABELV $802
line 1017
;1016:
;1017:	if (flags & CG_SHOW_ANYNONTEAMGAME) {
ADDRFP4 0
INDIRI4
CNSTI4 524288
BANDI4
CNSTI4 0
EQI4 $807
line 1018
;1018:		if( cgs.gametype < GT_TEAM) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
GEI4 $809
line 1019
;1019:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $773
JUMPV
LABELV $809
line 1021
;1020:		}
;1021:	}
LABELV $807
line 1023
;1022:
;1023:	if (flags & CG_SHOW_HARVESTER) {
ADDRFP4 0
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $812
line 1024
;1024:		if( cgs.gametype == GT_HARVESTER ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 7
NEI4 $814
line 1025
;1025:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $773
JUMPV
LABELV $814
line 1026
;1026:    } else {
line 1027
;1027:      return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $773
JUMPV
LABELV $812
line 1031
;1028:    }
;1029:	}
;1030:
;1031:	if (flags & CG_SHOW_ONEFLAG) {
ADDRFP4 0
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $817
line 1032
;1032:		if( cgs.gametype == GT_1FCTF ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 5
NEI4 $819
line 1033
;1033:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $773
JUMPV
LABELV $819
line 1034
;1034:    } else {
line 1035
;1035:      return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $773
JUMPV
LABELV $817
line 1039
;1036:    }
;1037:	}
;1038:
;1039:	if (flags & CG_SHOW_CTF) {
ADDRFP4 0
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $822
line 1040
;1040:		if( cgs.gametype == GT_CTF ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 4
NEI4 $824
line 1041
;1041:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $773
JUMPV
LABELV $824
line 1043
;1042:		}
;1043:	}
LABELV $822
line 1045
;1044:
;1045:	if (flags & CG_SHOW_OBELISK) {
ADDRFP4 0
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $827
line 1046
;1046:		if( cgs.gametype == GT_OBELISK ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 6
NEI4 $829
line 1047
;1047:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $773
JUMPV
LABELV $829
line 1048
;1048:    } else {
line 1049
;1049:      return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $773
JUMPV
LABELV $827
line 1053
;1050:    }
;1051:	}
;1052:
;1053:	if (flags & CG_SHOW_HEALTHCRITICAL) {
ADDRFP4 0
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $832
line 1054
;1054:		if (cg.snap->ps.stats[STAT_HEALTH] < 25) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 25
GEI4 $834
line 1055
;1055:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $773
JUMPV
LABELV $834
line 1057
;1056:		}
;1057:	}
LABELV $832
line 1059
;1058:
;1059:	if (flags & CG_SHOW_HEALTHOK) {
ADDRFP4 0
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $837
line 1060
;1060:		if (cg.snap->ps.stats[STAT_HEALTH] >= 25) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 25
LTI4 $839
line 1061
;1061:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $773
JUMPV
LABELV $839
line 1063
;1062:		}
;1063:	}
LABELV $837
line 1065
;1064:
;1065:	if (flags & CG_SHOW_SINGLEPLAYER) {
ADDRFP4 0
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $842
line 1066
;1066:		if( cgs.gametype == GT_SINGLE_PLAYER ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 2
NEI4 $844
line 1067
;1067:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $773
JUMPV
LABELV $844
line 1069
;1068:		}
;1069:	}
LABELV $842
line 1071
;1070:
;1071:	if (flags & CG_SHOW_TOURNAMENT) {
ADDRFP4 0
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $847
line 1072
;1072:		if( cgs.gametype == GT_TOURNAMENT ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 1
NEI4 $849
line 1073
;1073:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $773
JUMPV
LABELV $849
line 1075
;1074:		}
;1075:	}
LABELV $847
line 1077
;1076:
;1077:	if (flags & CG_SHOW_DURINGINCOMINGVOICE) {
ADDRFP4 0
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $852
line 1078
;1078:	}
LABELV $852
line 1080
;1079:
;1080:	if (flags & CG_SHOW_IF_PLAYER_HAS_FLAG) {
ADDRFP4 0
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $854
line 1081
;1081:		if (cg.snap->ps.powerups[PW_REDFLAG] || cg.snap->ps.powerups[PW_BLUEFLAG] || cg.snap->ps.powerups[PW_NEUTRALFLAG]) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
NEI4 $862
ADDRGP4 cg+36
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
NEI4 $862
ADDRGP4 cg+36
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
CNSTI4 0
EQI4 $856
LABELV $862
line 1082
;1082:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $773
JUMPV
LABELV $856
line 1084
;1083:		}
;1084:	}
LABELV $854
line 1085
;1085:	return qfalse;
CNSTI4 0
RETI4
LABELV $773
endproc CG_OwnerDrawVisible 4 0
proc CG_DrawPlayerHasFlag 16 24
line 1090
;1086:}
;1087:
;1088:
;1089:
;1090:static void CG_DrawPlayerHasFlag(rectDef_t *rect, qboolean force2D) {
line 1091
;1091:	int adj = (force2D) ? 0 : 2;
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $865
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $866
JUMPV
LABELV $865
ADDRLP4 4
CNSTI4 2
ASGNI4
LABELV $866
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1092
;1092:	if( cg.predictedPlayerState.powerups[PW_REDFLAG] ) {
ADDRGP4 cg+107636+312+28
INDIRI4
CNSTI4 0
EQI4 $867
line 1093
;1093:  	CG_DrawFlagModel( rect->x + adj, rect->y + adj, rect->w - adj, rect->h - adj, TEAM_RED, force2D);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 0
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ARGF4
CNSTI4 1
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 CG_DrawFlagModel
CALLV
pop
line 1094
;1094:	} else if( cg.predictedPlayerState.powerups[PW_BLUEFLAG] ) {
ADDRGP4 $868
JUMPV
LABELV $867
ADDRGP4 cg+107636+312+32
INDIRI4
CNSTI4 0
EQI4 $872
line 1095
;1095:  	CG_DrawFlagModel( rect->x + adj, rect->y + adj, rect->w - adj, rect->h - adj, TEAM_BLUE, force2D);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 0
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ARGF4
CNSTI4 2
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 CG_DrawFlagModel
CALLV
pop
line 1096
;1096:	} else if( cg.predictedPlayerState.powerups[PW_NEUTRALFLAG] ) {
ADDRGP4 $873
JUMPV
LABELV $872
ADDRGP4 cg+107636+312+36
INDIRI4
CNSTI4 0
EQI4 $877
line 1097
;1097:  	CG_DrawFlagModel( rect->x + adj, rect->y + adj, rect->w - adj, rect->h - adj, TEAM_FREE, force2D);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 0
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 CG_DrawFlagModel
CALLV
pop
line 1098
;1098:	}
LABELV $877
LABELV $873
LABELV $868
line 1099
;1099:}
LABELV $863
endproc CG_DrawPlayerHasFlag 16 24
proc CG_DrawAreaSystemChat 4 32
line 1101
;1100:
;1101:static void CG_DrawAreaSystemChat(rectDef_t *rect, float scale, vec4_t color, qhandle_t shader) {
line 1102
;1102:  CG_Text_Paint(rect->x, rect->y + rect->h, scale, color, systemChat, 0, 0, 0);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 systemChat
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 1103
;1103:}
LABELV $882
endproc CG_DrawAreaSystemChat 4 32
proc CG_DrawAreaTeamChat 4 32
line 1105
;1104:
;1105:static void CG_DrawAreaTeamChat(rectDef_t *rect, float scale, vec4_t color, qhandle_t shader) {
line 1106
;1106:  CG_Text_Paint(rect->x, rect->y + rect->h, scale, color,teamChat1, 0, 0, 0);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 teamChat1
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 1107
;1107:}
LABELV $883
endproc CG_DrawAreaTeamChat 4 32
proc CG_DrawAreaChat 4 32
line 1109
;1108:
;1109:static void CG_DrawAreaChat(rectDef_t *rect, float scale, vec4_t color, qhandle_t shader) {
line 1110
;1110:  CG_Text_Paint(rect->x, rect->y + rect->h, scale, color, teamChat2, 0, 0, 0);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 teamChat2
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 1111
;1111:}
LABELV $884
endproc CG_DrawAreaChat 4 32
export CG_GetKillerText
proc CG_GetKillerText 8 8
line 1113
;1112:
;1113:const char *CG_GetKillerText() {
line 1114
;1114:	const char *s = "";
ADDRLP4 0
ADDRGP4 $886
ASGNP4
line 1115
;1115:	if ( cg.killerName[0] ) {
ADDRGP4 cg+115368
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $887
line 1116
;1116:		s = va("Fragged by %s", cg.killerName );
ADDRGP4 $890
ARGP4
ADDRGP4 cg+115368
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1117
;1117:	}
LABELV $887
line 1118
;1118:	return s;
ADDRLP4 0
INDIRP4
RETP4
LABELV $885
endproc CG_GetKillerText 8 8
proc CG_DrawKiller 24 32
line 1122
;1119:}
;1120:
;1121:
;1122:static void CG_DrawKiller(rectDef_t *rect, float scale, vec4_t color, qhandle_t shader, int textStyle ) {
line 1124
;1123:	// fragged by ... line
;1124:	if ( cg.killerName[0] ) {
ADDRGP4 cg+115368
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $893
line 1125
;1125:		int x = rect->x + rect->w / 2;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1056964608
MULF4
ADDF4
CVFI4 4
ASGNI4
line 1126
;1126:	  CG_Text_Paint(x - CG_Text_Width(CG_GetKillerText(), scale, 0) / 2, rect->y + rect->h, scale, color, CG_GetKillerText(), 0, 0, textStyle);
ADDRLP4 8
ADDRGP4 CG_GetKillerText
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 12
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 16
ADDRGP4 CG_GetKillerText
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
CNSTI4 2
DIVI4
SUBI4
CVIF4 4
ARGF4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 1127
;1127:	}
LABELV $893
line 1129
;1128:	
;1129:}
LABELV $892
endproc CG_DrawKiller 24 32
proc CG_DrawCapFragLimit 16 32
line 1132
;1130:
;1131:
;1132:static void CG_DrawCapFragLimit(rectDef_t *rect, float scale, vec4_t color, qhandle_t shader, int textStyle) {
line 1133
;1133:	int limit = (cgs.gametype >= GT_CTF) ? cgs.capturelimit : cgs.fraglimit;
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 4
LTI4 $901
ADDRLP4 4
ADDRGP4 cgs+31496
INDIRI4
ASGNI4
ADDRGP4 $902
JUMPV
LABELV $901
ADDRLP4 4
ADDRGP4 cgs+31492
INDIRI4
ASGNI4
LABELV $902
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1134
;1134:	CG_Text_Paint(rect->x, rect->y, scale, color, va("%2i", limit),0, 0, textStyle); 
ADDRGP4 $903
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 1135
;1135:}
LABELV $896
endproc CG_DrawCapFragLimit 16 32
proc CG_Draw1stPlace 8 32
line 1137
;1136:
;1137:static void CG_Draw1stPlace(rectDef_t *rect, float scale, vec4_t color, qhandle_t shader, int textStyle) {
line 1138
;1138:	if (cgs.scores1 != SCORE_NOT_PRESENT) {
ADDRGP4 cgs+34824
INDIRI4
CNSTI4 -9999
EQI4 $905
line 1139
;1139:		CG_Text_Paint(rect->x, rect->y, scale, color, va("%2i", cgs.scores1),0, 0, textStyle); 
ADDRGP4 $903
ARGP4
ADDRGP4 cgs+34824
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 1140
;1140:	}
LABELV $905
line 1141
;1141:}
LABELV $904
endproc CG_Draw1stPlace 8 32
proc CG_Draw2ndPlace 8 32
line 1143
;1142:
;1143:static void CG_Draw2ndPlace(rectDef_t *rect, float scale, vec4_t color, qhandle_t shader, int textStyle) {
line 1144
;1144:	if (cgs.scores2 != SCORE_NOT_PRESENT) {
ADDRGP4 cgs+34828
INDIRI4
CNSTI4 -9999
EQI4 $910
line 1145
;1145:		CG_Text_Paint(rect->x, rect->y, scale, color, va("%2i", cgs.scores2),0, 0, textStyle); 
ADDRGP4 $903
ARGP4
ADDRGP4 cgs+34828
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 1146
;1146:	}
LABELV $910
line 1147
;1147:}
LABELV $909
endproc CG_Draw2ndPlace 8 32
export CG_GetGameStatusText
proc CG_GetGameStatusText 12 12
line 1149
;1148:
;1149:const char *CG_GetGameStatusText() {
line 1150
;1150:	const char *s = "";
ADDRLP4 0
ADDRGP4 $886
ASGNP4
line 1151
;1151:	if ( cgs.gametype < GT_TEAM) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
GEI4 $915
line 1152
;1152:		if (cg.snap->ps.persistant[PERS_TEAM] != TEAM_SPECTATOR ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
EQI4 $916
line 1153
;1153:			s = va("%s place with %i",CG_PlaceString( cg.snap->ps.persistant[PERS_RANK] + 1 ),cg.snap->ps.persistant[PERS_SCORE] );
ADDRGP4 cg+36
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 4
ADDRGP4 CG_PlaceString
CALLP4
ASGNP4
ADDRGP4 $921
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1154
;1154:		}
line 1155
;1155:	} else {
ADDRGP4 $916
JUMPV
LABELV $915
line 1156
;1156:		if ( cg.teamScores[0] == cg.teamScores[1] ) {
ADDRGP4 cg+110484
INDIRI4
ADDRGP4 cg+110484+4
INDIRI4
NEI4 $924
line 1157
;1157:			s = va("Teams are tied at %i", cg.teamScores[0] );
ADDRGP4 $929
ARGP4
ADDRGP4 cg+110484
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1158
;1158:		} else if ( cg.teamScores[0] >= cg.teamScores[1] ) {
ADDRGP4 $925
JUMPV
LABELV $924
ADDRGP4 cg+110484
INDIRI4
ADDRGP4 cg+110484+4
INDIRI4
LTI4 $931
line 1159
;1159:			s = va("Red leads Blue, %i to %i", cg.teamScores[0], cg.teamScores[1] );
ADDRGP4 $936
ARGP4
ADDRGP4 cg+110484
INDIRI4
ARGI4
ADDRGP4 cg+110484+4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1160
;1160:		} else {
ADDRGP4 $932
JUMPV
LABELV $931
line 1161
;1161:			s = va("Blue leads Red, %i to %i", cg.teamScores[1], cg.teamScores[0] );
ADDRGP4 $940
ARGP4
ADDRGP4 cg+110484+4
INDIRI4
ARGI4
ADDRGP4 cg+110484
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1162
;1162:		}
LABELV $932
LABELV $925
line 1163
;1163:	}
LABELV $916
line 1164
;1164:	return s;
ADDRLP4 0
INDIRP4
RETP4
LABELV $914
endproc CG_GetGameStatusText 12 12
proc CG_DrawGameStatus 8 32
line 1167
;1165:}
;1166:	
;1167:static void CG_DrawGameStatus(rectDef_t *rect, float scale, vec4_t color, qhandle_t shader, int textStyle ) {
line 1168
;1168:	CG_Text_Paint(rect->x, rect->y + rect->h, scale, color, CG_GetGameStatusText(), 0, 0, textStyle);
ADDRLP4 0
ADDRGP4 CG_GetGameStatusText
CALLP4
ASGNP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 1169
;1169:}
LABELV $944
endproc CG_DrawGameStatus 8 32
export CG_GameTypeString
proc CG_GameTypeString 0 0
line 1171
;1170:
;1171:const char *CG_GameTypeString() {
line 1172
;1172:	if ( cgs.gametype == GT_FFA ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 0
NEI4 $946
line 1173
;1173:		return "Free For All";
ADDRGP4 $949
RETP4
ADDRGP4 $945
JUMPV
LABELV $946
line 1174
;1174:	} else if ( cgs.gametype == GT_TEAM ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
NEI4 $950
line 1175
;1175:		return "Team Deathmatch";
ADDRGP4 $953
RETP4
ADDRGP4 $945
JUMPV
LABELV $950
line 1176
;1176:	} else if ( cgs.gametype == GT_CTF ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 4
NEI4 $954
line 1177
;1177:		return "Capture the Flag";
ADDRGP4 $957
RETP4
ADDRGP4 $945
JUMPV
LABELV $954
line 1178
;1178:	} else if ( cgs.gametype == GT_1FCTF ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 5
NEI4 $958
line 1179
;1179:		return "One Flag CTF";
ADDRGP4 $961
RETP4
ADDRGP4 $945
JUMPV
LABELV $958
line 1180
;1180:	} else if ( cgs.gametype == GT_OBELISK ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 6
NEI4 $962
line 1181
;1181:		return "Overload";
ADDRGP4 $965
RETP4
ADDRGP4 $945
JUMPV
LABELV $962
line 1182
;1182:	} else if ( cgs.gametype == GT_HARVESTER ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 7
NEI4 $966
line 1183
;1183:		return "Harvester";
ADDRGP4 $969
RETP4
ADDRGP4 $945
JUMPV
LABELV $966
line 1185
;1184:	}
;1185:	return "";
ADDRGP4 $886
RETP4
LABELV $945
endproc CG_GameTypeString 0 0
proc CG_DrawGameType 8 32
line 1187
;1186:}
;1187:static void CG_DrawGameType(rectDef_t *rect, float scale, vec4_t color, qhandle_t shader, int textStyle ) {
line 1188
;1188:	CG_Text_Paint(rect->x, rect->y + rect->h, scale, color, CG_GameTypeString(), 0, 0, textStyle);
ADDRLP4 0
ADDRGP4 CG_GameTypeString
CALLP4
ASGNP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 1189
;1189:}
LABELV $970
endproc CG_DrawGameType 8 32
proc CG_Text_Paint_Limit 68 40
line 1191
;1190:
;1191:static void CG_Text_Paint_Limit(float *maxX, float x, float y, float scale, vec4_t color, const char* text, float adjust, int limit) {
line 1195
;1192:  int len, count;
;1193:	vec4_t newColor;
;1194:	glyphInfo_t *glyph;
;1195:  if (text) {
ADDRFP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $972
line 1198
;1196:// TTimo: FIXME
;1197://    const unsigned char *s = text; // bk001206 - unsigned
;1198:    const char *s = text;
ADDRLP4 28
ADDRFP4 20
INDIRP4
ASGNP4
line 1199
;1199:		float max = *maxX;
ADDRLP4 40
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 1201
;1200:		float useScale;
;1201:		fontInfo_t *font = &cgDC.Assets.textFont;
ADDRLP4 36
ADDRGP4 cgDC+228+12
ASGNP4
line 1202
;1202:		if (scale <= cg_smallFont.value) {
ADDRFP4 12
INDIRF4
ADDRGP4 cg_smallFont+8
INDIRF4
GTF4 $976
line 1203
;1203:			font = &cgDC.Assets.smallFont;
ADDRLP4 36
ADDRGP4 cgDC+228+20560
ASGNP4
line 1204
;1204:		} else if (scale > cg_bigFont.value) {
ADDRGP4 $977
JUMPV
LABELV $976
ADDRFP4 12
INDIRF4
ADDRGP4 cg_bigFont+8
INDIRF4
LEF4 $981
line 1205
;1205:			font = &cgDC.Assets.bigFont;
ADDRLP4 36
ADDRGP4 cgDC+228+41108
ASGNP4
line 1206
;1206:		}
LABELV $981
LABELV $977
line 1207
;1207:		useScale = scale * font->glyphScale;
ADDRLP4 32
ADDRFP4 12
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 20480
ADDP4
INDIRF4
MULF4
ASGNF4
line 1208
;1208:		trap_R_SetColor( color );
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1209
;1209:    len = strlen(text);					 
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 24
ADDRLP4 44
INDIRU4
CVUI4 4
ASGNI4
line 1210
;1210:		if (limit > 0 && len > limit) {
ADDRLP4 48
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
LEI4 $986
ADDRLP4 24
INDIRI4
ADDRLP4 48
INDIRI4
LEI4 $986
line 1211
;1211:			len = limit;
ADDRLP4 24
ADDRFP4 28
INDIRI4
ASGNI4
line 1212
;1212:		}
LABELV $986
line 1213
;1213:		count = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 $989
JUMPV
LABELV $988
line 1214
;1214:		while (s && *s && count < len) {
line 1215
;1215:			glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRI1
CVII4 1
CNSTI4 80
MULI4
ADDRLP4 36
INDIRP4
ADDP4
ASGNP4
line 1216
;1216:			if ( Q_IsColorString( s ) ) {
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $991
ADDRLP4 28
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $991
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $991
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $991
line 1217
;1217:				memcpy( newColor, g_color_table[ColorIndex(*(s+1))], sizeof( newColor ) );
ADDRLP4 4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
CNSTI4 7
BANDI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
CNSTU4 16
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 1218
;1218:				newColor[3] = color[3];
ADDRLP4 4+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 1219
;1219:				trap_R_SetColor( newColor );
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1220
;1220:				s += 2;
ADDRLP4 28
ADDRLP4 28
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 1221
;1221:				continue;
ADDRGP4 $989
JUMPV
LABELV $991
line 1222
;1222:			} else {
line 1223
;1223:	      float yadj = useScale * glyph->top;
ADDRLP4 56
ADDRLP4 32
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 1224
;1224:				if (CG_Text_Width(s, useScale, 1) + x > max) {
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 60
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CVIF4 4
ADDRFP4 4
INDIRF4
ADDF4
ADDRLP4 40
INDIRF4
LEF4 $994
line 1225
;1225:					*maxX = 0;
ADDRFP4 0
INDIRP4
CNSTF4 0
ASGNF4
line 1226
;1226:					break;
ADDRGP4 $990
JUMPV
LABELV $994
line 1228
;1227:				}
;1228:		    CG_Text_PaintChar(x, y - yadj, 
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ADDRLP4 56
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Text_PaintChar
CALLV
pop
line 1237
;1229:			                    glyph->imageWidth,
;1230:				                  glyph->imageHeight,
;1231:					                useScale, 
;1232:						              glyph->s,
;1233:							            glyph->t,
;1234:								          glyph->s2,
;1235:									        glyph->t2,
;1236:										      glyph->glyph);
;1237:	      x += (glyph->xSkip * useScale) + adjust;
ADDRFP4 4
ADDRFP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 32
INDIRF4
MULF4
ADDRFP4 24
INDIRF4
ADDF4
ADDF4
ASGNF4
line 1238
;1238:				*maxX = x;
ADDRFP4 0
INDIRP4
ADDRFP4 4
INDIRF4
ASGNF4
line 1239
;1239:				count++;
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1240
;1240:				s++;
ADDRLP4 28
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1241
;1241:	    }
line 1242
;1242:		}
LABELV $989
line 1214
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $997
ADDRLP4 28
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $997
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
LTI4 $988
LABELV $997
LABELV $990
line 1243
;1243:	  trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1244
;1244:  }
LABELV $972
line 1246
;1245:
;1246:}
LABELV $971
endproc CG_Text_Paint_Limit 68 40
export CG_DrawNewTeamInfo
proc CG_DrawNewTeamInfo 96 32
line 1252
;1247:
;1248:
;1249:
;1250:#define PIC_WIDTH 12
;1251:
;1252:void CG_DrawNewTeamInfo(rectDef_t *rect, float text_x, float text_y, float scale, vec4_t color, qhandle_t shader) {
line 1264
;1253:	int xx;
;1254:	float y;
;1255:	int i, j, len, count;
;1256:	const char *p;
;1257:	vec4_t		hcolor;
;1258:	float pwidth, lwidth, maxx, leftOver;
;1259:	clientInfo_t *ci;
;1260:	gitem_t	*item;
;1261:	qhandle_t h;
;1262:
;1263:	// max player name width
;1264:	pwidth = 0;
ADDRLP4 64
CNSTF4 0
ASGNF4
line 1265
;1265:	count = (numSortedTeamPlayers > 8) ? 8 : numSortedTeamPlayers;
ADDRGP4 numSortedTeamPlayers
INDIRI4
CNSTI4 8
LEI4 $1000
ADDRLP4 72
CNSTI4 8
ASGNI4
ADDRGP4 $1001
JUMPV
LABELV $1000
ADDRLP4 72
ADDRGP4 numSortedTeamPlayers
INDIRI4
ASGNI4
LABELV $1001
ADDRLP4 32
ADDRLP4 72
INDIRI4
ASGNI4
line 1266
;1266:	for (i = 0; i < count; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $1005
JUMPV
LABELV $1002
line 1267
;1267:		ci = cgs.clientinfo + sortedTeamPlayers[i];
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 1268
;1268:		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $1007
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
NEI4 $1007
line 1269
;1269:			len = CG_Text_Width( ci->name, scale, 0);
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 80
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 80
INDIRI4
ASGNI4
line 1270
;1270:			if (len > pwidth)
ADDRLP4 28
INDIRI4
CVIF4 4
ADDRLP4 64
INDIRF4
LEF4 $1010
line 1271
;1271:				pwidth = len;
ADDRLP4 64
ADDRLP4 28
INDIRI4
CVIF4 4
ASGNF4
LABELV $1010
line 1272
;1272:		}
LABELV $1007
line 1273
;1273:	}
LABELV $1003
line 1266
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1005
ADDRLP4 8
INDIRI4
ADDRLP4 32
INDIRI4
LTI4 $1002
line 1276
;1274:
;1275:	// max location name width
;1276:	lwidth = 0;
ADDRLP4 68
CNSTF4 0
ASGNF4
line 1277
;1277:	for (i = 1; i < MAX_LOCATIONS; i++) {
ADDRLP4 8
CNSTI4 1
ASGNI4
LABELV $1012
line 1278
;1278:		p = CG_ConfigString(CS_LOCATIONS + i);
ADDRLP4 8
INDIRI4
CNSTI4 608
ADDI4
ARGI4
ADDRLP4 76
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 76
INDIRP4
ASGNP4
line 1279
;1279:		if (p && *p) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1016
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1016
line 1280
;1280:			len = CG_Text_Width(p, scale, 0);
ADDRLP4 20
INDIRP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 84
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 84
INDIRI4
ASGNI4
line 1281
;1281:			if (len > lwidth)
ADDRLP4 28
INDIRI4
CVIF4 4
ADDRLP4 68
INDIRF4
LEF4 $1018
line 1282
;1282:				lwidth = len;
ADDRLP4 68
ADDRLP4 28
INDIRI4
CVIF4 4
ASGNF4
LABELV $1018
line 1283
;1283:		}
LABELV $1016
line 1284
;1284:	}
LABELV $1013
line 1277
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 64
LTI4 $1012
line 1286
;1285:
;1286:	y = rect->y;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1288
;1287:
;1288:	for (i = 0; i < count; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $1023
JUMPV
LABELV $1020
line 1289
;1289:		ci = cgs.clientinfo + sortedTeamPlayers[i];
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 1290
;1290:		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $1025
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
NEI4 $1025
line 1292
;1291:
;1292:			xx = rect->x + 1;
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 1293
;1293:			for (j = 0; j <= PW_NUM_POWERUPS; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1028
line 1294
;1294:				if (ci->powerups & (1 << j)) {
ADDRLP4 4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $1032
line 1296
;1295:
;1296:					item = BG_FindItemForPowerup( j );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 80
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 80
INDIRP4
ASGNP4
line 1298
;1297:
;1298:					if (item) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1034
line 1299
;1299:						CG_DrawPic( xx, y, PIC_WIDTH, PIC_WIDTH, trap_R_RegisterShader( item->icon ) );
ADDRLP4 16
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
CNSTF4 1094713344
ARGF4
CNSTF4 1094713344
ARGF4
ADDRLP4 84
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1300
;1300:						xx += PIC_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 12
ADDI4
ASGNI4
line 1301
;1301:					}
LABELV $1034
line 1302
;1302:				}
LABELV $1032
line 1303
;1303:			}
LABELV $1029
line 1293
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 15
LEI4 $1028
line 1306
;1304:
;1305:			// FIXME: max of 3 powerups shown properly
;1306:			xx = rect->x + (PIC_WIDTH * 3) + 2;
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1108344832
ADDF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ASGNI4
line 1308
;1307:
;1308:			CG_GetColorForHealth( ci->health, ci->armor, hcolor );
ADDRLP4 4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ARGP4
ADDRGP4 CG_GetColorForHealth
CALLV
pop
line 1309
;1309:			trap_R_SetColor(hcolor);
ADDRLP4 48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1310
;1310:			CG_DrawPic( xx, y + 1, PIC_WIDTH - 2, PIC_WIDTH - 2, cgs.media.heartShader );
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
CNSTF4 1092616192
ARGF4
CNSTF4 1092616192
ARGF4
ADDRGP4 cgs+148772+576
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1316
;1311:
;1312:			//Com_sprintf (st, sizeof(st), "%3i %3i", ci->health,	ci->armor);
;1313:			//CG_Text_Paint(xx, y + text_y, scale, hcolor, st, 0, 0); 
;1314:
;1315:			// draw weapon icon
;1316:			xx += PIC_WIDTH + 1;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 13
ADDI4
ASGNI4
line 1327
;1317:
;1318:// weapon used is not that useful, use the space for task
;1319:#if 0
;1320:			if ( cg_weapons[ci->curWeapon].weaponIcon ) {
;1321:				CG_DrawPic( xx, y, PIC_WIDTH, PIC_WIDTH, cg_weapons[ci->curWeapon].weaponIcon );
;1322:			} else {
;1323:				CG_DrawPic( xx, y, PIC_WIDTH, PIC_WIDTH, cgs.media.deferShader );
;1324:			}
;1325:#endif
;1326:
;1327:			trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1328
;1328:			if (cgs.orderPending) {
ADDRGP4 cgs+148716
INDIRI4
CNSTI4 0
EQI4 $1038
line 1330
;1329:				// blink the icon
;1330:				if ( cg.time > cgs.orderTime - 2500 && (cg.time >> 9 ) & 1 ) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+148720
INDIRI4
CNSTI4 2500
SUBI4
LEI4 $1041
ADDRGP4 cg+107604
INDIRI4
CNSTI4 9
RSHI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1041
line 1331
;1331:					h = 0;
ADDRLP4 44
CNSTI4 0
ASGNI4
line 1332
;1332:				} else {
ADDRGP4 $1039
JUMPV
LABELV $1041
line 1333
;1333:					h = CG_StatusHandle(cgs.currentOrder);
ADDRGP4 cgs+148712
INDIRI4
ARGI4
ADDRLP4 84
ADDRGP4 CG_StatusHandle
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 84
INDIRI4
ASGNI4
line 1334
;1334:				}
line 1335
;1335:			}	else {
ADDRGP4 $1039
JUMPV
LABELV $1038
line 1336
;1336:				h = CG_StatusHandle(ci->teamTask);
ADDRLP4 4
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
ARGI4
ADDRLP4 84
ADDRGP4 CG_StatusHandle
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 84
INDIRI4
ASGNI4
line 1337
;1337:			}
LABELV $1039
line 1339
;1338:
;1339:			if (h) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $1047
line 1340
;1340:				CG_DrawPic( xx, y, PIC_WIDTH, PIC_WIDTH, h);
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
CNSTF4 1094713344
ARGF4
CNSTF4 1094713344
ARGF4
ADDRLP4 44
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1341
;1341:			}
LABELV $1047
line 1343
;1342:
;1343:			xx += PIC_WIDTH + 1;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 13
ADDI4
ASGNI4
line 1345
;1344:
;1345:			leftOver = rect->w - xx;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 12
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 1346
;1346:			maxx = xx + leftOver / 3;
ADDRLP4 36
ADDRLP4 12
INDIRI4
CVIF4 4
ADDRLP4 40
INDIRF4
CNSTF4 1051372203
MULF4
ADDF4
ASGNF4
line 1350
;1347:
;1348:
;1349:
;1350:			CG_Text_Paint_Limit(&maxx, xx, y + text_y, scale, color, ci->name, 0, 0); 
ADDRLP4 36
ARGP4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
INDIRF4
ADDRFP4 8
INDIRF4
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 CG_Text_Paint_Limit
CALLV
pop
line 1352
;1351:
;1352:			p = CG_ConfigString(CS_LOCATIONS + ci->location);
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 608
ADDI4
ARGI4
ADDRLP4 84
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 84
INDIRP4
ASGNP4
line 1353
;1353:			if (!p || !*p) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1051
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1049
LABELV $1051
line 1354
;1354:				p = "unknown";
ADDRLP4 20
ADDRGP4 $369
ASGNP4
line 1355
;1355:			}
LABELV $1049
line 1357
;1356:
;1357:			xx += leftOver / 3 + 2;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CVIF4 4
ADDRLP4 40
INDIRF4
CNSTF4 1051372203
MULF4
CNSTF4 1073741824
ADDF4
ADDF4
CVFI4 4
ASGNI4
line 1358
;1358:			maxx = rect->w - 4;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1082130432
SUBF4
ASGNF4
line 1360
;1359:
;1360:			CG_Text_Paint_Limit(&maxx, xx, y + text_y, scale, color, p, 0, 0); 
ADDRLP4 36
ARGP4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
INDIRF4
ADDRFP4 8
INDIRF4
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 CG_Text_Paint_Limit
CALLV
pop
line 1361
;1361:			y += text_y + 2;
ADDRLP4 24
ADDRLP4 24
INDIRF4
ADDRFP4 8
INDIRF4
CNSTF4 1073741824
ADDF4
ADDF4
ASGNF4
line 1362
;1362:			if ( y + text_y + 2 > rect->y + rect->h ) {
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRF4
ADDRFP4 8
INDIRF4
ADDF4
CNSTF4 1073741824
ADDF4
ADDRLP4 92
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
LEF4 $1052
line 1363
;1363:				break;
ADDRGP4 $1022
JUMPV
LABELV $1052
line 1366
;1364:			}
;1365:
;1366:		}
LABELV $1025
line 1367
;1367:	}
LABELV $1021
line 1288
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1023
ADDRLP4 8
INDIRI4
ADDRLP4 32
INDIRI4
LTI4 $1020
LABELV $1022
line 1368
;1368:}
LABELV $998
endproc CG_DrawNewTeamInfo 96 32
export CG_DrawTeamSpectators
proc CG_DrawTeamSpectators 24 32
line 1371
;1369:
;1370:
;1371:void CG_DrawTeamSpectators(rectDef_t *rect, float scale, vec4_t color, qhandle_t shader) {
line 1372
;1372:	if (cg.spectatorLen) {
ADDRGP4 cg+116460
INDIRI4
CNSTI4 0
EQI4 $1055
line 1375
;1373:		float maxX;
;1374:
;1375:		if (cg.spectatorWidth == -1) {
ADDRGP4 cg+116464
INDIRF4
CNSTF4 3212836864
NEF4 $1058
line 1376
;1376:			cg.spectatorWidth = 0;
ADDRGP4 cg+116464
CNSTF4 0
ASGNF4
line 1377
;1377:			cg.spectatorPaintX = rect->x + 1;
ADDRGP4 cg+116472
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 1378
;1378:			cg.spectatorPaintX2 = -1;
ADDRGP4 cg+116476
CNSTI4 -1
ASGNI4
line 1379
;1379:		}
LABELV $1058
line 1381
;1380:
;1381:		if (cg.spectatorOffset > cg.spectatorLen) {
ADDRGP4 cg+116480
INDIRI4
ADDRGP4 cg+116460
INDIRI4
LEI4 $1064
line 1382
;1382:			cg.spectatorOffset = 0;
ADDRGP4 cg+116480
CNSTI4 0
ASGNI4
line 1383
;1383:			cg.spectatorPaintX = rect->x + 1;
ADDRGP4 cg+116472
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 1384
;1384:			cg.spectatorPaintX2 = -1;
ADDRGP4 cg+116476
CNSTI4 -1
ASGNI4
line 1385
;1385:		}
LABELV $1064
line 1387
;1386:
;1387:		if (cg.time > cg.spectatorTime) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+116468
INDIRI4
LEI4 $1071
line 1388
;1388:			cg.spectatorTime = cg.time + 10;
ADDRGP4 cg+116468
ADDRGP4 cg+107604
INDIRI4
CNSTI4 10
ADDI4
ASGNI4
line 1389
;1389:			if (cg.spectatorPaintX <= rect->x + 2) {
ADDRGP4 cg+116472
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
GTF4 $1077
line 1390
;1390:				if (cg.spectatorOffset < cg.spectatorLen) {
ADDRGP4 cg+116480
INDIRI4
ADDRGP4 cg+116460
INDIRI4
GEI4 $1080
line 1391
;1391:					cg.spectatorPaintX += CG_Text_Width(&cg.spectatorList[cg.spectatorOffset], scale, 1) - 1;
ADDRGP4 cg+116480
INDIRI4
ADDRGP4 cg+115436
ADDP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 8
ADDRGP4 cg+116472
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ADDI4
ASGNI4
line 1392
;1392:					cg.spectatorOffset++;
ADDRLP4 12
ADDRGP4 cg+116480
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1393
;1393:				} else {
ADDRGP4 $1078
JUMPV
LABELV $1080
line 1394
;1394:					cg.spectatorOffset = 0;
ADDRGP4 cg+116480
CNSTI4 0
ASGNI4
line 1395
;1395:					if (cg.spectatorPaintX2 >= 0) {
ADDRGP4 cg+116476
INDIRI4
CNSTI4 0
LTI4 $1089
line 1396
;1396:						cg.spectatorPaintX = cg.spectatorPaintX2;
ADDRGP4 cg+116472
ADDRGP4 cg+116476
INDIRI4
ASGNI4
line 1397
;1397:					} else {
ADDRGP4 $1090
JUMPV
LABELV $1089
line 1398
;1398:						cg.spectatorPaintX = rect->x + rect->w - 2;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 cg+116472
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
SUBF4
CVFI4 4
ASGNI4
line 1399
;1399:					}
LABELV $1090
line 1400
;1400:					cg.spectatorPaintX2 = -1;
ADDRGP4 cg+116476
CNSTI4 -1
ASGNI4
line 1401
;1401:				}
line 1402
;1402:			} else {
ADDRGP4 $1078
JUMPV
LABELV $1077
line 1403
;1403:				cg.spectatorPaintX--;
ADDRLP4 4
ADDRGP4 cg+116472
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1404
;1404:				if (cg.spectatorPaintX2 >= 0) {
ADDRGP4 cg+116476
INDIRI4
CNSTI4 0
LTI4 $1097
line 1405
;1405:					cg.spectatorPaintX2--;
ADDRLP4 8
ADDRGP4 cg+116476
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1406
;1406:				}
LABELV $1097
line 1407
;1407:			}
LABELV $1078
line 1408
;1408:		}
LABELV $1071
line 1410
;1409:
;1410:		maxX = rect->x + rect->w - 2;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 1411
;1411:		CG_Text_Paint_Limit(&maxX, cg.spectatorPaintX, rect->y + rect->h - 3, scale, color, &cg.spectatorList[cg.spectatorOffset], 0, 0); 
ADDRLP4 0
ARGP4
ADDRGP4 cg+116472
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1077936128
SUBF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 cg+116480
INDIRI4
ADDRGP4 cg+115436
ADDP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 CG_Text_Paint_Limit
CALLV
pop
line 1412
;1412:		if (cg.spectatorPaintX2 >= 0) {
ADDRGP4 cg+116476
INDIRI4
CNSTI4 0
LTI4 $1104
line 1413
;1413:			float maxX2 = rect->x + rect->w - 2;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 1414
;1414:			CG_Text_Paint_Limit(&maxX2, cg.spectatorPaintX2, rect->y + rect->h - 3, scale, color, cg.spectatorList, 0, cg.spectatorOffset); 
ADDRLP4 12
ARGP4
ADDRGP4 cg+116476
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1077936128
SUBF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 cg+115436
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 cg+116480
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint_Limit
CALLV
pop
line 1415
;1415:		}
LABELV $1104
line 1416
;1416:		if (cg.spectatorOffset && maxX > 0) {
ADDRGP4 cg+116480
INDIRI4
CNSTI4 0
EQI4 $1110
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $1110
line 1418
;1417:			// if we have an offset ( we are skipping the first part of the string ) and we fit the string
;1418:			if (cg.spectatorPaintX2 == -1) {
ADDRGP4 cg+116476
INDIRI4
CNSTI4 -1
NEI4 $1111
line 1419
;1419:						cg.spectatorPaintX2 = rect->x + rect->w - 2;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 cg+116476
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
SUBF4
CVFI4 4
ASGNI4
line 1420
;1420:			}
line 1421
;1421:		} else {
ADDRGP4 $1111
JUMPV
LABELV $1110
line 1422
;1422:			cg.spectatorPaintX2 = -1;
ADDRGP4 cg+116476
CNSTI4 -1
ASGNI4
line 1423
;1423:		}
LABELV $1111
line 1425
;1424:
;1425:	}
LABELV $1055
line 1426
;1426:}
LABELV $1054
endproc CG_DrawTeamSpectators 24 32
export CG_DrawMedal
proc CG_DrawMedal 28 32
line 1430
;1427:
;1428:
;1429:
;1430:void CG_DrawMedal(int ownerDraw, rectDef_t *rect, float scale, vec4_t color, qhandle_t shader) {
line 1431
;1431:	score_t *score = &cg.scores[cg.selectedScore];
ADDRLP4 8
ADDRGP4 cg+110480
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492
ADDP4
ASGNP4
line 1432
;1432:	float value = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1433
;1433:	char *text = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 1434
;1434:	color[3] = 0.25;
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1048576000
ASGNF4
line 1436
;1435:
;1436:	switch (ownerDraw) {
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 53
LTI4 $1121
ADDRLP4 12
INDIRI4
CNSTI4 59
GTI4 $1131
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1132-212
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1132
address $1123
address $1124
address $1125
address $1126
address $1127
address $1128
address $1129
code
LABELV $1131
ADDRFP4 0
INDIRI4
CNSTI4 69
EQI4 $1130
ADDRGP4 $1121
JUMPV
LABELV $1123
line 1438
;1437:		case CG_ACCURACY:
;1438:			value = score->accuracy;
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1439
;1439:			break;
ADDRGP4 $1122
JUMPV
LABELV $1124
line 1441
;1440:		case CG_ASSISTS:
;1441:			value = score->assistCount;
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1442
;1442:			break;
ADDRGP4 $1122
JUMPV
LABELV $1125
line 1444
;1443:		case CG_DEFEND:
;1444:			value = score->defendCount;
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1445
;1445:			break;
ADDRGP4 $1122
JUMPV
LABELV $1126
line 1447
;1446:		case CG_EXCELLENT:
;1447:			value = score->excellentCount;
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1448
;1448:			break;
ADDRGP4 $1122
JUMPV
LABELV $1127
line 1450
;1449:		case CG_IMPRESSIVE:
;1450:			value = score->impressiveCount;
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1451
;1451:			break;
ADDRGP4 $1122
JUMPV
LABELV $1128
line 1453
;1452:		case CG_PERFECT:
;1453:			value = score->perfect;
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1454
;1454:			break;
ADDRGP4 $1122
JUMPV
LABELV $1129
line 1456
;1455:		case CG_GAUNTLET:
;1456:			value = score->gauntletCount;
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1457
;1457:			break;
ADDRGP4 $1122
JUMPV
LABELV $1130
line 1459
;1458:		case CG_CAPTURES:
;1459:			value = score->captures;
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1460
;1460:			break;
LABELV $1121
LABELV $1122
line 1463
;1461:	}
;1462:
;1463:	if (value > 0) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $1134
line 1464
;1464:		if (ownerDraw != CG_PERFECT) {
ADDRFP4 0
INDIRI4
CNSTI4 58
EQI4 $1136
line 1465
;1465:			if (ownerDraw == CG_ACCURACY) {
ADDRFP4 0
INDIRI4
CNSTI4 53
NEI4 $1138
line 1466
;1466:				text = va("%i%%", (int)value);
ADDRGP4 $1140
ARGP4
ADDRLP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 1467
;1467:				if (value > 50) {
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
LEF4 $1137
line 1468
;1468:					color[3] = 1.0;
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1065353216
ASGNF4
line 1469
;1469:				}
line 1470
;1470:			} else {
ADDRGP4 $1137
JUMPV
LABELV $1138
line 1471
;1471:				text = va("%i", (int)value);
ADDRGP4 $205
ARGP4
ADDRLP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 1472
;1472:				color[3] = 1.0;
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1065353216
ASGNF4
line 1473
;1473:			}
line 1474
;1474:		} else {
ADDRGP4 $1137
JUMPV
LABELV $1136
line 1475
;1475:			if (value) {
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $1143
line 1476
;1476:				color[3] = 1.0;
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1065353216
ASGNF4
line 1477
;1477:			}
LABELV $1143
line 1478
;1478:			text = "Wow";
ADDRLP4 4
ADDRGP4 $1145
ASGNP4
line 1479
;1479:		}
LABELV $1137
line 1480
;1480:	}
LABELV $1134
line 1482
;1481:
;1482:	trap_R_SetColor(color);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1483
;1483:	CG_DrawPic( rect->x, rect->y, rect->w, rect->h, shader );
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1485
;1484:
;1485:	if (text) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1146
line 1486
;1486:		color[3] = 1.0;
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1065353216
ASGNF4
line 1487
;1487:		value = CG_Text_Width(text, scale, 0);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 20
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
CVIF4 4
ASGNF4
line 1488
;1488:		CG_Text_Paint(rect->x + (rect->w - value) / 2, rect->y + rect->h + 10 , scale, color, text, 0, 0, 0);
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
CNSTF4 1056964608
MULF4
ADDF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1092616192
ADDF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 1489
;1489:	}
LABELV $1146
line 1490
;1490:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1492
;1491:
;1492:}
LABELV $1118
endproc CG_DrawMedal 28 32
export CG_OwnerDraw
proc CG_OwnerDraw 20 24
line 1496
;1493:
;1494:	
;1495://
;1496:void CG_OwnerDraw(float x, float y, float w, float h, float text_x, float text_y, int ownerDraw, int ownerDrawFlags, int align, float special, float scale, vec4_t color, qhandle_t shader, int textStyle) {
line 1499
;1497:	rectDef_t rect;
;1498:
;1499:  if ( cg_drawStatus.integer == 0 ) {
ADDRGP4 cg_drawStatus+12
INDIRI4
CNSTI4 0
NEI4 $1149
line 1500
;1500:		return;
ADDRGP4 $1148
JUMPV
LABELV $1149
line 1507
;1501:	}
;1502:
;1503:	//if (ownerDrawFlags != 0 && !CG_OwnerDrawVisible(ownerDrawFlags)) {
;1504:	//	return;
;1505:	//}
;1506:
;1507:  rect.x = x;
ADDRLP4 0
ADDRFP4 0
INDIRF4
ASGNF4
line 1508
;1508:  rect.y = y;
ADDRLP4 0+4
ADDRFP4 4
INDIRF4
ASGNF4
line 1509
;1509:  rect.w = w;
ADDRLP4 0+8
ADDRFP4 8
INDIRF4
ASGNF4
line 1510
;1510:  rect.h = h;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
ASGNF4
line 1512
;1511:
;1512:  switch (ownerDraw) {
ADDRLP4 16
ADDRFP4 24
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
LTI4 $1156
ADDRLP4 16
INDIRI4
CNSTI4 69
GTI4 $1156
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1212-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1212
address $1157
address $1159
address $1173
address $1176
address $1160
address $1162
address $1163
address $1169
address $1170
address $1166
address $1171
address $1172
address $1156
address $1156
address $1156
address $1156
address $1156
address $1156
address $1174
address $1175
address $1181
address $1182
address $1183
address $1184
address $1185
address $1186
address $1178
address $1177
address $1179
address $1180
address $1187
address $1189
address $1190
address $1191
address $1192
address $1193
address $1156
address $1195
address $1200
address $1167
address $1168
address $1194
address $1156
address $1156
address $1156
address $1197
address $1198
address $1199
address $1201
address $1202
address $1158
address $1161
address $1203
address $1203
address $1203
address $1203
address $1203
address $1203
address $1203
address $1204
address $1205
address $1164
address $1165
address $1196
address $1188
address $1209
address $1210
address $1211
address $1203
code
LABELV $1157
line 1514
;1513:  case CG_PLAYER_ARMOR_ICON:
;1514:    CG_DrawPlayerArmorIcon(&rect, ownerDrawFlags & CG_SHOW_2DONLY);
ADDRLP4 0
ARGP4
ADDRFP4 28
INDIRI4
CNSTI4 268435456
BANDI4
ARGI4
ADDRGP4 CG_DrawPlayerArmorIcon
CALLV
pop
line 1515
;1515:    break;
ADDRGP4 $1156
JUMPV
LABELV $1158
line 1517
;1516:  case CG_PLAYER_ARMOR_ICON2D:
;1517:    CG_DrawPlayerArmorIcon(&rect, qtrue);
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 CG_DrawPlayerArmorIcon
CALLV
pop
line 1518
;1518:    break;
ADDRGP4 $1156
JUMPV
LABELV $1159
line 1520
;1519:  case CG_PLAYER_ARMOR_VALUE:
;1520:    CG_DrawPlayerArmorValue(&rect, scale, color, shader, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 48
INDIRI4
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawPlayerArmorValue
CALLV
pop
line 1521
;1521:    break;
ADDRGP4 $1156
JUMPV
LABELV $1160
line 1523
;1522:  case CG_PLAYER_AMMO_ICON:
;1523:    CG_DrawPlayerAmmoIcon(&rect, ownerDrawFlags & CG_SHOW_2DONLY);
ADDRLP4 0
ARGP4
ADDRFP4 28
INDIRI4
CNSTI4 268435456
BANDI4
ARGI4
ADDRGP4 CG_DrawPlayerAmmoIcon
CALLV
pop
line 1524
;1524:    break;
ADDRGP4 $1156
JUMPV
LABELV $1161
line 1526
;1525:  case CG_PLAYER_AMMO_ICON2D:
;1526:    CG_DrawPlayerAmmoIcon(&rect, qtrue);
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 CG_DrawPlayerAmmoIcon
CALLV
pop
line 1527
;1527:    break;
ADDRGP4 $1156
JUMPV
LABELV $1162
line 1529
;1528:  case CG_PLAYER_AMMO_VALUE:
;1529:    CG_DrawPlayerAmmoValue(&rect, scale, color, shader, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 48
INDIRI4
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawPlayerAmmoValue
CALLV
pop
line 1530
;1530:    break;
ADDRGP4 $1156
JUMPV
LABELV $1163
line 1532
;1531:  case CG_SELECTEDPLAYER_HEAD:
;1532:    CG_DrawSelectedPlayerHead(&rect, ownerDrawFlags & CG_SHOW_2DONLY, qfalse);
ADDRLP4 0
ARGP4
ADDRFP4 28
INDIRI4
CNSTI4 268435456
BANDI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawSelectedPlayerHead
CALLV
pop
line 1533
;1533:    break;
ADDRGP4 $1156
JUMPV
LABELV $1164
line 1535
;1534:  case CG_VOICE_HEAD:
;1535:    CG_DrawSelectedPlayerHead(&rect, ownerDrawFlags & CG_SHOW_2DONLY, qtrue);
ADDRLP4 0
ARGP4
ADDRFP4 28
INDIRI4
CNSTI4 268435456
BANDI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_DrawSelectedPlayerHead
CALLV
pop
line 1536
;1536:    break;
ADDRGP4 $1156
JUMPV
LABELV $1165
line 1538
;1537:  case CG_VOICE_NAME:
;1538:    CG_DrawSelectedPlayerName(&rect, scale, color, qtrue, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawSelectedPlayerName
CALLV
pop
line 1539
;1539:    break;
ADDRGP4 $1156
JUMPV
LABELV $1166
line 1541
;1540:  case CG_SELECTEDPLAYER_STATUS:
;1541:    CG_DrawSelectedPlayerStatus(&rect);
ADDRLP4 0
ARGP4
ADDRGP4 CG_DrawSelectedPlayerStatus
CALLV
pop
line 1542
;1542:    break;
ADDRGP4 $1156
JUMPV
LABELV $1167
line 1544
;1543:  case CG_SELECTEDPLAYER_ARMOR:
;1544:    CG_DrawSelectedPlayerArmor(&rect, scale, color, shader, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 48
INDIRI4
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawSelectedPlayerArmor
CALLV
pop
line 1545
;1545:    break;
ADDRGP4 $1156
JUMPV
LABELV $1168
line 1547
;1546:  case CG_SELECTEDPLAYER_HEALTH:
;1547:    CG_DrawSelectedPlayerHealth(&rect, scale, color, shader, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 48
INDIRI4
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawSelectedPlayerHealth
CALLV
pop
line 1548
;1548:    break;
ADDRGP4 $1156
JUMPV
LABELV $1169
line 1550
;1549:  case CG_SELECTEDPLAYER_NAME:
;1550:    CG_DrawSelectedPlayerName(&rect, scale, color, qfalse, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawSelectedPlayerName
CALLV
pop
line 1551
;1551:    break;
ADDRGP4 $1156
JUMPV
LABELV $1170
line 1553
;1552:  case CG_SELECTEDPLAYER_LOCATION:
;1553:    CG_DrawSelectedPlayerLocation(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawSelectedPlayerLocation
CALLV
pop
line 1554
;1554:    break;
ADDRGP4 $1156
JUMPV
LABELV $1171
line 1556
;1555:  case CG_SELECTEDPLAYER_WEAPON:
;1556:    CG_DrawSelectedPlayerWeapon(&rect);
ADDRLP4 0
ARGP4
ADDRGP4 CG_DrawSelectedPlayerWeapon
CALLV
pop
line 1557
;1557:    break;
ADDRGP4 $1156
JUMPV
LABELV $1172
line 1559
;1558:  case CG_SELECTEDPLAYER_POWERUP:
;1559:    CG_DrawSelectedPlayerPowerup(&rect, ownerDrawFlags & CG_SHOW_2DONLY);
ADDRLP4 0
ARGP4
ADDRFP4 28
INDIRI4
CNSTI4 268435456
BANDI4
ARGI4
ADDRGP4 CG_DrawSelectedPlayerPowerup
CALLV
pop
line 1560
;1560:    break;
ADDRGP4 $1156
JUMPV
LABELV $1173
line 1562
;1561:  case CG_PLAYER_HEAD:
;1562:    CG_DrawPlayerHead(&rect, ownerDrawFlags & CG_SHOW_2DONLY);
ADDRLP4 0
ARGP4
ADDRFP4 28
INDIRI4
CNSTI4 268435456
BANDI4
ARGI4
ADDRGP4 CG_DrawPlayerHead
CALLV
pop
line 1563
;1563:    break;
ADDRGP4 $1156
JUMPV
LABELV $1174
line 1565
;1564:  case CG_PLAYER_ITEM:
;1565:    CG_DrawPlayerItem(&rect, scale, ownerDrawFlags & CG_SHOW_2DONLY);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 28
INDIRI4
CNSTI4 268435456
BANDI4
ARGI4
ADDRGP4 CG_DrawPlayerItem
CALLV
pop
line 1566
;1566:    break;
ADDRGP4 $1156
JUMPV
LABELV $1175
line 1568
;1567:  case CG_PLAYER_SCORE:
;1568:    CG_DrawPlayerScore(&rect, scale, color, shader, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 48
INDIRI4
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawPlayerScore
CALLV
pop
line 1569
;1569:    break;
ADDRGP4 $1156
JUMPV
LABELV $1176
line 1571
;1570:  case CG_PLAYER_HEALTH:
;1571:    CG_DrawPlayerHealth(&rect, scale, color, shader, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 48
INDIRI4
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawPlayerHealth
CALLV
pop
line 1572
;1572:    break;
ADDRGP4 $1156
JUMPV
LABELV $1177
line 1574
;1573:  case CG_RED_SCORE:
;1574:    CG_DrawRedScore(&rect, scale, color, shader, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 48
INDIRI4
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawRedScore
CALLV
pop
line 1575
;1575:    break;
ADDRGP4 $1156
JUMPV
LABELV $1178
line 1577
;1576:  case CG_BLUE_SCORE:
;1577:    CG_DrawBlueScore(&rect, scale, color, shader, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 48
INDIRI4
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawBlueScore
CALLV
pop
line 1578
;1578:    break;
ADDRGP4 $1156
JUMPV
LABELV $1179
line 1580
;1579:  case CG_RED_NAME:
;1580:    CG_DrawRedName(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawRedName
CALLV
pop
line 1581
;1581:    break;
ADDRGP4 $1156
JUMPV
LABELV $1180
line 1583
;1582:  case CG_BLUE_NAME:
;1583:    CG_DrawBlueName(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawBlueName
CALLV
pop
line 1584
;1584:    break;
ADDRGP4 $1156
JUMPV
LABELV $1181
line 1586
;1585:  case CG_BLUE_FLAGHEAD:
;1586:    CG_DrawBlueFlagHead(&rect);
ADDRLP4 0
ARGP4
ADDRGP4 CG_DrawBlueFlagHead
CALLV
pop
line 1587
;1587:    break;
ADDRGP4 $1156
JUMPV
LABELV $1182
line 1589
;1588:  case CG_BLUE_FLAGSTATUS:
;1589:    CG_DrawBlueFlagStatus(&rect, shader);
ADDRLP4 0
ARGP4
ADDRFP4 48
INDIRI4
ARGI4
ADDRGP4 CG_DrawBlueFlagStatus
CALLV
pop
line 1590
;1590:    break;
ADDRGP4 $1156
JUMPV
LABELV $1183
line 1592
;1591:  case CG_BLUE_FLAGNAME:
;1592:    CG_DrawBlueFlagName(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawBlueFlagName
CALLV
pop
line 1593
;1593:    break;
ADDRGP4 $1156
JUMPV
LABELV $1184
line 1595
;1594:  case CG_RED_FLAGHEAD:
;1595:    CG_DrawRedFlagHead(&rect);
ADDRLP4 0
ARGP4
ADDRGP4 CG_DrawRedFlagHead
CALLV
pop
line 1596
;1596:    break;
ADDRGP4 $1156
JUMPV
LABELV $1185
line 1598
;1597:  case CG_RED_FLAGSTATUS:
;1598:    CG_DrawRedFlagStatus(&rect, shader);
ADDRLP4 0
ARGP4
ADDRFP4 48
INDIRI4
ARGI4
ADDRGP4 CG_DrawRedFlagStatus
CALLV
pop
line 1599
;1599:    break;
ADDRGP4 $1156
JUMPV
LABELV $1186
line 1601
;1600:  case CG_RED_FLAGNAME:
;1601:    CG_DrawRedFlagName(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawRedFlagName
CALLV
pop
line 1602
;1602:    break;
ADDRGP4 $1156
JUMPV
LABELV $1187
line 1604
;1603:  case CG_HARVESTER_SKULLS:
;1604:    CG_HarvesterSkulls(&rect, scale, color, qfalse, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_HarvesterSkulls
CALLV
pop
line 1605
;1605:    break;
ADDRGP4 $1156
JUMPV
LABELV $1188
line 1607
;1606:  case CG_HARVESTER_SKULLS2D:
;1607:    CG_HarvesterSkulls(&rect, scale, color, qtrue, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_HarvesterSkulls
CALLV
pop
line 1608
;1608:    break;
ADDRGP4 $1156
JUMPV
LABELV $1189
line 1610
;1609:  case CG_ONEFLAG_STATUS:
;1610:    CG_OneFlagStatus(&rect);
ADDRLP4 0
ARGP4
ADDRGP4 CG_OneFlagStatus
CALLV
pop
line 1611
;1611:    break;
ADDRGP4 $1156
JUMPV
LABELV $1190
line 1613
;1612:  case CG_PLAYER_LOCATION:
;1613:    CG_DrawPlayerLocation(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawPlayerLocation
CALLV
pop
line 1614
;1614:    break;
ADDRGP4 $1156
JUMPV
LABELV $1191
line 1616
;1615:  case CG_TEAM_COLOR:
;1616:    CG_DrawTeamColor(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 CG_DrawTeamColor
CALLV
pop
line 1617
;1617:    break;
ADDRGP4 $1156
JUMPV
LABELV $1192
line 1619
;1618:  case CG_CTF_POWERUP:
;1619:    CG_DrawCTFPowerUp(&rect);
ADDRLP4 0
ARGP4
ADDRGP4 CG_DrawCTFPowerUp
CALLV
pop
line 1620
;1620:    break;
ADDRGP4 $1156
JUMPV
LABELV $1193
line 1622
;1621:  case CG_AREA_POWERUP:
;1622:		CG_DrawAreaPowerUp(&rect, align, special, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 32
INDIRI4
ARGI4
ADDRFP4 36
INDIRF4
ARGF4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 CG_DrawAreaPowerUp
CALLV
pop
line 1623
;1623:    break;
ADDRGP4 $1156
JUMPV
LABELV $1194
line 1625
;1624:  case CG_PLAYER_STATUS:
;1625:    CG_DrawPlayerStatus(&rect);
ADDRLP4 0
ARGP4
ADDRGP4 CG_DrawPlayerStatus
CALLV
pop
line 1626
;1626:    break;
ADDRGP4 $1156
JUMPV
LABELV $1195
line 1628
;1627:  case CG_PLAYER_HASFLAG:
;1628:    CG_DrawPlayerHasFlag(&rect, qfalse);
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawPlayerHasFlag
CALLV
pop
line 1629
;1629:    break;
ADDRGP4 $1156
JUMPV
LABELV $1196
line 1631
;1630:  case CG_PLAYER_HASFLAG2D:
;1631:    CG_DrawPlayerHasFlag(&rect, qtrue);
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 CG_DrawPlayerHasFlag
CALLV
pop
line 1632
;1632:    break;
ADDRGP4 $1156
JUMPV
LABELV $1197
line 1634
;1633:  case CG_AREA_SYSTEMCHAT:
;1634:    CG_DrawAreaSystemChat(&rect, scale, color, shader);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 48
INDIRI4
ARGI4
ADDRGP4 CG_DrawAreaSystemChat
CALLV
pop
line 1635
;1635:    break;
ADDRGP4 $1156
JUMPV
LABELV $1198
line 1637
;1636:  case CG_AREA_TEAMCHAT:
;1637:    CG_DrawAreaTeamChat(&rect, scale, color, shader);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 48
INDIRI4
ARGI4
ADDRGP4 CG_DrawAreaTeamChat
CALLV
pop
line 1638
;1638:    break;
ADDRGP4 $1156
JUMPV
LABELV $1199
line 1640
;1639:  case CG_AREA_CHAT:
;1640:    CG_DrawAreaChat(&rect, scale, color, shader);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 48
INDIRI4
ARGI4
ADDRGP4 CG_DrawAreaChat
CALLV
pop
line 1641
;1641:    break;
ADDRGP4 $1156
JUMPV
LABELV $1200
line 1643
;1642:  case CG_GAME_TYPE:
;1643:    CG_DrawGameType(&rect, scale, color, shader, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 48
INDIRI4
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawGameType
CALLV
pop
line 1644
;1644:    break;
ADDRGP4 $1156
JUMPV
LABELV $1201
line 1646
;1645:  case CG_GAME_STATUS:
;1646:    CG_DrawGameStatus(&rect, scale, color, shader, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 48
INDIRI4
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawGameStatus
CALLV
pop
line 1647
;1647:		break;
ADDRGP4 $1156
JUMPV
LABELV $1202
line 1649
;1648:  case CG_KILLER:
;1649:    CG_DrawKiller(&rect, scale, color, shader, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 48
INDIRI4
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawKiller
CALLV
pop
line 1650
;1650:		break;
ADDRGP4 $1156
JUMPV
LABELV $1203
line 1659
;1651:	case CG_ACCURACY:
;1652:	case CG_ASSISTS:
;1653:	case CG_DEFEND:
;1654:	case CG_EXCELLENT:
;1655:	case CG_IMPRESSIVE:
;1656:	case CG_PERFECT:
;1657:	case CG_GAUNTLET:
;1658:	case CG_CAPTURES:
;1659:		CG_DrawMedal(ownerDraw, &rect, scale, color, shader);
ADDRFP4 24
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 48
INDIRI4
ARGI4
ADDRGP4 CG_DrawMedal
CALLV
pop
line 1660
;1660:		break;
ADDRGP4 $1156
JUMPV
LABELV $1204
line 1662
;1661:  case CG_SPECTATORS:
;1662:		CG_DrawTeamSpectators(&rect, scale, color, shader);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 48
INDIRI4
ARGI4
ADDRGP4 CG_DrawTeamSpectators
CALLV
pop
line 1663
;1663:		break;
ADDRGP4 $1156
JUMPV
LABELV $1205
line 1665
;1664:  case CG_TEAMINFO:
;1665:		if (cg_currentSelectedPlayer.integer == numSortedTeamPlayers) {
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
ADDRGP4 numSortedTeamPlayers
INDIRI4
NEI4 $1156
line 1666
;1666:			CG_DrawNewTeamInfo(&rect, text_x, text_y, scale, color, shader);
ADDRLP4 0
ARGP4
ADDRFP4 16
INDIRF4
ARGF4
ADDRFP4 20
INDIRF4
ARGF4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 48
INDIRI4
ARGI4
ADDRGP4 CG_DrawNewTeamInfo
CALLV
pop
line 1667
;1667:		}
line 1668
;1668:		break;
ADDRGP4 $1156
JUMPV
LABELV $1209
line 1670
;1669:  case CG_CAPFRAGLIMIT:
;1670:    CG_DrawCapFragLimit(&rect, scale, color, shader, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 48
INDIRI4
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawCapFragLimit
CALLV
pop
line 1671
;1671:		break;
ADDRGP4 $1156
JUMPV
LABELV $1210
line 1673
;1672:  case CG_1STPLACE:
;1673:    CG_Draw1stPlace(&rect, scale, color, shader, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 48
INDIRI4
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_Draw1stPlace
CALLV
pop
line 1674
;1674:		break;
ADDRGP4 $1156
JUMPV
LABELV $1211
line 1676
;1675:  case CG_2NDPLACE:
;1676:    CG_Draw2ndPlace(&rect, scale, color, shader, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 48
INDIRI4
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 CG_Draw2ndPlace
CALLV
pop
line 1677
;1677:		break;
line 1679
;1678:  default:
;1679:    break;
LABELV $1156
line 1681
;1680:  }
;1681:}
LABELV $1148
endproc CG_OwnerDraw 20 24
export CG_MouseEvent
proc CG_MouseEvent 16 12
line 1683
;1682:
;1683:void CG_MouseEvent(int x, int y) {
line 1686
;1684:	int n;
;1685:
;1686:	if ( (cg.predictedPlayerState.pm_type == PM_NORMAL || cg.predictedPlayerState.pm_type == PM_SPECTATOR) && cg.showScores == qfalse) {
ADDRGP4 cg+107636+4
INDIRI4
CNSTI4 0
EQI4 $1222
ADDRGP4 cg+107636+4
INDIRI4
CNSTI4 2
NEI4 $1215
LABELV $1222
ADDRGP4 cg+115356
INDIRI4
CNSTI4 0
NEI4 $1215
line 1687
;1687:    trap_Key_SetCatcher(0);
CNSTI4 0
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 1688
;1688:		return;
ADDRGP4 $1214
JUMPV
LABELV $1215
line 1691
;1689:	}
;1690:
;1691:	cgs.cursorX += x * cgs.cursorScaleR;
ADDRLP4 4
ADDRGP4 cgs+150108
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRFP4 0
INDIRI4
CVIF4 4
ADDRGP4 cgs+31440
INDIRF4
MULF4
ADDF4
ASGNF4
line 1692
;1692:	cgs.cursorY += y * cgs.cursorScaleR;
ADDRLP4 8
ADDRGP4 cgs+150112
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRFP4 4
INDIRI4
CVIF4 4
ADDRGP4 cgs+31440
INDIRF4
MULF4
ADDF4
ASGNF4
line 1694
;1693:
;1694:	if ( cgs.cursorX < cgs.screenXmin ) {
ADDRGP4 cgs+150108
INDIRF4
ADDRGP4 cgs+31452
INDIRF4
GEF4 $1227
line 1695
;1695:		cgs.cursorX = cgs.screenXmin;
ADDRGP4 cgs+150108
ADDRGP4 cgs+31452
INDIRF4
ASGNF4
line 1696
;1696:	}
ADDRGP4 $1228
JUMPV
LABELV $1227
line 1697
;1697:	else if ( cgs.cursorX > cgs.screenXmax ) {
ADDRGP4 cgs+150108
INDIRF4
ADDRGP4 cgs+31456
INDIRF4
LEF4 $1233
line 1698
;1698:		cgs.cursorX = cgs.screenXmax;
ADDRGP4 cgs+150108
ADDRGP4 cgs+31456
INDIRF4
ASGNF4
line 1699
;1699:	}
LABELV $1233
LABELV $1228
line 1701
;1700:
;1701:	if ( cgs.cursorY < cgs.screenYmin ) {
ADDRGP4 cgs+150112
INDIRF4
ADDRGP4 cgs+31460
INDIRF4
GEF4 $1239
line 1702
;1702:		cgs.cursorY = cgs.screenYmin;
ADDRGP4 cgs+150112
ADDRGP4 cgs+31460
INDIRF4
ASGNF4
line 1703
;1703:	}
ADDRGP4 $1240
JUMPV
LABELV $1239
line 1704
;1704:	else if ( cgs.cursorY > cgs.screenYmax ) {
ADDRGP4 cgs+150112
INDIRF4
ADDRGP4 cgs+31464
INDIRF4
LEF4 $1245
line 1705
;1705:		cgs.cursorY = cgs.screenYmax;
ADDRGP4 cgs+150112
ADDRGP4 cgs+31464
INDIRF4
ASGNF4
line 1706
;1706:	}
LABELV $1245
LABELV $1240
line 1708
;1707:
;1708:	n = Display_CursorType(cgs.cursorX, cgs.cursorY);
ADDRGP4 cgs+150108
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cgs+150112
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 12
ADDRGP4 Display_CursorType
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 1709
;1709:	cgs.activeCursor = 0;
ADDRGP4 cgs+148708
CNSTI4 0
ASGNI4
line 1710
;1710:	if (n == CURSOR_ARROW) {
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $1254
line 1711
;1711:		cgs.activeCursor = cgs.media.selectCursor;
ADDRGP4 cgs+148708
ADDRGP4 cgs+148772+1204
INDIRI4
ASGNI4
line 1712
;1712:	} else if (n == CURSOR_SIZER) {
ADDRGP4 $1255
JUMPV
LABELV $1254
ADDRLP4 0
INDIRI4
CNSTI4 4
NEI4 $1259
line 1713
;1713:		cgs.activeCursor = cgs.media.sizeCursor;
ADDRGP4 cgs+148708
ADDRGP4 cgs+148772+1200
INDIRI4
ASGNI4
line 1714
;1714:	}
LABELV $1259
LABELV $1255
line 1716
;1715:
;1716:  if (cgs.capturedItem) {
ADDRGP4 cgs+148704
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1264
line 1717
;1717:	  Display_MouseMove(cgs.capturedItem, x, y);
ADDRGP4 cgs+148704
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 Display_MouseMove
CALLI4
pop
line 1718
;1718:  } else {
ADDRGP4 $1265
JUMPV
LABELV $1264
line 1719
;1719:	  Display_MouseMove(NULL, cgs.cursorX, cgs.cursorY);
CNSTP4 0
ARGP4
ADDRGP4 cgs+150108
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cgs+150112
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Display_MouseMove
CALLI4
pop
line 1720
;1720:  }
LABELV $1265
line 1722
;1721:
;1722:}
LABELV $1214
endproc CG_MouseEvent 16 12
export CG_HideTeamMenu
proc CG_HideTeamMenu 0 4
line 1730
;1723:
;1724:/*
;1725:==================
;1726:CG_HideTeamMenus
;1727:==================
;1728:
;1729:*/
;1730:void CG_HideTeamMenu() {
line 1731
;1731:  Menus_CloseByName("teamMenu");
ADDRGP4 $1271
ARGP4
ADDRGP4 Menus_CloseByName
CALLV
pop
line 1732
;1732:  Menus_CloseByName("getMenu");
ADDRGP4 $1272
ARGP4
ADDRGP4 Menus_CloseByName
CALLV
pop
line 1733
;1733:}
LABELV $1270
endproc CG_HideTeamMenu 0 4
export CG_ShowTeamMenu
proc CG_ShowTeamMenu 0 4
line 1741
;1734:
;1735:/*
;1736:==================
;1737:CG_ShowTeamMenus
;1738:==================
;1739:
;1740:*/
;1741:void CG_ShowTeamMenu() {
line 1742
;1742:  Menus_OpenByName("teamMenu");
ADDRGP4 $1271
ARGP4
ADDRGP4 Menus_OpenByName
CALLV
pop
line 1743
;1743:}
LABELV $1273
endproc CG_ShowTeamMenu 0 4
export CG_EventHandling
proc CG_EventHandling 0 0
line 1757
;1744:
;1745:
;1746:
;1747:
;1748:/*
;1749:==================
;1750:CG_EventHandling
;1751:==================
;1752: type 0 - no event handling
;1753:      1 - team menu
;1754:      2 - hud editor
;1755:
;1756:*/
;1757:void CG_EventHandling(cgame_event_t type) {
line 1758
;1758:	cgs.eventHandling = type;
ADDRGP4 cgs+148692
ADDRFP4 0
INDIRI4
ASGNI4
line 1759
;1759:  if (type == CGAME_EVENT_NONE) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $1276
line 1760
;1760:    CG_HideTeamMenu();
ADDRGP4 CG_HideTeamMenu
CALLV
pop
line 1761
;1761:  } else if (type == CGAME_EVENT_TEAMMENU) {
ADDRGP4 $1277
JUMPV
LABELV $1276
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $1278
line 1763
;1762:    //CG_ShowTeamMenu();
;1763:  } else if (type == CGAME_EVENT_SCOREBOARD) {
ADDRGP4 $1279
JUMPV
LABELV $1278
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $1280
line 1764
;1764:  }
LABELV $1280
LABELV $1279
LABELV $1277
line 1766
;1765:
;1766:}
LABELV $1274
endproc CG_EventHandling 0 0
export CG_KeyEvent
proc CG_KeyEvent 4 16
line 1770
;1767:
;1768:
;1769:
;1770:void CG_KeyEvent(int key, qboolean down) {
line 1772
;1771:
;1772:	if (!down) {
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $1283
line 1773
;1773:		return;
ADDRGP4 $1282
JUMPV
LABELV $1283
line 1789
;1774:	}
;1775:
;1776:#if 0
;1777:	// process scoreboard clicks etc..
;1778:	if ( cgs.score_catched && down )
;1779:	{
;1780:		if ( key == /*K_TAB*/ cgs.score_key )
;1781:			return;
;1782:		if ( key == /*K_MOUSE1*/178 )
;1783:			CG_ScoreboardClick
;1784:		else
;1785:			CG_SetScoreCatcher( qfalse );
;1786:	}
;1787:#endif
;1788:
;1789:	if ( cg.predictedPlayerState.pm_type == PM_NORMAL || (cg.predictedPlayerState.pm_type == PM_SPECTATOR && cg.showScores == qfalse)) {
ADDRGP4 cg+107636+4
INDIRI4
CNSTI4 0
EQI4 $1292
ADDRGP4 cg+107636+4
INDIRI4
CNSTI4 2
NEI4 $1285
ADDRGP4 cg+115356
INDIRI4
CNSTI4 0
NEI4 $1285
LABELV $1292
line 1790
;1790:		CG_EventHandling(CGAME_EVENT_NONE);
CNSTI4 0
ARGI4
ADDRGP4 CG_EventHandling
CALLV
pop
line 1791
;1791:    trap_Key_SetCatcher(0);
CNSTI4 0
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 1792
;1792:		return;
ADDRGP4 $1282
JUMPV
LABELV $1285
line 1803
;1793:	}
;1794:
;1795:  //if (key == trap_Key_GetKey("teamMenu") || !Display_CaptureItem(cgs.cursorX, cgs.cursorY)) {
;1796:    // if we see this then we should always be visible
;1797:  //  CG_EventHandling(CGAME_EVENT_NONE);
;1798:  //  trap_Key_SetCatcher(0);
;1799:  //}
;1800:
;1801:
;1802:
;1803:  Display_HandleKey(key, down, cgs.cursorX, cgs.cursorY);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 cgs+150108
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cgs+150112
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Display_HandleKey
CALLV
pop
line 1805
;1804:
;1805:	if (cgs.capturedItem) {
ADDRGP4 cgs+148704
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1295
line 1806
;1806:		cgs.capturedItem = NULL;
ADDRGP4 cgs+148704
CNSTP4 0
ASGNP4
line 1807
;1807:	}	else {
ADDRGP4 $1296
JUMPV
LABELV $1295
line 1808
;1808:		if (key == K_MOUSE2 && down) {
ADDRFP4 0
INDIRI4
CNSTI4 179
NEI4 $1299
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $1299
line 1809
;1809:			cgs.capturedItem = Display_CaptureItem(cgs.cursorX, cgs.cursorY);
ADDRGP4 cgs+150108
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cgs+150112
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 0
ADDRGP4 Display_CaptureItem
CALLP4
ASGNP4
ADDRGP4 cgs+148704
ADDRLP4 0
INDIRP4
ASGNP4
line 1810
;1810:		}
LABELV $1299
line 1811
;1811:	}
LABELV $1296
line 1812
;1812:}
LABELV $1282
endproc CG_KeyEvent 4 16
export CG_ClientNumFromName
proc CG_ClientNumFromName 12 8
line 1814
;1813:
;1814:int CG_ClientNumFromName(const char *p) {
line 1816
;1815:  int i;
;1816:  for (i = 0; i < cgs.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1308
JUMPV
LABELV $1305
line 1817
;1817:    if (cgs.clientinfo[i].infoValid && Q_stricmp(cgs.clientinfo[i].name, p) == 0) {
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1310
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+4
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $1310
line 1818
;1818:      return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1304
JUMPV
LABELV $1310
line 1820
;1819:    }
;1820:  }
LABELV $1306
line 1816
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1308
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+31504
INDIRI4
LTI4 $1305
line 1821
;1821:  return -1;
CNSTI4 -1
RETI4
LABELV $1304
endproc CG_ClientNumFromName 12 8
export CG_ShowResponseHead
proc CG_ShowResponseHead 0 8
line 1824
;1822:}
;1823:
;1824:void CG_ShowResponseHead() {
line 1825
;1825:  Menus_OpenByName("voiceMenu");
ADDRGP4 $1316
ARGP4
ADDRGP4 Menus_OpenByName
CALLV
pop
line 1826
;1826:	trap_Cvar_Set("cl_conXOffset", "72");
ADDRGP4 $1317
ARGP4
ADDRGP4 $1318
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1827
;1827:	cg.voiceTime = cg.time;
ADDRGP4 cg+125528
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1828
;1828:}
LABELV $1315
endproc CG_ShowResponseHead 0 8
export CG_RunMenuScript
proc CG_RunMenuScript 0 0
line 1830
;1829:
;1830:void CG_RunMenuScript(char **args) {
line 1831
;1831:}
LABELV $1321
endproc CG_RunMenuScript 0 0
export CG_GetTeamColor
proc CG_GetTeamColor 8 0
line 1834
;1832:
;1833:
;1834:void CG_GetTeamColor(vec4_t *color) {
line 1835
;1835:  if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1323
line 1836
;1836:    (*color)[0] = 1.0f;
ADDRFP4 0
INDIRP4
CNSTF4 1065353216
ASGNF4
line 1837
;1837:    (*color)[3] = 0.25f;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1048576000
ASGNF4
line 1838
;1838:    (*color)[1] = (*color)[2] = 0.0f;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 1839
;1839:  } else if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
ADDRGP4 $1324
JUMPV
LABELV $1323
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1326
line 1840
;1840:    (*color)[0] = (*color)[1] = 0.0f;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRF4
ASGNF4
line 1841
;1841:    (*color)[2] = 1.0f;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1065353216
ASGNF4
line 1842
;1842:    (*color)[3] = 0.25f;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1048576000
ASGNF4
line 1843
;1843:  } else {
ADDRGP4 $1327
JUMPV
LABELV $1326
line 1844
;1844:    (*color)[0] = (*color)[2] = 0.0f;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRF4
ASGNF4
line 1845
;1845:    (*color)[1] = 0.17f;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1043207291
ASGNF4
line 1846
;1846:    (*color)[3] = 0.25f;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1048576000
ASGNF4
line 1847
;1847:	}
LABELV $1327
LABELV $1324
line 1848
;1848:}
LABELV $1322
endproc CG_GetTeamColor 8 0
import cgDC
import trap_PC_SourceFileAndLine
import trap_PC_ReadToken
import trap_PC_FreeSource
import trap_PC_LoadSource
import trap_PC_AddGlobalDefine
import Controls_SetDefaults
import Controls_SetConfig
import Controls_GetConfig
import UI_OutOfMemory
import UI_InitMemory
import UI_Alloc
import Display_CacheAll
import Menu_SetFeederSelection
import Menu_Paint
import Menus_CloseAll
import LerpColor
import Display_HandleKey
import Menus_CloseByName
import Menus_ShowByName
import Menus_FindByName
import Menus_OpenByName
import Display_KeyBindPending
import Display_CursorType
import Display_MouseMove
import Display_CaptureItem
import Display_GetContext
import Menus_Activate
import Menus_AnyFullScreenVisible
import Menu_Reset
import Menus_ActivateByName
import Menu_PaintAll
import Menu_New
import Menu_Count
import PC_Script_Parse
import PC_String_Parse
import PC_Rect_Parse
import PC_Int_Parse
import PC_Color_Parse
import PC_Float_Parse
import Script_Parse
import String_Parse
import Rect_Parse
import Int_Parse
import Color_Parse
import Float_Parse
import Menu_ScrollFeeder
import Menu_HandleMouseMove
import Menu_HandleKey
import Menu_GetFocused
import Menu_PostParse
import Item_Init
import Menu_Init
import Display_ExpandMacros
import Init_Display
import String_Report
import String_Init
import String_Alloc
import trap_R_AddLinearLightToScene
import trap_R_AddRefEntityToScene2
import linearLight
import intShaderTime
import CG_NewParticleArea
import initparticles
import CG_ParticleExplosion
import CG_ParticleMisc
import CG_ParticleDust
import CG_ParticleSparks
import CG_ParticleBulletDebris
import CG_ParticleSnowFlurry
import CG_AddParticleShrapnel
import CG_ParticleSmoke
import CG_ParticleSnow
import CG_AddParticles
import CG_ClearParticles
import trap_GetEntityToken
import trap_getCameraInfo
import trap_startCamera
import trap_loadCamera
import trap_SnapVector
import trap_CIN_SetExtents
import trap_CIN_DrawCinematic
import trap_CIN_RunCinematic
import trap_CIN_StopCinematic
import trap_CIN_PlayCinematic
import trap_Key_GetKey
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_IsDown
import trap_R_RegisterFont
import trap_MemoryRemaining
import testPrintFloat
import testPrintInt
import trap_SetUserCmdValue
import trap_GetUserCmd
import trap_GetCurrentCmdNumber
import trap_GetServerCommand
import trap_GetSnapshot
import trap_GetCurrentSnapshotNumber
import trap_GetGameState
import trap_GetGlconfig
import trap_R_inPVS
import trap_R_RemapShader
import trap_R_LerpTag
import trap_R_ModelBounds
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_LightForPoint
import trap_R_AddAdditiveLightToScene
import trap_R_AddLightToScene
import trap_R_AddPolysToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterShader
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_R_LoadWorldMap
import trap_S_StopBackgroundTrack
import trap_S_StartBackgroundTrack
import trap_S_RegisterSound
import trap_S_Respatialize
import trap_S_UpdateEntityPosition
import trap_S_AddRealLoopingSound
import trap_S_AddLoopingSound
import trap_S_ClearLoopingSounds
import trap_S_StartLocalSound
import trap_S_StopLoopingSound
import trap_S_StartSound
import trap_CM_MarkFragments
import trap_CM_TransformedCapsuleTrace
import trap_CM_TransformedBoxTrace
import trap_CM_CapsuleTrace
import trap_CM_BoxTrace
import trap_CM_TransformedPointContents
import trap_CM_PointContents
import trap_CM_TempBoxModel
import trap_CM_InlineModel
import trap_CM_NumInlineModels
import trap_CM_LoadMap
import trap_UpdateScreen
import trap_SendClientCommand
import trap_RemoveCommand
import trap_AddCommand
import trap_RealTime
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_Cvar_VariableStringBuffer
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import CG_CheckChangedPredictableEvents
import CG_TransitionPlayerState
import CG_Respawn
import CG_PlayBufferedVoiceChats
import CG_VoiceChatLocal
import CG_LoadVoiceChats
import CG_ShaderStateChanged
import CG_SetConfigValues
import CG_ParseSysteminfo
import CG_ParseServerinfo
import CG_ExecuteNewServerCommands
import CG_InitConsoleCommands
import CG_ConsoleCommand
import CG_ScoreboardClick
import CG_DrawOldTourneyScoreboard
import CG_DrawOldScoreboard
import CG_DrawInformation
import CG_LoadingClient
import CG_LoadingItem
import CG_LoadingString
import CG_ProcessSnapshots
import CG_MakeExplosion
import CG_Bleed
import CG_BigExplode
import CG_GibPlayer
import CG_ScorePlum
import CG_LightningBoltBeam
import CG_InvulnerabilityJuiced
import CG_InvulnerabilityImpact
import CG_ObeliskPain
import CG_ObeliskExplode
import CG_KamikazeEffect
import CG_SpawnEffect
import CG_BubbleTrail
import CG_SmokePuff
import CG_AddLocalEntities
import CG_AllocLocalEntity
import CG_InitLocalEntities
import CG_ImpactMark
import CG_AddMarks
import CG_InitMarkPolys
import CG_OutOfAmmoChange
import CG_DrawWeaponSelect
import CG_AddPlayerWeapon
import CG_AddViewWeapon
import CG_GrappleTrail
import CG_RailTrail
import CG_Bullet
import CG_ShotgunFire
import CG_MissileHitPlayer
import CG_MissileHitWall
import CG_FireWeapon
import CG_RegisterItemVisuals
import CG_RegisterWeapon
import CG_Weapon_f
import CG_LastWeapon_f
import CG_PrevWeapon_f
import CG_NextWeapon_f
import CG_PositionRotatedEntityOnTag
import CG_PositionEntityOnTag
import CG_AdjustPositionForMover
import CG_Beam
import CG_AddPacketEntities
import CG_SetEntitySoundPosition
import CG_PainEvent
import CG_EntityEvent
import CG_PlaceString
import CG_CheckEvents
import CG_PlayDroppedEvents
import CG_LoadDeferredPlayers
import CG_PredictPlayerState
import CG_Trace
import CG_PointContents
import CG_BuildSolidList
import CG_CustomSound
import CG_NewClientInfo
import CG_AddRefEntityWithPowerups
import CG_ResetPlayerEntity
import CG_Player
import CG_TrackClientTeamChange
import CG_ForceModelChange
import CG_Text_PaintChar
import CG_Draw3DModel
import CG_Text_Height
import CG_Text_Width
import CG_Text_Paint
import CG_DrawTeamBackground
import CG_DrawFlagModel
import CG_DrawActive
import CG_DrawHead
import CG_CenterPrint
import CG_AddLagometerSnapshotInfo
import CG_AddLagometerFrameInfo
import teamChat2
import teamChat1
import systemChat
import numSortedTeamPlayers
import sortedTeamPlayers
import CG_SelectFont
import CG_LoadFonts
import CG_DrawString
import CG_DrawTopBottom
import CG_DrawSides
import CG_DrawRect
import UI_DrawProportionalString
import CG_GetColorForHealth
import CG_ColorForHealth
import CG_TileClear
import CG_TeamColor
import CG_FadeColorTime
import CG_FadeColor
import CG_DrawStrlen
import CG_DrawStringExt
import CG_DrawPic
import CG_FillScreen
import CG_FillRect
import CG_AdjustFrom640
import CG_DrawActiveFrame
import CG_AddBufferedSound
import CG_ZoomUp_f
import CG_ZoomDown_f
import CG_TestModelPrevSkin_f
import CG_TestModelNextSkin_f
import CG_TestModelPrevFrame_f
import CG_TestModelNextFrame_f
import CG_TestGun_f
import CG_TestModel_f
import CG_SetScoreCatcher
import CG_BuildSpectatorString
import CG_GetSelectedScore
import CG_SetScoreSelection
import CG_RankRunFrame
import CG_LoadMenus
import CG_LastAttacker
import CG_CrosshairPlayer
import CG_UpdateCvars
import CG_StartMusic
import CG_Error
import CG_Printf
import CG_Argv
import CG_ConfigString
import eventnames
import cg_followKiller
import cg_fovAdjust
import cg_deadBodyDarken
import cg_teamColors
import cg_teamModel
import cg_enemyColors
import cg_enemyModel
import cg_hitSounds
import cg_kickScale
import cg_trueLightning
import cg_oldPlasma
import cg_oldRocket
import cg_oldRail
import cg_bigFont
import cg_smallFont
import cg_noProjectileTrail
import cg_noTaunt
import cg_cameraMode
import cg_smoothClients
import cg_scorePlum
import cg_timescale
import cg_timescaleFadeSpeed
import cg_timescaleFadeEnd
import cg_cameraOrbitDelay
import cg_cameraOrbit
import cg_hudFiles
import cg_obeliskRespawnDelay
import cg_recordSPDemoName
import cg_recordSPDemo
import cg_singlePlayerActive
import cg_enableBreath
import cg_enableDust
import cg_singlePlayer
import cg_currentSelectedPlayerName
import cg_currentSelectedPlayer
import cg_blueTeamName
import cg_redTeamName
import cg_blood
import cg_paused
import cg_buildScript
import cg_noVoiceText
import cg_noVoiceChats
import cg_teamChatsOnly
import cg_drawFriend
import cg_stats
import cg_teamOverlayUserinfo
import cg_drawTeamOverlay
import cg_deferPlayers
import cg_predictItems
import cg_forceModel
import cg_teamChatHeight
import cg_teamChatTime
import cg_thirdPerson
import cg_thirdPersonAngle
import cg_thirdPersonRange
import cg_tracerLength
import cg_tracerWidth
import cg_tracerChance
import cg_footsteps
import cg_showmiss
import cg_noPlayerAnims
import cg_nopredict
import cg_errorDecay
import cg_debugEvents
import cg_debugPosition
import cg_debugAnim
import cg_animSpeed
import cg_swingSpeed
import cg_bobroll
import cg_bobpitch
import cg_bobup
import cg_runroll
import cg_runpitch
import cg_centertime
import cg_gun_z
import cg_gun_y
import cg_gun_x
import cg_gun_frame
import cg_railTrailRadius
import cg_railTrailTime
import cg_lagometer
import cg_addMarks
import cg_simpleItems
import cg_brassTime
import cg_crosshairY
import cg_crosshairX
import cg_crosshairHealth
import cg_crosshairSize
import cg_drawWeaponSelect
import cg_drawRewards
import cg_crosshairColor
import cg_drawCrosshairNames
import cg_drawCrosshair
import cg_drawSpeed
import cg_drawAttacker
import cg_drawAmmoWarning
import cg_drawIcons
import cg_draw3dIcons
import cg_drawSnapshot
import cg_drawFPS
import cg_drawTimer
import cg_drawStatus
import cg_draw2D
import cg_gibs
import cg_shadows
import cg_viewsize
import cg_fov
import cg_zoomFov
import cg_drawGun
import cg_autoswitch
import cg_ignore
import cg_playback_follow
import cg_markPolys
import cg_items
import cg_weapons
import cg_entities
import cg
import cgs
import BigEndian
import replace1
import Q_stradd
import Q_strcpy
import BG_StripColor
import BG_CleanName
import DecodedString
import EncodedString
import strtok
import Q_stristr
import BG_sprintf
import BG_PlayerTouchesItem
import BG_PlayerStateToEntityStateExtraPolate
import BG_PlayerStateToEntityState
import BG_TouchJumpPad
import BG_AddPredictableEventToPlayerstate
import BG_EvaluateTrajectoryDelta
import BG_EvaluateTrajectory
import BG_CanItemBeGrabbed
import BG_FindItemForHoldable
import BG_FindItemForPowerup
import BG_FindItemForWeapon
import BG_FindItem
import bg_numItems
import bg_itemlist
import Pmove
import PM_UpdateViewAngles
import Com_Printf
import Com_Error
import Info_NextPair
import Info_ValidateKeyValue
import Info_Validate
import Info_SetValueForKey_Big
import Info_SetValueForKey
import Info_ValueForKey
import va
import Q_CleanStr
import Q_PrintStrlen
import Q_strcat
import Q_strncpyz
import Q_strrchr
import Q_strupr
import Q_strlwr
import Q_stricmpn
import Q_strncmp
import Q_stricmp
import Q_isalpha
import Q_isupper
import Q_islower
import Q_isprint
import locase
import Com_sprintf
import Parse3DMatrix
import Parse2DMatrix
import Parse1DMatrix
import SkipRestOfLine
import SkipBracedSection
import COM_MatchToken
import Com_Split
import COM_ParseSep
import Com_InitSeparators
import SkipTillSeparators
import COM_ParseWarning
import COM_ParseError
import COM_Compress
import COM_ParseExt
import COM_Parse
import COM_GetCurrentParseLine
import COM_BeginParseSession
import COM_DefaultExtension
import COM_StripExtension
import COM_SkipPath
import Com_Clamp
import PerpendicularVector
import AngleVectors
import MatrixMultiply
import MakeNormalVectors
import RotateAroundDirection
import RotatePointAroundVector
import ProjectPointOnPlane
import PlaneFromPoints
import AngleDelta
import AngleNormalize180
import AngleNormalize360
import AnglesSubtract
import AngleSubtract
import LerpAngle
import AngleMod
import BoxOnPlaneSide
import SetPlaneSignbits
import AxisCopy
import AxisClear
import AnglesToAxis
import vectoangles
import Q_crandom
import Q_random
import Q_rand
import Q_acos
import Q_log2
import VectorRotate
import Vector4Scale
import VectorNormalize2
import VectorNormalize
import CrossProduct
import VectorInverse
import VectorNormalizeFast
import DistanceSquared
import Distance
import VectorLengthSquared
import VectorLength
import VectorCompare
import AddPointToBounds
import ClearBounds
import RadiusFromBounds
import NormalizeColor
import ColorBytes4
import ColorBytes3
import _VectorMA
import _VectorScale
import _VectorCopy
import _VectorAdd
import _VectorSubtract
import _DotProduct
import ByteToDir
import DirToByte
import ClampShort
import ClampChar
import Q_rsqrt
import Q_fabs
import axisDefault
import vec3_origin
import g_color_table
import colorPink
import colorOrange
import colorDkGrey
import colorMdGrey
import colorLtGrey
import colorWhite
import colorCyan
import colorMagenta
import colorYellow
import colorBlue
import colorGreen
import colorRed
import colorBlack
import bytedirs
import Hunk_Alloc
import acos
import fabs
import abs
import tan
import atan2
import cos
import sin
import sqrt
import floor
import ceil
import memcpy
import memset
import memmove
import Q_sscanf
import ED_vsprintf
import atoi
import atof
import toupper
import tolower
import strncpy
import strstr
import strchr
import strcmp
import strcpy
import strcat
import strlen
import rand
import srand
import qsort
lit
align 1
LABELV $1318
byte 1 55
byte 1 50
byte 1 0
align 1
LABELV $1317
byte 1 99
byte 1 108
byte 1 95
byte 1 99
byte 1 111
byte 1 110
byte 1 88
byte 1 79
byte 1 102
byte 1 102
byte 1 115
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $1316
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 0
align 1
LABELV $1272
byte 1 103
byte 1 101
byte 1 116
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 0
align 1
LABELV $1271
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 0
align 1
LABELV $1145
byte 1 87
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $1140
byte 1 37
byte 1 105
byte 1 37
byte 1 37
byte 1 0
align 1
LABELV $969
byte 1 72
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $965
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $961
byte 1 79
byte 1 110
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 67
byte 1 84
byte 1 70
byte 1 0
align 1
LABELV $957
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $953
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $949
byte 1 70
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 70
byte 1 111
byte 1 114
byte 1 32
byte 1 65
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $940
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 32
byte 1 82
byte 1 101
byte 1 100
byte 1 44
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $936
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 32
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 44
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $929
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $921
byte 1 37
byte 1 115
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $903
byte 1 37
byte 1 50
byte 1 105
byte 1 0
align 1
LABELV $890
byte 1 70
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $886
byte 1 0
align 1
LABELV $460
byte 1 45
byte 1 0
align 1
LABELV $369
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $205
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $153
byte 1 69
byte 1 118
byte 1 101
byte 1 114
byte 1 121
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $150
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $149
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $148
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $134
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $130
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $125
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 118
byte 1 115
byte 1 97
byte 1 121
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $119
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $118
byte 1 111
byte 1 110
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $116
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $115
byte 1 111
byte 1 110
byte 1 103
byte 1 101
byte 1 116
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $113
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $112
byte 1 111
byte 1 110
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $110
byte 1 43
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 49
byte 1 48
byte 1 59
byte 1 32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 59
byte 1 32
byte 1 45
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $109
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $108
byte 1 111
byte 1 110
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $106
byte 1 43
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 57
byte 1 59
byte 1 32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 59
byte 1 32
byte 1 45
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 57
byte 1 0
align 1
LABELV $105
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $104
byte 1 111
byte 1 110
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $102
byte 1 43
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 56
byte 1 59
byte 1 32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 59
byte 1 32
byte 1 45
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 56
byte 1 0
align 1
LABELV $101
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $100
byte 1 111
byte 1 110
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $98
byte 1 43
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 55
byte 1 59
byte 1 32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 59
byte 1 32
byte 1 45
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 55
byte 1 0
align 1
LABELV $97
byte 1 111
byte 1 102
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $96
byte 1 111
byte 1 110
byte 1 111
byte 1 102
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
