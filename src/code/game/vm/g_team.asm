export Team_InitGame
code
proc Team_InitGame 4 12
file "../g_team.c"
line 25
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:#include "g_local.h"
;5:
;6:
;7:typedef struct teamgame_s {
;8:	float			last_flag_capture;
;9:	int				last_capture_team;
;10:	flagStatus_t	redStatus;	// CTF
;11:	flagStatus_t	blueStatus;	// CTF
;12:	flagStatus_t	flagStatus;	// One Flag CTF
;13:	int				redTakenTime;
;14:	int				blueTakenTime;
;15:	int				redObeliskAttackedTime;
;16:	int				blueObeliskAttackedTime;
;17:} teamgame_t;
;18:
;19:teamgame_t teamgame;
;20:
;21:gentity_t	*neutralObelisk;
;22:
;23:static void Team_SetFlagStatus( team_t team, flagStatus_t status );
;24:
;25:void Team_InitGame( void ) {
line 26
;26:	memset(&teamgame, 0, sizeof teamgame);
ADDRGP4 teamgame
ARGP4
CNSTI4 0
ARGI4
CNSTU4 36
ARGU4
ADDRGP4 memset
CALLP4
pop
line 28
;27:
;28:	switch( g_gametype.integer ) {
ADDRLP4 0
ADDRGP4 g_gametype+12
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
EQI4 $58
ADDRLP4 0
INDIRI4
CNSTI4 5
EQI4 $61
ADDRGP4 $56
JUMPV
LABELV $58
line 30
;29:	case GT_CTF:
;30:		teamgame.redStatus = -1; // Invalid to force update
ADDRGP4 teamgame+8
CNSTI4 -1
ASGNI4
line 31
;31:		Team_SetFlagStatus( TEAM_RED, FLAG_ATBASE );
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 32
;32:		teamgame.blueStatus = -1; // Invalid to force update
ADDRGP4 teamgame+12
CNSTI4 -1
ASGNI4
line 33
;33:		Team_SetFlagStatus( TEAM_BLUE, FLAG_ATBASE );
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 34
;34:		break;
ADDRGP4 $56
JUMPV
LABELV $61
line 37
;35:#ifdef MISSIONPACK
;36:	case GT_1FCTF:
;37:		teamgame.flagStatus = -1; // Invalid to force update
ADDRGP4 teamgame+16
CNSTI4 -1
ASGNI4
line 38
;38:		Team_SetFlagStatus( TEAM_FREE, FLAG_ATBASE );
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 39
;39:		break;
line 42
;40:#endif
;41:	default:
;42:		break;
LABELV $56
line 44
;43:	}
;44:}
LABELV $54
endproc Team_InitGame 4 12
export OtherTeam
proc OtherTeam 0 0
line 47
;45:
;46:
;47:int OtherTeam( team_t team ) {
line 48
;48:	if ( team == TEAM_RED )
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $64
line 49
;49:		return TEAM_BLUE;
CNSTI4 2
RETI4
ADDRGP4 $63
JUMPV
LABELV $64
line 50
;50:	else if ( team == TEAM_BLUE )
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $66
line 51
;51:		return TEAM_RED;
CNSTI4 1
RETI4
ADDRGP4 $63
JUMPV
LABELV $66
line 52
;52:	return team;
ADDRFP4 0
INDIRI4
RETI4
LABELV $63
endproc OtherTeam 0 0
export TeamName
proc TeamName 0 0
line 56
;53:}
;54:
;55:
;56:const char *TeamName( team_t team ) {
line 57
;57:	if ( team == TEAM_RED )
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $69
line 58
;58:		return "RED";
ADDRGP4 $71
RETP4
ADDRGP4 $68
JUMPV
LABELV $69
line 59
;59:	else if ( team == TEAM_BLUE )
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $72
line 60
;60:		return "BLUE";
ADDRGP4 $74
RETP4
ADDRGP4 $68
JUMPV
LABELV $72
line 61
;61:	else if ( team == TEAM_SPECTATOR )
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $75
line 62
;62:		return "SPECTATOR";
ADDRGP4 $77
RETP4
ADDRGP4 $68
JUMPV
LABELV $75
line 63
;63:	return "FREE";
ADDRGP4 $78
RETP4
LABELV $68
endproc TeamName 0 0
export OtherTeamName
proc OtherTeamName 0 0
line 67
;64:}
;65:
;66:
;67:const char *OtherTeamName( team_t team ) {
line 68
;68:	if ( team == TEAM_RED )
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $80
line 69
;69:		return "BLUE";
ADDRGP4 $74
RETP4
ADDRGP4 $79
JUMPV
LABELV $80
line 70
;70:	else if ( team == TEAM_BLUE )
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $82
line 71
;71:		return "RED";
ADDRGP4 $71
RETP4
ADDRGP4 $79
JUMPV
LABELV $82
line 72
;72:	else if ( team == TEAM_SPECTATOR )
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $84
line 73
;73:		return "SPECTATOR";
ADDRGP4 $77
RETP4
ADDRGP4 $79
JUMPV
LABELV $84
line 74
;74:	return "FREE";
ADDRGP4 $78
RETP4
LABELV $79
endproc OtherTeamName 0 0
export TeamColorString
proc TeamColorString 0 0
line 78
;75:}
;76:
;77:
;78:const char *TeamColorString( team_t team ) {
line 79
;79:	if ( team == TEAM_RED )
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $87
line 80
;80:		return S_COLOR_RED;
ADDRGP4 $89
RETP4
ADDRGP4 $86
JUMPV
LABELV $87
line 81
;81:	else if ( team == TEAM_BLUE )
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $90
line 82
;82:		return S_COLOR_BLUE;
ADDRGP4 $92
RETP4
ADDRGP4 $86
JUMPV
LABELV $90
line 83
;83:	else if ( team == TEAM_SPECTATOR )
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $93
line 84
;84:		return S_COLOR_YELLOW;
ADDRGP4 $95
RETP4
ADDRGP4 $86
JUMPV
LABELV $93
line 85
;85:	return S_COLOR_WHITE;
ADDRGP4 $96
RETP4
LABELV $86
endproc TeamColorString 0 0
export PrintMsg
proc PrintMsg 1048 12
line 90
;86:}
;87:
;88:
;89:// NULL for everyone
;90:void QDECL PrintMsg( gentity_t *ent, const char *fmt, ... ) {
line 95
;91:	char		msg[1024];
;92:	va_list		argptr;
;93:	char		*p;
;94:	
;95:	va_start (argptr,fmt);
ADDRLP4 1028
ADDRFP4 4+4
ASGNP4
line 96
;96:	if ( ED_vsprintf( msg, fmt, argptr ) >= sizeof( msg ) ) {
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 ED_vsprintf
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CVIU4 4
CNSTU4 1024
LTU4 $99
line 97
;97:		G_Error ( "PrintMsg overrun" );
ADDRGP4 $101
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 98
;98:	}
LABELV $99
line 99
;99:	va_end (argptr);
ADDRLP4 1028
CNSTP4 0
ASGNP4
ADDRGP4 $103
JUMPV
LABELV $102
line 103
;100:
;101:	// double quotes are bad
;102:	while ((p = strchr(msg, '"')) != NULL)
;103:		*p = '\'';
ADDRLP4 0
INDIRP4
CNSTI1 39
ASGNI1
LABELV $103
line 102
ADDRLP4 4
ARGP4
CNSTI4 34
ARGI4
ADDRLP4 1036
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1036
INDIRP4
ASGNP4
ADDRLP4 1036
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $102
line 105
;104:
;105:	trap_SendServerCommand ( ( (ent == NULL) ? -1 : ent-g_entities ), va("print \"%s\"", msg ));
ADDRGP4 $106
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1044
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $107
ADDRLP4 1040
CNSTI4 -1
ASGNI4
ADDRGP4 $108
JUMPV
LABELV $107
ADDRLP4 1040
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 824
DIVI4
ASGNI4
LABELV $108
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 1044
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 106
;106:}
LABELV $97
endproc PrintMsg 1048 12
export AddTeamScore
proc AddTeamScore 40 8
line 117
;107:
;108:
;109:/*
;110:==============
;111:AddTeamScore
;112:
;113: used for gametype > GT_TEAM
;114: for gametype GT_TEAM the level.teamScores is updated in AddScore in g_combat.c
;115:==============
;116:*/
;117:void AddTeamScore( vec3_t origin, team_t team, int score ) {
line 122
;118:	int			eventParm;
;119:	int			otherTeam;
;120:	gentity_t	*te;
;121:
;122:	if ( score == 0 ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $110
line 123
;123:		return;
ADDRGP4 $109
JUMPV
LABELV $110
line 126
;124:	}
;125:
;126:	eventParm = -1;
ADDRLP4 4
CNSTI4 -1
ASGNI4
line 127
;127:	otherTeam = OtherTeam( team );
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 129
;128:
;129:	if ( level.teamScores[ team ] + score == level.teamScores[ otherTeam ] ) {
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+48
ADDP4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+48
ADDP4
INDIRI4
NEI4 $112
line 131
;130:		//teams are tied sound
;131:		eventParm = GTS_TEAMS_ARE_TIED;
ADDRLP4 4
CNSTI4 12
ASGNI4
line 132
;132:	} else if ( level.teamScores[ team ] >= level.teamScores[ otherTeam ] &&
ADDRGP4 $113
JUMPV
LABELV $112
ADDRLP4 16
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+48
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+48
ADDP4
INDIRI4
LTI4 $116
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+48
ADDP4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+48
ADDP4
INDIRI4
GEI4 $116
line 133
;133:				level.teamScores[ team ] + score < level.teamScores[ otherTeam ] ) {
line 135
;134:		// other team took the lead sound (negative score)
;135:		eventParm = ( otherTeam == TEAM_RED ) ? GTS_REDTEAM_TOOK_LEAD : GTS_BLUETEAM_TOOK_LEAD;
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $123
ADDRLP4 24
CNSTI4 10
ASGNI4
ADDRGP4 $124
JUMPV
LABELV $123
ADDRLP4 24
CNSTI4 11
ASGNI4
LABELV $124
ADDRLP4 4
ADDRLP4 24
INDIRI4
ASGNI4
line 136
;136:	} else if ( level.teamScores[ team ] <= level.teamScores[ otherTeam ] &&
ADDRGP4 $117
JUMPV
LABELV $116
ADDRLP4 24
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+48
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+48
ADDP4
INDIRI4
GTI4 $125
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+48
ADDP4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+48
ADDP4
INDIRI4
LEI4 $125
line 137
;137:				level.teamScores[ team ] + score > level.teamScores[ otherTeam ] ) {
line 139
;138:		// this team took the lead sound
;139:		eventParm = ( team == TEAM_RED ) ? GTS_REDTEAM_TOOK_LEAD : GTS_BLUETEAM_TOOK_LEAD;
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $132
ADDRLP4 32
CNSTI4 10
ASGNI4
ADDRGP4 $133
JUMPV
LABELV $132
ADDRLP4 32
CNSTI4 11
ASGNI4
LABELV $133
ADDRLP4 4
ADDRLP4 32
INDIRI4
ASGNI4
line 140
;140:	} else if ( score > 0 && g_gametype.integer != GT_TEAM ) {
ADDRGP4 $126
JUMPV
LABELV $125
ADDRFP4 8
INDIRI4
CNSTI4 0
LEI4 $134
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
EQI4 $134
line 142
;141:		// team scored sound
;142:		eventParm = ( team == TEAM_RED ) ? GTS_REDTEAM_SCORED : GTS_BLUETEAM_SCORED;
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $138
ADDRLP4 32
CNSTI4 8
ASGNI4
ADDRGP4 $139
JUMPV
LABELV $138
ADDRLP4 32
CNSTI4 9
ASGNI4
LABELV $139
ADDRLP4 4
ADDRLP4 32
INDIRI4
ASGNI4
line 143
;143:	}
LABELV $134
LABELV $126
LABELV $117
LABELV $113
line 145
;144:
;145:	if ( eventParm != -1 ) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
EQI4 $140
line 146
;146:		te = G_TempEntity(origin, EV_GLOBAL_TEAM_SOUND );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 32
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 32
INDIRP4
ASGNP4
line 147
;147:		te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 36
ADDRLP4 8
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 148
;148:		te->s.eventParm = eventParm;
ADDRLP4 8
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 149
;149:	}
LABELV $140
line 151
;150:
;151:	level.teamScores[ team ] += score;
ADDRLP4 32
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+48
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ASGNI4
line 152
;152:}
LABELV $109
endproc AddTeamScore 40 8
export OnSameTeam
proc OnSameTeam 0 0
line 159
;153:
;154:/*
;155:==============
;156:OnSameTeam
;157:==============
;158:*/
;159:qboolean OnSameTeam( gentity_t *ent1, gentity_t *ent2 ) {
line 160
;160:	if ( !ent1->client || !ent2->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $146
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $144
LABELV $146
line 161
;161:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $143
JUMPV
LABELV $144
line 164
;162:	}
;163:
;164:	if ( g_gametype.integer < GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
GEI4 $147
line 165
;165:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $143
JUMPV
LABELV $147
line 168
;166:	}
;167:
;168:	if ( ent1->client->sess.sessionTeam == ent2->client->sess.sessionTeam ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
NEI4 $150
line 169
;169:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $143
JUMPV
LABELV $150
line 172
;170:	}
;171:
;172:	return qfalse;
CNSTI4 0
RETI4
LABELV $143
endproc OnSameTeam 0 0
lit
align 1
LABELV ctfFlagStatusRemap
byte 1 48
byte 1 49
byte 1 42
byte 1 42
byte 1 50
align 1
LABELV oneFlagStatusRemap
byte 1 48
byte 1 49
byte 1 50
byte 1 51
byte 1 52
code
proc Team_SetFlagStatus 16 8
line 179
;173:}
;174:
;175:
;176:static char ctfFlagStatusRemap[] = { '0', '1', '*', '*', '2' };
;177:static char oneFlagStatusRemap[] = { '0', '1', '2', '3', '4' };
;178:
;179:static void Team_SetFlagStatus( team_t team, flagStatus_t status ) {
line 180
;180:	qboolean modified = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 182
;181:
;182:	switch( team ) {
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $166
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $156
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $161
ADDRGP4 $152
JUMPV
LABELV $156
line 184
;183:	case TEAM_RED:	// CTF
;184:		if ( teamgame.redStatus != status ) {
ADDRGP4 teamgame+8
INDIRI4
ADDRFP4 4
INDIRI4
EQI4 $154
line 185
;185:			teamgame.redStatus = status;
ADDRGP4 teamgame+8
ADDRFP4 4
INDIRI4
ASGNI4
line 186
;186:			modified = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 187
;187:		}
line 188
;188:		break;
ADDRGP4 $154
JUMPV
LABELV $161
line 191
;189:
;190:	case TEAM_BLUE:	// CTF
;191:		if ( teamgame.blueStatus != status ) {
ADDRGP4 teamgame+12
INDIRI4
ADDRFP4 4
INDIRI4
EQI4 $154
line 192
;192:			teamgame.blueStatus = status;
ADDRGP4 teamgame+12
ADDRFP4 4
INDIRI4
ASGNI4
line 193
;193:			modified = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 194
;194:		}
line 195
;195:		break;
ADDRGP4 $154
JUMPV
LABELV $166
line 198
;196:
;197:	case TEAM_FREE:	// One Flag CTF
;198:		if ( teamgame.flagStatus != status ) {
ADDRGP4 teamgame+16
INDIRI4
ADDRFP4 4
INDIRI4
EQI4 $154
line 199
;199:			teamgame.flagStatus = status;
ADDRGP4 teamgame+16
ADDRFP4 4
INDIRI4
ASGNI4
line 200
;200:			modified = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 201
;201:		}
line 202
;202:		break;
line 205
;203:
;204:	default:
;205:		return;
LABELV $154
line 208
;206:	}
;207:
;208:	if ( modified ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $171
line 211
;209:		char st[4];
;210:
;211:		if ( g_gametype.integer == GT_CTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $173
line 212
;212:			st[0] = ctfFlagStatusRemap[teamgame.redStatus];
ADDRLP4 12
ADDRGP4 teamgame+8
INDIRI4
ADDRGP4 ctfFlagStatusRemap
ADDP4
INDIRI1
ASGNI1
line 213
;213:			st[1] = ctfFlagStatusRemap[teamgame.blueStatus];
ADDRLP4 12+1
ADDRGP4 teamgame+12
INDIRI4
ADDRGP4 ctfFlagStatusRemap
ADDP4
INDIRI1
ASGNI1
line 214
;214:			st[2] = '\0';
ADDRLP4 12+2
CNSTI1 0
ASGNI1
line 215
;215:		} else {	// GT_1FCTF
ADDRGP4 $174
JUMPV
LABELV $173
line 216
;216:			st[0] = oneFlagStatusRemap[teamgame.flagStatus];
ADDRLP4 12
ADDRGP4 teamgame+16
INDIRI4
ADDRGP4 oneFlagStatusRemap
ADDP4
INDIRI1
ASGNI1
line 217
;217:			st[1] = '\0';
ADDRLP4 12+1
CNSTI1 0
ASGNI1
line 218
;218:		}
LABELV $174
line 220
;219:
;220:		trap_SetConfigstring( CS_FLAGSTATUS, st );
CNSTI4 23
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 221
;221:	}
LABELV $171
line 222
;222:}
LABELV $152
endproc Team_SetFlagStatus 16 8
export Team_CheckDroppedItem
proc Team_CheckDroppedItem 0 8
line 225
;223:
;224:
;225:void Team_CheckDroppedItem( gentity_t *dropped ) {
line 226
;226:	if( dropped->item->giTag == PW_REDFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $183
line 227
;227:		Team_SetFlagStatus( TEAM_RED, FLAG_DROPPED );
CNSTI4 1
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 228
;228:	}
ADDRGP4 $184
JUMPV
LABELV $183
line 229
;229:	else if( dropped->item->giTag == PW_BLUEFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $185
line 230
;230:		Team_SetFlagStatus( TEAM_BLUE, FLAG_DROPPED );
CNSTI4 2
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 231
;231:	}
ADDRGP4 $186
JUMPV
LABELV $185
line 232
;232:	else if( dropped->item->giTag == PW_NEUTRALFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 9
NEI4 $187
line 233
;233:		Team_SetFlagStatus( TEAM_FREE, FLAG_DROPPED );
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 234
;234:	}
LABELV $187
LABELV $186
LABELV $184
line 235
;235:}
LABELV $182
endproc Team_CheckDroppedItem 0 8
proc Team_ForceGesture 12 0
line 243
;236:
;237:
;238:/*
;239:================
;240:Team_ForceGesture
;241:================
;242:*/
;243:static void Team_ForceGesture( team_t team ) {
line 247
;244:	int i;
;245:	gentity_t *ent;
;246:
;247:	for ( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $193
JUMPV
LABELV $190
line 248
;248:		ent = &g_entities[i];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 249
;249:		if ( !ent->inuse )
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $195
line 250
;250:			continue;
ADDRGP4 $191
JUMPV
LABELV $195
line 251
;251:		if ( !ent->client )
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $197
line 252
;252:			continue;
ADDRGP4 $191
JUMPV
LABELV $197
line 253
;253:		if ( ent->client->sess.sessionTeam != team )
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $199
line 254
;254:			continue;
ADDRGP4 $191
JUMPV
LABELV $199
line 256
;255:		//
;256:		ent->flags |= FL_FORCE_GESTURE;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 32768
BORI4
ASGNI4
line 257
;257:	}
LABELV $191
line 247
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $193
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $190
line 258
;258:}
LABELV $189
endproc Team_ForceGesture 12 0
export Team_FragBonuses
proc Team_FragBonuses 176 16
line 271
;259:
;260:
;261:/*
;262:================
;263:Team_FragBonuses
;264:
;265:Calculate the bonuses for flag defense, flag carrier defense, etc.
;266:Note that bonuses are not cumulative.  You get one, they are in importance
;267:order.
;268:================
;269:*/
;270:void Team_FragBonuses(gentity_t *targ, gentity_t *inflictor, gentity_t *attacker)
;271:{
line 277
;272:	int i;
;273:	gentity_t *ent;
;274:	int flag_pw, enemy_flag_pw;
;275:	int otherteam;
;276:	int tokens;
;277:	gentity_t *flag, *carrier = NULL;
ADDRLP4 12
CNSTP4 0
ASGNP4
line 283
;278:	char *c;
;279:	vec3_t v1, v2;
;280:	int team;
;281:
;282:	// no bonus for fragging yourself or team mates
;283:	if (!targ->client || !attacker->client || targ == attacker || OnSameTeam(targ, attacker))
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $206
ADDRLP4 68
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $206
ADDRLP4 64
INDIRP4
CVPU4 4
ADDRLP4 68
INDIRP4
CVPU4 4
EQU4 $206
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $202
LABELV $206
line 284
;284:		return;
ADDRGP4 $201
JUMPV
LABELV $202
line 286
;285:
;286:	team = targ->client->sess.sessionTeam;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ASGNI4
line 287
;287:	otherteam = OtherTeam(targ->client->sess.sessionTeam);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ARGI4
ADDRLP4 76
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 76
INDIRI4
ASGNI4
line 288
;288:	if (otherteam < 0)
ADDRLP4 16
INDIRI4
CNSTI4 0
GEI4 $207
line 289
;289:		return; // whoever died isn't on a team
ADDRGP4 $201
JUMPV
LABELV $207
line 292
;290:
;291:	// same team, if the flag at base, check to he has the enemy flag
;292:	if (team == TEAM_RED) {
ADDRLP4 52
INDIRI4
CNSTI4 1
NEI4 $209
line 293
;293:		flag_pw = PW_REDFLAG;
ADDRLP4 36
CNSTI4 7
ASGNI4
line 294
;294:		enemy_flag_pw = PW_BLUEFLAG;
ADDRLP4 60
CNSTI4 8
ASGNI4
line 295
;295:	} else {
ADDRGP4 $210
JUMPV
LABELV $209
line 296
;296:		flag_pw = PW_BLUEFLAG;
ADDRLP4 36
CNSTI4 8
ASGNI4
line 297
;297:		enemy_flag_pw = PW_REDFLAG;
ADDRLP4 60
CNSTI4 7
ASGNI4
line 298
;298:	}
LABELV $210
line 301
;299:
;300:#ifdef MISSIONPACK
;301:	if (g_gametype.integer == GT_1FCTF) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
NEI4 $211
line 302
;302:		enemy_flag_pw = PW_NEUTRALFLAG;
ADDRLP4 60
CNSTI4 9
ASGNI4
line 303
;303:	} 
LABELV $211
line 307
;304:#endif
;305:
;306:	// did the attacker frag the flag carrier?
;307:	tokens = 0;
ADDRLP4 56
CNSTI4 0
ASGNI4
line 309
;308:#ifdef MISSIONPACK
;309:	if( g_gametype.integer == GT_HARVESTER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
NEI4 $214
line 310
;310:		tokens = targ->client->ps.generic1;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
ASGNI4
line 311
;311:	}
LABELV $214
line 313
;312:#endif
;313:	if (targ->client->ps.powerups[enemy_flag_pw]) {
ADDRLP4 60
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $217
line 314
;314:		attacker->client->pers.teamState.lastfraggedcarrier = level.time;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 596
ADDP4
ADDRGP4 level+32
INDIRI4
CVIF4 4
ASGNF4
line 315
;315:		AddScore(attacker, targ->r.currentOrigin, CTF_FRAG_CARRIER_BONUS);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 316
;316:		attacker->client->pers.teamState.fragcarrier++;
ADDRLP4 80
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 576
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 317
;317:		PrintMsg(NULL, "%s" S_COLOR_WHITE " fragged %s's flag carrier!\n",
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 84
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $220
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 322
;318:			attacker->client->pers.netname, TeamName(team));
;319:
;320:		// the target had the flag, clear the hurt carrier
;321:		// field on the other team
;322:		for (i = 0; i < level.maxclients; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $224
JUMPV
LABELV $221
line 323
;323:			ent = g_entities + i;
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 324
;324:			if (ent->inuse && ent->client->sess.sessionTeam == otherteam)
ADDRLP4 8
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $226
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $226
line 325
;325:				ent->client->pers.teamState.lasthurtcarrier = 0;
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 584
ADDP4
CNSTF4 0
ASGNF4
LABELV $226
line 326
;326:		}
LABELV $222
line 322
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $224
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $221
line 327
;327:		return;
ADDRGP4 $201
JUMPV
LABELV $217
line 331
;328:	}
;329:
;330:	// did the attacker frag a head carrier? other->client->ps.generic1
;331:	if (tokens) {
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $228
line 332
;332:		attacker->client->pers.teamState.lastfraggedcarrier = level.time;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 596
ADDP4
ADDRGP4 level+32
INDIRI4
CVIF4 4
ASGNF4
line 333
;333:		AddScore(attacker, targ->r.currentOrigin, CTF_FRAG_CARRIER_BONUS * tokens * tokens);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 56
INDIRI4
CNSTI4 20
MULI4
ADDRLP4 56
INDIRI4
MULI4
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 334
;334:		attacker->client->pers.teamState.fragcarrier++;
ADDRLP4 84
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 576
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 335
;335:		PrintMsg(NULL, "%s" S_COLOR_WHITE " fragged %s's skull carrier!\n",
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 88
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $231
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 340
;336:			attacker->client->pers.netname, TeamName(team));
;337:
;338:		// the target had the flag, clear the hurt carrier
;339:		// field on the other team
;340:		for (i = 0; i < level.maxclients; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $235
JUMPV
LABELV $232
line 341
;341:			ent = g_entities + i;
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 342
;342:			if (ent->inuse && ent->client->sess.sessionTeam == otherteam)
ADDRLP4 8
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $237
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $237
line 343
;343:				ent->client->pers.teamState.lasthurtcarrier = 0;
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 584
ADDP4
CNSTF4 0
ASGNF4
LABELV $237
line 344
;344:		}
LABELV $233
line 340
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $235
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $232
line 345
;345:		return;
ADDRGP4 $201
JUMPV
LABELV $228
line 348
;346:	}
;347:
;348:	if (targ->client->pers.teamState.lasthurtcarrier &&
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 584
ADDP4
INDIRF4
CNSTF4 0
EQF4 $239
ADDRGP4 level+32
INDIRI4
CVIF4 4
ADDRLP4 80
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 584
ADDP4
INDIRF4
SUBF4
CNSTF4 1174011904
GEF4 $239
ADDRLP4 36
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $239
line 350
;349:		level.time - targ->client->pers.teamState.lasthurtcarrier < CTF_CARRIER_DANGER_PROTECT_TIMEOUT &&
;350:		!attacker->client->ps.powerups[flag_pw]) {
line 353
;351:		// attacker is on the same team as the flag carrier and
;352:		// fragged a guy who hurt our flag carrier
;353:		AddScore(attacker, targ->r.currentOrigin, CTF_CARRIER_DANGER_PROTECT_BONUS);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 355
;354:
;355:		attacker->client->pers.teamState.carrierdefense++;
ADDRLP4 84
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 568
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 356
;356:		targ->client->pers.teamState.lasthurtcarrier = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 584
ADDP4
CNSTF4 0
ASGNF4
line 358
;357:
;358:		attacker->client->ps.persistant[PERS_DEFEND_COUNT]++;
ADDRLP4 88
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 292
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 359
;359:		team = attacker->client->sess.sessionTeam;
ADDRLP4 52
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ASGNI4
line 361
;360:		// add the sprite over the player's head
;361:		attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 92
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 362
;362:		attacker->client->ps.eFlags |= EF_AWARD_DEFEND;
ADDRLP4 96
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRI4
CNSTI4 65536
BORI4
ASGNI4
line 363
;363:		attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 752
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 365
;364:
;365:		return;
ADDRGP4 $201
JUMPV
LABELV $239
line 368
;366:	}
;367:
;368:	if (targ->client->pers.teamState.lasthurtcarrier &&
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 584
ADDP4
INDIRF4
CNSTF4 0
EQF4 $243
ADDRGP4 level+32
INDIRI4
CVIF4 4
ADDRLP4 84
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 584
ADDP4
INDIRF4
SUBF4
CNSTF4 1174011904
GEF4 $243
line 369
;369:		level.time - targ->client->pers.teamState.lasthurtcarrier < CTF_CARRIER_DANGER_PROTECT_TIMEOUT) {
line 371
;370:		// attacker is on the same team as the skull carrier and
;371:		AddScore(attacker, targ->r.currentOrigin, CTF_CARRIER_DANGER_PROTECT_BONUS);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 373
;372:
;373:		attacker->client->pers.teamState.carrierdefense++;
ADDRLP4 88
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 568
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 374
;374:		targ->client->pers.teamState.lasthurtcarrier = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 584
ADDP4
CNSTF4 0
ASGNF4
line 376
;375:
;376:		attacker->client->ps.persistant[PERS_DEFEND_COUNT]++;
ADDRLP4 92
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 292
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 377
;377:		team = attacker->client->sess.sessionTeam;
ADDRLP4 52
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ASGNI4
line 379
;378:		// add the sprite over the player's head
;379:		attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 96
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 380
;380:		attacker->client->ps.eFlags |= EF_AWARD_DEFEND;
ADDRLP4 100
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI4
CNSTI4 65536
BORI4
ASGNI4
line 381
;381:		attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 752
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 383
;382:
;383:		return;
ADDRGP4 $201
JUMPV
LABELV $243
line 391
;384:	}
;385:
;386:	// flag and flag carrier area defense bonuses
;387:
;388:	// we have to find the flag and carrier entities
;389:
;390:#ifdef MISSIONPACK	
;391:	if( g_gametype.integer == GT_OBELISK ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 6
NEI4 $247
line 393
;392:		// find the team obelisk
;393:		switch (attacker->client->sess.sessionTeam) {
ADDRLP4 88
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 1
EQI4 $253
ADDRLP4 88
INDIRI4
CNSTI4 2
EQI4 $255
ADDRGP4 $201
JUMPV
LABELV $253
line 395
;394:		case TEAM_RED:
;395:			c = "team_redobelisk";
ADDRLP4 20
ADDRGP4 $254
ASGNP4
line 396
;396:			break;
ADDRGP4 $248
JUMPV
LABELV $255
line 398
;397:		case TEAM_BLUE:
;398:			c = "team_blueobelisk";
ADDRLP4 20
ADDRGP4 $256
ASGNP4
line 399
;399:			break;		
line 401
;400:		default:
;401:			return;
line 404
;402:		}
;403:		
;404:	} else if (g_gametype.integer == GT_HARVESTER ) {
ADDRGP4 $248
JUMPV
LABELV $247
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
NEI4 $257
line 406
;405:		// find the center obelisk
;406:		c = "team_neutralobelisk";
ADDRLP4 20
ADDRGP4 $260
ASGNP4
line 407
;407:	} else {
ADDRGP4 $258
JUMPV
LABELV $257
line 410
;408:#endif
;409:	// find the flag
;410:	switch (attacker->client->sess.sessionTeam) {
ADDRLP4 88
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 1
EQI4 $264
ADDRLP4 88
INDIRI4
CNSTI4 2
EQI4 $266
ADDRGP4 $201
JUMPV
LABELV $264
line 412
;411:	case TEAM_RED:
;412:		c = "team_CTF_redflag";
ADDRLP4 20
ADDRGP4 $265
ASGNP4
line 413
;413:		break;
ADDRGP4 $262
JUMPV
LABELV $266
line 415
;414:	case TEAM_BLUE:
;415:		c = "team_CTF_blueflag";
ADDRLP4 20
ADDRGP4 $267
ASGNP4
line 416
;416:		break;		
line 418
;417:	default:
;418:		return;
LABELV $262
line 421
;419:	}
;420:	// find attacker's team's flag carrier
;421:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $271
JUMPV
LABELV $268
line 422
;422:		carrier = g_entities + i;
ADDRLP4 12
ADDRLP4 4
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 423
;423:		if (carrier->inuse && carrier->client->ps.powerups[flag_pw])
ADDRLP4 12
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $273
ADDRLP4 36
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $273
line 424
;424:			break;
ADDRGP4 $270
JUMPV
LABELV $273
line 425
;425:		carrier = NULL;
ADDRLP4 12
CNSTP4 0
ASGNP4
line 426
;426:	}
LABELV $269
line 421
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $271
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $268
LABELV $270
line 428
;427:#ifdef MISSIONPACK
;428:	}
LABELV $258
LABELV $248
line 430
;429:#endif
;430:	flag = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $276
JUMPV
LABELV $275
line 431
;431:	while ((flag = G_Find (flag, FOFS(classname), c)) != NULL) {
line 432
;432:		if (!(flag->flags & FL_DROPPED_ITEM))
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $278
line 433
;433:			break;
ADDRGP4 $277
JUMPV
LABELV $278
line 434
;434:	}
LABELV $276
line 431
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 88
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 88
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $275
LABELV $277
line 436
;435:
;436:	if (!flag)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $280
line 437
;437:		return; // can't find attacker's flag
ADDRGP4 $201
JUMPV
LABELV $280
line 442
;438:
;439:	// ok we have the attackers flag and a pointer to the carrier
;440:
;441:	// check to see if we are defending the base's flag
;442:	VectorSubtract(targ->r.currentOrigin, flag->r.currentOrigin, v1);
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 92
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 92
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+8
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
SUBF4
ASGNF4
line 443
;443:	VectorSubtract(attacker->r.currentOrigin, flag->r.currentOrigin, v2);
ADDRLP4 100
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 40
ADDRLP4 100
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 40+4
ADDRLP4 100
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 40+8
ADDRFP4 8
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
SUBF4
ASGNF4
line 445
;444:
;445:	if ( ( ( VectorLength(v1) < CTF_TARGET_PROTECT_RADIUS &&
ADDRLP4 24
ARGP4
ADDRLP4 108
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 108
INDIRF4
CNSTF4 1148846080
GEF4 $289
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 112
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
NEI4 $288
LABELV $289
ADDRLP4 40
ARGP4
ADDRLP4 116
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 116
INDIRF4
CNSTF4 1148846080
GEF4 $286
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 120
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
EQI4 $286
LABELV $288
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
EQI4 $286
line 449
;446:		trap_InPVS(flag->r.currentOrigin, targ->r.currentOrigin ) ) ||
;447:		( VectorLength(v2) < CTF_TARGET_PROTECT_RADIUS &&
;448:		trap_InPVS(flag->r.currentOrigin, attacker->r.currentOrigin ) ) ) &&
;449:		attacker->client->sess.sessionTeam != targ->client->sess.sessionTeam) {
line 452
;450:
;451:		// we defended the base flag
;452:		AddScore(attacker, targ->r.currentOrigin, CTF_FLAG_DEFENSE_BONUS);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 453
;453:		attacker->client->pers.teamState.basedefense++;
ADDRLP4 124
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 564
ADDP4
ASGNP4
ADDRLP4 124
INDIRP4
ADDRLP4 124
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 455
;454:
;455:		attacker->client->ps.persistant[PERS_DEFEND_COUNT]++;
ADDRLP4 128
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 292
ADDP4
ASGNP4
ADDRLP4 128
INDIRP4
ADDRLP4 128
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 457
;456:		// add the sprite over the player's head
;457:		attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 132
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 132
INDIRP4
ADDRLP4 132
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 458
;458:		attacker->client->ps.eFlags |= EF_AWARD_DEFEND;
ADDRLP4 136
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 136
INDIRP4
ADDRLP4 136
INDIRP4
INDIRI4
CNSTI4 65536
BORI4
ASGNI4
line 459
;459:		attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 752
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 461
;460:
;461:		return;
ADDRGP4 $201
JUMPV
LABELV $286
line 464
;462:	}
;463:
;464:	if (carrier && carrier != attacker) {
ADDRLP4 124
ADDRLP4 12
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 124
INDIRU4
CNSTU4 0
EQU4 $291
ADDRLP4 124
INDIRU4
ADDRFP4 8
INDIRP4
CVPU4 4
EQU4 $291
line 465
;465:		VectorSubtract(targ->r.currentOrigin, carrier->r.currentOrigin, v1);
ADDRLP4 128
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 128
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 128
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+8
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
SUBF4
ASGNF4
line 466
;466:		VectorSubtract(attacker->r.currentOrigin, carrier->r.currentOrigin, v1);
ADDRLP4 136
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 136
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 136
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+8
ADDRFP4 8
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
SUBF4
ASGNF4
line 468
;467:
;468:		if ( ( ( VectorLength(v1) < CTF_ATTACKER_PROTECT_RADIUS &&
ADDRLP4 24
ARGP4
ADDRLP4 144
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 144
INDIRF4
CNSTF4 1148846080
GEF4 $300
ADDRLP4 12
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 148
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $299
LABELV $300
ADDRLP4 40
ARGP4
ADDRLP4 152
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 152
INDIRF4
CNSTF4 1148846080
GEF4 $297
ADDRLP4 12
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 156
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $297
LABELV $299
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
EQI4 $297
line 472
;469:			trap_InPVS(carrier->r.currentOrigin, targ->r.currentOrigin ) ) ||
;470:			( VectorLength(v2) < CTF_ATTACKER_PROTECT_RADIUS &&
;471:				trap_InPVS(carrier->r.currentOrigin, attacker->r.currentOrigin ) ) ) &&
;472:			attacker->client->sess.sessionTeam != targ->client->sess.sessionTeam) {
line 473
;473:			AddScore(attacker, targ->r.currentOrigin, CTF_CARRIER_PROTECT_BONUS);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 474
;474:			attacker->client->pers.teamState.carrierdefense++;
ADDRLP4 160
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 568
ADDP4
ASGNP4
ADDRLP4 160
INDIRP4
ADDRLP4 160
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 476
;475:
;476:			attacker->client->ps.persistant[PERS_DEFEND_COUNT]++;
ADDRLP4 164
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 292
ADDP4
ASGNP4
ADDRLP4 164
INDIRP4
ADDRLP4 164
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 478
;477:			// add the sprite over the player's head
;478:			attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 168
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
ADDRLP4 168
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 479
;479:			attacker->client->ps.eFlags |= EF_AWARD_DEFEND;
ADDRLP4 172
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 172
INDIRP4
ADDRLP4 172
INDIRP4
INDIRI4
CNSTI4 65536
BORI4
ASGNI4
line 480
;480:			attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 752
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 482
;481:
;482:			return;
LABELV $297
line 484
;483:		}
;484:	}
LABELV $291
line 485
;485:}
LABELV $201
endproc Team_FragBonuses 176 16
export Team_CheckHurtCarrier
proc Team_CheckHurtCarrier 12 0
line 497
;486:
;487:
;488:/*
;489:================
;490:Team_CheckHurtCarrier
;491:
;492:Check to see if attacker hurt the flag carrier.  Needed when handing out bonuses for assistance to flag
;493:carrier defense.
;494:================
;495:*/
;496:void Team_CheckHurtCarrier(gentity_t *targ, gentity_t *attacker)
;497:{
line 500
;498:	int flag_pw;
;499:
;500:	if (!targ->client || !attacker->client)
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $305
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $303
LABELV $305
line 501
;501:		return;
ADDRGP4 $302
JUMPV
LABELV $303
line 503
;502:
;503:	if (targ->client->sess.sessionTeam == TEAM_RED)
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 1
NEI4 $306
line 504
;504:		flag_pw = PW_BLUEFLAG;
ADDRLP4 0
CNSTI4 8
ASGNI4
ADDRGP4 $307
JUMPV
LABELV $306
line 506
;505:	else
;506:		flag_pw = PW_REDFLAG;
ADDRLP4 0
CNSTI4 7
ASGNI4
LABELV $307
line 509
;507:
;508:	// flags
;509:	if (targ->client->ps.powerups[flag_pw] &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $308
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
EQI4 $308
line 511
;510:		targ->client->sess.sessionTeam != attacker->client->sess.sessionTeam)
;511:		attacker->client->pers.teamState.lasthurtcarrier = level.time;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 584
ADDP4
ADDRGP4 level+32
INDIRI4
CVIF4 4
ASGNF4
LABELV $308
line 514
;512:
;513:	// skulls
;514:	if (targ->client->ps.generic1 &&
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
CNSTI4 0
EQI4 $311
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
EQI4 $311
line 516
;515:		targ->client->sess.sessionTeam != attacker->client->sess.sessionTeam)
;516:		attacker->client->pers.teamState.lasthurtcarrier = level.time;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 584
ADDP4
ADDRGP4 level+32
INDIRI4
CVIF4 4
ASGNF4
LABELV $311
line 517
;517:}
LABELV $302
endproc Team_CheckHurtCarrier 12 0
proc Team_ResetFlag 24 12
line 520
;518:
;519:
;520:static gentity_t *Team_ResetFlag( team_t team ) {
line 522
;521:	char *c;
;522:	gentity_t *ent, *rent = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 524
;523:
;524:	switch (team) {
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $320
ADDRLP4 12
INDIRI4
CNSTI4 1
EQI4 $318
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $319
ADDRGP4 $315
JUMPV
LABELV $318
line 526
;525:	case TEAM_RED:
;526:		c = "team_CTF_redflag";
ADDRLP4 4
ADDRGP4 $265
ASGNP4
line 527
;527:		break;
ADDRGP4 $316
JUMPV
LABELV $319
line 529
;528:	case TEAM_BLUE:
;529:		c = "team_CTF_blueflag";
ADDRLP4 4
ADDRGP4 $267
ASGNP4
line 530
;530:		break;
ADDRGP4 $316
JUMPV
LABELV $320
line 532
;531:	case TEAM_FREE:
;532:		c = "team_CTF_neutralflag";
ADDRLP4 4
ADDRGP4 $321
ASGNP4
line 533
;533:		break;
ADDRGP4 $316
JUMPV
LABELV $315
line 535
;534:	default:
;535:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $314
JUMPV
LABELV $316
line 538
;536:	}
;537:
;538:	ent = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $323
JUMPV
LABELV $322
line 539
;539:	while ((ent = G_Find (ent, FOFS(classname), c)) != NULL) {
line 540
;540:		if (ent->flags & FL_DROPPED_ITEM)
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $325
line 541
;541:			G_FreeEntity(ent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
ADDRGP4 $326
JUMPV
LABELV $325
line 542
;542:		else {
line 543
;543:			rent = ent;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
line 544
;544:			RespawnItem(ent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RespawnItem
CALLV
pop
line 545
;545:		}
LABELV $326
line 546
;546:	}
LABELV $323
line 539
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $322
line 548
;547:
;548:	Team_SetFlagStatus( team, FLAG_ATBASE );
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 550
;549:
;550:	return rent;
ADDRLP4 8
INDIRP4
RETP4
LABELV $314
endproc Team_ResetFlag 24 12
export Team_ResetFlags
proc Team_ResetFlags 0 4
line 554
;551:}
;552:
;553:
;554:void Team_ResetFlags( void ) {
line 555
;555:	if( g_gametype.integer == GT_CTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $328
line 556
;556:		Team_ResetFlag( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 Team_ResetFlag
CALLP4
pop
line 557
;557:		Team_ResetFlag( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 Team_ResetFlag
CALLP4
pop
line 558
;558:	}
ADDRGP4 $329
JUMPV
LABELV $328
line 560
;559:#ifdef MISSIONPACK
;560:	else if( g_gametype.integer == GT_1FCTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
NEI4 $331
line 561
;561:		Team_ResetFlag( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 Team_ResetFlag
CALLP4
pop
line 562
;562:	}
LABELV $331
LABELV $329
line 564
;563:#endif
;564:}
LABELV $327
endproc Team_ResetFlags 0 4
proc Team_ReturnFlagSound 12 8
line 567
;565:
;566:
;567:static void Team_ReturnFlagSound( gentity_t *ent, team_t team ) {
line 570
;568:	gentity_t	*te;
;569:
;570:	if (ent == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $335
line 571
;571:		G_Printf ("Warning:  NULL passed to Team_ReturnFlagSound\n");
ADDRGP4 $337
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 572
;572:		return;
ADDRGP4 $334
JUMPV
LABELV $335
line 575
;573:	}
;574:
;575:	te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_TEAM_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 576
;576:	if( team == TEAM_BLUE ) {
ADDRFP4 4
INDIRI4
CNSTI4 2
NEI4 $338
line 577
;577:		te->s.eventParm = GTS_RED_RETURN;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 2
ASGNI4
line 578
;578:	}
ADDRGP4 $339
JUMPV
LABELV $338
line 579
;579:	else {
line 580
;580:		te->s.eventParm = GTS_BLUE_RETURN;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 3
ASGNI4
line 581
;581:	}
LABELV $339
line 582
;582:	te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 583
;583:}
LABELV $334
endproc Team_ReturnFlagSound 12 8
proc Team_TakeFlagSound 20 8
line 586
;584:
;585:
;586:static void Team_TakeFlagSound( gentity_t *ent, team_t team ) {
line 589
;587:	gentity_t	*te;
;588:
;589:	if ( ent == NULL ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $341
line 590
;590:		G_Printf( "Warning:  NULL passed to Team_TakeFlagSound\n" );
ADDRGP4 $343
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 591
;591:		return;
ADDRGP4 $340
JUMPV
LABELV $341
line 596
;592:	}
;593:
;594:	// only play sound when the flag was at the base
;595:	// or not picked up the last 10 seconds
;596:	switch ( team ) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $347
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $357
ADDRGP4 $340
JUMPV
LABELV $347
line 598
;597:		case TEAM_RED:
;598:			if( teamgame.blueStatus != FLAG_ATBASE ) {
ADDRGP4 teamgame+12
INDIRI4
CNSTI4 0
EQI4 $348
line 599
;599:				if (teamgame.blueTakenTime > level.time - 10000)
ADDRGP4 teamgame+24
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
SUBI4
LEI4 $351
line 600
;600:					return;
ADDRGP4 $340
JUMPV
LABELV $351
line 601
;601:			}
LABELV $348
line 602
;602:			teamgame.blueTakenTime = level.time;
ADDRGP4 teamgame+24
ADDRGP4 level+32
INDIRI4
ASGNI4
line 603
;603:			break;
ADDRGP4 $345
JUMPV
LABELV $357
line 606
;604:
;605:		case TEAM_BLUE:	// CTF
;606:			if( teamgame.redStatus != FLAG_ATBASE ) {
ADDRGP4 teamgame+8
INDIRI4
CNSTI4 0
EQI4 $358
line 607
;607:				if (teamgame.redTakenTime > level.time - 10000)
ADDRGP4 teamgame+20
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
SUBI4
LEI4 $361
line 608
;608:					return;
ADDRGP4 $340
JUMPV
LABELV $361
line 609
;609:			}
LABELV $358
line 610
;610:			teamgame.redTakenTime = level.time;
ADDRGP4 teamgame+20
ADDRGP4 level+32
INDIRI4
ASGNI4
line 611
;611:			break;
line 614
;612:
;613:		default:
;614:			return;
LABELV $345
line 617
;615:	}
;616:
;617:	te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_TEAM_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 12
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 618
;618:	if( team == TEAM_BLUE ) {
ADDRFP4 4
INDIRI4
CNSTI4 2
NEI4 $367
line 619
;619:		te->s.eventParm = GTS_RED_TAKEN;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 4
ASGNI4
line 620
;620:	}
ADDRGP4 $368
JUMPV
LABELV $367
line 621
;621:	else {
line 622
;622:		te->s.eventParm = GTS_BLUE_TAKEN;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 5
ASGNI4
line 623
;623:	}
LABELV $368
line 624
;624:	te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 625
;625:}
LABELV $340
endproc Team_TakeFlagSound 20 8
proc Team_CaptureFlagSound 12 8
line 628
;626:
;627:
;628:static void Team_CaptureFlagSound( gentity_t *ent, team_t team ) {
line 631
;629:	gentity_t	*te;
;630:
;631:	if (ent == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $370
line 632
;632:		G_Printf ("Warning:  NULL passed to Team_CaptureFlagSound\n");
ADDRGP4 $372
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 633
;633:		return;
ADDRGP4 $369
JUMPV
LABELV $370
line 636
;634:	}
;635:
;636:	te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_TEAM_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 637
;637:	if( team == TEAM_BLUE ) {
ADDRFP4 4
INDIRI4
CNSTI4 2
NEI4 $373
line 638
;638:		te->s.eventParm = GTS_BLUE_CAPTURE;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 1
ASGNI4
line 639
;639:	}
ADDRGP4 $374
JUMPV
LABELV $373
line 640
;640:	else {
line 641
;641:		te->s.eventParm = GTS_RED_CAPTURE;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 0
ASGNI4
line 642
;642:	}
LABELV $374
line 643
;643:	te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 644
;644:}
LABELV $369
endproc Team_CaptureFlagSound 12 8
export Team_ReturnFlag
proc Team_ReturnFlag 8 12
line 647
;645:
;646:
;647:void Team_ReturnFlag( team_t team ) {
line 648
;648:	Team_ReturnFlagSound(Team_ResetFlag(team), team);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 Team_ResetFlag
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 Team_ReturnFlagSound
CALLV
pop
line 649
;649:	if( team == TEAM_FREE ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $376
line 650
;650:		PrintMsg(NULL, "The flag has returned!\n" );
CNSTP4 0
ARGP4
ADDRGP4 $378
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 651
;651:	}
ADDRGP4 $377
JUMPV
LABELV $376
line 652
;652:	else {
line 653
;653:		PrintMsg(NULL, "The %s flag has returned!\n", TeamName(team));
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $379
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 654
;654:	}
LABELV $377
line 655
;655:}
LABELV $375
endproc Team_ReturnFlag 8 12
export Team_FreeEntity
proc Team_FreeEntity 0 4
line 658
;656:
;657:
;658:void Team_FreeEntity( gentity_t *ent ) {
line 659
;659:	if( ent->item->giTag == PW_REDFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $381
line 660
;660:		Team_ReturnFlag( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 661
;661:	}
ADDRGP4 $382
JUMPV
LABELV $381
line 662
;662:	else if( ent->item->giTag == PW_BLUEFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $383
line 663
;663:		Team_ReturnFlag( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 664
;664:	}
ADDRGP4 $384
JUMPV
LABELV $383
line 665
;665:	else if( ent->item->giTag == PW_NEUTRALFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 9
NEI4 $385
line 666
;666:		Team_ReturnFlag( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 667
;667:	}
LABELV $385
LABELV $384
LABELV $382
line 668
;668:}
LABELV $380
endproc Team_FreeEntity 0 4
export Team_DroppedFlagThink
proc Team_DroppedFlagThink 8 8
line 680
;669:
;670:
;671:/*
;672:==============
;673:Team_DroppedFlagThink
;674:
;675:Automatically set in Launch_Item if the item is one of the flags
;676:
;677:Flags are unique in that if they are dropped, the base flag must be respawned when they time out
;678:==============
;679:*/
;680:void Team_DroppedFlagThink(gentity_t *ent) {
line 681
;681:	int		team = TEAM_FREE;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 683
;682:
;683:	if( ent->item->giTag == PW_REDFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $388
line 684
;684:		team = TEAM_RED;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 685
;685:	}
ADDRGP4 $389
JUMPV
LABELV $388
line 686
;686:	else if( ent->item->giTag == PW_BLUEFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $390
line 687
;687:		team = TEAM_BLUE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 688
;688:	}
ADDRGP4 $391
JUMPV
LABELV $390
line 689
;689:	else if( ent->item->giTag == PW_NEUTRALFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 9
NEI4 $392
line 690
;690:		team = TEAM_FREE;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 691
;691:	}
LABELV $392
LABELV $391
LABELV $389
line 693
;692:
;693:	Team_ReturnFlagSound( Team_ResetFlag( team ), team );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 Team_ResetFlag
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Team_ReturnFlagSound
CALLV
pop
line 695
;694:	// Reset Flag will delete this entity
;695:}
LABELV $387
endproc Team_DroppedFlagThink 8 8
proc Team_TouchOurFlag 260 32
line 703
;696:
;697:
;698:/*
;699:==============
;700:Team_DroppedFlagThink
;701:==============
;702:*/
;703:static int Team_TouchOurFlag( gentity_t *ent, gentity_t *other, team_t team ) {
line 706
;704:	int			i;
;705:	gentity_t	*player, *tent;
;706:	gclient_t	*cl = other->client;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 713
;707:	int			enemy_flag;
;708:#ifdef MISSIONPACK
;709:	vec3_t	origin, angles;
;710:#endif
;711:
;712:#ifdef MISSIONPACK
;713:	if( g_gametype.integer == GT_1FCTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
NEI4 $395
line 714
;714:		enemy_flag = PW_NEUTRALFLAG;
ADDRLP4 12
CNSTI4 9
ASGNI4
line 715
;715:	}
ADDRGP4 $396
JUMPV
LABELV $395
line 716
;716:	else {
line 718
;717:#endif
;718:	if (cl->sess.sessionTeam == TEAM_RED) {
ADDRLP4 8
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 1
NEI4 $398
line 719
;719:		enemy_flag = PW_BLUEFLAG;
ADDRLP4 12
CNSTI4 8
ASGNI4
line 720
;720:	} else {
ADDRGP4 $399
JUMPV
LABELV $398
line 721
;721:		enemy_flag = PW_REDFLAG;
ADDRLP4 12
CNSTI4 7
ASGNI4
line 722
;722:	}
LABELV $399
line 724
;723:
;724:	if ( ent->flags & FL_DROPPED_ITEM ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $400
line 726
;725:		// hey, its not home.  return it by teleporting it back
;726:		PrintMsg( NULL, "%s" S_COLOR_WHITE " returned the %s flag!\n", 
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $402
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 728
;727:			cl->pers.netname, TeamName(team));
;728:		AddScore(other, ent->r.currentOrigin, CTF_RECOVERY_BONUS);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 729
;729:		other->client->pers.teamState.flagrecovery++;
ADDRLP4 48
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 572
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 730
;730:		other->client->pers.teamState.lastreturnedflag = level.time;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 588
ADDP4
ADDRGP4 level+32
INDIRI4
CVIF4 4
ASGNF4
line 732
;731:		//ResetFlag will remove this entity!  We must return zero
;732:		Team_ReturnFlagSound(Team_ResetFlag(team), team);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 Team_ResetFlag
CALLP4
ASGNP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Team_ReturnFlagSound
CALLV
pop
line 733
;733:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $394
JUMPV
LABELV $400
line 736
;734:	}
;735:#ifdef MISSIONPACK
;736:	}
LABELV $396
line 741
;737:#endif
;738:
;739:	// the flag is at home base.  if the player has the enemy
;740:	// flag, he's just won!
;741:	if (!cl->ps.powerups[enemy_flag])
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $404
line 742
;742:		return 0; // We don't have the flag
CNSTI4 0
RETI4
ADDRGP4 $394
JUMPV
LABELV $404
line 744
;743:#ifdef MISSIONPACK
;744:	if( g_gametype.integer == GT_1FCTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
NEI4 $406
line 745
;745:		PrintMsg( NULL, "%s" S_COLOR_WHITE " captured the flag!\n", cl->pers.netname );
CNSTP4 0
ARGP4
ADDRGP4 $409
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 746
;746:	}
ADDRGP4 $407
JUMPV
LABELV $406
line 747
;747:	else {
line 749
;748:#endif
;749:	PrintMsg( NULL, "%s" S_COLOR_WHITE " captured the %s flag!\n", cl->pers.netname, TeamName(OtherTeam(team)));
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $410
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 751
;750:#ifdef MISSIONPACK
;751:	}
LABELV $407
line 754
;752:#endif
;753:
;754:	cl->ps.powerups[enemy_flag] = 0;
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 312
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 756
;755:
;756:	teamgame.last_flag_capture = level.time;
ADDRGP4 teamgame
ADDRGP4 level+32
INDIRI4
CVIF4 4
ASGNF4
line 757
;757:	teamgame.last_capture_team = team;
ADDRGP4 teamgame+4
ADDRFP4 8
INDIRI4
ASGNI4
line 760
;758:
;759:#ifdef MISSIONPACK
;760:	if( g_gametype.integer == GT_1FCTF && g_1FRespawn.integer ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
NEI4 $413
ADDRGP4 g_1FRespawn+12
INDIRI4
CNSTI4 0
EQI4 $413
line 761
;761:		qboolean backup_god = qfalse;
ADDRLP4 44
CNSTI4 0
ASGNI4
line 762
;762:		int backup_weapon = WP_NONE, backup_persist = 0, backup_portal = 0;
ADDRLP4 48
CNSTI4 0
ASGNI4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 56
CNSTI4 0
ASGNI4
line 765
;763:		int backup_stats[MAX_STATS], backup_ammo[MAX_WEAPONS], backup_powerups[MAX_POWERUPS];
;764:
;765:		tent = G_TempEntity( cl->ps.origin, EV_PLAYER_TELEPORT_OUT );
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 43
ARGI4
ADDRLP4 252
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 252
INDIRP4
ASGNP4
line 766
;766:		tent->s.clientNum = other->s.clientNum;
ADDRLP4 16
INDIRP4
CNSTI4 168
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 767
;767:		G_GenericDeathCleanup(other);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 G_GenericDeathCleanup
CALLV
pop
line 768
;768:		ClientBackupStats(other, &backup_weapon, &backup_god, &backup_persist, &backup_portal, backup_stats, backup_ammo, backup_powerups);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 48
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 60
ARGP4
ADDRLP4 124
ARGP4
ADDRLP4 188
ARGP4
ADDRGP4 ClientBackupStats
CALLV
pop
line 769
;769:		ClientSpawn(other);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 ClientSpawn
CALLV
pop
line 770
;770:		ClientRestoreStats(other, &backup_weapon, &backup_god, &backup_persist, &backup_portal, backup_stats, backup_ammo, backup_powerups);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 48
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 60
ARGP4
ADDRLP4 124
ARGP4
ADDRLP4 188
ARGP4
ADDRGP4 ClientRestoreStats
CALLV
pop
line 771
;771:		tent = G_TempEntity( cl->ps.origin, EV_PLAYER_TELEPORT_IN );
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 42
ARGI4
ADDRLP4 256
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 256
INDIRP4
ASGNP4
line 772
;772:		tent->s.clientNum = other->s.clientNum;
ADDRLP4 16
INDIRP4
CNSTI4 168
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 773
;773:	}
LABELV $413
line 777
;774:#endif
;775:
;776:	// Increase the team's score
;777:	AddTeamScore(ent->s.pos.trBase, other->client->sess.sessionTeam, 1);
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 AddTeamScore
CALLV
pop
line 778
;778:	Team_ForceGesture(other->client->sess.sessionTeam);
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ARGI4
ADDRGP4 Team_ForceGesture
CALLV
pop
line 780
;779:
;780:	other->client->pers.teamState.captures++;
ADDRLP4 44
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 560
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 782
;781:	// add the sprite over the player's head
;782:	other->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 48
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 783
;783:	other->client->ps.eFlags |= EF_AWARD_CAP;
ADDRLP4 52
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 784
;784:	other->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 752
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 785
;785:	other->client->ps.persistant[PERS_CAPTURES]++;
ADDRLP4 56
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 304
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 788
;786:
;787:	// other gets another 10 frag bonus
;788:	AddScore(other, ent->r.currentOrigin, CTF_CAPTURE_BONUS);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 100
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 790
;789:
;790:	Team_CaptureFlagSound( ent, team );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Team_CaptureFlagSound
CALLV
pop
line 793
;791:
;792:	// Ok, let's do the player loop, hand out the bonuses
;793:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $421
JUMPV
LABELV $418
line 794
;794:		player = &g_entities[i];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 795
;795:		if (!player->inuse || player == other)
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $425
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $423
LABELV $425
line 796
;796:			continue;
ADDRGP4 $419
JUMPV
LABELV $423
line 798
;797:
;798:		if (player->client->sess.sessionTeam !=
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
EQI4 $426
line 799
;799:			cl->sess.sessionTeam) {
line 800
;800:			player->client->pers.teamState.lasthurtcarrier = -5;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 584
ADDP4
CNSTF4 3231711232
ASGNF4
line 801
;801:		} else {
ADDRGP4 $427
JUMPV
LABELV $426
line 803
;802:#ifdef MISSIONPACK
;803:				AddScore(player, ent->r.currentOrigin, CTF_TEAM_BONUS);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 25
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 806
;804:#endif
;805:			// award extra points for capture assists
;806:			if (player->client->pers.teamState.lastreturnedflag + 
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 588
ADDP4
INDIRF4
CNSTF4 1176256512
ADDF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LEF4 $428
line 807
;807:				CTF_RETURN_FLAG_ASSIST_TIMEOUT > level.time) {
line 808
;808:				AddScore (player, ent->r.currentOrigin, CTF_RETURN_FLAG_ASSIST_BONUS);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 809
;809:				other->client->pers.teamState.assists++;
ADDRLP4 64
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 580
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 811
;810:
;811:				player->client->ps.persistant[PERS_ASSIST_COUNT]++;
ADDRLP4 68
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 813
;812:				// add the sprite over the player's head
;813:				player->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 72
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 814
;814:				player->client->ps.eFlags |= EF_AWARD_ASSIST;
ADDRLP4 76
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 131072
BORI4
ASGNI4
line 815
;815:				player->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 752
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 817
;816:
;817:			} 
LABELV $428
line 818
;818:			if (player->client->pers.teamState.lastfraggedcarrier + 
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 596
ADDP4
INDIRF4
CNSTF4 1176256512
ADDF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LEF4 $432
line 819
;819:				CTF_FRAG_CARRIER_ASSIST_TIMEOUT > level.time) {
line 820
;820:				AddScore(player, ent->r.currentOrigin, CTF_FRAG_CARRIER_ASSIST_BONUS);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 821
;821:				other->client->pers.teamState.assists++;
ADDRLP4 64
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 580
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 822
;822:				player->client->ps.persistant[PERS_ASSIST_COUNT]++;
ADDRLP4 68
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 824
;823:				// add the sprite over the player's head
;824:				player->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 72
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 825
;825:				player->client->ps.eFlags |= EF_AWARD_ASSIST;
ADDRLP4 76
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 131072
BORI4
ASGNI4
line 826
;826:				player->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 752
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 827
;827:			}
LABELV $432
line 828
;828:		}
LABELV $427
line 829
;829:	}
LABELV $419
line 793
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $421
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $418
line 830
;830:	Team_ResetFlags();
ADDRGP4 Team_ResetFlags
CALLV
pop
line 832
;831:
;832:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 834
;833:
;834:	return 0; // Do not respawn this automatically
CNSTI4 0
RETI4
LABELV $394
endproc Team_TouchOurFlag 260 32
proc Team_TouchEnemyFlag 8 16
line 838
;835:}
;836:
;837:
;838:static int Team_TouchEnemyFlag( gentity_t *ent, gentity_t *other, team_t team ) {
line 839
;839:	gclient_t *cl = other->client;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 842
;840:
;841:#ifdef MISSIONPACK
;842:	if( g_gametype.integer == GT_1FCTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
NEI4 $437
line 843
;843:		PrintMsg (NULL, "%s" S_COLOR_WHITE " got the flag!\n", other->client->pers.netname );
CNSTP4 0
ARGP4
ADDRGP4 $440
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 845
;844:
;845:		cl->ps.powerups[PW_NEUTRALFLAG] = INT_MAX; // flags never expire
ADDRLP4 0
INDIRP4
CNSTI4 348
ADDP4
CNSTI4 2147483647
ASGNI4
line 847
;846:
;847:		if( team == TEAM_RED ) {
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $441
line 848
;848:			Team_SetFlagStatus( TEAM_FREE, FLAG_TAKEN_RED );
CNSTI4 0
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 849
;849:		}
ADDRGP4 $438
JUMPV
LABELV $441
line 850
;850:		else {
line 851
;851:			Team_SetFlagStatus( TEAM_FREE, FLAG_TAKEN_BLUE );
CNSTI4 0
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 852
;852:		}
line 853
;853:	}
ADDRGP4 $438
JUMPV
LABELV $437
line 854
;854:	else{
line 856
;855:#endif
;856:		PrintMsg (NULL, "%s" S_COLOR_WHITE " got the %s flag!\n",
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $443
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 859
;857:			other->client->pers.netname, TeamName(team));
;858:
;859:		if (team == TEAM_RED)
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $444
line 860
;860:			cl->ps.powerups[PW_REDFLAG] = INT_MAX; // flags never expire
ADDRLP4 0
INDIRP4
CNSTI4 340
ADDP4
CNSTI4 2147483647
ASGNI4
ADDRGP4 $445
JUMPV
LABELV $444
line 862
;861:		else
;862:			cl->ps.powerups[PW_BLUEFLAG] = INT_MAX; // flags never expire
ADDRLP4 0
INDIRP4
CNSTI4 344
ADDP4
CNSTI4 2147483647
ASGNI4
LABELV $445
line 864
;863:
;864:		Team_SetFlagStatus( team, FLAG_TAKEN );
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 866
;865:#ifdef MISSIONPACK
;866:	}
LABELV $438
line 868
;867:
;868:	AddScore(other, ent->r.currentOrigin, CTF_FLAG_BONUS);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 870
;869:#endif
;870:	cl->pers.teamState.flagsince = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 592
ADDP4
ADDRGP4 level+32
INDIRI4
CVIF4 4
ASGNF4
line 871
;871:	Team_TakeFlagSound( ent, team );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Team_TakeFlagSound
CALLV
pop
line 873
;872:
;873:	return -1; // Do not respawn this automatically, but do delete it if it was FL_DROPPED
CNSTI4 -1
RETI4
LABELV $436
endproc Team_TouchEnemyFlag 8 16
export Pickup_Team
proc Pickup_Team 24 12
line 877
;874:}
;875:
;876:
;877:int Pickup_Team( gentity_t *ent, gentity_t *other ) {
line 879
;878:	int team;
;879:	gclient_t *cl = other->client;
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 882
;880:
;881:#ifdef MISSIONPACK
;882:	if( g_gametype.integer == GT_OBELISK ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 6
NEI4 $448
line 884
;883:		// there are no team items that can be picked up in obelisk
;884:		G_FreeEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 885
;885:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $447
JUMPV
LABELV $448
line 888
;886:	}
;887:
;888:	if( g_gametype.integer == GT_HARVESTER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
NEI4 $451
line 890
;889:		// the only team items that can be picked up in harvester are the cubes
;890:		if( ent->spawnflags != cl->sess.sessionTeam ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
EQI4 $454
line 891
;891:			cl->ps.generic1 += 1;
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 440
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 892
;892:		}
LABELV $454
line 893
;893:		G_FreeEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 894
;894:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $447
JUMPV
LABELV $451
line 898
;895:	}
;896:#endif
;897:	// figure out what team this flag is
;898:	if( strcmp(ent->classname, "team_CTF_redflag") == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $265
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $456
line 899
;899:		team = TEAM_RED;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 900
;900:	}
ADDRGP4 $457
JUMPV
LABELV $456
line 901
;901:	else if( strcmp(ent->classname, "team_CTF_blueflag") == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $267
ARGP4
ADDRLP4 12
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $458
line 902
;902:		team = TEAM_BLUE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 903
;903:	}
ADDRGP4 $459
JUMPV
LABELV $458
line 905
;904:#ifdef MISSIONPACK
;905:	else if( strcmp(ent->classname, "team_CTF_neutralflag") == 0  ) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $321
ARGP4
ADDRLP4 16
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $460
line 906
;906:		team = TEAM_FREE;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 907
;907:	}
ADDRGP4 $461
JUMPV
LABELV $460
line 909
;908:#endif
;909:	else {
line 910
;910:		PrintMsg ( other, "Don't know what team the flag is on.\n");
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $462
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 911
;911:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $447
JUMPV
LABELV $461
LABELV $459
LABELV $457
line 914
;912:	}
;913:#ifdef MISSIONPACK
;914:	if( g_gametype.integer == GT_1FCTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
NEI4 $463
line 915
;915:		if( team == TEAM_FREE ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $466
line 916
;916:			return Team_TouchEnemyFlag( ent, other, cl->sess.sessionTeam );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 Team_TouchEnemyFlag
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $447
JUMPV
LABELV $466
line 918
;917:		}
;918:		if( team != cl->sess.sessionTeam) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
EQI4 $468
line 919
;919:			return Team_TouchOurFlag( ent, other, cl->sess.sessionTeam );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 Team_TouchOurFlag
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $447
JUMPV
LABELV $468
line 921
;920:		}
;921:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $447
JUMPV
LABELV $463
line 925
;922:	}
;923:#endif
;924:	// GT_CTF
;925:	if( team == cl->sess.sessionTeam) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
NEI4 $470
line 926
;926:		return Team_TouchOurFlag( ent, other, team );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 Team_TouchOurFlag
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $447
JUMPV
LABELV $470
line 928
;927:	}
;928:	return Team_TouchEnemyFlag( ent, other, team );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 Team_TouchEnemyFlag
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
LABELV $447
endproc Pickup_Team 24 12
export Team_GetLocation
proc Team_GetLocation 40 8
line 940
;929:}
;930:
;931:
;932:/*
;933:===========
;934:Team_GetLocation
;935:
;936:Report a location for the player. Uses placed nearby target_location entities
;937:============
;938:*/
;939:gentity_t *Team_GetLocation(gentity_t *ent)
;940:{
line 945
;941:	gentity_t		*eloc, *best;
;942:	float			bestlen, len;
;943:	vec3_t			origin;
;944:
;945:	best = NULL;
ADDRLP4 24
CNSTP4 0
ASGNP4
line 946
;946:	bestlen = 3*8192.0*8192.0;
ADDRLP4 20
CNSTF4 1296039936
ASGNF4
line 948
;947:
;948:	VectorCopy( ent->r.currentOrigin, origin );
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 950
;949:
;950:	for (eloc = level.locationHead; eloc; eloc = eloc->nextTrain) {
ADDRLP4 0
ADDRGP4 level+7648
INDIRP4
ASGNP4
ADDRGP4 $476
JUMPV
LABELV $473
line 951
;951:		len = ( origin[0] - eloc->r.currentOrigin[0] ) * ( origin[0] - eloc->r.currentOrigin[0] )
ADDRLP4 28
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 28
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
SUBF4
ADDRLP4 28
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
SUBF4
MULF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
SUBF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
SUBF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 955
;952:			+ ( origin[1] - eloc->r.currentOrigin[1] ) * ( origin[1] - eloc->r.currentOrigin[1] )
;953:			+ ( origin[2] - eloc->r.currentOrigin[2] ) * ( origin[2] - eloc->r.currentOrigin[2] );
;954:
;955:		if ( len > bestlen ) {
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
LEF4 $482
line 956
;956:			continue;
ADDRGP4 $474
JUMPV
LABELV $482
line 959
;957:		}
;958:
;959:		if ( !trap_InPVS( origin, eloc->r.currentOrigin ) ) {
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $484
line 960
;960:			continue;
ADDRGP4 $474
JUMPV
LABELV $484
line 963
;961:		}
;962:
;963:		bestlen = len;
ADDRLP4 20
ADDRLP4 16
INDIRF4
ASGNF4
line 964
;964:		best = eloc;
ADDRLP4 24
ADDRLP4 0
INDIRP4
ASGNP4
line 965
;965:	}
LABELV $474
line 950
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRP4
ASGNP4
LABELV $476
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $473
line 967
;966:
;967:	return best;
ADDRLP4 24
INDIRP4
RETP4
LABELV $472
endproc Team_GetLocation 40 8
export Team_GetLocationMsg
proc Team_GetLocationMsg 12 24
line 979
;968:}
;969:
;970:
;971:/*
;972:===========
;973:Team_GetLocation
;974:
;975:Report a location for the player. Uses placed nearby target_location entities
;976:============
;977:*/
;978:qboolean Team_GetLocationMsg(gentity_t *ent, char *loc, int loclen)
;979:{
line 982
;980:	gentity_t *best;
;981:
;982:	best = Team_GetLocation( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Team_GetLocation
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 984
;983:	
;984:	if (!best)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $487
line 985
;985:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $486
JUMPV
LABELV $487
line 987
;986:
;987:	if (best->count) {
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $489
line 988
;988:		if (best->count < 0)
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
GEI4 $491
line 989
;989:			best->count = 0;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 0
ASGNI4
LABELV $491
line 990
;990:		if (best->count > 7)
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 7
LEI4 $493
line 991
;991:			best->count = 7;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 7
ASGNI4
LABELV $493
line 992
;992:		Com_sprintf(loc, loclen, "%c%c%s" S_COLOR_WHITE, Q_COLOR_ESCAPE, best->count + '0', best->message );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $495
ARGP4
CNSTI4 94
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 48
ADDI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 993
;993:	} else
ADDRGP4 $490
JUMPV
LABELV $489
line 994
;994:		Com_sprintf(loc, loclen, "%s", best->message);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $496
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
LABELV $490
line 996
;995:
;996:	return qtrue;
CNSTI4 1
RETI4
LABELV $486
endproc Team_GetLocationMsg 12 24
export SelectRandomTeamSpawnPoint
proc SelectRandomTeamSpawnPoint 168 4
line 1010
;997:}
;998:
;999:
;1000:/*---------------------------------------------------------------------------*/
;1001:
;1002:/*
;1003:================
;1004:SelectRandomTeamSpawnPoint
;1005:
;1006:go to a random point that doesn't telefrag
;1007:================
;1008:*/
;1009:#define	MAX_TEAM_SPAWN_POINTS	32
;1010:gentity_t *SelectRandomTeamSpawnPoint( gentity_t *ent, int teamstate, team_t team ) {
line 1020
;1011:	gentity_t	*spot;
;1012:	int			selection;
;1013:	gentity_t	*spots[ MAX_TEAM_SPAWN_POINTS ];
;1014:	int			numSpots;
;1015:	int			checkMask;
;1016:	int			n;
;1017:	qboolean	checkState;
;1018:	qboolean	checkTelefrag;
;1019:
;1020:	if ( team != TEAM_RED && team != TEAM_BLUE )
ADDRLP4 156
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 1
EQI4 $498
ADDRLP4 156
INDIRI4
CNSTI4 2
EQI4 $498
line 1021
;1021:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $497
JUMPV
LABELV $498
line 1023
;1022:
;1023:	checkMask = 3;
ADDRLP4 148
CNSTI4 3
ASGNI4
LABELV $500
line 1027
;1024:
;1025:__rescan:
;1026:
;1027:	checkTelefrag = checkMask & 1;
ADDRLP4 144
ADDRLP4 148
INDIRI4
CNSTI4 1
BANDI4
ASGNI4
line 1028
;1028:	checkState = checkMask & 2;
ADDRLP4 140
ADDRLP4 148
INDIRI4
CNSTI4 2
BANDI4
ASGNI4
line 1029
;1029:	numSpots = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1031
;1030:
;1031:	for ( n = 0 ; n < level.numSpawnSpots ; n++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $504
JUMPV
LABELV $501
line 1032
;1032:		spot = level.spawnSpots[ n ];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+7692
ADDP4
INDIRP4
ASGNP4
line 1033
;1033:		if ( spot->fteam != team )
ADDRLP4 0
INDIRP4
CNSTI4 816
ADDP4
INDIRI4
ADDRFP4 8
INDIRI4
EQI4 $507
line 1034
;1034:			continue;
ADDRGP4 $502
JUMPV
LABELV $507
line 1035
;1035:		if ( checkTelefrag && SpotWouldTelefrag( spot ) )
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $509
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 160
ADDRGP4 SpotWouldTelefrag
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
EQI4 $509
line 1036
;1036:			continue;
ADDRGP4 $502
JUMPV
LABELV $509
line 1037
;1037:		if ( checkState ) {
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $511
line 1038
;1038:			if ( teamstate == TEAM_BEGIN ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $513
line 1039
;1039:				if ( spot->count != 0 )
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $514
line 1040
;1040:					continue;
ADDRGP4 $502
JUMPV
line 1041
;1041:			} else {
LABELV $513
line 1042
;1042:				if ( spot->count == 0 )
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
NEI4 $517
line 1043
;1043:					continue;
ADDRGP4 $502
JUMPV
LABELV $517
line 1044
;1044:			}
LABELV $514
line 1045
;1045:		}
LABELV $511
line 1046
;1046:		spots[ numSpots++ ] = spot;
ADDRLP4 164
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 164
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1047
;1047:		if ( numSpots >= MAX_TEAM_SPAWN_POINTS )
ADDRLP4 8
INDIRI4
CNSTI4 32
LTI4 $519
line 1048
;1048:			break;
ADDRGP4 $503
JUMPV
LABELV $519
line 1049
;1049:	}
LABELV $502
line 1031
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $504
ADDRLP4 4
INDIRI4
ADDRGP4 level+11788
INDIRI4
LTI4 $501
LABELV $503
line 1051
;1050:
;1051:	if ( !numSpots ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $521
line 1052
;1052:		if ( checkMask <= 0 ) {
ADDRLP4 148
INDIRI4
CNSTI4 0
GTI4 $523
line 1053
;1053:			return NULL;
CNSTP4 0
RETP4
ADDRGP4 $497
JUMPV
LABELV $523
line 1055
;1054:		}
;1055:		checkMask--;
ADDRLP4 148
ADDRLP4 148
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1056
;1056:		goto __rescan; // next attempt with different flags
ADDRGP4 $500
JUMPV
LABELV $521
line 1059
;1057:	}
;1058:
;1059:	selection = rand() % numSpots;
ADDRLP4 160
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 152
ADDRLP4 160
INDIRI4
ADDRLP4 8
INDIRI4
MODI4
ASGNI4
line 1060
;1060:	return spots[ selection ];
ADDRLP4 152
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
INDIRP4
RETP4
LABELV $497
endproc SelectRandomTeamSpawnPoint 168 4
export SelectCTFSpawnPoint
proc SelectCTFSpawnPoint 12 16
line 1069
;1061:}
;1062:
;1063:
;1064:/*
;1065:===========
;1066:SelectCTFSpawnPoint
;1067:============
;1068:*/
;1069:gentity_t *SelectCTFSpawnPoint( gentity_t *ent, team_t team, int teamstate, vec3_t origin, vec3_t angles ) {
line 1072
;1070:	gentity_t	*spot;
;1071:
;1072:	spot = SelectRandomTeamSpawnPoint( ent, teamstate, team );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 SelectRandomTeamSpawnPoint
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1074
;1073:
;1074:	if ( !spot ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $526
line 1075
;1075:		return SelectSpawnPoint( ent, vec3_origin, origin, angles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 SelectSpawnPoint
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
RETP4
ADDRGP4 $525
JUMPV
LABELV $526
line 1078
;1076:	}
;1077:
;1078:	VectorCopy( spot->s.origin, origin );
ADDRFP4 12
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1079
;1079:	VectorCopy( spot->s.angles, angles );
ADDRFP4 16
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 1080
;1080:	origin[2] += 9.0f;
ADDRLP4 8
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1091567616
ADDF4
ASGNF4
line 1082
;1081:
;1082:	return spot;
ADDRLP4 0
INDIRP4
RETP4
LABELV $525
endproc SelectCTFSpawnPoint 12 16
proc SortClients 0 0
line 1087
;1083:}
;1084:
;1085:/*---------------------------------------------------------------------------*/
;1086:
;1087:static int QDECL SortClients( const void *a, const void *b ) {
line 1088
;1088:	return *(int *)a - *(int *)b;
ADDRFP4 0
INDIRP4
INDIRI4
ADDRFP4 4
INDIRP4
INDIRI4
SUBI4
RETI4
LABELV $528
endproc SortClients 0 0
export TeamplayInfoMessage
proc TeamplayInfoMessage 1312 32
line 1101
;1089:}
;1090:
;1091:
;1092:/*
;1093:==================
;1094:TeamplayLocationsMessage
;1095:
;1096:Format:
;1097:	clientNum location health armor weapon powerups
;1098:
;1099:==================
;1100:*/
;1101:void TeamplayInfoMessage( gentity_t *ent ) {
line 1111
;1102:	char		entry[ 128 ]; // to fit 6 decimal numbers with spaces
;1103:	char		string[ MAX_STRING_CHARS - 9 ]; // -strlen("tinfo nn ")
;1104:	int			stringlength;
;1105:	int			i, j;
;1106:	gentity_t	*player;
;1107:	int			cnt;
;1108:	int			h, a;
;1109:	int			clients[TEAM_MAXOVERLAY];
;1110:
;1111:	if ( !ent->client->pers.teamInfo )
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 608
ADDP4
INDIRI4
CNSTI4 0
NEI4 $530
line 1112
;1112:		return;
ADDRGP4 $529
JUMPV
LABELV $530
line 1117
;1113:
;1114:	// figure out what client should be on the display
;1115:	// we are limited to 8, but we want to use the top eight players
;1116:	// but in client order (so they don't keep changing position on the overlay)
;1117:	for (i = 0, cnt = 0; i < level.maxclients && cnt < TEAM_MAXOVERLAY; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $535
JUMPV
LABELV $532
line 1118
;1118:		player = g_entities + level.sortedClients[i];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+88
ADDP4
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1119
;1119:		if (player->inuse && player->client->sess.sessionTeam ==
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $538
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
NEI4 $538
line 1120
;1120:			ent->client->sess.sessionTeam ) {
line 1121
;1121:			clients[cnt++] = level.sortedClients[i];
ADDRLP4 1304
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 1304
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1304
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1172
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+88
ADDP4
INDIRI4
ASGNI4
line 1122
;1122:		}
LABELV $538
line 1123
;1123:	}
LABELV $533
line 1117
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $535
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
GEI4 $541
ADDRLP4 8
INDIRI4
CNSTI4 32
LTI4 $532
LABELV $541
line 1126
;1124:
;1125:	// We have the top eight players, sort them by clientNum
;1126:	qsort( clients, cnt, sizeof( clients[0] ), SortClients );
ADDRLP4 1172
ARGP4
ADDRLP4 8
INDIRI4
CVIU4 4
ARGU4
CNSTU4 4
ARGU4
ADDRGP4 SortClients
ARGP4
ADDRGP4 qsort
CALLV
pop
line 1129
;1127:
;1128:	// send the latest information on all clients
;1129:	string[0] = '\0';
ADDRLP4 28
CNSTI1 0
ASGNI1
line 1130
;1130:	stringlength = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 1132
;1131:
;1132:	for (i = 0, cnt = 0; i < level.maxclients && cnt < TEAM_MAXOVERLAY; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $545
JUMPV
LABELV $542
line 1133
;1133:		player = g_entities + i;
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1134
;1134:		if ( player->inuse && player->client->sess.sessionTeam ==
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $547
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
NEI4 $547
line 1135
;1135:			ent->client->sess.sessionTeam ) {
line 1137
;1136:
;1137:			h = player->client->ps.stats[STAT_HEALTH];
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 1138
;1138:			a = player->client->ps.stats[STAT_ARMOR];
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ASGNI4
line 1139
;1139:			if (h < 0) h = 0;
ADDRLP4 12
INDIRI4
CNSTI4 0
GEI4 $549
ADDRLP4 12
CNSTI4 0
ASGNI4
LABELV $549
line 1140
;1140:			if (a < 0) a = 0;
ADDRLP4 16
INDIRI4
CNSTI4 0
GEI4 $551
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $551
line 1142
;1141:
;1142:			j = BG_sprintf( entry, " %i %i %i %i %i %i",
ADDRLP4 1043
ARGP4
ADDRGP4 $553
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ARGI4
ADDRLP4 1308
ADDRGP4 BG_sprintf
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 1308
INDIRI4
ASGNI4
line 1146
;1143://				level.sortedClients[i], player->client->pers.teamState.location, h, a, 
;1144:				i, player->client->pers.teamState.location, h, a, 
;1145:				player->client->ps.weapon, player->s.powerups);
;1146:			if ( stringlength + j >= sizeof( string ) )
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
ADDI4
CVIU4 4
CNSTU4 1015
LTU4 $554
line 1147
;1147:				break;
ADDRGP4 $544
JUMPV
LABELV $554
line 1148
;1148:			strcpy( string + stringlength, entry );
ADDRLP4 20
INDIRI4
ADDRLP4 28
ADDP4
ARGP4
ADDRLP4 1043
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1149
;1149:			stringlength += j;
ADDRLP4 20
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
ADDI4
ASGNI4
line 1150
;1150:			cnt++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1151
;1151:		}
LABELV $547
line 1152
;1152:	}
LABELV $543
line 1132
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $545
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
GEI4 $556
ADDRLP4 8
INDIRI4
CNSTI4 32
LTI4 $542
LABELV $556
LABELV $544
line 1154
;1153:
;1154:	trap_SendServerCommand( ent-g_entities, va( "tinfo %i %s", cnt, string ) );
ADDRGP4 $557
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRLP4 1300
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 824
DIVI4
ARGI4
ADDRLP4 1300
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1155
;1155:}
LABELV $529
endproc TeamplayInfoMessage 1312 32
export CheckTeamStatus
proc CheckTeamStatus 20 4
line 1158
;1156:
;1157:
;1158:void CheckTeamStatus( void ) {
line 1162
;1159:	int i;
;1160:	gentity_t *loc, *ent;
;1161:
;1162:	if (level.time - level.lastTeamLocationTime > TEAM_LOCATION_UPDATE_TIME) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+64
INDIRI4
SUBI4
CNSTI4 1000
LEI4 $559
line 1164
;1163:
;1164:		level.lastTeamLocationTime = level.time;
ADDRGP4 level+64
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1166
;1165:
;1166:		for (i = 0; i < level.maxclients; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $568
JUMPV
LABELV $565
line 1167
;1167:			ent = g_entities + i;
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1169
;1168:
;1169:			if ( ent->client->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $570
line 1170
;1170:				continue;
ADDRGP4 $566
JUMPV
LABELV $570
line 1173
;1171:			}
;1172:
;1173:			if (ent->inuse && (ent->client->sess.sessionTeam == TEAM_RED ||	ent->client->sess.sessionTeam == TEAM_BLUE)) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $572
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 1
EQI4 $574
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 2
NEI4 $572
LABELV $574
line 1174
;1174:				loc = Team_GetLocation( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Team_GetLocation
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
ASGNP4
line 1175
;1175:				if (loc)
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $575
line 1176
;1176:					ent->client->pers.teamState.location = loc->health;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 556
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $576
JUMPV
LABELV $575
line 1178
;1177:				else
;1178:					ent->client->pers.teamState.location = 0;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 0
ASGNI4
LABELV $576
line 1179
;1179:			}
LABELV $572
line 1180
;1180:		}
LABELV $566
line 1166
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $568
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $565
line 1182
;1181:
;1182:		for (i = 0; i < level.maxclients; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $580
JUMPV
LABELV $577
line 1183
;1183:			ent = g_entities + i;
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1185
;1184:
;1185:			if ( ent->client->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $582
line 1186
;1186:				continue;
ADDRGP4 $578
JUMPV
LABELV $582
line 1189
;1187:			}
;1188:
;1189:			if (ent->inuse && (ent->client->sess.sessionTeam == TEAM_RED ||	ent->client->sess.sessionTeam == TEAM_BLUE)) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $584
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 1
EQI4 $586
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 2
NEI4 $584
LABELV $586
line 1190
;1190:				TeamplayInfoMessage( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 TeamplayInfoMessage
CALLV
pop
line 1191
;1191:			}
LABELV $584
line 1192
;1192:		}
LABELV $578
line 1182
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $580
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $577
line 1193
;1193:	}
LABELV $559
line 1194
;1194:}
LABELV $558
endproc CheckTeamStatus 20 4
export SP_team_CTF_redplayer
proc SP_team_CTF_redplayer 0 0
line 1201
;1195:
;1196:/*-----------------------------------------------------------------*/
;1197:
;1198:/*QUAKED team_CTF_redplayer (1 0 0) (-16 -16 -16) (16 16 32)
;1199:Only in CTF games.  Red players spawn here at game start.
;1200:*/
;1201:void SP_team_CTF_redplayer( gentity_t *ent ) {
line 1202
;1202:}
LABELV $587
endproc SP_team_CTF_redplayer 0 0
export SP_team_CTF_blueplayer
proc SP_team_CTF_blueplayer 0 0
line 1208
;1203:
;1204:
;1205:/*QUAKED team_CTF_blueplayer (0 0 1) (-16 -16 -16) (16 16 32)
;1206:Only in CTF games.  Blue players spawn here at game start.
;1207:*/
;1208:void SP_team_CTF_blueplayer( gentity_t *ent ) {
line 1209
;1209:}
LABELV $588
endproc SP_team_CTF_blueplayer 0 0
export SP_team_CTF_redspawn
proc SP_team_CTF_redspawn 0 0
line 1216
;1210:
;1211:
;1212:/*QUAKED team_CTF_redspawn (1 0 0) (-16 -16 -24) (16 16 32)
;1213:potential spawning position for red team in CTF games.
;1214:Targets will be fired when someone spawns in on them.
;1215:*/
;1216:void SP_team_CTF_redspawn(gentity_t *ent) {
line 1217
;1217:}
LABELV $589
endproc SP_team_CTF_redspawn 0 0
export SP_team_CTF_bluespawn
proc SP_team_CTF_bluespawn 0 0
line 1223
;1218:
;1219:/*QUAKED team_CTF_bluespawn (0 0 1) (-16 -16 -24) (16 16 32)
;1220:potential spawning position for blue team in CTF games.
;1221:Targets will be fired when someone spawns in on them.
;1222:*/
;1223:void SP_team_CTF_bluespawn(gentity_t *ent) {
line 1224
;1224:}
LABELV $590
endproc SP_team_CTF_bluespawn 0 0
proc ObeliskRegen 8 12
line 1234
;1225:
;1226:
;1227:#ifdef MISSIONPACK
;1228:/*
;1229:================
;1230:Obelisks
;1231:================
;1232:*/
;1233:
;1234:static void ObeliskRegen( gentity_t *self ) {
line 1235
;1235:	self->nextthink = level.time + g_obeliskRegenPeriod.integer * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRGP4 g_obeliskRegenPeriod+12
INDIRI4
CNSTI4 1000
MULI4
ADDI4
ASGNI4
line 1236
;1236:	if( self->health >= g_obeliskHealth.integer ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 g_obeliskHealth+12
INDIRI4
LTI4 $594
line 1237
;1237:		return;
ADDRGP4 $591
JUMPV
LABELV $594
line 1240
;1238:	}
;1239:
;1240:	G_AddEvent( self, EV_POWERUP_REGEN, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 63
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 1241
;1241:	self->health += g_obeliskRegenAmount.integer;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 g_obeliskRegenAmount+12
INDIRI4
ADDI4
ASGNI4
line 1242
;1242:	if ( self->health > g_obeliskHealth.integer ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 g_obeliskHealth+12
INDIRI4
LEI4 $598
line 1243
;1243:		self->health = g_obeliskHealth.integer;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ADDRGP4 g_obeliskHealth+12
INDIRI4
ASGNI4
line 1244
;1244:	}
LABELV $598
line 1246
;1245:
;1246:	self->activator->s.modelindex2 = self->health * 0xff / g_obeliskHealth.integer;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 164
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 255
MULI4
ADDRGP4 g_obeliskHealth+12
INDIRI4
DIVI4
ASGNI4
line 1247
;1247:	self->activator->s.frame = 0;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 0
ASGNI4
line 1248
;1248:}
LABELV $591
endproc ObeliskRegen 8 12
proc ObeliskRespawn 0 0
line 1251
;1249:
;1250:
;1251:static void ObeliskRespawn( gentity_t *self ) {
line 1252
;1252:	self->takedamage = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 1253
;1253:	self->health = g_obeliskHealth.integer;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ADDRGP4 g_obeliskHealth+12
INDIRI4
ASGNI4
line 1255
;1254:
;1255:	self->think = ObeliskRegen;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 ObeliskRegen
ASGNP4
line 1256
;1256:	self->nextthink = level.time + g_obeliskRegenPeriod.integer * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRGP4 g_obeliskRegenPeriod+12
INDIRI4
CNSTI4 1000
MULI4
ADDI4
ASGNI4
line 1258
;1257:
;1258:	self->activator->s.frame = 0;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 0
ASGNI4
line 1259
;1259:}
LABELV $603
endproc ObeliskRespawn 0 0
proc ObeliskDie 20 12
line 1262
;1260:
;1261:
;1262:static void ObeliskDie( gentity_t *self, gentity_t *inflictor, gentity_t *attacker, int damage, int mod ) {
line 1265
;1263:	int			otherTeam;
;1264:
;1265:	otherTeam = OtherTeam( self->spawnflags );
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1266
;1266:	AddTeamScore(self->s.pos.trBase, otherTeam, 1);
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 AddTeamScore
CALLV
pop
line 1267
;1267:	Team_ForceGesture(otherTeam);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Team_ForceGesture
CALLV
pop
line 1269
;1268:
;1269:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 1271
;1270:
;1271:	self->takedamage = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 0
ASGNI4
line 1272
;1272:	self->think = ObeliskRespawn;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 ObeliskRespawn
ASGNP4
line 1273
;1273:	self->nextthink = level.time + g_obeliskRespawnDelay.integer * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRGP4 g_obeliskRespawnDelay+12
INDIRI4
CNSTI4 1000
MULI4
ADDI4
ASGNI4
line 1275
;1274:
;1275:	self->activator->s.modelindex2 = 0xff;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 255
ASGNI4
line 1276
;1276:	self->activator->s.frame = 2;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 2
ASGNI4
line 1278
;1277:
;1278:	G_AddEvent( self->activator, EV_OBELISKEXPLODE, 0 );
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
ARGP4
CNSTI4 69
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 1280
;1279:
;1280:	AddScore(attacker, self->r.currentOrigin, CTF_CAPTURE_BONUS);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 100
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 1283
;1281:
;1282:	// add the sprite over the player's head
;1283:	attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 8
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 1284
;1284:	attacker->client->ps.eFlags |= EF_AWARD_CAP;
ADDRLP4 12
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 1285
;1285:	attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 752
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 1286
;1286:	attacker->client->ps.persistant[PERS_CAPTURES]++;
ADDRLP4 16
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 304
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1288
;1287:
;1288:	teamgame.redObeliskAttackedTime = 0;
ADDRGP4 teamgame+28
CNSTI4 0
ASGNI4
line 1289
;1289:	teamgame.blueObeliskAttackedTime = 0;
ADDRGP4 teamgame+32
CNSTI4 0
ASGNI4
line 1290
;1290:}
LABELV $607
endproc ObeliskDie 20 12
proc ObeliskTouch 32 20
line 1293
;1291:
;1292:
;1293:static void ObeliskTouch( gentity_t *self, gentity_t *other, trace_t *trace ) {
line 1296
;1294:	int			tokens;
;1295:
;1296:	if ( !other->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $614
line 1297
;1297:		return;
ADDRGP4 $613
JUMPV
LABELV $614
line 1300
;1298:	}
;1299:
;1300:	if ( OtherTeam(other->client->sess.sessionTeam) != self->spawnflags ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
EQI4 $616
line 1301
;1301:		return;
ADDRGP4 $613
JUMPV
LABELV $616
line 1304
;1302:	}
;1303:
;1304:	tokens = other->client->ps.generic1;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
ASGNI4
line 1305
;1305:	if( tokens <= 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $618
line 1306
;1306:		return;
ADDRGP4 $613
JUMPV
LABELV $618
line 1309
;1307:	}
;1308:
;1309:	PrintMsg(NULL, "%s" S_COLOR_WHITE " brought in %i skull%s.\n",
CNSTP4 0
ARGP4
ADDRGP4 $620
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $624
ADDRLP4 8
ADDRGP4 $621
ASGNP4
ADDRGP4 $625
JUMPV
LABELV $624
ADDRLP4 8
ADDRGP4 $622
ASGNP4
LABELV $625
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 1312
;1310:					other->client->pers.netname, tokens, tokens ? "s" : "" );
;1311:
;1312:	AddTeamScore(self->s.pos.trBase, other->client->sess.sessionTeam, tokens);
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 AddTeamScore
CALLV
pop
line 1313
;1313:	Team_ForceGesture(other->client->sess.sessionTeam);
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ARGI4
ADDRGP4 Team_ForceGesture
CALLV
pop
line 1315
;1314:
;1315:	AddScore(other, self->r.currentOrigin, CTF_CAPTURE_BONUS*tokens);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 1318
;1316:
;1317:	// add the sprite over the player's head
;1318:	other->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 16
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 1319
;1319:	other->client->ps.eFlags |= EF_AWARD_CAP;
ADDRLP4 20
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 1320
;1320:	other->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 752
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 1321
;1321:	other->client->ps.persistant[PERS_CAPTURES] += tokens;
ADDRLP4 24
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 304
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 1323
;1322:	
;1323:	other->client->ps.generic1 = 0;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 440
ADDP4
CNSTI4 0
ASGNI4
line 1324
;1324:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 1326
;1325:
;1326:	Team_CaptureFlagSound( self, self->spawnflags );
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ARGI4
ADDRGP4 Team_CaptureFlagSound
CALLV
pop
line 1327
;1327:}
LABELV $613
endproc ObeliskTouch 32 20
proc ObeliskPain 8 12
line 1329
;1328:
;1329:static void ObeliskPain( gentity_t *self, gentity_t *attacker, int damage ) {
line 1330
;1330:	int actualDamage = damage / 10;
ADDRLP4 0
ADDRFP4 8
INDIRI4
CNSTI4 10
DIVI4
ASGNI4
line 1331
;1331:	if (actualDamage <= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $628
line 1332
;1332:		actualDamage = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1333
;1333:	}
LABELV $628
line 1334
;1334:	self->activator->s.modelindex2 = self->health * 0xff / g_obeliskHealth.integer;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 164
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 255
MULI4
ADDRGP4 g_obeliskHealth+12
INDIRI4
DIVI4
ASGNI4
line 1335
;1335:	if (!self->activator->s.frame) {
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
CNSTI4 0
NEI4 $631
line 1336
;1336:		G_AddEvent(self, EV_OBELISKPAIN, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 70
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 1337
;1337:	}
LABELV $631
line 1338
;1338:	self->activator->s.frame = 1;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 1
ASGNI4
line 1339
;1339:	AddScore(attacker, self->r.currentOrigin, actualDamage);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 1340
;1340:}
LABELV $627
endproc ObeliskPain 8 12
export SpawnObelisk
proc SpawnObelisk 100 28
line 1342
;1341:
;1342:gentity_t *SpawnObelisk( vec3_t origin, int team, int spawnflags) {
line 1347
;1343:	trace_t		tr;
;1344:	vec3_t		dest;
;1345:	gentity_t	*ent;
;1346:
;1347:	ent = G_Spawn();
ADDRLP4 72
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 72
INDIRP4
ASGNP4
line 1349
;1348:
;1349:	VectorCopy( origin, ent->s.origin );
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 1350
;1350:	VectorCopy( origin, ent->s.pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 1351
;1351:	VectorCopy( origin, ent->r.currentOrigin );
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 1353
;1352:
;1353:	VectorSet( ent->r.mins, -15, -15, 0 );
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 440
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 444
ADDP4
CNSTF4 0
ASGNF4
line 1354
;1354:	VectorSet( ent->r.maxs, 15, 15, 87 );
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 1118699520
ASGNF4
line 1356
;1355:
;1356:	ent->s.eType = ET_GENERAL;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 1357
;1357:	ent->flags = FL_NO_KNOCKBACK;
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
CNSTI4 2048
ASGNI4
line 1359
;1358:
;1359:	if( g_gametype.integer == GT_OBELISK ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 6
NEI4 $634
line 1360
;1360:		ent->r.contents = CONTENTS_SOLID;
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1
ASGNI4
line 1361
;1361:		ent->takedamage = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 1362
;1362:		ent->health = g_obeliskHealth.integer;
ADDRLP4 0
INDIRP4
CNSTI4 732
ADDP4
ADDRGP4 g_obeliskHealth+12
INDIRI4
ASGNI4
line 1363
;1363:		ent->die = ObeliskDie;
ADDRLP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 ObeliskDie
ASGNP4
line 1364
;1364:		ent->pain = ObeliskPain;
ADDRLP4 0
INDIRP4
CNSTI4 712
ADDP4
ADDRGP4 ObeliskPain
ASGNP4
line 1365
;1365:		ent->think = ObeliskRegen;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 ObeliskRegen
ASGNP4
line 1366
;1366:		ent->nextthink = level.time + g_obeliskRegenPeriod.integer * 1000;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRGP4 g_obeliskRegenPeriod+12
INDIRI4
CNSTI4 1000
MULI4
ADDI4
ASGNI4
line 1367
;1367:	}
LABELV $634
line 1368
;1368:	if( g_gametype.integer == GT_HARVESTER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
NEI4 $640
line 1369
;1369:		ent->r.contents = CONTENTS_TRIGGER;
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1073741824
ASGNI4
line 1370
;1370:		ent->touch = ObeliskTouch;
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
ADDRGP4 ObeliskTouch
ASGNP4
line 1371
;1371:	}
LABELV $640
line 1373
;1372:
;1373:	if ( spawnflags & 1 ) {
ADDRFP4 8
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $643
line 1375
;1374:		// suspended
;1375:		G_SetOrigin( ent, ent->s.origin );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 1376
;1376:	} else {
ADDRGP4 $644
JUMPV
LABELV $643
line 1379
;1377:		// mappers like to put them exactly on the floor, but being coplanar
;1378:		// will sometimes show up as starting in solid, so lif it up one pixel
;1379:		ent->s.origin[2] += 1;
ADDRLP4 76
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1382
;1380:
;1381:		// drop to floor
;1382:		VectorSet( dest, ent->s.origin[0], ent->s.origin[1], ent->s.origin[2] - 4096 );
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
CNSTF4 1166016512
SUBF4
ASGNF4
line 1383
;1383:		trap_Trace( &tr, ent->s.origin, ent->r.mins, ent->r.maxs, dest, ent->s.number, MASK_SOLID );
ADDRLP4 16
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1384
;1384:		if ( tr.startsolid ) {
ADDRLP4 16+4
INDIRI4
CNSTI4 0
EQI4 $647
line 1385
;1385:			ent->s.origin[2] -= 1;
ADDRLP4 88
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 1386
;1386:			G_Printf( "SpawnObelisk: %s startsolid at %s\n", ent->classname, vtos(ent->s.origin) );
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 92
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $650
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1388
;1387:
;1388:			ent->s.groundEntityNum = ENTITYNUM_NONE;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 1023
ASGNI4
line 1389
;1389:			G_SetOrigin( ent, ent->s.origin );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 1390
;1390:		}
ADDRGP4 $648
JUMPV
LABELV $647
line 1391
;1391:		else {
line 1393
;1392:			// allow to ride movers
;1393:			ent->s.groundEntityNum = tr.entityNum;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
ADDRLP4 16+52
INDIRI4
ASGNI4
line 1394
;1394:			G_SetOrigin( ent, tr.endpos );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16+12
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 1395
;1395:		}
LABELV $648
line 1396
;1396:	}
LABELV $644
line 1398
;1397:
;1398:	ent->spawnflags = team;
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 1400
;1399:
;1400:	trap_LinkEntity( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1402
;1401:
;1402:	return ent;
ADDRLP4 0
INDIRP4
RETP4
LABELV $633
endproc SpawnObelisk 100 28
export SP_team_redobelisk
proc SP_team_redobelisk 12 12
line 1407
;1403:}
;1404:
;1405:/*QUAKED team_redobelisk (1 0 0) (-16 -16 0) (16 16 8)
;1406:*/
;1407:void SP_team_redobelisk( gentity_t *ent ) {
line 1410
;1408:	gentity_t *obelisk;
;1409:
;1410:	if ( g_gametype.integer <= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
GTI4 $654
line 1411
;1411:		G_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 1412
;1412:		return;
ADDRGP4 $653
JUMPV
LABELV $654
line 1414
;1413:	}
;1414:	ent->s.eType = ET_TEAM;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 12
ASGNI4
line 1415
;1415:	if ( g_gametype.integer == GT_OBELISK ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 6
NEI4 $657
line 1416
;1416:		obelisk = SpawnObelisk( ent->s.origin, TEAM_RED, ent->spawnflags );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 SpawnObelisk
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1417
;1417:		obelisk->activator = ent;
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 1419
;1418:		// initial obelisk health value
;1419:		ent->s.modelindex2 = 0xff;
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 255
ASGNI4
line 1420
;1420:		ent->s.frame = 0;
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 0
ASGNI4
line 1421
;1421:	}
LABELV $657
line 1422
;1422:	if ( g_gametype.integer == GT_HARVESTER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
NEI4 $660
line 1423
;1423:		obelisk = SpawnObelisk( ent->s.origin, TEAM_RED, ent->spawnflags );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 SpawnObelisk
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1424
;1424:		obelisk->activator = ent;
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 1425
;1425:	}
LABELV $660
line 1426
;1426:	ent->s.modelindex = TEAM_RED;
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
CNSTI4 1
ASGNI4
line 1427
;1427:	trap_LinkEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1428
;1428:}
LABELV $653
endproc SP_team_redobelisk 12 12
export SP_team_blueobelisk
proc SP_team_blueobelisk 12 12
line 1432
;1429:
;1430:/*QUAKED team_blueobelisk (0 0 1) (-16 -16 0) (16 16 88)
;1431:*/
;1432:void SP_team_blueobelisk( gentity_t *ent ) {
line 1435
;1433:	gentity_t *obelisk;
;1434:
;1435:	if ( g_gametype.integer <= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
GTI4 $664
line 1436
;1436:		G_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 1437
;1437:		return;
ADDRGP4 $663
JUMPV
LABELV $664
line 1439
;1438:	}
;1439:	ent->s.eType = ET_TEAM;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 12
ASGNI4
line 1440
;1440:	if ( g_gametype.integer == GT_OBELISK ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 6
NEI4 $667
line 1441
;1441:		obelisk = SpawnObelisk( ent->s.origin, TEAM_BLUE, ent->spawnflags );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 SpawnObelisk
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1442
;1442:		obelisk->activator = ent;
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 1444
;1443:		// initial obelisk health value
;1444:		ent->s.modelindex2 = 0xff;
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 255
ASGNI4
line 1445
;1445:		ent->s.frame = 0;
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 0
ASGNI4
line 1446
;1446:	}
LABELV $667
line 1447
;1447:	if ( g_gametype.integer == GT_HARVESTER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
NEI4 $670
line 1448
;1448:		obelisk = SpawnObelisk( ent->s.origin, TEAM_BLUE, ent->spawnflags );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 SpawnObelisk
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1449
;1449:		obelisk->activator = ent;
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 1450
;1450:	}
LABELV $670
line 1451
;1451:	ent->s.modelindex = TEAM_BLUE;
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
CNSTI4 2
ASGNI4
line 1452
;1452:	trap_LinkEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1453
;1453:}
LABELV $663
endproc SP_team_blueobelisk 12 12
export SP_team_neutralobelisk
proc SP_team_neutralobelisk 8 12
line 1457
;1454:
;1455:/*QUAKED team_neutralobelisk (0 0 1) (-16 -16 0) (16 16 88)
;1456:*/
;1457:void SP_team_neutralobelisk( gentity_t *ent ) {
line 1458
;1458:	if ( g_gametype.integer != GT_1FCTF && g_gametype.integer != GT_HARVESTER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
EQI4 $674
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
EQI4 $674
line 1459
;1459:		G_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 1460
;1460:		return;
ADDRGP4 $673
JUMPV
LABELV $674
line 1462
;1461:	}
;1462:	ent->s.eType = ET_TEAM;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 12
ASGNI4
line 1463
;1463:	if ( g_gametype.integer == GT_HARVESTER) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
NEI4 $678
line 1464
;1464:		neutralObelisk = SpawnObelisk( ent->s.origin, TEAM_FREE, ent->spawnflags);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 SpawnObelisk
CALLP4
ASGNP4
ADDRGP4 neutralObelisk
ADDRLP4 4
INDIRP4
ASGNP4
line 1465
;1465:		neutralObelisk->spawnflags = TEAM_FREE;
ADDRGP4 neutralObelisk
INDIRP4
CNSTI4 528
ADDP4
CNSTI4 0
ASGNI4
line 1466
;1466:	}
LABELV $678
line 1467
;1467:	ent->s.modelindex = TEAM_FREE;
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
CNSTI4 0
ASGNI4
line 1468
;1468:	trap_LinkEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1469
;1469:}
LABELV $673
endproc SP_team_neutralobelisk 8 12
export CheckObeliskAttack
proc CheckObeliskAttack 12 8
line 1477
;1470:
;1471:
;1472:/*
;1473:================
;1474:CheckObeliskAttack
;1475:================
;1476:*/
;1477:qboolean CheckObeliskAttack( gentity_t *obelisk, gentity_t *attacker ) {
line 1481
;1478:	gentity_t	*te;
;1479:
;1480:	// if this really is an obelisk
;1481:	if( obelisk->die != ObeliskDie ) {
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 ObeliskDie
CVPU4 4
EQU4 $682
line 1482
;1482:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $681
JUMPV
LABELV $682
line 1486
;1483:	}
;1484:
;1485:	// if the attacker is a client
;1486:	if( !attacker->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $684
line 1487
;1487:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $681
JUMPV
LABELV $684
line 1491
;1488:	}
;1489:
;1490:	// if the obelisk is on the same team as the attacker then don't hurt it
;1491:	if( obelisk->spawnflags == attacker->client->sess.sessionTeam ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
NEI4 $686
line 1492
;1492:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $681
JUMPV
LABELV $686
line 1498
;1493:	}
;1494:
;1495:	// obelisk may be hurt
;1496:
;1497:	// if not played any sounds recently
;1498:	if ((obelisk->spawnflags == TEAM_RED &&
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 1
NEI4 $695
ADDRGP4 teamgame+28
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 20000
SUBI4
LTI4 $694
LABELV $695
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 2
NEI4 $688
ADDRGP4 teamgame+32
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 20000
SUBI4
GEI4 $688
LABELV $694
line 1501
;1499:		teamgame.redObeliskAttackedTime < level.time - OVERLOAD_ATTACK_BASE_SOUND_TIME) ||
;1500:		(obelisk->spawnflags == TEAM_BLUE &&
;1501:		teamgame.blueObeliskAttackedTime < level.time - OVERLOAD_ATTACK_BASE_SOUND_TIME) ) {
line 1504
;1502:
;1503:		// tell which obelisk is under attack
;1504:		te = G_TempEntity( obelisk->s.pos.trBase, EV_GLOBAL_TEAM_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1505
;1505:		if( obelisk->spawnflags == TEAM_RED ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 1
NEI4 $696
line 1506
;1506:			te->s.eventParm = GTS_REDOBELISK_ATTACKED;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 6
ASGNI4
line 1507
;1507:			teamgame.redObeliskAttackedTime = level.time;
ADDRGP4 teamgame+28
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1508
;1508:		}
ADDRGP4 $697
JUMPV
LABELV $696
line 1509
;1509:		else {
line 1510
;1510:			te->s.eventParm = GTS_BLUEOBELISK_ATTACKED;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 7
ASGNI4
line 1511
;1511:			teamgame.blueObeliskAttackedTime = level.time;
ADDRGP4 teamgame+32
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1512
;1512:		}
LABELV $697
line 1513
;1513:		te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 1514
;1514:	}
LABELV $688
line 1516
;1515:
;1516:	return qfalse;
CNSTI4 0
RETI4
LABELV $681
endproc CheckObeliskAttack 12 8
proc Cmd_Flaginfo_f 20 0
line 1520
;1517:}
;1518:#endif
;1519:
;1520:static void Cmd_Flaginfo_f( gentity_t *ent ) {
line 1521
;1521:	if ( g_gametype.integer < GT_CTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
GEI4 $703
line 1522
;1522:		return;
ADDRGP4 $702
JUMPV
LABELV $703
line 1525
;1523:	}
;1524:
;1525:	switch( g_gametype.integer ) {
ADDRLP4 0
ADDRGP4 g_gametype+12
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $702
ADDRLP4 0
INDIRI4
CNSTI4 7
GTI4 $702
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $741-16
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $741
address $709
address $728
address $707
address $707
code
LABELV $709
line 1527
;1526:		case GT_CTF:
;1527:		{
line 1528
;1528:			switch( teamgame.redStatus ) {
ADDRLP4 4
ADDRGP4 teamgame+8
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 -1
LTI4 $711
ADDRLP4 4
INDIRI4
CNSTI4 4
GTI4 $711
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $717+4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $717
address $711
address $711
address $711
address $711
address $711
address $711
code
line 1531
;1529:				case -1:
;1530:				case FLAG_ATBASE:
;1531:				{
line 1532
;1532:					break;
line 1535
;1533:				}
;1534:				case FLAG_TAKEN:
;1535:				{
line 1536
;1536:					break;
line 1539
;1537:				}
;1538:				case FLAG_DROPPED:
;1539:				{
line 1540
;1540:					break;
line 1543
;1541:				}
;1542:				default:
;1543:					break;
LABELV $711
line 1545
;1544:			}
;1545:			switch( teamgame.blueStatus ) {
ADDRLP4 12
ADDRGP4 teamgame+12
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 -1
LTI4 $707
ADDRLP4 12
INDIRI4
CNSTI4 4
GTI4 $707
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $726+4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $726
address $707
address $707
address $707
address $707
address $707
address $707
code
line 1548
;1546:				case -1:
;1547:				case FLAG_ATBASE:
;1548:				{
line 1549
;1549:					break;
line 1552
;1550:				}
;1551:				case FLAG_TAKEN:
;1552:				{
line 1553
;1553:					break;
line 1556
;1554:				}
;1555:				case FLAG_DROPPED:
;1556:				{
line 1557
;1557:					break;
line 1560
;1558:				}
;1559:				default:
;1560:					break;
line 1562
;1561:			}
;1562:			break;
LABELV $728
line 1566
;1563:		}
;1564:#ifdef MISSIONPACK
;1565:		case GT_1FCTF:
;1566:		{
line 1567
;1567:			switch( teamgame.flagStatus ) {
ADDRLP4 4
ADDRGP4 teamgame+16
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 -1
LTI4 $707
ADDRLP4 4
INDIRI4
CNSTI4 4
GTI4 $707
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $737+4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $737
address $707
address $707
address $707
address $707
address $707
address $707
code
line 1570
;1568:				case -1:
;1569:				case FLAG_ATBASE:
;1570:				{
line 1571
;1571:					break;
line 1574
;1572:				}
;1573:				case FLAG_TAKEN_RED:
;1574:				{
line 1575
;1575:					break;
line 1578
;1576:				}
;1577:				case FLAG_TAKEN_BLUE:
;1578:				{
line 1579
;1579:					break;
line 1582
;1580:				}
;1581:				case FLAG_DROPPED:
;1582:				{
line 1583
;1583:					break;
line 1586
;1584:				}
;1585:				default:
;1586:					break;
line 1588
;1587:			}
;1588:			break;
line 1591
;1589:		}
;1590:		case GT_OBELISK:
;1591:		{
line 1592
;1592:			break;
line 1595
;1593:		}
;1594:		case GT_HARVESTER:
;1595:		{
line 1596
;1596:			break;
line 1600
;1597:		}
;1598:#endif
;1599:		default:
;1600:			return;
LABELV $707
line 1602
;1601:	}
;1602:}
LABELV $702
endproc Cmd_Flaginfo_f 20 0
bss
export neutralObelisk
align 4
LABELV neutralObelisk
skip 4
export teamgame
align 4
LABELV teamgame
skip 36
import svf_self_portal2
import G_RailgunRadiusDamage
import trap_SnapVector
import trap_GeneticParentsAndChildSelection
import trap_BotResetWeaponState
import trap_BotFreeWeaponState
import trap_BotAllocWeaponState
import trap_BotLoadWeaponWeights
import trap_BotGetWeaponInfo
import trap_BotChooseBestFightWeapon
import trap_BotAddAvoidSpot
import trap_BotInitMoveState
import trap_BotFreeMoveState
import trap_BotAllocMoveState
import trap_BotPredictVisiblePosition
import trap_BotMovementViewTarget
import trap_BotReachabilityArea
import trap_BotResetLastAvoidReach
import trap_BotResetAvoidReach
import trap_BotMoveInDirection
import trap_BotMoveToGoal
import trap_BotResetMoveState
import trap_BotFreeGoalState
import trap_BotAllocGoalState
import trap_BotMutateGoalFuzzyLogic
import trap_BotSaveGoalFuzzyLogic
import trap_BotInterbreedGoalFuzzyLogic
import trap_BotFreeItemWeights
import trap_BotLoadItemWeights
import trap_BotUpdateEntityItems
import trap_BotInitLevelItems
import trap_BotSetAvoidGoalTime
import trap_BotAvoidGoalTime
import trap_BotGetLevelItemGoal
import trap_BotGetMapLocationGoal
import trap_BotGetNextCampSpotGoal
import trap_BotItemGoalInVisButNotVisible
import trap_BotTouchingGoal
import trap_BotChooseNBGItem
import trap_BotChooseLTGItem
import trap_BotGetSecondGoal
import trap_BotGetTopGoal
import trap_BotGoalName
import trap_BotDumpGoalStack
import trap_BotDumpAvoidGoals
import trap_BotEmptyGoalStack
import trap_BotPopGoal
import trap_BotPushGoal
import trap_BotResetAvoidGoals
import trap_BotRemoveFromAvoidGoals
import trap_BotResetGoalState
import trap_BotSetChatName
import trap_BotSetChatGender
import trap_BotLoadChatFile
import trap_BotReplaceSynonyms
import trap_UnifyWhiteSpaces
import trap_BotMatchVariable
import trap_BotFindMatch
import trap_StringContains
import trap_BotGetChatMessage
import trap_BotEnterChat
import trap_BotChatLength
import trap_BotReplyChat
import trap_BotNumInitialChats
import trap_BotInitialChat
import trap_BotNumConsoleMessages
import trap_BotNextConsoleMessage
import trap_BotRemoveConsoleMessage
import trap_BotQueueConsoleMessage
import trap_BotFreeChatState
import trap_BotAllocChatState
import trap_Characteristic_String
import trap_Characteristic_BInteger
import trap_Characteristic_Integer
import trap_Characteristic_BFloat
import trap_Characteristic_Float
import trap_BotFreeCharacter
import trap_BotLoadCharacter
import trap_EA_ResetInput
import trap_EA_GetInput
import trap_EA_EndRegular
import trap_EA_View
import trap_EA_Move
import trap_EA_DelayedJump
import trap_EA_Jump
import trap_EA_SelectWeapon
import trap_EA_MoveRight
import trap_EA_MoveLeft
import trap_EA_MoveBack
import trap_EA_MoveForward
import trap_EA_MoveDown
import trap_EA_MoveUp
import trap_EA_Crouch
import trap_EA_Respawn
import trap_EA_Use
import trap_EA_Attack
import trap_EA_Talk
import trap_EA_Gesture
import trap_EA_Action
import trap_EA_Command
import trap_EA_SayTeam
import trap_EA_Say
import trap_AAS_PredictClientMovement
import trap_AAS_Swimming
import trap_AAS_AlternativeRouteGoals
import trap_AAS_PredictRoute
import trap_AAS_EnableRoutingArea
import trap_AAS_AreaTravelTimeToGoalArea
import trap_AAS_AreaReachability
import trap_AAS_IntForBSPEpairKey
import trap_AAS_FloatForBSPEpairKey
import trap_AAS_VectorForBSPEpairKey
import trap_AAS_ValueForBSPEpairKey
import trap_AAS_NextBSPEntity
import trap_AAS_PointContents
import trap_AAS_TraceAreas
import trap_AAS_PointReachabilityAreaIndex
import trap_AAS_PointAreaNum
import trap_AAS_Time
import trap_AAS_PresenceTypeBoundingBox
import trap_AAS_Initialized
import trap_AAS_EntityInfo
import trap_AAS_AreaInfo
import trap_AAS_BBoxAreas
import trap_BotUserCommand
import trap_BotGetServerCommand
import trap_BotGetSnapshotEntity
import trap_BotLibTest
import trap_BotLibUpdateEntity
import trap_BotLibLoadMap
import trap_BotLibStartFrame
import trap_BotLibDefine
import trap_BotLibVarGet
import trap_BotLibVarSet
import trap_BotLibShutdown
import trap_BotLibSetup
import trap_DebugPolygonDelete
import trap_DebugPolygonCreate
import trap_GetEntityToken
import trap_GetUsercmd
import trap_BotFreeClient
import trap_BotAllocateClient
import trap_EntityContact
import trap_EntitiesInBox
import trap_UnlinkEntity
import trap_LinkEntity
import trap_AreasConnected
import trap_AdjustAreaPortalState
import trap_InPVSIgnorePortals
import trap_InPVS
import trap_PointContents
import trap_TraceCapsule
import trap_Trace
import trap_SetBrushModel
import trap_GetServerinfo
import trap_SetUserinfo
import trap_GetUserinfo
import trap_GetConfigstring
import trap_SetConfigstring
import trap_SendServerCommand
import trap_DropClient
import trap_LocateGameData
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_VariableIntegerValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_RealTime
import trap_Milliseconds
import trap_Error
import trap_Print
import g_rotation
import g_loadCustomEnts
import g_1FRespawn
import g_wpflags
import g_removeweapon
import g_removepowerup
import g_removeitem
import g_removeammo
import g_startingWeapon
import g_tossWeapon
import g_damageCG
import g_splashRadiusPL
import g_damagePL
import g_damageNG
import g_startAmmoCG
import g_startAmmoPL
import g_startAmmoNG
import g_splashRadiusBFG
import g_splashDamageBFG
import g_damageBFG
import g_splashRadiusPG
import g_splashDamagePG
import g_damagePG
import g_damageRG
import g_damageLG
import g_velocityRL
import g_splashRadiusRL
import g_splashDamageRL
import g_damageRL
import g_splashRadiusGL
import g_splashDamageGL
import g_damageGL
import g_sgPelletSpread
import g_sgPellets
import g_damageSG
import g_damageTeamMG
import g_damageMG
import g_damageG
import g_startAmmoBFG
import g_startAmmoPG
import g_startAmmoRG
import g_startAmmoLG
import g_startAmmoRL
import g_startAmmoGL
import g_startAmmoSG
import g_startAmmoMG
import g_grappleDamage
import g_grapplePull
import g_grappleSpeed
import g_grappleHoldTime
import g_grappleDelayTime
import g_grapple
import g_startHealth
import g_startArmor
import g_noSelfDamage
import g_railJumpDamage
import g_railJump
import g_instagib
import pmove_msec
import pmove_fixed
import g_smoothClients
import g_proxMineTimeout
import g_enableBreath
import g_enableDust
import g_singlePlayer
import g_blueteam
import g_redteam
import g_cubeTimeout
import g_obeliskRespawnDelay
import g_obeliskRegenAmount
import g_obeliskRegenPeriod
import g_obeliskHealth
import g_predictPVS
import g_unlagged
import g_listEntity
import g_allowVote
import g_podiumDrop
import g_podiumDist
import g_blood
import g_motd
import g_debugAlloc
import g_debugDamage
import g_debugMove
import g_inactivity
import g_forcerespawn
import g_holdableTeamRespawn
import g_holdableRespawn
import g_powerupTeamRespawn
import g_powerupRespawn
import g_megahealthTeamRespawn
import g_megahealthRespawn
import g_healthTeamRespawn
import g_healthRespawn
import g_armorTeamRespawn
import g_armorRespawn
import g_ammoTeamRespawn
import g_ammoRespawn
import g_weaponTeamRespawn
import g_weaponRespawn
import g_quadfactor
import g_knockback
import g_gravity
import g_speed
import g_dedicated
import g_needpass
import g_filterBan
import g_banIPs
import g_password
import g_logSync
import g_log
import g_warmup
import g_teamForceBalance
import g_autoJoin
import g_friendlyFire
import g_synchronousClients
import g_capturelimit
import g_timelimit
import g_fraglimit
import g_dmflags
import g_maxGameClients
import g_maxclients
import g_gametype
import sv_fps
import g_mapname
import g_cheats
import g_entities
import level
import Hook_Fire
import G_SetInfiniteAmmo
import G_RemoveWeapon
import G_RemovePowerup
import G_RemoveItem
import G_RemoveAmmo
import G_SpawnWeapon
import G_RegisterWeapon
import G_MapExist
import G_LoadMap
import ParseMapRotation
import BotTestAAS
import BotAIStartFrame
import BotAIShutdownClient
import BotAISetupClient
import BotAILoadMap
import BotAIShutdown
import BotAISetup
import BotInterbreedEndMatch
import Svcmd_BotList_f
import Svcmd_AddBot_f
import G_BotConnect
import G_RemoveQueuedBotBegin
import G_CheckBotSpawn
import G_GetBotInfoByName
import G_GetBotInfoByNumber
import G_InitBots
import G_PredictPlayerMove
import G_UnTimeShiftClient
import G_UndoTimeShiftFor
import G_DoTimeShiftFor
import G_UnTimeShiftAllClients
import G_TimeShiftAllClients
import G_StoreHistory
import G_ResetHistory
import Svcmd_AbortPodium_f
import SpawnModelsOnVictoryPads
import UpdateTournamentInfo
import G_ClearClientSessionData
import G_WriteClientSessionData
import G_ReadClientSessionData
import G_InitSessionData
import G_WriteSessionData
import G_InitWorldSession
import Svcmd_GameMem_f
import G_InitMemory
import G_Alloc
import G_RunClient
import ClientEndFrame
import ClientThink
import ClientCommand
import ClientBegin
import ClientDisconnect
import ClientUserinfoChanged
import ClientConnect
import G_BroadcastServerCommand
import G_Error
import G_Printf
import G_LogPrintf
import G_RunThink
import CheckTeamLeader
import SetLeader
import FindIntermissionPoint
import MoveClientToIntermission
import DeathmatchScoreboardMessage
import G_StartKamikaze
import FireWeapon
import G_FilterPacket
import G_ProcessIPBans
import ConsoleCommand
import SpotWouldTelefrag
import CalculateRanks
import AddScore
import player_die
import G_GenericDeathCleanup
import ClientSpawn
import ClientRestoreStats
import ClientBackupStats
import InitBodyQue
import BeginIntermission
import respawn
import CopyToBodyQue
import SelectSpawnPoint
import SetClientViewAngle
import PickTeam
import TeamLeader
import TeamConnectedCount
import TeamCount
import Weapon_HookThink
import Weapon_HookFree
import CheckGauntletAttack
import SnapVectorTowards
import CalcMuzzlePoint
import LogAccuracyHit
import DropPortalDestination
import DropPortalSource
import TeleportPlayer
import trigger_teleporter_touch
import Touch_DoorTrigger
import G_RunMover
import fire_prox
import fire_nail
import fire_grapple
import fire_bfg
import fire_rocket
import fire_grenade
import fire_plasma
import fire_blaster
import G_RunMissile
import TossClientCubes
import TossClientPersistantPowerups
import TossClientItems
import body_die
import G_InvulnerabilityEffect
import G_RadiusDamage
import G_Damage
import CanDamage
import BuildShaderStateConfig
import AddRemap
import G_SetOrigin
import G_AddEvent
import G_AddPredictableEvent
import vectoyaw
import vtos
import tv
import G_TouchSolids
import G_TouchTriggers
import G_EntitiesFree
import G_FreeEntity
import G_Sound
import G_TempEntity
import G_Spawn
import G_InitGentity
import G_SetMovedir
import G_UseTargets
import G_PickTarget
import G_Find
import G_KillBox
import G_TeamCommand
import G_SoundIndex
import G_ModelIndex
import SaveRegisteredItems
import RegisterItem
import ClearRegisteredItems
import Touch_Item
import ArmorIndex
import Think_Weapon
import FinishSpawningItem
import G_SpawnItem
import SetRespawn
import LaunchItem
import Drop_Item
import PrecacheItem
import UseHoldableItem
import SpawnTime
import RespawnItem
import G_RunItem
import G_CheckTeamItems
import Registered
import G_RevertVote
import Cmd_FollowCycle_f
import SetTeam
import BroadcastTeamChange
import StopFollowing
import Cmd_Score_f
import G_NewString
import G_SpawnEntitiesFromString
import G_SpawnVector
import G_SpawnInt
import G_SpawnFloat
import G_SpawnString
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
LABELV $650
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 79
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 115
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $622
byte 1 0
align 1
LABELV $621
byte 1 115
byte 1 0
align 1
LABELV $620
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 98
byte 1 114
byte 1 111
byte 1 117
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 37
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $557
byte 1 116
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $553
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $496
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $495
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $462
byte 1 68
byte 1 111
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 32
byte 1 119
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 110
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $443
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $440
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $410
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $409
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $402
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $379
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $378
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $372
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 83
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $343
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 84
byte 1 97
byte 1 107
byte 1 101
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 83
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $337
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 82
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 83
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $321
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $267
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $265
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $260
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $256
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $254
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $231
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 32
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $220
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $106
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $101
byte 1 80
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 77
byte 1 115
byte 1 103
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 114
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $96
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $95
byte 1 94
byte 1 51
byte 1 0
align 1
LABELV $92
byte 1 94
byte 1 52
byte 1 0
align 1
LABELV $89
byte 1 94
byte 1 49
byte 1 0
align 1
LABELV $78
byte 1 70
byte 1 82
byte 1 69
byte 1 69
byte 1 0
align 1
LABELV $77
byte 1 83
byte 1 80
byte 1 69
byte 1 67
byte 1 84
byte 1 65
byte 1 84
byte 1 79
byte 1 82
byte 1 0
align 1
LABELV $74
byte 1 66
byte 1 76
byte 1 85
byte 1 69
byte 1 0
align 1
LABELV $71
byte 1 82
byte 1 69
byte 1 68
byte 1 0
