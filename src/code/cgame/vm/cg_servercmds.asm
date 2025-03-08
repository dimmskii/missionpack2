data
align 4
LABELV validOrders
address $73
byte 4 1
address $74
byte 4 1
address $75
byte 4 2
address $76
byte 4 2
address $77
byte 4 3
address $78
byte 4 7
address $79
byte 4 4
address $80
byte 4 5
address $81
byte 4 6
align 4
LABELV numValidOrders
byte 4 9
code
proc CG_ValidOrder 8 8
file "../cg_servercmds.c"
line 31
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_servercmds.c -- reliably sequenced text commands sent by the server
;4:// these are processed at snapshot transition time, so there will definately
;5:// be a valid snapshot this frame
;6:
;7:#include "cg_local.h"
;8:
;9:#ifdef MISSIONPACK // bk001204
;10:#include "../../ui/menudef.h" // bk001205 - for Q3_ui as well
;11:
;12:typedef struct {
;13:	const char *order;
;14:	int taskNum;
;15:} orderTask_t;
;16:
;17:static const orderTask_t validOrders[] = {
;18:	{ VOICECHAT_GETFLAG,						TEAMTASK_OFFENSE },
;19:	{ VOICECHAT_OFFENSE,						TEAMTASK_OFFENSE },
;20:	{ VOICECHAT_DEFEND,							TEAMTASK_DEFENSE },
;21:	{ VOICECHAT_DEFENDFLAG,					TEAMTASK_DEFENSE },
;22:	{ VOICECHAT_PATROL,							TEAMTASK_PATROL },
;23:	{ VOICECHAT_CAMP,								TEAMTASK_CAMP },
;24:	{ VOICECHAT_FOLLOWME,						TEAMTASK_FOLLOW },
;25:	{ VOICECHAT_RETURNFLAG,					TEAMTASK_RETRIEVE },
;26:	{ VOICECHAT_FOLLOWFLAGCARRIER,	TEAMTASK_ESCORT }
;27:};
;28:
;29:static const int numValidOrders = sizeof(validOrders) / sizeof(orderTask_t);
;30:
;31:static int CG_ValidOrder(const char *p) {
line 33
;32:	int i;
;33:	for (i = 0; i < numValidOrders; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $86
JUMPV
LABELV $83
line 34
;34:		if (Q_stricmp(p, validOrders[i].order) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 validOrders
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $87
line 35
;35:			return validOrders[i].taskNum;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 validOrders+4
ADDP4
INDIRI4
RETI4
ADDRGP4 $82
JUMPV
LABELV $87
line 37
;36:		}
;37:	}
LABELV $84
line 33
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $86
ADDRLP4 0
INDIRI4
ADDRGP4 numValidOrders
INDIRI4
LTI4 $83
line 38
;38:	return -1;
CNSTI4 -1
RETI4
LABELV $82
endproc CG_ValidOrder 8 8
proc CG_ParseScores 208 12
line 48
;39:}
;40:#endif
;41:
;42:/*
;43:=================
;44:CG_ParseScores
;45:
;46:=================
;47:*/
;48:static void CG_ParseScores( void ) {
line 51
;49:	int		i, powerups;
;50:
;51:	cg.numScores = atoi( CG_Argv( 1 ) );
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cg+110476
ADDRLP4 12
INDIRI4
ASGNI4
line 52
;52:	if ( cg.numScores > MAX_CLIENTS ) {
ADDRGP4 cg+110476
INDIRI4
CNSTI4 64
LEI4 $92
line 53
;53:		cg.numScores = MAX_CLIENTS;
ADDRGP4 cg+110476
CNSTI4 64
ASGNI4
line 54
;54:	}
LABELV $92
line 56
;55:
;56:	cg.teamScores[0] = atoi( CG_Argv( 2 ) );
CNSTI4 2
ARGI4
ADDRLP4 16
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cg+110484
ADDRLP4 20
INDIRI4
ASGNI4
line 57
;57:	cg.teamScores[1] = atoi( CG_Argv( 3 ) );
CNSTI4 3
ARGI4
ADDRLP4 24
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cg+110484+4
ADDRLP4 28
INDIRI4
ASGNI4
line 59
;58:
;59:	memset( cg.scores, 0, sizeof( cg.scores ) );
ADDRGP4 cg+110492
ARGP4
CNSTI4 0
ARGI4
CNSTU4 4864
ARGU4
ADDRGP4 memset
CALLP4
pop
line 60
;60:	for ( i = 0 ; i < cg.numScores ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $104
JUMPV
LABELV $101
line 62
;61:		//
;62:		cg.scores[i].client = atoi( CG_Argv( i * 14 + 4 ) );
ADDRLP4 0
INDIRI4
CNSTI4 14
MULI4
CNSTI4 4
ADDI4
ARGI4
ADDRLP4 36
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 63
;63:		cg.scores[i].score = atoi( CG_Argv( i * 14 + 5 ) );
ADDRLP4 0
INDIRI4
CNSTI4 14
MULI4
CNSTI4 5
ADDI4
ARGI4
ADDRLP4 48
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492+4
ADDP4
ADDRLP4 52
INDIRI4
ASGNI4
line 64
;64:		cg.scores[i].ping = atoi( CG_Argv( i * 14 + 6 ) );
ADDRLP4 0
INDIRI4
CNSTI4 14
MULI4
CNSTI4 6
ADDI4
ARGI4
ADDRLP4 60
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492+8
ADDP4
ADDRLP4 64
INDIRI4
ASGNI4
line 65
;65:		cg.scores[i].time = atoi( CG_Argv( i * 14 + 7 ) );
ADDRLP4 0
INDIRI4
CNSTI4 14
MULI4
CNSTI4 7
ADDI4
ARGI4
ADDRLP4 72
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492+12
ADDP4
ADDRLP4 76
INDIRI4
ASGNI4
line 66
;66:		cg.scores[i].scoreFlags = atoi( CG_Argv( i * 14 + 8 ) );
ADDRLP4 0
INDIRI4
CNSTI4 14
MULI4
CNSTI4 8
ADDI4
ARGI4
ADDRLP4 84
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 88
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492+16
ADDP4
ADDRLP4 88
INDIRI4
ASGNI4
line 67
;67:		powerups = atoi( CG_Argv( i * 14 + 9 ) );
ADDRLP4 0
INDIRI4
CNSTI4 14
MULI4
CNSTI4 9
ADDI4
ARGI4
ADDRLP4 92
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 96
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 96
INDIRI4
ASGNI4
line 68
;68:		cg.scores[i].accuracy = atoi(CG_Argv(i * 14 + 10));
ADDRLP4 0
INDIRI4
CNSTI4 14
MULI4
CNSTI4 10
ADDI4
ARGI4
ADDRLP4 104
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492+24
ADDP4
ADDRLP4 108
INDIRI4
ASGNI4
line 69
;69:		cg.scores[i].impressiveCount = atoi(CG_Argv(i * 14 + 11));
ADDRLP4 0
INDIRI4
CNSTI4 14
MULI4
CNSTI4 11
ADDI4
ARGI4
ADDRLP4 116
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492+28
ADDP4
ADDRLP4 120
INDIRI4
ASGNI4
line 70
;70:		cg.scores[i].excellentCount = atoi(CG_Argv(i * 14 + 12));
ADDRLP4 0
INDIRI4
CNSTI4 14
MULI4
CNSTI4 12
ADDI4
ARGI4
ADDRLP4 128
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRLP4 132
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492+32
ADDP4
ADDRLP4 132
INDIRI4
ASGNI4
line 71
;71:		cg.scores[i].gauntletCount = atoi(CG_Argv(i * 14 + 13));
ADDRLP4 0
INDIRI4
CNSTI4 14
MULI4
CNSTI4 13
ADDI4
ARGI4
ADDRLP4 140
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 140
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492+36
ADDP4
ADDRLP4 144
INDIRI4
ASGNI4
line 72
;72:		cg.scores[i].defendCount = atoi(CG_Argv(i * 14 + 14));
ADDRLP4 0
INDIRI4
CNSTI4 14
MULI4
CNSTI4 14
ADDI4
ARGI4
ADDRLP4 152
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRLP4 156
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492+40
ADDP4
ADDRLP4 156
INDIRI4
ASGNI4
line 73
;73:		cg.scores[i].assistCount = atoi(CG_Argv(i * 14 + 15));
ADDRLP4 0
INDIRI4
CNSTI4 14
MULI4
CNSTI4 15
ADDI4
ARGI4
ADDRLP4 164
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 164
INDIRP4
ARGP4
ADDRLP4 168
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492+44
ADDP4
ADDRLP4 168
INDIRI4
ASGNI4
line 74
;74:		cg.scores[i].perfect = atoi(CG_Argv(i * 14 + 16));
ADDRLP4 0
INDIRI4
CNSTI4 14
MULI4
CNSTI4 16
ADDI4
ARGI4
ADDRLP4 176
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 176
INDIRP4
ARGP4
ADDRLP4 180
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492+52
ADDP4
ADDRLP4 180
INDIRI4
ASGNI4
line 75
;75:		cg.scores[i].captures = atoi(CG_Argv(i * 14 + 17));
ADDRLP4 0
INDIRI4
CNSTI4 14
MULI4
CNSTI4 17
ADDI4
ARGI4
ADDRLP4 188
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 188
INDIRP4
ARGP4
ADDRLP4 192
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492+48
ADDP4
ADDRLP4 192
INDIRI4
ASGNI4
line 77
;76:
;77:		if ( cg.scores[i].client < 0 || cg.scores[i].client >= MAX_CLIENTS ) {
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492
ADDP4
INDIRI4
CNSTI4 0
LTI4 $135
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492
ADDP4
INDIRI4
CNSTI4 64
LTI4 $131
LABELV $135
line 78
;78:			cg.scores[i].client = 0;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492
ADDP4
CNSTI4 0
ASGNI4
line 79
;79:		}
LABELV $131
line 80
;80:		cgs.clientinfo[ cg.scores[i].client ].score = cg.scores[i].score;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+68
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492+4
ADDP4
INDIRI4
ASGNI4
line 81
;81:		cgs.clientinfo[ cg.scores[i].client ].powerups = powerups;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+108
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 83
;82:
;83:		cg.scores[i].team = cgs.clientinfo[cg.scores[i].client].team;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492+56
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+36
ADDP4
INDIRI4
ASGNI4
line 84
;84:	}
LABELV $102
line 60
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $104
ADDRLP4 0
INDIRI4
ADDRGP4 cg+110476
INDIRI4
LTI4 $101
line 86
;85:#ifdef MISSIONPACK
;86:	CG_SetScoreSelection(NULL);
CNSTP4 0
ARGP4
ADDRGP4 CG_SetScoreSelection
CALLV
pop
line 88
;87:#endif
;88:}
LABELV $90
endproc CG_ParseScores 208 12
proc CG_ParseTeamInfo 64 4
line 96
;89:
;90:
;91:/*
;92:=================
;93:CG_ParseTeamInfo
;94:=================
;95:*/
;96:static void CG_ParseTeamInfo( void ) {
line 100
;97:	int		i;
;98:	int		client;
;99:
;100:	numSortedTeamPlayers = atoi( CG_Argv( 1 ) );
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 numSortedTeamPlayers
ADDRLP4 12
INDIRI4
ASGNI4
line 101
;101:	if( (unsigned) numSortedTeamPlayers > TEAM_MAXOVERLAY )
ADDRGP4 numSortedTeamPlayers
INDIRI4
CVIU4 4
CNSTU4 32
LEU4 $151
line 102
;102:		numSortedTeamPlayers = TEAM_MAXOVERLAY;
ADDRGP4 numSortedTeamPlayers
CNSTI4 32
ASGNI4
LABELV $151
line 104
;103:
;104:	for ( i = 0 ; i < numSortedTeamPlayers ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $156
JUMPV
LABELV $153
line 105
;105:		client = atoi( CG_Argv( i * 6 + 2 ) );
ADDRLP4 0
INDIRI4
CNSTI4 6
MULI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 16
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
ASGNI4
line 106
;106:		if ( (unsigned) client >= MAX_CLIENTS )
ADDRLP4 4
INDIRI4
CVIU4 4
CNSTU4 64
LTU4 $157
line 107
;107:			continue;
ADDRGP4 $154
JUMPV
LABELV $157
line 109
;108:
;109:		sortedTeamPlayers[i] = client;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 111
;110:
;111:		cgs.clientinfo[ client ].location = atoi( CG_Argv( i * 6 + 3 ) );
ADDRLP4 0
INDIRI4
CNSTI4 6
MULI4
CNSTI4 3
ADDI4
ARGI4
ADDRLP4 24
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+72
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 112
;112:		cgs.clientinfo[ client ].health = atoi( CG_Argv( i * 6 + 4 ) );
ADDRLP4 0
INDIRI4
CNSTI4 6
MULI4
CNSTI4 4
ADDI4
ARGI4
ADDRLP4 32
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+76
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 113
;113:		cgs.clientinfo[ client ].armor = atoi( CG_Argv( i * 6 + 5 ) );
ADDRLP4 0
INDIRI4
CNSTI4 6
MULI4
CNSTI4 5
ADDI4
ARGI4
ADDRLP4 40
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+80
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 114
;114:		cgs.clientinfo[ client ].curWeapon = atoi( CG_Argv( i * 6 + 6 ) );
ADDRLP4 0
INDIRI4
CNSTI4 6
MULI4
CNSTI4 6
ADDI4
ARGI4
ADDRLP4 48
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+84
ADDP4
ADDRLP4 52
INDIRI4
ASGNI4
line 115
;115:		cgs.clientinfo[ client ].powerups = atoi( CG_Argv( i * 6 + 7 ) );
ADDRLP4 0
INDIRI4
CNSTI4 6
MULI4
CNSTI4 7
ADDI4
ARGI4
ADDRLP4 56
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+108
ADDP4
ADDRLP4 60
INDIRI4
ASGNI4
line 116
;116:	}
LABELV $154
line 104
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $156
ADDRLP4 0
INDIRI4
ADDRGP4 numSortedTeamPlayers
INDIRI4
LTI4 $153
line 117
;117:}
LABELV $150
endproc CG_ParseTeamInfo 64 4
export CG_ParseServerinfo
proc CG_ParseServerinfo 116 16
line 128
;118:
;119:
;120:/*
;121:================
;122:CG_ParseServerinfo
;123:
;124:This is called explicitly when the gamestate is first received,
;125:and whenever the server updates any serverinfo flagged cvars
;126:================
;127:*/
;128:void CG_ParseServerinfo( void ) {
line 132
;129:	const char	*info;
;130:	char	*mapname;
;131:
;132:	info = CG_ConfigString( CS_SERVERINFO );
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 133
;133:	cgs.gametype = atoi( Info_ValueForKey( info, "g_gametype" ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $171
ARGP4
ADDRLP4 12
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31480
ADDRLP4 16
INDIRI4
ASGNI4
line 134
;134:	trap_Cvar_Set( "ui_gametype", va( "%i", cgs.gametype ) );
ADDRGP4 $173
ARGP4
ADDRGP4 cgs+31480
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $172
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 135
;135:	cgs.dmflags = atoi( Info_ValueForKey( info, "dmflags" ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $176
ARGP4
ADDRLP4 24
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31484
ADDRLP4 28
INDIRI4
ASGNI4
line 136
;136:	cgs.teamflags = atoi( Info_ValueForKey( info, "teamflags" ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $178
ARGP4
ADDRLP4 32
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31488
ADDRLP4 36
INDIRI4
ASGNI4
line 137
;137:	cgs.fraglimit = atoi( Info_ValueForKey( info, "fraglimit" ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $180
ARGP4
ADDRLP4 40
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31492
ADDRLP4 44
INDIRI4
ASGNI4
line 138
;138:	cgs.capturelimit = atoi( Info_ValueForKey( info, "capturelimit" ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $182
ARGP4
ADDRLP4 48
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31496
ADDRLP4 52
INDIRI4
ASGNI4
line 139
;139:	cgs.timelimit = atoi( Info_ValueForKey( info, "timelimit" ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $184
ARGP4
ADDRLP4 56
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31500
ADDRLP4 60
INDIRI4
ASGNI4
line 140
;140:	cgs.maxclients = atoi( Info_ValueForKey( info, "sv_maxclients" ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $186
ARGP4
ADDRLP4 64
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31504
ADDRLP4 68
INDIRI4
ASGNI4
line 141
;141:	cgs.g_grappleDelayTime = atoi(Info_ValueForKey(info, "g_grappleDelayTime"));
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $188
ARGP4
ADDRLP4 72
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+150056
ADDRLP4 76
INDIRI4
CVIU4 4
ASGNU4
line 142
;142:	cgs.g_grapplePull = atoi(Info_ValueForKey(info, "g_grapplePull"));
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $190
ARGP4
ADDRLP4 80
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+150052
ADDRLP4 84
INDIRI4
CVIU4 4
ASGNU4
line 143
;143:	cgs.g_sgPelletSpread = atoi(Info_ValueForKey(info, "g_sgPelletSpread"));
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $192
ARGP4
ADDRLP4 88
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+150060
ADDRLP4 92
INDIRI4
CVIU4 4
ASGNU4
line 144
;144:	cgs.g_sgPellets = atoi(Info_ValueForKey(info, "g_sgPellets"));
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 96
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+150064
ADDRLP4 100
INDIRI4
CVIU4 4
ASGNU4
line 145
;145:	mapname = Info_ValueForKey( info, "mapname" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $195
ARGP4
ADDRLP4 104
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 104
INDIRP4
ASGNP4
line 146
;146:	Com_sprintf( cgs.mapname, sizeof( cgs.mapname ), "maps/%s.bsp", mapname );
ADDRGP4 cgs+31508
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $198
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 148
;147:
;148:    Q_strncpyz( cgs.redTeam, Info_ValueForKey( info, "g_redteam" ), sizeof(cgs.redTeam) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $200
ARGP4
ADDRLP4 108
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 cgs+31572
ARGP4
ADDRLP4 108
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 150
;149:
;150:    if( cgs.redTeam[0] == '\0' ) {
ADDRGP4 cgs+31572
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $202
line 151
;151:        Q_strncpyz( cgs.redTeam, "^1RED", sizeof(cgs.redTeam) );
ADDRGP4 cgs+31572
ARGP4
ADDRGP4 $206
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 152
;152:    }
LABELV $202
line 154
;153:
;154:	Q_strncpyz( cgs.blueTeam, Info_ValueForKey( info, "g_blueteam" ), sizeof(cgs.blueTeam) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 112
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 cgs+31636
ARGP4
ADDRLP4 112
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 156
;155:
;156:    if( cgs.blueTeam[0] == '\0' ) {
ADDRGP4 cgs+31636
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $211
line 157
;157:        Q_strncpyz( cgs.blueTeam, "^4BLUE", sizeof(cgs.redTeam) );
ADDRGP4 cgs+31636
ARGP4
ADDRGP4 $215
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 158
;158:    }
LABELV $211
line 159
;159:}
LABELV $169
endproc CG_ParseServerinfo 116 16
export CG_ParseSysteminfo
proc CG_ParseSysteminfo 40 8
line 162
;160:
;161:
;162:void CG_ParseSysteminfo( void ) {
line 165
;163:	const char	*info;
;164:
;165:	info = CG_ConfigString( CS_SYSTEMINFO );
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 167
;166:
;167:	cgs.pmove_fixed = ( atoi( Info_ValueForKey( info, "pmove_fixed" ) ) ) ? qtrue : qfalse;
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $219
ARGP4
ADDRLP4 12
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $221
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $222
JUMPV
LABELV $221
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $222
ADDRGP4 cgs+150076
ADDRLP4 8
INDIRI4
ASGNI4
line 168
;168:	cgs.pmove_msec = atoi( Info_ValueForKey( info, "pmove_msec" ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $224
ARGP4
ADDRLP4 20
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+150080
ADDRLP4 24
INDIRI4
ASGNI4
line 169
;169:	if ( cgs.pmove_msec < 8 ) {
ADDRGP4 cgs+150080
INDIRI4
CNSTI4 8
GEI4 $225
line 170
;170:		cgs.pmove_msec = 8;
ADDRGP4 cgs+150080
CNSTI4 8
ASGNI4
line 171
;171:	} else if ( cgs.pmove_msec > 33 ) {
ADDRGP4 $226
JUMPV
LABELV $225
ADDRGP4 cgs+150080
INDIRI4
CNSTI4 33
LEI4 $229
line 172
;172:		cgs.pmove_msec = 33;
ADDRGP4 cgs+150080
CNSTI4 33
ASGNI4
line 173
;173:	}
LABELV $229
LABELV $226
line 175
;174:
;175:	cgs.synchronousClients = ( atoi( Info_ValueForKey( info, "g_synchronousClients" ) ) ) ? qtrue : qfalse;
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $234
ARGP4
ADDRLP4 32
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $236
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRGP4 $237
JUMPV
LABELV $236
ADDRLP4 28
CNSTI4 0
ASGNI4
LABELV $237
ADDRGP4 cgs+150084
ADDRLP4 28
INDIRI4
ASGNI4
line 176
;176:}
LABELV $217
endproc CG_ParseSysteminfo 40 8
proc CG_ParseWarmup 24 8
line 184
;177:
;178:
;179:/*
;180:==================
;181:CG_ParseWarmup
;182:==================
;183:*/
;184:static void CG_ParseWarmup( void ) {
line 188
;185:	const char	*info;
;186:	int			warmup;
;187:
;188:	info = CG_ConfigString( CS_WARMUP );
CNSTI4 5
ARGI4
ADDRLP4 8
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 190
;189:
;190:	warmup = atoi( info );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 191
;191:	cg.warmupCount = -1;
ADDRGP4 cg+125772
CNSTI4 -1
ASGNI4
line 193
;192:
;193:	if ( warmup ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $240
line 194
;194:		cg.timelimitWarnings |= 1 | 2 | 4;
ADDRLP4 16
ADDRGP4 cg+107616
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 7
BORI4
ASGNI4
line 195
;195:		cg.fraglimitWarnings |= 1 | 2 | 4;
ADDRLP4 20
ADDRGP4 cg+107620
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 7
BORI4
ASGNI4
line 196
;196:	}
LABELV $240
line 198
;197:
;198:	if ( cg.clientFrame == 0 ) {
ADDRGP4 cg
INDIRI4
CNSTI4 0
NEI4 $244
line 199
;199:		if ( warmup == 0 && cgs.gametype != GT_SINGLE_PLAYER ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $246
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 2
EQI4 $246
line 200
;200:			if ( cg.snap && ( cg.snap->ps.persistant[PERS_TEAM] != TEAM_SPECTATOR || cg.snap->ps.pm_flags & PMF_FOLLOW ) ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $238
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $254
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $238
LABELV $254
line 202
;201:				// force sound playback in CG_WarmupEvents()
;202:				cg.warmup = cg.time;
ADDRGP4 cg+125768
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 203
;203:				cg.warmupCount = -2; // special value to silent FIGHT sound for demo playback
ADDRGP4 cg+125772
CNSTI4 -2
ASGNI4
line 204
;204:			}
line 205
;205:			return;
ADDRGP4 $238
JUMPV
LABELV $246
line 207
;206:		}
;207:	}
LABELV $244
line 209
;208:
;209:	if ( warmup == 0 && cg.warmup ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $258
ADDRGP4 cg+125768
INDIRI4
CNSTI4 0
EQI4 $258
line 211
;210:
;211:	} else if ( warmup > 0 && cg.warmup <= 0 ) {
ADDRGP4 $259
JUMPV
LABELV $258
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $261
ADDRGP4 cg+125768
INDIRI4
CNSTI4 0
GTI4 $261
line 213
;212:#ifdef MISSIONPACK
;213:		if (cgs.gametype >= GT_CTF && cgs.gametype <= GT_HARVESTER) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 4
LTI4 $264
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 7
GTI4 $264
line 214
;214:			trap_S_StartLocalSound( cgs.media.countPrepareTeamSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+148772+1220
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 215
;215:		} else
ADDRGP4 $265
JUMPV
LABELV $264
line 217
;216:#endif
;217:		{
line 218
;218:			if ( cg.soundPlaying != cgs.media.countPrepareSound ) {
ADDRGP4 cg+125752
INDIRI4
ADDRGP4 cgs+148772+1164
INDIRI4
EQI4 $270
line 219
;219:				CG_AddBufferedSound( -1 );
CNSTI4 -1
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 220
;220:				CG_AddBufferedSound( cgs.media.countPrepareSound );
ADDRGP4 cgs+148772+1164
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 221
;221:				cg.soundTime = cg.time + 1; // play in next frame
ADDRGP4 cg+125668
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 222
;222:			}
LABELV $270
line 223
;223:		}
LABELV $265
line 224
;224:	}
LABELV $261
LABELV $259
line 226
;225:
;226:	cg.warmup = warmup;
ADDRGP4 cg+125768
ADDRLP4 0
INDIRI4
ASGNI4
line 227
;227:}
LABELV $238
endproc CG_ParseWarmup 24 8
export CG_SetConfigValues
proc CG_SetConfigValues 32 4
line 237
;228:
;229:
;230:/*
;231:================
;232:CG_SetConfigValues
;233:
;234:Called on load to set the initial values from configure strings
;235:================
;236:*/
;237:void CG_SetConfigValues( void ) {
line 240
;238:	const char *s;
;239:
;240:	cgs.scores1 = atoi( CG_ConfigString( CS_SCORES1 ) );
CNSTI4 6
ARGI4
ADDRLP4 4
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34824
ADDRLP4 8
INDIRI4
ASGNI4
line 241
;241:	cgs.scores2 = atoi( CG_ConfigString( CS_SCORES2 ) );
CNSTI4 7
ARGI4
ADDRLP4 12
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34828
ADDRLP4 16
INDIRI4
ASGNI4
line 242
;242:	cgs.levelStartTime = atoi( CG_ConfigString( CS_LEVEL_START_TIME ) );
CNSTI4 21
ARGI4
ADDRLP4 20
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34820
ADDRLP4 24
INDIRI4
ASGNI4
line 243
;243:	if( cgs.gametype == GT_CTF ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 4
NEI4 $284
line 244
;244:		s = CG_ConfigString( CS_FLAGSTATUS );
CNSTI4 23
ARGI4
ADDRLP4 28
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 245
;245:		cgs.redflag = s[0] - '0';
ADDRGP4 cgs+34832
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
ASGNI4
line 246
;246:		cgs.blueflag = s[1] - '0';
ADDRGP4 cgs+34836
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
ASGNI4
line 247
;247:	}
ADDRGP4 $285
JUMPV
LABELV $284
line 249
;248:#ifdef MISSIONPACK
;249:	else if( cgs.gametype == GT_1FCTF ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 5
NEI4 $289
line 250
;250:		s = CG_ConfigString( CS_FLAGSTATUS );
CNSTI4 23
ARGI4
ADDRLP4 28
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 251
;251:		cgs.flagStatus = s[0] - '0';
ADDRGP4 cgs+34840
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
ASGNI4
line 252
;252:	}
LABELV $289
LABELV $285
line 254
;253:#endif
;254:	CG_ParseWarmup();
ADDRGP4 CG_ParseWarmup
CALLV
pop
line 255
;255:}
LABELV $280
endproc CG_SetConfigValues 32 4
export CG_ShaderStateChanged
proc CG_ShaderStateChanged 180 12
line 263
;256:
;257:
;258:/*
;259:=====================
;260:CG_ShaderStateChanged
;261:=====================
;262:*/
;263:void CG_ShaderStateChanged(void) {
line 270
;264:	char originalShader[MAX_QPATH];
;265:	char newShader[MAX_QPATH];
;266:	char timeOffset[16];
;267:	const char *o;
;268:	char *n,*t;
;269:
;270:	o = CG_ConfigString( CS_SHADERSTATE );
CNSTI4 24
ARGI4
ADDRLP4 156
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 156
INDIRP4
ASGNP4
ADDRGP4 $295
JUMPV
LABELV $294
line 271
;271:	while (o && *o) {
line 272
;272:		n = strchr(o, '=');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 61
ARGI4
ADDRLP4 160
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 160
INDIRP4
ASGNP4
line 273
;273:		if (n) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $296
line 274
;274:			strncpy(originalShader, o, n-o);
ADDRLP4 12
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CVIU4 4
ARGU4
ADDRGP4 strncpy
CALLP4
pop
line 275
;275:			originalShader[n-o] = '\0';
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ADDRLP4 12
ADDP4
CNSTI1 0
ASGNI1
line 276
;276:			n++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 277
;277:			t = strchr(n, ':');
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 58
ARGI4
ADDRLP4 168
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 168
INDIRP4
ASGNP4
line 278
;278:			if (t) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $296
line 279
;279:				strncpy(newShader, n, t-n);
ADDRLP4 76
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CVIU4 4
ARGU4
ADDRGP4 strncpy
CALLP4
pop
line 280
;280:				newShader[t-n] = '\0';
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ADDRLP4 76
ADDP4
CNSTI1 0
ASGNI1
line 281
;281:			} else {
line 282
;282:				break;
LABELV $300
line 284
;283:			}
;284:			t++;
ADDRLP4 8
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 285
;285:			o = strchr(t, '@');
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 172
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 172
INDIRP4
ASGNP4
line 286
;286:			if (o) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $298
line 287
;287:				strncpy(timeOffset, t, o-t);
ADDRLP4 140
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CVIU4 4
ARGU4
ADDRGP4 strncpy
CALLP4
pop
line 288
;288:				timeOffset[o-t] = 0;
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ADDRLP4 140
ADDP4
CNSTI1 0
ASGNI1
line 289
;289:				o++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 290
;290:				trap_R_RemapShader( originalShader, newShader, timeOffset );
ADDRLP4 12
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 140
ARGP4
ADDRGP4 trap_R_RemapShader
CALLV
pop
line 291
;291:			}
line 292
;292:		} else {
line 293
;293:			break;
LABELV $298
line 295
;294:		}
;295:	}
LABELV $295
line 271
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $303
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $294
LABELV $303
LABELV $296
line 296
;296:}
LABELV $293
endproc CG_ShaderStateChanged 180 12
proc CG_ConfigStringModified 48 12
line 305
;297:
;298:
;299:/*
;300:================
;301:CG_ConfigStringModified
;302:
;303:================
;304:*/
;305:static void CG_ConfigStringModified( void ) {
line 309
;306:	const char	*str;
;307:	int		num;
;308:
;309:	num = atoi( CG_Argv( 1 ) );
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 313
;310:
;311:	// get the gamestate from the client system, which will have the
;312:	// new configstring already integrated
;313:	trap_GetGameState( &cgs.gameState );
ADDRGP4 cgs
ARGP4
ADDRGP4 trap_GetGameState
CALLV
pop
line 316
;314:
;315:	// look up the individual string that was modified
;316:	str = CG_ConfigString( num );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 319
;317:
;318:	// do something with it if necessary
;319:	if ( num == CS_MUSIC ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $305
line 320
;320:		CG_StartMusic();
ADDRGP4 CG_StartMusic
CALLV
pop
line 321
;321:	} else if ( num == CS_SYSTEMINFO ) {
ADDRGP4 $306
JUMPV
LABELV $305
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $307
line 322
;322:		CG_ParseSysteminfo();
ADDRGP4 CG_ParseSysteminfo
CALLV
pop
line 323
;323:	} else if ( num == CS_SERVERINFO ) {
ADDRGP4 $308
JUMPV
LABELV $307
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $309
line 324
;324:		CG_ParseServerinfo();
ADDRGP4 CG_ParseServerinfo
CALLV
pop
line 325
;325:	} else if ( num == CS_WARMUP ) {
ADDRGP4 $310
JUMPV
LABELV $309
ADDRLP4 0
INDIRI4
CNSTI4 5
NEI4 $311
line 326
;326:		CG_ParseWarmup();
ADDRGP4 CG_ParseWarmup
CALLV
pop
line 327
;327:	} else if ( num == CS_SCORES1 ) {
ADDRGP4 $312
JUMPV
LABELV $311
ADDRLP4 0
INDIRI4
CNSTI4 6
NEI4 $313
line 328
;328:		cgs.scores1 = atoi( str );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34824
ADDRLP4 20
INDIRI4
ASGNI4
line 329
;329:	} else if ( num == CS_SCORES2 ) {
ADDRGP4 $314
JUMPV
LABELV $313
ADDRLP4 0
INDIRI4
CNSTI4 7
NEI4 $316
line 330
;330:		cgs.scores2 = atoi( str );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34828
ADDRLP4 20
INDIRI4
ASGNI4
line 331
;331:	} else if ( num == CS_LEVEL_START_TIME ) {
ADDRGP4 $317
JUMPV
LABELV $316
ADDRLP4 0
INDIRI4
CNSTI4 21
NEI4 $319
line 332
;332:		cgs.levelStartTime = atoi( str );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34820
ADDRLP4 20
INDIRI4
ASGNI4
line 333
;333:	} else if ( num == CS_VOTE_TIME ) {
ADDRGP4 $320
JUMPV
LABELV $319
ADDRLP4 0
INDIRI4
CNSTI4 8
NEI4 $322
line 334
;334:		cgs.voteTime = atoi( str );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31700
ADDRLP4 20
INDIRI4
ASGNI4
line 335
;335:		cgs.voteModified = qtrue;
ADDRGP4 cgs+31712
CNSTI4 1
ASGNI4
line 336
;336:	} else if ( num == CS_VOTE_YES ) {
ADDRGP4 $323
JUMPV
LABELV $322
ADDRLP4 0
INDIRI4
CNSTI4 10
NEI4 $326
line 337
;337:		cgs.voteYes = atoi( str );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31704
ADDRLP4 20
INDIRI4
ASGNI4
line 338
;338:		cgs.voteModified = qtrue;
ADDRGP4 cgs+31712
CNSTI4 1
ASGNI4
line 339
;339:	} else if ( num == CS_VOTE_NO ) {
ADDRGP4 $327
JUMPV
LABELV $326
ADDRLP4 0
INDIRI4
CNSTI4 11
NEI4 $330
line 340
;340:		cgs.voteNo = atoi( str );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31708
ADDRLP4 20
INDIRI4
ASGNI4
line 341
;341:		cgs.voteModified = qtrue;
ADDRGP4 cgs+31712
CNSTI4 1
ASGNI4
line 342
;342:	} else if ( num == CS_VOTE_STRING ) {
ADDRGP4 $331
JUMPV
LABELV $330
ADDRLP4 0
INDIRI4
CNSTI4 9
NEI4 $334
line 343
;343:		Q_strncpyz( cgs.voteString, str, sizeof( cgs.voteString ) );
ADDRGP4 cgs+31716
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 345
;344:#ifdef MISSIONPACK
;345:		trap_S_StartLocalSound( cgs.media.voteNow, CHAN_ANNOUNCER );
ADDRGP4 cgs+148772+1024
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 347
;346:#endif //MISSIONPACK
;347:	} else if ( num >= CS_TEAMVOTE_TIME && num <= CS_TEAMVOTE_TIME + 1) {
ADDRGP4 $335
JUMPV
LABELV $334
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $340
ADDRLP4 0
INDIRI4
CNSTI4 13
GTI4 $340
line 348
;348:		cgs.teamVoteTime[num-CS_TEAMVOTE_TIME] = atoi( str );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32740-48
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 349
;349:		cgs.teamVoteModified[num-CS_TEAMVOTE_TIME] = qtrue;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32764-48
ADDP4
CNSTI4 1
ASGNI4
line 350
;350:	} else if ( num >= CS_TEAMVOTE_YES && num <= CS_TEAMVOTE_YES + 1) {
ADDRGP4 $341
JUMPV
LABELV $340
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $346
ADDRLP4 0
INDIRI4
CNSTI4 17
GTI4 $346
line 351
;351:		cgs.teamVoteYes[num-CS_TEAMVOTE_YES] = atoi( str );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32748-64
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 352
;352:		cgs.teamVoteModified[num-CS_TEAMVOTE_YES] = qtrue;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32764-64
ADDP4
CNSTI4 1
ASGNI4
line 353
;353:	} else if ( num >= CS_TEAMVOTE_NO && num <= CS_TEAMVOTE_NO + 1) {
ADDRGP4 $347
JUMPV
LABELV $346
ADDRLP4 0
INDIRI4
CNSTI4 18
LTI4 $352
ADDRLP4 0
INDIRI4
CNSTI4 19
GTI4 $352
line 354
;354:		cgs.teamVoteNo[num-CS_TEAMVOTE_NO] = atoi( str );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32756-72
ADDP4
ADDRLP4 32
INDIRI4
ASGNI4
line 355
;355:		cgs.teamVoteModified[num-CS_TEAMVOTE_NO] = qtrue;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32764-72
ADDP4
CNSTI4 1
ASGNI4
line 356
;356:	} else if ( num >= CS_TEAMVOTE_STRING && num <= CS_TEAMVOTE_STRING + 1) {
ADDRGP4 $353
JUMPV
LABELV $352
ADDRLP4 0
INDIRI4
CNSTI4 14
LTI4 $358
ADDRLP4 0
INDIRI4
CNSTI4 15
GTI4 $358
line 357
;357:		Q_strncpyz( cgs.teamVoteString[num-CS_TEAMVOTE_STRING], str, sizeof( cgs.teamVoteString[0] ) );
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 cgs+32772-14336
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 359
;358:#ifdef MISSIONPACK
;359:		trap_S_StartLocalSound( cgs.media.voteNow, CHAN_ANNOUNCER );
ADDRGP4 cgs+148772+1024
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 361
;360:#endif
;361:	} else if ( num == CS_INTERMISSION ) {
ADDRGP4 $359
JUMPV
LABELV $358
ADDRLP4 0
INDIRI4
CNSTI4 22
NEI4 $365
line 362
;362:		cg.intermissionStarted = atoi( str );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cg+24
ADDRLP4 36
INDIRI4
ASGNI4
line 363
;363:	} else if ( num >= CS_MODELS && num < CS_MODELS+MAX_MODELS ) {
ADDRGP4 $366
JUMPV
LABELV $365
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $368
ADDRLP4 0
INDIRI4
CNSTI4 288
GEI4 $368
line 364
;364:		cgs.gameModels[ num-CS_MODELS ] = trap_R_RegisterModel( str );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+34848-128
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 365
;365:	} else if ( num >= CS_SOUNDS && num < CS_SOUNDS+MAX_SOUNDS ) {
ADDRGP4 $369
JUMPV
LABELV $368
ADDRLP4 0
INDIRI4
CNSTI4 288
LTI4 $372
ADDRLP4 0
INDIRI4
CNSTI4 544
GEI4 $372
line 366
;366:		if ( str[0] != '*' ) {	// player specific sounds don't register here
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
EQI4 $373
line 367
;367:			cgs.gameSounds[ num-CS_SOUNDS] = trap_S_RegisterSound( str, qfalse );
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 44
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35872-1152
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 368
;368:		}
line 369
;369:	} else if ( num >= CS_PLAYERS && num < CS_PLAYERS+MAX_CLIENTS ) {
ADDRGP4 $373
JUMPV
LABELV $372
ADDRLP4 0
INDIRI4
CNSTI4 544
LTI4 $378
ADDRLP4 0
INDIRI4
CNSTI4 608
GEI4 $378
line 370
;370:		CG_NewClientInfo( num - CS_PLAYERS );
ADDRLP4 0
INDIRI4
CNSTI4 544
SUBI4
ARGI4
ADDRGP4 CG_NewClientInfo
CALLV
pop
line 371
;371:		CG_BuildSpectatorString();
ADDRGP4 CG_BuildSpectatorString
CALLV
pop
line 372
;372:	} else if ( num == CS_FLAGSTATUS ) {
ADDRGP4 $379
JUMPV
LABELV $378
ADDRLP4 0
INDIRI4
CNSTI4 23
NEI4 $380
line 373
;373:		if( cgs.gametype == GT_CTF ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 4
NEI4 $382
line 375
;374:			// format is rb where its red/blue, 0 is at base, 1 is taken, 2 is dropped
;375:			cgs.redflag = str[0] - '0';
ADDRGP4 cgs+34832
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
ASGNI4
line 376
;376:			cgs.blueflag = str[1] - '0';
ADDRGP4 cgs+34836
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
ASGNI4
line 377
;377:		}
ADDRGP4 $381
JUMPV
LABELV $382
line 379
;378:#ifdef MISSIONPACK
;379:		else if( cgs.gametype == GT_1FCTF ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 5
NEI4 $381
line 380
;380:			cgs.flagStatus = str[0] - '0';
ADDRGP4 cgs+34840
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
ASGNI4
line 381
;381:		}
line 383
;382:#endif
;383:	}
ADDRGP4 $381
JUMPV
LABELV $380
line 384
;384:	else if ( num == CS_SHADERSTATE ) {
ADDRLP4 0
INDIRI4
CNSTI4 24
NEI4 $391
line 385
;385:		CG_ShaderStateChanged();
ADDRGP4 CG_ShaderStateChanged
CALLV
pop
line 386
;386:	}
LABELV $391
LABELV $381
LABELV $379
LABELV $373
LABELV $369
LABELV $366
LABELV $359
LABELV $353
LABELV $347
LABELV $341
LABELV $335
LABELV $331
LABELV $327
LABELV $323
LABELV $320
LABELV $317
LABELV $314
LABELV $312
LABELV $310
LABELV $308
LABELV $306
line 388
;387:		
;388:}
LABELV $304
endproc CG_ConfigStringModified 48 12
proc CG_AddToTeamChat 40 0
line 397
;389:
;390:
;391:/*
;392:=======================
;393:CG_AddToTeamChat
;394:
;395:=======================
;396:*/
;397:static void CG_AddToTeamChat( const char *str ) {
line 403
;398:	int len;
;399:	char *p, *ls;
;400:	int lastcolor;
;401:	int chatHeight;
;402:
;403:	if (cg_teamChatHeight.integer < TEAMCHAT_HEIGHT) {
ADDRGP4 cg_teamChatHeight+12
INDIRI4
CNSTI4 8
GEI4 $394
line 404
;404:		chatHeight = cg_teamChatHeight.integer;
ADDRLP4 12
ADDRGP4 cg_teamChatHeight+12
INDIRI4
ASGNI4
line 405
;405:	} else {
ADDRGP4 $395
JUMPV
LABELV $394
line 406
;406:		chatHeight = TEAMCHAT_HEIGHT;
ADDRLP4 12
CNSTI4 8
ASGNI4
line 407
;407:	}
LABELV $395
line 409
;408:
;409:	if (chatHeight <= 0 || cg_teamChatTime.integer <= 0) {
ADDRLP4 12
INDIRI4
CNSTI4 0
LEI4 $401
ADDRGP4 cg_teamChatTime+12
INDIRI4
CNSTI4 0
GTI4 $398
LABELV $401
line 411
;410:		// team chat disabled, dump into normal chat
;411:		cgs.teamChatPos = cgs.teamLastChatPos = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 cgs+148688
ADDRLP4 20
INDIRI4
ASGNI4
ADDRGP4 cgs+148684
ADDRLP4 20
INDIRI4
ASGNI4
line 412
;412:		return;
ADDRGP4 $393
JUMPV
LABELV $398
line 415
;413:	}
;414:
;415:	len = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 417
;416:
;417:	p = cgs.teamChatMsgs[cgs.teamChatPos % chatHeight];
ADDRLP4 0
ADDRGP4 cgs+148684
INDIRI4
ADDRLP4 12
INDIRI4
MODI4
CNSTI4 241
MULI4
ADDRGP4 cgs+146724
ADDP4
ASGNP4
line 418
;418:	*p = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 420
;419:
;420:	lastcolor = '7';
ADDRLP4 16
CNSTI4 55
ASGNI4
line 422
;421:
;422:	ls = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
ADDRGP4 $407
JUMPV
LABELV $406
line 423
;423:	while (*str) {
line 424
;424:		if (len > TEAMCHAT_WIDTH - 1) {
ADDRLP4 4
INDIRI4
CNSTI4 79
LEI4 $409
line 425
;425:			if (ls) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $411
line 426
;426:				str -= (p - ls);
ADDRFP4 0
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
SUBP4
ASGNP4
line 427
;427:				str++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 428
;428:				p -= (p - ls);
ADDRLP4 0
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
SUBP4
ASGNP4
line 429
;429:			}
LABELV $411
line 430
;430:			*p = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 432
;431:
;432:			cgs.teamChatMsgTimes[cgs.teamChatPos % chatHeight] = cg.time;
ADDRGP4 cgs+148684
INDIRI4
ADDRLP4 12
INDIRI4
MODI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+148652
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 434
;433:
;434:			cgs.teamChatPos++;
ADDRLP4 20
ADDRGP4 cgs+148684
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 435
;435:			p = cgs.teamChatMsgs[cgs.teamChatPos % chatHeight];
ADDRLP4 0
ADDRGP4 cgs+148684
INDIRI4
ADDRLP4 12
INDIRI4
MODI4
CNSTI4 241
MULI4
ADDRGP4 cgs+146724
ADDP4
ASGNP4
line 436
;436:			*p = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 437
;437:			*p++ = Q_COLOR_ESCAPE;
ADDRLP4 24
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI1 94
ASGNI1
line 438
;438:			*p++ = lastcolor;
ADDRLP4 28
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 16
INDIRI4
CVII1 4
ASGNI1
line 439
;439:			len = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 440
;440:			ls = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 441
;441:		}
LABELV $409
line 443
;442:
;443:		if ( Q_IsColorString( str ) ) {
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $419
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $419
ADDRLP4 20
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $419
ADDRLP4 20
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $419
line 444
;444:			*p++ = *str++;
ADDRLP4 24
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI1
ASGNI1
line 445
;445:			lastcolor = *str;
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 446
;446:			*p++ = *str++;
ADDRLP4 32
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 36
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI1
ASGNI1
line 447
;447:			continue;
ADDRGP4 $407
JUMPV
LABELV $419
line 449
;448:		}
;449:		if (*str == ' ') {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
NEI4 $421
line 450
;450:			ls = p;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
line 451
;451:		}
LABELV $421
line 452
;452:		*p++ = *str++;
ADDRLP4 24
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI1
ASGNI1
line 453
;453:		len++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 454
;454:	}
LABELV $407
line 423
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $406
line 455
;455:	*p = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 457
;456:
;457:	cgs.teamChatMsgTimes[cgs.teamChatPos % chatHeight] = cg.time;
ADDRGP4 cgs+148684
INDIRI4
ADDRLP4 12
INDIRI4
MODI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+148652
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 458
;458:	cgs.teamChatPos++;
ADDRLP4 20
ADDRGP4 cgs+148684
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 460
;459:
;460:	if (cgs.teamChatPos - cgs.teamLastChatPos > chatHeight)
ADDRGP4 cgs+148684
INDIRI4
ADDRGP4 cgs+148688
INDIRI4
SUBI4
ADDRLP4 12
INDIRI4
LEI4 $427
line 461
;461:		cgs.teamLastChatPos = cgs.teamChatPos - chatHeight;
ADDRGP4 cgs+148688
ADDRGP4 cgs+148684
INDIRI4
ADDRLP4 12
INDIRI4
SUBI4
ASGNI4
LABELV $427
line 462
;462:}
LABELV $393
endproc CG_AddToTeamChat 40 0
proc CG_MapRestart 8 8
line 475
;463:
;464:/*
;465:===============
;466:CG_MapRestart
;467:
;468:The server has issued a map_restart, so the next snapshot
;469:is completely new and should not be interpolated to.
;470:
;471:A tournement restart will clear everything, but doesn't
;472:require a reload of all the media
;473:===============
;474:*/
;475:static void CG_MapRestart( void ) {
line 476
;476:	if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $434
line 477
;477:		CG_Printf( "CG_MapRestart\n" );
ADDRGP4 $437
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 478
;478:	}
LABELV $434
line 480
;479:
;480:	CG_InitLocalEntities();
ADDRGP4 CG_InitLocalEntities
CALLV
pop
line 481
;481:	CG_InitMarkPolys();
ADDRGP4 CG_InitMarkPolys
CALLV
pop
line 482
;482:	CG_ClearParticles ();
ADDRGP4 CG_ClearParticles
CALLV
pop
line 485
;483:
;484:	// make sure the "3 frags left" warnings play again
;485:	cg.fraglimitWarnings = 0;
ADDRGP4 cg+107620
CNSTI4 0
ASGNI4
line 486
;486:	cg.timelimitWarnings = 0;
ADDRGP4 cg+107616
CNSTI4 0
ASGNI4
line 488
;487:
;488:	cg.rewardTime = 0;
ADDRGP4 cg+125536
CNSTI4 0
ASGNI4
line 489
;489:	cg.rewardStack = 0;
ADDRGP4 cg+125532
CNSTI4 0
ASGNI4
line 490
;490:	cg.intermissionStarted = qfalse;
ADDRGP4 cg+24
CNSTI4 0
ASGNI4
line 491
;491:	cg.levelShot = qfalse;
ADDRGP4 cg+12
CNSTI4 0
ASGNI4
line 493
;492:
;493:	cgs.voteTime = 0;
ADDRGP4 cgs+31700
CNSTI4 0
ASGNI4
line 495
;494:
;495:	cg.mapRestart = qtrue;
ADDRGP4 cg+107624
CNSTI4 1
ASGNI4
line 497
;496:
;497:	CG_StartMusic();
ADDRGP4 CG_StartMusic
CALLV
pop
line 499
;498:
;499:	trap_S_ClearLoopingSounds( qtrue );
CNSTI4 1
ARGI4
ADDRGP4 trap_S_ClearLoopingSounds
CALLV
pop
line 501
;500:
;501:	cg.allowPickupPrediction = cg.time + PICKUP_PREDICTION_DELAY;
ADDRGP4 cg+157024
ADDRGP4 cg+107604
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 506
;502:
;503:	// we really should clear more parts of cg here and stop sounds
;504:
;505:	// play the "fight" sound if this is a restart without warmup
;506:	if ( cg.warmup == 0 /* && cgs.gametype == GT_TOURNAMENT */ ) {
ADDRGP4 cg+125768
INDIRI4
CNSTI4 0
NEI4 $448
line 508
;507:		// force sound playback in CG_WarmupEvents()
;508:		cg.warmup = cg.time;
ADDRGP4 cg+125768
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 509
;509:		cg.warmupCount = -1;
ADDRGP4 cg+125772
CNSTI4 -1
ASGNI4
line 510
;510:	}
LABELV $448
line 513
;511:
;512:#ifdef MISSIONPACK
;513:	if (cg_singlePlayerActive.integer) {
ADDRGP4 cg_singlePlayerActive+12
INDIRI4
CNSTI4 0
EQI4 $454
line 514
;514:		trap_Cvar_Set("ui_matchStartTime", va("%i", cg.time));
ADDRGP4 $173
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $457
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 515
;515:		if (cg_recordSPDemo.integer && *cg_recordSPDemoName.string) {
ADDRGP4 cg_recordSPDemo+12
INDIRI4
CNSTI4 0
EQI4 $459
ADDRGP4 cg_recordSPDemoName+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $459
line 516
;516:			trap_SendConsoleCommand(va("set g_synchronousclients 1 ; record %s \n", cg_recordSPDemoName.string));
ADDRGP4 $463
ARGP4
ADDRGP4 cg_recordSPDemoName+16
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 517
;517:		}
LABELV $459
line 518
;518:	}
LABELV $454
line 521
;519:#endif
;520:
;521:	trap_Cvar_Set( "cg_thirdPerson", "0" );
ADDRGP4 $465
ARGP4
ADDRGP4 $466
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 522
;522:}
LABELV $433
endproc CG_MapRestart 8 8
export CG_ParseVoiceChats
proc CG_ParseVoiceChats 16488 16
line 563
;523:
;524:#ifdef MISSIONPACK
;525:
;526:#define MAX_VOICEFILESIZE	16384
;527:#define MAX_VOICEFILES		8
;528:#define MAX_VOICECHATS		64
;529:#define MAX_VOICESOUNDS		64
;530:#define MAX_CHATSIZE		64
;531:#define MAX_HEADMODELS		64
;532:
;533:typedef struct voiceChat_s
;534:{
;535:	char id[64];
;536:	int numSounds;
;537:	sfxHandle_t sounds[MAX_VOICESOUNDS];
;538:	char chats[MAX_VOICESOUNDS][MAX_CHATSIZE];
;539:} voiceChat_t;
;540:
;541:typedef struct voiceChatList_s
;542:{
;543:	char name[64];
;544:	int gender;
;545:	int numVoiceChats;
;546:	voiceChat_t voiceChats[MAX_VOICECHATS];
;547:} voiceChatList_t;
;548:
;549:typedef struct headModelVoiceChat_s
;550:{
;551:	char headmodel[64];
;552:	int voiceChatNum;
;553:} headModelVoiceChat_t;
;554:
;555:voiceChatList_t voiceChatLists[MAX_VOICEFILES];
;556:headModelVoiceChat_t headModelVoiceChat[MAX_HEADMODELS];
;557:
;558:/*
;559:=================
;560:CG_ParseVoiceChats
;561:=================
;562:*/
;563:int CG_ParseVoiceChats( const char *filename, voiceChatList_t *voiceChatList, int maxVoiceChats ) {
line 573
;564:	int	len, i;
;565:	fileHandle_t f;
;566:	char buf[MAX_VOICEFILESIZE];
;567:	char **p, *ptr;
;568:	char *token;
;569:	voiceChat_t *voiceChats;
;570:	qboolean compress;
;571:	sfxHandle_t sound;
;572:
;573:	compress = qtrue;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 574
;574:	if (cg_buildScript.integer) {
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $468
line 575
;575:		compress = qfalse;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 576
;576:	}
LABELV $468
line 578
;577:
;578:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 16420
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 16420
INDIRI4
ASGNI4
line 579
;579:	if ( f == FS_INVALID_HANDLE ) {
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $471
line 580
;580:		trap_Print( va( S_COLOR_RED "voice chat file not found: %s\n", filename ) );
ADDRGP4 $473
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16424
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16424
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 581
;581:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $467
JUMPV
LABELV $471
line 583
;582:	}
;583:	if ( len >= MAX_VOICEFILESIZE ) {
ADDRLP4 24
INDIRI4
CNSTI4 16384
LTI4 $474
line 584
;584:		trap_Print( va( S_COLOR_RED "voice chat file too large: %s is %i, max allowed is %i", filename, len, MAX_VOICEFILESIZE ) );
ADDRGP4 $476
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
CNSTI4 16384
ARGI4
ADDRLP4 16424
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16424
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 585
;585:		trap_FS_FCloseFile( f );
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 586
;586:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $467
JUMPV
LABELV $474
line 589
;587:	}
;588:
;589:	trap_FS_Read( buf, len, f );
ADDRLP4 32
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 590
;590:	buf[len] = 0;
ADDRLP4 24
INDIRI4
ADDRLP4 32
ADDP4
CNSTI1 0
ASGNI1
line 591
;591:	trap_FS_FCloseFile( f );
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 593
;592:
;593:	ptr = buf;
ADDRLP4 16416
ADDRLP4 32
ASGNP4
line 594
;594:	p = &ptr;
ADDRLP4 12
ADDRLP4 16416
ASGNP4
line 596
;595:
;596:	Com_sprintf(voiceChatList->name, sizeof(voiceChatList->name), "%s", filename);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $477
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 597
;597:	voiceChats = voiceChatList->voiceChats;
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
line 598
;598:	for ( i = 0; i < maxVoiceChats; i++ ) {
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 $481
JUMPV
LABELV $478
line 599
;599:		voiceChats[i].id[0] = 0;
ADDRLP4 20
INDIRI4
CNSTI4 4420
MULI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 600
;600:	}
LABELV $479
line 598
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $481
ADDRLP4 20
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $478
line 601
;601:	token = COM_ParseExt(p, qtrue);
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 16424
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16424
INDIRP4
ASGNP4
line 602
;602:	if (token[0] == '\0') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $482
line 603
;603:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $467
JUMPV
LABELV $482
line 605
;604:	}
;605:	if (!Q_stricmp(token, "female")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $486
ARGP4
ADDRLP4 16428
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16428
INDIRI4
CNSTI4 0
NEI4 $484
line 606
;606:		voiceChatList->gender = GENDER_FEMALE;
ADDRFP4 4
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 1
ASGNI4
line 607
;607:	}
ADDRGP4 $485
JUMPV
LABELV $484
line 608
;608:	else if (!Q_stricmp(token, "male")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $489
ARGP4
ADDRLP4 16432
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16432
INDIRI4
CNSTI4 0
NEI4 $487
line 609
;609:		voiceChatList->gender = GENDER_MALE;
ADDRFP4 4
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 0
ASGNI4
line 610
;610:	}
ADDRGP4 $488
JUMPV
LABELV $487
line 611
;611:	else if (!Q_stricmp(token, "neuter")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $492
ARGP4
ADDRLP4 16436
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16436
INDIRI4
CNSTI4 0
NEI4 $490
line 612
;612:		voiceChatList->gender = GENDER_NEUTER;
ADDRFP4 4
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 2
ASGNI4
line 613
;613:	}
ADDRGP4 $491
JUMPV
LABELV $490
line 614
;614:	else {
line 615
;615:		trap_Print( va( S_COLOR_RED "expected gender not found in voice chat file: %s\n", filename ) );
ADDRGP4 $493
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16440
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16440
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 616
;616:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $467
JUMPV
LABELV $491
LABELV $488
LABELV $485
line 619
;617:	}
;618:
;619:	voiceChatList->numVoiceChats = 0;
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 0
ASGNI4
ADDRGP4 $495
JUMPV
LABELV $494
line 620
;620:	while ( 1 ) {
line 621
;621:		token = COM_ParseExt(p, qtrue);
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 16440
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16440
INDIRP4
ASGNP4
line 622
;622:		if (token[0] == '\0') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $497
line 623
;623:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $467
JUMPV
LABELV $497
line 625
;624:		}
;625:		Com_sprintf(voiceChats[voiceChatList->numVoiceChats].id, sizeof( voiceChats[voiceChatList->numVoiceChats].id ), "%s", token);
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4420
MULI4
ADDRLP4 4
INDIRP4
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $477
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 626
;626:		token = COM_ParseExt(p, qtrue);
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 16444
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16444
INDIRP4
ASGNP4
line 627
;627:		if (Q_stricmp(token, "{")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $501
ARGP4
ADDRLP4 16448
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16448
INDIRI4
CNSTI4 0
EQI4 $499
line 628
;628:			trap_Print( va( S_COLOR_RED "expected { found %s in voice chat file: %s\n", token, filename ) );
ADDRGP4 $502
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16452
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16452
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 629
;629:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $467
JUMPV
LABELV $499
line 631
;630:		}
;631:		voiceChats[voiceChatList->numVoiceChats].numSounds = 0;
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4420
MULI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 64
ADDP4
CNSTI4 0
ASGNI4
ADDRGP4 $504
JUMPV
LABELV $503
line 632
;632:		while(1) {
line 633
;633:			token = COM_ParseExt(p, qtrue);
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 16452
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16452
INDIRP4
ASGNP4
line 634
;634:			if (token[0] == '\0') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $506
line 635
;635:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $467
JUMPV
LABELV $506
line 637
;636:			}
;637:			if (!Q_stricmp(token, "}"))
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $510
ARGP4
ADDRLP4 16456
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16456
INDIRI4
CNSTI4 0
NEI4 $508
line 638
;638:				break;
ADDRGP4 $505
JUMPV
LABELV $508
line 639
;639:			sound = trap_S_RegisterSound( token, compress );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 16460
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16460
INDIRI4
ASGNI4
line 640
;640:			voiceChats[voiceChatList->numVoiceChats].sounds[voiceChats[voiceChatList->numVoiceChats].numSounds] = sound;
ADDRLP4 16464
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16464
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4420
MULI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16464
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4420
MULI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 68
ADDP4
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 641
;641:			token = COM_ParseExt(p, qtrue);
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 16472
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16472
INDIRP4
ASGNP4
line 642
;642:			if (token[0] == '\0') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $511
line 643
;643:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $467
JUMPV
LABELV $511
line 645
;644:			}
;645:			Com_sprintf(voiceChats[voiceChatList->numVoiceChats].chats[
ADDRLP4 16476
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16476
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4420
MULI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 6
LSHI4
ADDRLP4 16476
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4420
MULI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 324
ADDP4
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $477
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 647
;646:							voiceChats[voiceChatList->numVoiceChats].numSounds], MAX_CHATSIZE, "%s", token);
;647:			if (sound)
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $513
line 648
;648:				voiceChats[voiceChatList->numVoiceChats].numSounds++;
ADDRLP4 16484
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4420
MULI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 64
ADDP4
ASGNP4
ADDRLP4 16484
INDIRP4
ADDRLP4 16484
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $513
line 649
;649:			if (voiceChats[voiceChatList->numVoiceChats].numSounds >= MAX_VOICESOUNDS)
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4420
MULI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 64
LTI4 $515
line 650
;650:				break;
ADDRGP4 $505
JUMPV
LABELV $515
line 651
;651:		}
LABELV $504
line 632
ADDRGP4 $503
JUMPV
LABELV $505
line 652
;652:		voiceChatList->numVoiceChats++;
ADDRLP4 16452
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 16452
INDIRP4
ADDRLP4 16452
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 653
;653:		if (voiceChatList->numVoiceChats >= maxVoiceChats)
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $517
line 654
;654:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $467
JUMPV
LABELV $517
line 655
;655:	}
LABELV $495
line 620
ADDRGP4 $494
JUMPV
line 656
;656:	return qtrue;
CNSTI4 1
RETI4
LABELV $467
endproc CG_ParseVoiceChats 16488 16
export CG_LoadVoiceChats
proc CG_LoadVoiceChats 12 12
line 664
;657:}
;658:
;659:/*
;660:=================
;661:CG_LoadVoiceChats
;662:=================
;663:*/
;664:void CG_LoadVoiceChats( void ) {
line 667
;665:	int size;
;666:
;667:	size = trap_MemoryRemaining();
ADDRLP4 4
ADDRGP4 trap_MemoryRemaining
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 668
;668:	CG_ParseVoiceChats( "scripts/female1.voice", &voiceChatLists[0], MAX_VOICECHATS );
ADDRGP4 $520
ARGP4
ADDRGP4 voiceChatLists
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 CG_ParseVoiceChats
CALLI4
pop
line 669
;669:	CG_ParseVoiceChats( "scripts/female2.voice", &voiceChatLists[1], MAX_VOICECHATS );
ADDRGP4 $521
ARGP4
ADDRGP4 voiceChatLists+282952
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 CG_ParseVoiceChats
CALLI4
pop
line 670
;670:	CG_ParseVoiceChats( "scripts/female3.voice", &voiceChatLists[2], MAX_VOICECHATS );
ADDRGP4 $523
ARGP4
ADDRGP4 voiceChatLists+565904
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 CG_ParseVoiceChats
CALLI4
pop
line 671
;671:	CG_ParseVoiceChats( "scripts/male1.voice", &voiceChatLists[3], MAX_VOICECHATS );
ADDRGP4 $525
ARGP4
ADDRGP4 voiceChatLists+848856
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 CG_ParseVoiceChats
CALLI4
pop
line 672
;672:	CG_ParseVoiceChats( "scripts/male2.voice", &voiceChatLists[4], MAX_VOICECHATS );
ADDRGP4 $527
ARGP4
ADDRGP4 voiceChatLists+1131808
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 CG_ParseVoiceChats
CALLI4
pop
line 673
;673:	CG_ParseVoiceChats( "scripts/male3.voice", &voiceChatLists[5], MAX_VOICECHATS );
ADDRGP4 $529
ARGP4
ADDRGP4 voiceChatLists+1414760
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 CG_ParseVoiceChats
CALLI4
pop
line 674
;674:	CG_ParseVoiceChats( "scripts/male4.voice", &voiceChatLists[6], MAX_VOICECHATS );
ADDRGP4 $531
ARGP4
ADDRGP4 voiceChatLists+1697712
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 CG_ParseVoiceChats
CALLI4
pop
line 675
;675:	CG_ParseVoiceChats( "scripts/male5.voice", &voiceChatLists[7], MAX_VOICECHATS );
ADDRGP4 $533
ARGP4
ADDRGP4 voiceChatLists+1980664
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 CG_ParseVoiceChats
CALLI4
pop
line 676
;676:	CG_Printf("voice chat memory size = %d\n", size - trap_MemoryRemaining());
ADDRLP4 8
ADDRGP4 trap_MemoryRemaining
CALLI4
ASGNI4
ADDRGP4 $535
ARGP4
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 677
;677:}
LABELV $519
endproc CG_LoadVoiceChats 12 12
export CG_HeadModelVoiceChats
proc CG_HeadModelVoiceChats 16420 16
line 684
;678:
;679:/*
;680:=================
;681:CG_HeadModelVoiceChats
;682:=================
;683:*/
;684:int CG_HeadModelVoiceChats( char *filename ) {
line 691
;685:	int	len, i;
;686:	fileHandle_t f;
;687:	char buf[MAX_VOICEFILESIZE];
;688:	char **p, *ptr;
;689:	char *token;
;690:
;691:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 16408
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16408
INDIRI4
ASGNI4
line 692
;692:	if ( f == FS_INVALID_HANDLE ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $537
line 694
;693:		//trap_Print( va( "voice chat file not found: %s\n", filename ) );
;694:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $536
JUMPV
LABELV $537
line 696
;695:	}
;696:	if ( len >= MAX_VOICEFILESIZE ) {
ADDRLP4 8
INDIRI4
CNSTI4 16384
LTI4 $539
line 697
;697:		trap_Print( va( S_COLOR_RED "voice chat file too large: %s is %i, max allowed is %i", filename, len, MAX_VOICEFILESIZE ) );
ADDRGP4 $476
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
CNSTI4 16384
ARGI4
ADDRLP4 16412
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16412
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 698
;698:		trap_FS_FCloseFile( f );
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 699
;699:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $536
JUMPV
LABELV $539
line 702
;700:	}
;701:
;702:	trap_FS_Read( buf, len, f );
ADDRLP4 16
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 703
;703:	buf[len] = 0;
ADDRLP4 8
INDIRI4
ADDRLP4 16
ADDP4
CNSTI1 0
ASGNI1
line 704
;704:	trap_FS_FCloseFile( f );
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 706
;705:
;706:	ptr = buf;
ADDRLP4 16404
ADDRLP4 16
ASGNP4
line 707
;707:	p = &ptr;
ADDRLP4 16400
ADDRLP4 16404
ASGNP4
line 709
;708:
;709:	token = COM_ParseExt(p, qtrue);
ADDRLP4 16400
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 16412
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16412
INDIRP4
ASGNP4
line 710
;710:	if ( token[0] == '\0' ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $541
line 711
;711:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $536
JUMPV
LABELV $541
line 714
;712:	}
;713:
;714:	for ( i = 0; i < MAX_VOICEFILES; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $543
line 715
;715:		if ( !Q_stricmp(token, voiceChatLists[i].name) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 282952
MULI4
ADDRGP4 voiceChatLists
ADDP4
ARGP4
ADDRLP4 16416
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16416
INDIRI4
CNSTI4 0
NEI4 $547
line 716
;716:			return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $536
JUMPV
LABELV $547
line 718
;717:		}
;718:	}
LABELV $544
line 714
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $543
line 722
;719:
;720:	//FIXME: maybe try to load the .voice file which name is stored in token?
;721:
;722:	return -1;
CNSTI4 -1
RETI4
LABELV $536
endproc CG_HeadModelVoiceChats 16420 16
export CG_GetVoiceChat
proc CG_GetVoiceChat 16 8
line 731
;723:}
;724:
;725:
;726:/*
;727:=================
;728:CG_GetVoiceChat
;729:=================
;730:*/
;731:int CG_GetVoiceChat( voiceChatList_t *voiceChatList, const char *id, sfxHandle_t *snd, char **chat) {
line 734
;732:	int i, rnd;
;733:
;734:	for ( i = 0; i < voiceChatList->numVoiceChats; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $553
JUMPV
LABELV $550
line 735
;735:		if ( !Q_stricmp( id, voiceChatList->voiceChats[i].id ) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 4420
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $554
line 736
;736:			rnd = random() * voiceChatList->voiceChats[i].numSounds;
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ADDRLP4 0
INDIRI4
CNSTI4 4420
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDP4
CNSTI4 64
ADDP4
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 737
;737:			*snd = voiceChatList->voiceChats[i].sounds[rnd];
ADDRFP4 8
INDIRP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 4420
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDP4
CNSTI4 68
ADDP4
ADDP4
INDIRI4
ASGNI4
line 738
;738:			*chat = voiceChatList->voiceChats[i].chats[rnd];
ADDRFP4 12
INDIRP4
ADDRLP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 4420
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDP4
CNSTI4 324
ADDP4
ADDP4
ASGNP4
line 739
;739:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $549
JUMPV
LABELV $554
line 741
;740:		}
;741:	}
LABELV $551
line 734
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $553
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
LTI4 $550
line 742
;742:	return qfalse;
CNSTI4 0
RETI4
LABELV $549
endproc CG_GetVoiceChat 16 8
export CG_VoiceChatListForClient
proc CG_VoiceChatListForClient 164 20
line 751
;743:}
;744:
;745:
;746:/*
;747:=================
;748:CG_VoiceChatListForClient
;749:=================
;750:*/
;751:voiceChatList_t *CG_VoiceChatListForClient( int clientNum ) {
line 756
;752:	clientInfo_t *ci;
;753:	int voiceChatNum, i, j, k, gender;
;754:	char filename[MAX_QPATH], headModelName[MAX_QPATH];
;755:
;756:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS ) {
ADDRLP4 152
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
LTI4 $559
ADDRLP4 152
INDIRI4
CNSTI4 64
LTI4 $557
LABELV $559
line 757
;757:		clientNum = 0;
ADDRFP4 0
CNSTI4 0
ASGNI4
line 758
;758:	}
LABELV $557
line 759
;759:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 148
ADDRFP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 761
;760:
;761:	for ( k = 0; k < 2; k++ ) {
ADDRLP4 144
CNSTI4 0
ASGNI4
LABELV $561
line 762
;762:		if ( k == 0 ) {
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $565
line 763
;763:			if (ci->headModelName[0] == '*') {
ADDRLP4 148
INDIRP4
CNSTI4 256
ADDP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $567
line 764
;764:				Com_sprintf( headModelName, sizeof(headModelName), "%s/%s", ci->headModelName+1, ci->headSkinName );
ADDRLP4 8
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $569
ARGP4
ADDRLP4 148
INDIRP4
CNSTI4 257
ADDP4
ARGP4
ADDRLP4 148
INDIRP4
CNSTI4 320
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 765
;765:			}
ADDRGP4 $566
JUMPV
LABELV $567
line 766
;766:			else {
line 767
;767:				Com_sprintf( headModelName, sizeof(headModelName), "%s/%s", ci->headModelName, ci->headSkinName );
ADDRLP4 8
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $569
ARGP4
ADDRLP4 148
INDIRP4
CNSTI4 256
ADDP4
ARGP4
ADDRLP4 148
INDIRP4
CNSTI4 320
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 768
;768:			}
line 769
;769:		}
ADDRGP4 $566
JUMPV
LABELV $565
line 770
;770:		else {
line 771
;771:			if (ci->headModelName[0] == '*') {
ADDRLP4 148
INDIRP4
CNSTI4 256
ADDP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $570
line 772
;772:				Com_sprintf( headModelName, sizeof(headModelName), "%s", ci->headModelName+1 );
ADDRLP4 8
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $477
ARGP4
ADDRLP4 148
INDIRP4
CNSTI4 257
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 773
;773:			}
ADDRGP4 $571
JUMPV
LABELV $570
line 774
;774:			else {
line 775
;775:				Com_sprintf( headModelName, sizeof(headModelName), "%s", ci->headModelName );
ADDRLP4 8
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $477
ARGP4
ADDRLP4 148
INDIRP4
CNSTI4 256
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 776
;776:			}
LABELV $571
line 777
;777:		}
LABELV $566
line 779
;778:		// find the voice file for the head model the client uses
;779:		for ( i = 0; i < MAX_HEADMODELS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $572
line 780
;780:			if (!Q_stricmp(headModelVoiceChat[i].headmodel, headModelName)) {
ADDRLP4 0
INDIRI4
CNSTI4 68
MULI4
ADDRGP4 headModelVoiceChat
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 156
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
NEI4 $576
line 781
;781:				break;
ADDRGP4 $574
JUMPV
LABELV $576
line 783
;782:			}
;783:		}
LABELV $573
line 779
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $572
LABELV $574
line 784
;784:		if (i < MAX_HEADMODELS) {
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $578
line 785
;785:			return &voiceChatLists[headModelVoiceChat[i].voiceChatNum];
ADDRLP4 0
INDIRI4
CNSTI4 68
MULI4
ADDRGP4 headModelVoiceChat+64
ADDP4
INDIRI4
CNSTI4 282952
MULI4
ADDRGP4 voiceChatLists
ADDP4
RETP4
ADDRGP4 $556
JUMPV
LABELV $578
line 788
;786:		}
;787:		// find a <headmodelname>.vc file
;788:		for ( i = 0; i < MAX_HEADMODELS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $581
line 789
;789:			if (!strlen(headModelVoiceChat[i].headmodel)) {
ADDRLP4 0
INDIRI4
CNSTI4 68
MULI4
ADDRGP4 headModelVoiceChat
ADDP4
ARGP4
ADDRLP4 156
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 156
INDIRU4
CNSTU4 0
NEU4 $585
line 790
;790:				Com_sprintf(filename, sizeof(filename), "scripts/%s.vc", headModelName);
ADDRLP4 76
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $587
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 791
;791:				voiceChatNum = CG_HeadModelVoiceChats(filename);
ADDRLP4 76
ARGP4
ADDRLP4 160
ADDRGP4 CG_HeadModelVoiceChats
CALLI4
ASGNI4
ADDRLP4 72
ADDRLP4 160
INDIRI4
ASGNI4
line 792
;792:				if (voiceChatNum == -1)
ADDRLP4 72
INDIRI4
CNSTI4 -1
NEI4 $588
line 793
;793:					break;
ADDRGP4 $583
JUMPV
LABELV $588
line 794
;794:				Com_sprintf(headModelVoiceChat[i].headmodel, sizeof ( headModelVoiceChat[i].headmodel ),
ADDRLP4 0
INDIRI4
CNSTI4 68
MULI4
ADDRGP4 headModelVoiceChat
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $477
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 796
;795:							"%s", headModelName);
;796:				headModelVoiceChat[i].voiceChatNum = voiceChatNum;
ADDRLP4 0
INDIRI4
CNSTI4 68
MULI4
ADDRGP4 headModelVoiceChat+64
ADDP4
ADDRLP4 72
INDIRI4
ASGNI4
line 797
;797:				return &voiceChatLists[headModelVoiceChat[i].voiceChatNum];
ADDRLP4 0
INDIRI4
CNSTI4 68
MULI4
ADDRGP4 headModelVoiceChat+64
ADDP4
INDIRI4
CNSTI4 282952
MULI4
ADDRGP4 voiceChatLists
ADDP4
RETP4
ADDRGP4 $556
JUMPV
LABELV $585
line 799
;798:			}
;799:		}
LABELV $582
line 788
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $581
LABELV $583
line 800
;800:	}
LABELV $562
line 761
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 2
LTI4 $561
line 801
;801:	gender = ci->gender;
ADDRLP4 140
ADDRLP4 148
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
ASGNI4
line 802
;802:	for (k = 0; k < 2; k++) {
ADDRLP4 144
CNSTI4 0
ASGNI4
LABELV $592
line 804
;803:		// just pick the first with the right gender
;804:		for ( i = 0; i < MAX_VOICEFILES; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $596
line 805
;805:			if (strlen(voiceChatLists[i].name)) {
ADDRLP4 0
INDIRI4
CNSTI4 282952
MULI4
ADDRGP4 voiceChatLists
ADDP4
ARGP4
ADDRLP4 156
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 156
INDIRU4
CNSTU4 0
EQU4 $600
line 806
;806:				if (voiceChatLists[i].gender == gender) {
ADDRLP4 0
INDIRI4
CNSTI4 282952
MULI4
ADDRGP4 voiceChatLists+64
ADDP4
INDIRI4
ADDRLP4 140
INDIRI4
NEI4 $602
line 808
;807:					// store this head model with voice chat for future reference
;808:					for ( j = 0; j < MAX_HEADMODELS; j++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $605
line 809
;809:						if (!strlen(headModelVoiceChat[j].headmodel)) {
ADDRLP4 4
INDIRI4
CNSTI4 68
MULI4
ADDRGP4 headModelVoiceChat
ADDP4
ARGP4
ADDRLP4 160
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 160
INDIRU4
CNSTU4 0
NEU4 $609
line 810
;810:							Com_sprintf(headModelVoiceChat[j].headmodel, sizeof ( headModelVoiceChat[j].headmodel ),
ADDRLP4 4
INDIRI4
CNSTI4 68
MULI4
ADDRGP4 headModelVoiceChat
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $477
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 812
;811:									"%s", headModelName);
;812:							headModelVoiceChat[j].voiceChatNum = i;
ADDRLP4 4
INDIRI4
CNSTI4 68
MULI4
ADDRGP4 headModelVoiceChat+64
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 813
;813:							break;
ADDRGP4 $607
JUMPV
LABELV $609
line 815
;814:						}
;815:					}
LABELV $606
line 808
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $605
LABELV $607
line 816
;816:					return &voiceChatLists[i];
ADDRLP4 0
INDIRI4
CNSTI4 282952
MULI4
ADDRGP4 voiceChatLists
ADDP4
RETP4
ADDRGP4 $556
JUMPV
LABELV $602
line 818
;817:				}
;818:			}
LABELV $600
line 819
;819:		}
LABELV $597
line 804
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $596
line 821
;820:		// fall back to male gender because we don't have neuter in the mission pack
;821:		if (gender == GENDER_MALE)
ADDRLP4 140
INDIRI4
CNSTI4 0
NEI4 $612
line 822
;822:			break;
ADDRGP4 $594
JUMPV
LABELV $612
line 823
;823:		gender = GENDER_MALE;
ADDRLP4 140
CNSTI4 0
ASGNI4
line 824
;824:	}
LABELV $593
line 802
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 2
LTI4 $592
LABELV $594
line 826
;825:	// store this head model with voice chat for future reference
;826:	for ( j = 0; j < MAX_HEADMODELS; j++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $614
line 827
;827:		if (!strlen(headModelVoiceChat[j].headmodel)) {
ADDRLP4 4
INDIRI4
CNSTI4 68
MULI4
ADDRGP4 headModelVoiceChat
ADDP4
ARGP4
ADDRLP4 156
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 156
INDIRU4
CNSTU4 0
NEU4 $618
line 828
;828:			Com_sprintf(headModelVoiceChat[j].headmodel, sizeof ( headModelVoiceChat[j].headmodel ),
ADDRLP4 4
INDIRI4
CNSTI4 68
MULI4
ADDRGP4 headModelVoiceChat
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $477
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 830
;829:					"%s", headModelName);
;830:			headModelVoiceChat[j].voiceChatNum = 0;
ADDRLP4 4
INDIRI4
CNSTI4 68
MULI4
ADDRGP4 headModelVoiceChat+64
ADDP4
CNSTI4 0
ASGNI4
line 831
;831:			break;
ADDRGP4 $616
JUMPV
LABELV $618
line 833
;832:		}
;833:	}
LABELV $615
line 826
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $614
LABELV $616
line 835
;834:	// just return the first voice chat list
;835:	return &voiceChatLists[0];
ADDRGP4 voiceChatLists
RETP4
LABELV $556
endproc CG_VoiceChatListForClient 164 20
export CG_PlayVoiceChat
proc CG_PlayVoiceChat 8 12
line 856
;836:}
;837:
;838:#define MAX_VOICECHATBUFFER		32
;839:
;840:typedef struct bufferedVoiceChat_s
;841:{
;842:	int clientNum;
;843:	sfxHandle_t snd;
;844:	int voiceOnly;
;845:	char cmd[MAX_SAY_TEXT];
;846:	char message[MAX_SAY_TEXT];
;847:} bufferedVoiceChat_t;
;848:
;849:bufferedVoiceChat_t voiceChatBuffer[MAX_VOICECHATBUFFER];
;850:
;851:/*
;852:=================
;853:CG_PlayVoiceChat
;854:=================
;855:*/
;856:void CG_PlayVoiceChat( bufferedVoiceChat_t *vchat ) {
line 859
;857:
;858:	// if we are going into the intermission, don't start any voices
;859:	if ( cg.intermissionStarted ) {
ADDRGP4 cg+24
INDIRI4
CNSTI4 0
EQI4 $622
line 860
;860:		return;
ADDRGP4 $621
JUMPV
LABELV $622
line 863
;861:	}
;862:
;863:	if ( !cg_noVoiceChats.integer ) {
ADDRGP4 cg_noVoiceChats+12
INDIRI4
CNSTI4 0
NEI4 $625
line 864
;864:		trap_S_StartLocalSound( vchat->snd, CHAN_VOICE);
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 865
;865:		if (vchat->clientNum != cg.snap->ps.clientNum) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $628
line 866
;866:			int orderTask = CG_ValidOrder(vchat->cmd);
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 CG_ValidOrder
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 867
;867:			if (orderTask > 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $631
line 868
;868:				cgs.acceptOrderTime = cg.time + 5000;
ADDRGP4 cgs+148728
ADDRGP4 cg+107604
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 869
;869:				Q_strncpyz(cgs.acceptVoice, vchat->cmd, sizeof(cgs.acceptVoice));
ADDRGP4 cgs+148740
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 870
;870:				cgs.acceptTask = orderTask;
ADDRGP4 cgs+148732
ADDRLP4 0
INDIRI4
ASGNI4
line 871
;871:				cgs.acceptLeader = vchat->clientNum;
ADDRGP4 cgs+148736
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 872
;872:			}
LABELV $631
line 874
;873:			// see if this was an order
;874:			CG_ShowResponseHead();
ADDRGP4 CG_ShowResponseHead
CALLV
pop
line 875
;875:		}
LABELV $628
line 876
;876:	}
LABELV $625
line 877
;877:	if (!vchat->voiceOnly && !cg_noVoiceText.integer) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
NEI4 $639
ADDRGP4 cg_noVoiceText+12
INDIRI4
CNSTI4 0
NEI4 $639
line 878
;878:		CG_AddToTeamChat( vchat->message );
ADDRFP4 0
INDIRP4
CNSTI4 162
ADDP4
ARGP4
ADDRGP4 CG_AddToTeamChat
CALLV
pop
line 879
;879:		CG_Printf( "%s\n", vchat->message );
ADDRGP4 $642
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 162
ADDP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 880
;880:	}
LABELV $639
line 881
;881:	voiceChatBuffer[cg.voiceChatBufferOut].snd = 0;
ADDRGP4 cg+125764
INDIRI4
CNSTI4 312
MULI4
ADDRGP4 voiceChatBuffer+4
ADDP4
CNSTI4 0
ASGNI4
line 882
;882:}
LABELV $621
endproc CG_PlayVoiceChat 8 12
export CG_PlayBufferedVoiceChats
proc CG_PlayBufferedVoiceChats 0 4
line 890
;883:
;884:
;885:/*
;886:=====================
;887:CG_PlayBufferedVoieChats
;888:=====================
;889:*/
;890:void CG_PlayBufferedVoiceChats( void ) {
line 891
;891:	if ( cg.voiceChatTime < cg.time ) {
ADDRGP4 cg+125756
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $646
line 892
;892:		if (cg.voiceChatBufferOut != cg.voiceChatBufferIn && voiceChatBuffer[cg.voiceChatBufferOut].snd) {
ADDRGP4 cg+125764
INDIRI4
ADDRGP4 cg+125760
INDIRI4
EQI4 $650
ADDRGP4 cg+125764
INDIRI4
CNSTI4 312
MULI4
ADDRGP4 voiceChatBuffer+4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $650
line 894
;893:			//
;894:			CG_PlayVoiceChat(&voiceChatBuffer[cg.voiceChatBufferOut]);
ADDRGP4 cg+125764
INDIRI4
CNSTI4 312
MULI4
ADDRGP4 voiceChatBuffer
ADDP4
ARGP4
ADDRGP4 CG_PlayVoiceChat
CALLV
pop
line 896
;895:			//
;896:			cg.voiceChatBufferOut = (cg.voiceChatBufferOut + 1) % MAX_VOICECHATBUFFER;
ADDRGP4 cg+125764
ADDRGP4 cg+125764
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 32
MODI4
ASGNI4
line 897
;897:			cg.voiceChatTime = cg.time + 1000;
ADDRGP4 cg+125756
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 898
;898:		}
LABELV $650
line 899
;899:	}
LABELV $646
line 900
;900:}
LABELV $645
endproc CG_PlayBufferedVoiceChats 0 4
export CG_AddBufferedVoiceChat
proc CG_AddBufferedVoiceChat 4 12
line 908
;901:
;902:
;903:/*
;904:=====================
;905:CG_AddBufferedVoiceChat
;906:=====================
;907:*/
;908:void CG_AddBufferedVoiceChat( bufferedVoiceChat_t *vchat ) {
line 911
;909:
;910:	// if we are going into the intermission, don't start any voices
;911:	if ( cg.intermissionStarted ) {
ADDRGP4 cg+24
INDIRI4
CNSTI4 0
EQI4 $662
line 912
;912:		return;
ADDRGP4 $661
JUMPV
LABELV $662
line 915
;913:	}
;914:
;915:	memcpy(&voiceChatBuffer[cg.voiceChatBufferIn], vchat, sizeof(bufferedVoiceChat_t));
ADDRGP4 cg+125760
INDIRI4
CNSTI4 312
MULI4
ADDRGP4 voiceChatBuffer
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTU4 312
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 916
;916:	cg.voiceChatBufferIn = (cg.voiceChatBufferIn + 1) % MAX_VOICECHATBUFFER;
ADDRGP4 cg+125760
ADDRGP4 cg+125760
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 32
MODI4
ASGNI4
line 917
;917:	if (cg.voiceChatBufferIn == cg.voiceChatBufferOut) {
ADDRGP4 cg+125760
INDIRI4
ADDRGP4 cg+125764
INDIRI4
NEI4 $668
line 918
;918:		CG_PlayVoiceChat( &voiceChatBuffer[cg.voiceChatBufferOut] );
ADDRGP4 cg+125764
INDIRI4
CNSTI4 312
MULI4
ADDRGP4 voiceChatBuffer
ADDP4
ARGP4
ADDRGP4 CG_PlayVoiceChat
CALLV
pop
line 919
;919:		cg.voiceChatBufferOut++;
ADDRLP4 0
ADDRGP4 cg+125764
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 920
;920:	}
LABELV $668
line 921
;921:}
LABELV $661
endproc CG_AddBufferedVoiceChat 4 12
export CG_VoiceChatLocal
proc CG_VoiceChatLocal 340 32
line 929
;922:
;923:
;924:/*
;925:=================
;926:CG_VoiceChatLocal
;927:=================
;928:*/
;929:void CG_VoiceChatLocal( int mode, qboolean voiceOnly, int clientNum, int color, const char *cmd ) {
line 938
;930:
;931:	char *chat;
;932:	voiceChatList_t *voiceChatList;
;933:	clientInfo_t *ci;
;934:	sfxHandle_t snd;
;935:	bufferedVoiceChat_t vchat;
;936:
;937:	// if we are going into the intermission, don't start any voices
;938:	if ( cg.intermissionStarted ) {
ADDRGP4 cg+24
INDIRI4
CNSTI4 0
EQI4 $675
line 939
;939:		return;
ADDRGP4 $674
JUMPV
LABELV $675
line 942
;940:	}
;941:
;942:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS ) {
ADDRLP4 328
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 328
INDIRI4
CNSTI4 0
LTI4 $680
ADDRLP4 328
INDIRI4
CNSTI4 64
LTI4 $678
LABELV $680
line 943
;943:		clientNum = 0;
ADDRFP4 8
CNSTI4 0
ASGNI4
line 944
;944:	}
LABELV $678
line 945
;945:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 320
ADDRFP4 8
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 947
;946:
;947:	cgs.currentVoiceClient = clientNum;
ADDRGP4 cgs+148724
ADDRFP4 8
INDIRI4
ASGNI4
line 949
;948:
;949:	voiceChatList = CG_VoiceChatListForClient( clientNum );
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 332
ADDRGP4 CG_VoiceChatListForClient
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 332
INDIRP4
ASGNP4
line 951
;950:
;951:	if ( CG_GetVoiceChat( voiceChatList, cmd, &snd, &chat ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 324
ARGP4
ADDRLP4 316
ARGP4
ADDRLP4 336
ADDRGP4 CG_GetVoiceChat
CALLI4
ASGNI4
ADDRLP4 336
INDIRI4
CNSTI4 0
EQI4 $683
line 953
;952:		//
;953:		if ( mode == SAY_TEAM || !cg_teamChatsOnly.integer ) {
ADDRFP4 0
INDIRI4
CNSTI4 1
EQI4 $688
ADDRGP4 cg_teamChatsOnly+12
INDIRI4
CNSTI4 0
NEI4 $685
LABELV $688
line 954
;954:			vchat.clientNum = clientNum;
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
line 955
;955:			vchat.snd = snd;
ADDRLP4 4+4
ADDRLP4 324
INDIRI4
ASGNI4
line 956
;956:			vchat.voiceOnly = voiceOnly;
ADDRLP4 4+8
ADDRFP4 4
INDIRI4
ASGNI4
line 957
;957:			Q_strncpyz(vchat.cmd, cmd, sizeof(vchat.cmd));
ADDRLP4 4+12
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
CNSTI4 150
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 958
;958:			if ( mode == SAY_TELL ) {
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $693
line 959
;959:				Com_sprintf(vchat.message, sizeof(vchat.message), "(%i) [%s]: %c%c%s", clientNum, ci->name, Q_COLOR_ESCAPE, color, chat);
ADDRLP4 4+162
ARGP4
CNSTI4 150
ARGI4
ADDRGP4 $697
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 320
INDIRP4
CNSTI4 4
ADDP4
ARGP4
CNSTI4 94
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 316
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 960
;960:			}
ADDRGP4 $694
JUMPV
LABELV $693
line 961
;961:			else if ( mode == SAY_TEAM ) {
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $698
line 962
;962:				Com_sprintf(vchat.message, sizeof(vchat.message), "(%i) (%s): %c%c%s", clientNum, ci->name, Q_COLOR_ESCAPE, color, chat);
ADDRLP4 4+162
ARGP4
CNSTI4 150
ARGI4
ADDRGP4 $702
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 320
INDIRP4
CNSTI4 4
ADDP4
ARGP4
CNSTI4 94
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 316
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 963
;963:			}
ADDRGP4 $699
JUMPV
LABELV $698
line 964
;964:			else {
line 965
;965:				Com_sprintf(vchat.message, sizeof(vchat.message), "(%i) %s: %c%c%s", clientNum, ci->name, Q_COLOR_ESCAPE, color, chat);
ADDRLP4 4+162
ARGP4
CNSTI4 150
ARGI4
ADDRGP4 $705
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 320
INDIRP4
CNSTI4 4
ADDP4
ARGP4
CNSTI4 94
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 316
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 966
;966:			}
LABELV $699
LABELV $694
line 967
;967:			CG_AddBufferedVoiceChat(&vchat);
ADDRLP4 4
ARGP4
ADDRGP4 CG_AddBufferedVoiceChat
CALLV
pop
line 968
;968:		}
LABELV $685
line 969
;969:	}
LABELV $683
line 970
;970:}
LABELV $674
endproc CG_VoiceChatLocal 340 32
export CG_VoiceChat
proc CG_VoiceChat 64 20
line 978
;971:
;972:
;973:/*
;974:=================
;975:CG_VoiceChat
;976:=================
;977:*/
;978:void CG_VoiceChat( int mode ) {
line 983
;979:	const char *cmd;
;980:	int clientNum, color;
;981:	qboolean voiceOnly;
;982:
;983:	voiceOnly = atoi(CG_Argv(1));
CNSTI4 1
ARGI4
ADDRLP4 16
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 20
INDIRI4
ASGNI4
line 984
;984:	clientNum = atoi(CG_Argv(2));
CNSTI4 2
ARGI4
ADDRLP4 24
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 28
INDIRI4
ASGNI4
line 985
;985:	color = atoi(CG_Argv(3));
CNSTI4 3
ARGI4
ADDRLP4 32
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 36
INDIRI4
ASGNI4
line 986
;986:	cmd = CG_Argv(4);
CNSTI4 4
ARGI4
ADDRLP4 40
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 40
INDIRP4
ASGNP4
line 988
;987:
;988:	if (cg_noTaunt.integer != 0) {
ADDRGP4 cg_noTaunt+12
INDIRI4
CNSTI4 0
EQI4 $707
line 989
;989:		if (!strcmp(cmd, VOICECHAT_KILLINSULT)  || !strcmp(cmd, VOICECHAT_TAUNT) || \
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $712
ARGP4
ADDRLP4 44
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $720
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $713
ARGP4
ADDRLP4 48
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $720
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $714
ARGP4
ADDRLP4 52
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $720
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $715
ARGP4
ADDRLP4 56
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $720
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $716
ARGP4
ADDRLP4 60
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $710
LABELV $720
line 992
;990:			!strcmp(cmd, VOICECHAT_DEATHINSULT) || !strcmp(cmd, VOICECHAT_KILLGAUNTLET) || \
;991:			!strcmp(cmd, VOICECHAT_PRAISE)) {
;992:			return;
ADDRGP4 $706
JUMPV
LABELV $710
line 994
;993:		}
;994:	}
LABELV $707
line 996
;995:
;996:	CG_VoiceChatLocal( mode, voiceOnly, clientNum, color, cmd );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_VoiceChatLocal
CALLV
pop
line 997
;997:}
LABELV $706
endproc CG_VoiceChat 64 20
proc CG_RemoveChatEscapeChar 12 0
line 1006
;998:#endif // MISSIONPACK
;999:
;1000:
;1001:/*
;1002:=================
;1003:CG_RemoveChatEscapeChar
;1004:=================
;1005:*/
;1006:static void CG_RemoveChatEscapeChar( char *text ) {
line 1009
;1007:	int i, l;
;1008:
;1009:	l = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1010
;1010:	for ( i = 0; text[i]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $725
JUMPV
LABELV $722
line 1011
;1011:		if (text[i] == '\x19')
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 25
NEI4 $726
line 1012
;1012:			continue;
ADDRGP4 $723
JUMPV
LABELV $726
line 1013
;1013:		text[l] = text[i];
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 1014
;1014:		l++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1015
;1015:	}
LABELV $723
line 1010
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $725
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $722
line 1016
;1016:	text[l] = '\0';
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1017
;1017:}
LABELV $721
endproc CG_RemoveChatEscapeChar 12 0
proc CG_ServerCommand 420 12
line 1028
;1018:
;1019:
;1020:/*
;1021:=================
;1022:CG_ServerCommand
;1023:
;1024:The string has been tokenized and can be retrieved with
;1025:Cmd_Argc() / Cmd_Argv()
;1026:=================
;1027:*/
;1028:static void CG_ServerCommand( void ) {
line 1032
;1029:	const char	*cmd, *id;
;1030:	char		text[MAX_SAY_TEXT];
;1031:
;1032:	cmd = CG_Argv(0);
CNSTI4 0
ARGI4
ADDRLP4 160
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 160
INDIRP4
ASGNP4
line 1034
;1033:
;1034:	if ( !cmd[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $729
line 1036
;1035:		// server claimed the command
;1036:		return;
ADDRGP4 $728
JUMPV
LABELV $729
line 1039
;1037:	}
;1038:
;1039:	if ( !strcmp( cmd, "cp" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $733
ARGP4
ADDRLP4 164
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
NEI4 $731
line 1040
;1040:		CG_CenterPrint( CG_Argv(1), SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
CNSTI4 1
ARGI4
ADDRLP4 168
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 168
INDIRP4
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 1041
;1041:		return;
ADDRGP4 $728
JUMPV
LABELV $731
line 1044
;1042:	}
;1043:
;1044:	if ( !strcmp( cmd, "cs" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $736
ARGP4
ADDRLP4 168
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
NEI4 $734
line 1045
;1045:		CG_ConfigStringModified();
ADDRGP4 CG_ConfigStringModified
CALLV
pop
line 1046
;1046:		return;
ADDRGP4 $728
JUMPV
LABELV $734
line 1049
;1047:	}
;1048:
;1049:	if ( !strcmp( cmd, "print" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $739
ARGP4
ADDRLP4 172
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
NEI4 $737
line 1050
;1050:		CG_Printf( "%s", CG_Argv(1) );
CNSTI4 1
ARGI4
ADDRLP4 176
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRGP4 $477
ARGP4
ADDRLP4 176
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1052
;1051:#ifdef MISSIONPACK
;1052:		cmd = CG_Argv(1);			// yes, this is obviously a hack, but so is the way we hear about
CNSTI4 1
ARGI4
ADDRLP4 180
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 180
INDIRP4
ASGNP4
line 1054
;1053:									// votes passing or failing
;1054:		if ( !Q_stricmpn( cmd, "vote failed", 11 ) || !Q_stricmpn( cmd, "team vote failed", 16 )) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $742
ARGP4
CNSTI4 11
ARGI4
ADDRLP4 184
ADDRGP4 Q_stricmpn
CALLI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 0
EQI4 $744
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $743
ARGP4
CNSTI4 16
ARGI4
ADDRLP4 188
ADDRGP4 Q_stricmpn
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 0
NEI4 $740
LABELV $744
line 1055
;1055:			trap_S_StartLocalSound( cgs.media.voteFailed, CHAN_ANNOUNCER );
ADDRGP4 cgs+148772+1032
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1056
;1056:		} else if ( !Q_stricmpn( cmd, "vote passed", 11 ) || !Q_stricmpn( cmd, "team vote passed", 16 ) ) {
ADDRGP4 $728
JUMPV
LABELV $740
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $749
ARGP4
CNSTI4 11
ARGI4
ADDRLP4 192
ADDRGP4 Q_stricmpn
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
EQI4 $751
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $750
ARGP4
CNSTI4 16
ARGI4
ADDRLP4 196
ADDRGP4 Q_stricmpn
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
NEI4 $728
LABELV $751
line 1057
;1057:			trap_S_StartLocalSound( cgs.media.votePassed, CHAN_ANNOUNCER );
ADDRGP4 cgs+148772+1028
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1058
;1058:		}
line 1060
;1059:#endif
;1060:		return;
ADDRGP4 $728
JUMPV
LABELV $737
line 1063
;1061:	}
;1062:
;1063:	if ( !strcmp( cmd, "chat" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $756
ARGP4
ADDRLP4 176
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
NEI4 $754
line 1064
;1064:		if ( !cg_teamChatsOnly.integer ) {
ADDRGP4 cg_teamChatsOnly+12
INDIRI4
CNSTI4 0
NEI4 $728
line 1065
;1065:			trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+148772+908
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1066
;1066:			Q_strncpyz( text, CG_Argv(1), MAX_SAY_TEXT );
CNSTI4 1
ARGI4
ADDRLP4 180
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 180
INDIRP4
ARGP4
CNSTI4 150
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1067
;1067:			CG_RemoveChatEscapeChar( text );
ADDRLP4 4
ARGP4
ADDRGP4 CG_RemoveChatEscapeChar
CALLV
pop
line 1068
;1068:			id = CG_Argv( 2 );
CNSTI4 2
ARGI4
ADDRLP4 184
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 156
ADDRLP4 184
INDIRP4
ASGNP4
line 1069
;1069:			if ( *id >= '0' && *id <= '9' )
ADDRLP4 188
ADDRLP4 156
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 48
LTI4 $762
ADDRLP4 188
INDIRI4
CNSTI4 57
GTI4 $762
line 1070
;1070:				CG_Printf( "(%i) %s\n", atoi( id ), text );
ADDRLP4 156
INDIRP4
ARGP4
ADDRLP4 192
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 $764
ARGP4
ADDRLP4 192
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
ADDRGP4 $728
JUMPV
LABELV $762
line 1072
;1071:			else
;1072:				CG_Printf( "%s\n", text );
ADDRGP4 $642
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1073
;1073:		}
line 1074
;1074:		return;
ADDRGP4 $728
JUMPV
LABELV $754
line 1077
;1075:	}
;1076:
;1077:	if ( !strcmp( cmd, "tchat" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $767
ARGP4
ADDRLP4 180
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
NEI4 $765
line 1078
;1078:		trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+148772+908
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1079
;1079:		Q_strncpyz( text, CG_Argv(1), MAX_SAY_TEXT );
CNSTI4 1
ARGI4
ADDRLP4 184
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 184
INDIRP4
ARGP4
CNSTI4 150
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1080
;1080:		CG_RemoveChatEscapeChar( text );
ADDRLP4 4
ARGP4
ADDRGP4 CG_RemoveChatEscapeChar
CALLV
pop
line 1081
;1081:		CG_AddToTeamChat( text );
ADDRLP4 4
ARGP4
ADDRGP4 CG_AddToTeamChat
CALLV
pop
line 1082
;1082:		id = CG_Argv( 2 );
CNSTI4 2
ARGI4
ADDRLP4 188
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 156
ADDRLP4 188
INDIRP4
ASGNP4
line 1083
;1083:		if ( *id >= '0' && *id <= '9' )
ADDRLP4 192
ADDRLP4 156
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 48
LTI4 $770
ADDRLP4 192
INDIRI4
CNSTI4 57
GTI4 $770
line 1084
;1084:			CG_Printf( "(%i) %s\n", atoi( id ), text );
ADDRLP4 156
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 $764
ARGP4
ADDRLP4 196
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
ADDRGP4 $728
JUMPV
LABELV $770
line 1086
;1085:		else
;1086:			CG_Printf( "%s\n", text );
ADDRGP4 $642
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1087
;1087:		return;
ADDRGP4 $728
JUMPV
LABELV $765
line 1091
;1088:	}
;1089:
;1090:#ifdef MISSIONPACK
;1091:	if ( !strcmp( cmd, "vchat" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $774
ARGP4
ADDRLP4 184
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 0
NEI4 $772
line 1092
;1092:		CG_VoiceChat( SAY_ALL );
CNSTI4 0
ARGI4
ADDRGP4 CG_VoiceChat
CALLV
pop
line 1093
;1093:		return;
ADDRGP4 $728
JUMPV
LABELV $772
line 1096
;1094:	}
;1095:
;1096:	if ( !strcmp( cmd, "vtchat" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $777
ARGP4
ADDRLP4 188
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 0
NEI4 $775
line 1097
;1097:		CG_VoiceChat( SAY_TEAM );
CNSTI4 1
ARGI4
ADDRGP4 CG_VoiceChat
CALLV
pop
line 1098
;1098:		return;
ADDRGP4 $728
JUMPV
LABELV $775
line 1101
;1099:	}
;1100:
;1101:	if ( !strcmp( cmd, "vtell" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $780
ARGP4
ADDRLP4 192
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
NEI4 $778
line 1102
;1102:		CG_VoiceChat( SAY_TELL );
CNSTI4 2
ARGI4
ADDRGP4 CG_VoiceChat
CALLV
pop
line 1103
;1103:		return;
ADDRGP4 $728
JUMPV
LABELV $778
line 1107
;1104:	}
;1105:#endif
;1106:
;1107:	if ( !strcmp( cmd, "scores" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $783
ARGP4
ADDRLP4 196
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
NEI4 $781
line 1108
;1108:		CG_ParseScores();
ADDRGP4 CG_ParseScores
CALLV
pop
line 1109
;1109:		return;
ADDRGP4 $728
JUMPV
LABELV $781
line 1112
;1110:	}
;1111:
;1112:	if ( !strcmp( cmd, "tinfo" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $786
ARGP4
ADDRLP4 200
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
NEI4 $784
line 1113
;1113:		CG_ParseTeamInfo();
ADDRGP4 CG_ParseTeamInfo
CALLV
pop
line 1114
;1114:		return;
ADDRGP4 $728
JUMPV
LABELV $784
line 1117
;1115:	}
;1116:
;1117:	if ( !strcmp( cmd, "map_restart" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $789
ARGP4
ADDRLP4 204
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
NEI4 $787
line 1118
;1118:		CG_MapRestart();
ADDRGP4 CG_MapRestart
CALLV
pop
line 1119
;1119:		return;
ADDRGP4 $728
JUMPV
LABELV $787
line 1122
;1120:	}
;1121:
;1122:	if ( Q_stricmp (cmd, "remapShader") == 0 )
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $792
ARGP4
ADDRLP4 208
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 208
INDIRI4
CNSTI4 0
NEI4 $790
line 1123
;1123:	{
line 1124
;1124:		if (trap_Argc() == 4)
ADDRLP4 212
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 212
INDIRI4
CNSTI4 4
NEI4 $728
line 1125
;1125:		{
line 1130
;1126:			char shader1[MAX_QPATH];
;1127:			char shader2[MAX_QPATH];
;1128:			char shader3[MAX_QPATH];
;1129:
;1130:			Q_strncpyz(shader1, CG_Argv(1), sizeof(shader1));
CNSTI4 1
ARGI4
ADDRLP4 408
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 216
ARGP4
ADDRLP4 408
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1131
;1131:			Q_strncpyz(shader2, CG_Argv(2), sizeof(shader2));
CNSTI4 2
ARGI4
ADDRLP4 412
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 280
ARGP4
ADDRLP4 412
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1132
;1132:			Q_strncpyz(shader3, CG_Argv(3), sizeof(shader3));
CNSTI4 3
ARGI4
ADDRLP4 416
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 344
ARGP4
ADDRLP4 416
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1134
;1133:
;1134:			trap_R_RemapShader(shader1, shader2, shader3);
ADDRLP4 216
ARGP4
ADDRLP4 280
ARGP4
ADDRLP4 344
ARGP4
ADDRGP4 trap_R_RemapShader
CALLV
pop
line 1135
;1135:		}
line 1137
;1136:		
;1137:		return;
ADDRGP4 $728
JUMPV
LABELV $790
line 1141
;1138:	}
;1139:
;1140:	// loaddeferred can be both a servercmd and a consolecmd
;1141:	if ( !strcmp( cmd, "loaddeferred" ) ) {	// FIXME: spelled wrong, but not changing for demo
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $797
ARGP4
ADDRLP4 212
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 212
INDIRI4
CNSTI4 0
NEI4 $795
line 1142
;1142:		CG_LoadDeferredPlayers();
ADDRGP4 CG_LoadDeferredPlayers
CALLV
pop
line 1143
;1143:		return;
ADDRGP4 $728
JUMPV
LABELV $795
line 1148
;1144:	}
;1145:
;1146:	// clientLevelShot is sent before taking a special screenshot for
;1147:	// the menu system during development
;1148:	if ( !strcmp( cmd, "clientLevelShot" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $800
ARGP4
ADDRLP4 216
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 216
INDIRI4
CNSTI4 0
NEI4 $798
line 1149
;1149:		cg.levelShot = qtrue;
ADDRGP4 cg+12
CNSTI4 1
ASGNI4
line 1150
;1150:		return;
ADDRGP4 $728
JUMPV
LABELV $798
line 1153
;1151:	}
;1152:
;1153:	if ( cgs.defrag && cg.demoPlayback ) {
ADDRGP4 cgs+150092
INDIRI4
CNSTI4 0
EQI4 $802
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
EQI4 $802
line 1154
;1154:		if ( !strcmp( cmd, "aswitch" ) || !strcmp( cmd, "stats" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $808
ARGP4
ADDRLP4 220
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 220
INDIRI4
CNSTI4 0
EQI4 $810
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $809
ARGP4
ADDRLP4 224
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 224
INDIRI4
CNSTI4 0
NEI4 $806
LABELV $810
line 1155
;1155:			return;
ADDRGP4 $728
JUMPV
LABELV $806
line 1157
;1156:		}
;1157:	}
LABELV $802
line 1159
;1158:
;1159:	CG_Printf( "Unknown client game command: %s\n", cmd );
ADDRGP4 $811
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1160
;1160:}
LABELV $728
endproc CG_ServerCommand 420 12
export CG_ExecuteNewServerCommands
proc CG_ExecuteNewServerCommands 12 4
line 1171
;1161:
;1162:
;1163:/*
;1164:====================
;1165:CG_ExecuteNewServerCommands
;1166:
;1167:Execute all of the server commands that were received along
;1168:with this this snapshot.
;1169:====================
;1170:*/
;1171:void CG_ExecuteNewServerCommands( int latestSequence ) {
ADDRGP4 $814
JUMPV
LABELV $813
line 1172
;1172:	while ( cgs.serverCommandSequence < latestSequence ) {
line 1173
;1173:		if ( trap_GetServerCommand( ++cgs.serverCommandSequence ) ) {
ADDRLP4 0
ADDRGP4 cgs+31468
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 trap_GetServerCommand
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $817
line 1174
;1174:			CG_ServerCommand();
ADDRGP4 CG_ServerCommand
CALLV
pop
line 1175
;1175:		}
LABELV $817
line 1176
;1176:	}
LABELV $814
line 1172
ADDRGP4 cgs+31468
INDIRI4
ADDRFP4 0
INDIRI4
LTI4 $813
line 1177
;1177:}
LABELV $812
endproc CG_ExecuteNewServerCommands 12 4
bss
export voiceChatBuffer
align 4
LABELV voiceChatBuffer
skip 9984
export headModelVoiceChat
align 4
LABELV headModelVoiceChat
skip 4352
export voiceChatLists
align 4
LABELV voiceChatLists
skip 2263616
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
import CG_StatusHandle
import CG_OtherTeamHasFlag
import CG_YourTeamHasFlag
import CG_GameTypeString
import CG_CheckOrderPending
import CG_Text_PaintChar
import CG_Draw3DModel
import CG_GetKillerText
import CG_GetGameStatusText
import CG_GetTeamColor
import CG_InitTeamChat
import CG_SetPrintString
import CG_ShowResponseHead
import CG_RunMenuScript
import CG_OwnerDrawVisible
import CG_GetValue
import CG_SelectNextPlayer
import CG_SelectPrevPlayer
import CG_Text_Height
import CG_Text_Width
import CG_Text_Paint
import CG_OwnerDraw
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
import drawTeamOverlayModificationCount
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
import CG_EventHandling
import CG_MouseEvent
import CG_KeyEvent
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
LABELV $811
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $809
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $808
byte 1 97
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $800
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 76
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $797
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $792
byte 1 114
byte 1 101
byte 1 109
byte 1 97
byte 1 112
byte 1 83
byte 1 104
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $789
byte 1 109
byte 1 97
byte 1 112
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $786
byte 1 116
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 0
align 1
LABELV $783
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $780
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $777
byte 1 118
byte 1 116
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $774
byte 1 118
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $767
byte 1 116
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $764
byte 1 40
byte 1 37
byte 1 105
byte 1 41
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $756
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $750
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $749
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $743
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $742
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $739
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $736
byte 1 99
byte 1 115
byte 1 0
align 1
LABELV $733
byte 1 99
byte 1 112
byte 1 0
align 1
LABELV $716
byte 1 112
byte 1 114
byte 1 97
byte 1 105
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $715
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $714
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 105
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $713
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $712
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 105
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $705
byte 1 40
byte 1 37
byte 1 105
byte 1 41
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $702
byte 1 40
byte 1 37
byte 1 105
byte 1 41
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 58
byte 1 32
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $697
byte 1 40
byte 1 37
byte 1 105
byte 1 41
byte 1 32
byte 1 91
byte 1 37
byte 1 115
byte 1 93
byte 1 58
byte 1 32
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $642
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $587
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 118
byte 1 99
byte 1 0
align 1
LABELV $569
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $535
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 32
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 61
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $533
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 53
byte 1 46
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $531
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 52
byte 1 46
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $529
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 51
byte 1 46
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $527
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 50
byte 1 46
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $525
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 49
byte 1 46
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $523
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 102
byte 1 101
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 51
byte 1 46
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $521
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 102
byte 1 101
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 50
byte 1 46
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $520
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 102
byte 1 101
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 49
byte 1 46
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $510
byte 1 125
byte 1 0
align 1
LABELV $502
byte 1 94
byte 1 49
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 123
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $501
byte 1 123
byte 1 0
align 1
LABELV $493
byte 1 94
byte 1 49
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 103
byte 1 101
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $492
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $489
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $486
byte 1 102
byte 1 101
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $477
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $476
byte 1 94
byte 1 49
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 108
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 44
byte 1 32
byte 1 109
byte 1 97
byte 1 120
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $473
byte 1 94
byte 1 49
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $466
byte 1 48
byte 1 0
align 1
LABELV $465
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $463
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 103
byte 1 95
byte 1 115
byte 1 121
byte 1 110
byte 1 99
byte 1 104
byte 1 114
byte 1 111
byte 1 110
byte 1 111
byte 1 117
byte 1 115
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 49
byte 1 32
byte 1 59
byte 1 32
byte 1 114
byte 1 101
byte 1 99
byte 1 111
byte 1 114
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $457
byte 1 117
byte 1 105
byte 1 95
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $437
byte 1 67
byte 1 71
byte 1 95
byte 1 77
byte 1 97
byte 1 112
byte 1 82
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $234
byte 1 103
byte 1 95
byte 1 115
byte 1 121
byte 1 110
byte 1 99
byte 1 104
byte 1 114
byte 1 111
byte 1 110
byte 1 111
byte 1 117
byte 1 115
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $224
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 109
byte 1 115
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $219
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $215
byte 1 94
byte 1 52
byte 1 66
byte 1 76
byte 1 85
byte 1 69
byte 1 0
align 1
LABELV $209
byte 1 103
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $206
byte 1 94
byte 1 49
byte 1 82
byte 1 69
byte 1 68
byte 1 0
align 1
LABELV $200
byte 1 103
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $198
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $195
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $194
byte 1 103
byte 1 95
byte 1 115
byte 1 103
byte 1 80
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $192
byte 1 103
byte 1 95
byte 1 115
byte 1 103
byte 1 80
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 83
byte 1 112
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $190
byte 1 103
byte 1 95
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 101
byte 1 80
byte 1 117
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $188
byte 1 103
byte 1 95
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 101
byte 1 68
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $186
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $184
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $182
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $180
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $178
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $176
byte 1 100
byte 1 109
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $173
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $172
byte 1 117
byte 1 105
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $171
byte 1 103
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $81
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
LABELV $80
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
LABELV $79
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
LABELV $78
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $77
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $76
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $75
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $74
byte 1 111
byte 1 102
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $73
byte 1 103
byte 1 101
byte 1 116
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
