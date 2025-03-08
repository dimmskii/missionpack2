code
proc UI_PlayerInfo_SetWeapon 84 12
file "../ui_players.c"
line 34
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// ui_players.c
;4:
;5:#include "ui_local.h"
;6:
;7:
;8:#define UI_TIMER_GESTURE		2300
;9:#define UI_TIMER_JUMP			1000
;10:#define UI_TIMER_LAND			130
;11:#define UI_TIMER_WEAPON_SWITCH	300
;12:#define UI_TIMER_ATTACK			500
;13:#define	UI_TIMER_MUZZLE_FLASH	20
;14:#define	UI_TIMER_WEAPON_DELAY	250
;15:
;16:#define JUMP_HEIGHT				56
;17:
;18:#define SWINGSPEED				0.3f
;19:
;20:#define SPIN_SPEED				0.9f
;21:#define COAST_TIME				1000
;22:
;23:
;24:static int			dp_realtime;
;25:static float		jumpHeight;
;26:sfxHandle_t weaponChangeSound;
;27:
;28:
;29:/*
;30:===============
;31:UI_PlayerInfo_SetWeapon
;32:===============
;33:*/
;34:static void UI_PlayerInfo_SetWeapon( playerInfo_t *pi, weapon_t weaponNum ) {
line 38
;35:	gitem_t *	item;
;36:	char		path[MAX_QPATH];
;37:
;38:	pi->currentWeapon = weaponNum;
ADDRFP4 0
INDIRP4
CNSTI4 1208
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
LABELV $89
line 40
;39:tryagain:
;40:	pi->realWeapon = weaponNum;
ADDRFP4 0
INDIRP4
CNSTI4 1272
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 41
;41:	pi->weaponModel = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1156
ADDP4
CNSTI4 0
ASGNI4
line 42
;42:	pi->barrelModel = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1160
ADDP4
CNSTI4 0
ASGNI4
line 43
;43:	pi->flashModel = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1164
ADDP4
CNSTI4 0
ASGNI4
line 45
;44:
;45:	if ( weaponNum == WP_NONE ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $90
line 46
;46:		return;
ADDRGP4 $88
JUMPV
LABELV $90
line 49
;47:	}
;48:
;49:	for ( item = bg_itemlist + 1; item->classname ; item++ ) {
ADDRLP4 0
ADDRGP4 bg_itemlist+52
ASGNP4
ADDRGP4 $95
JUMPV
LABELV $92
line 50
;50:		if ( item->giType != IT_WEAPON ) {
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
EQI4 $97
line 51
;51:			continue;
ADDRGP4 $93
JUMPV
LABELV $97
line 53
;52:		}
;53:		if ( item->giTag == weaponNum ) {
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $99
line 54
;54:			break;
ADDRGP4 $94
JUMPV
LABELV $99
line 56
;55:		}
;56:	}
LABELV $93
line 49
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
LABELV $95
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $92
LABELV $94
line 58
;57:
;58:	if ( item->classname ) {
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $101
line 59
;59:		pi->weaponModel = trap_R_RegisterModel( item->world_model[0] );
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1156
ADDP4
ADDRLP4 68
INDIRI4
ASGNI4
line 60
;60:	}
LABELV $101
line 62
;61:
;62:	if( pi->weaponModel == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 1156
ADDP4
INDIRI4
CNSTI4 0
NEI4 $103
line 63
;63:		if( weaponNum == WP_MACHINEGUN ) {
ADDRFP4 4
INDIRI4
CNSTI4 2
NEI4 $105
line 64
;64:			weaponNum = WP_NONE;
ADDRFP4 4
CNSTI4 0
ASGNI4
line 65
;65:			goto tryagain;
ADDRGP4 $89
JUMPV
LABELV $105
line 67
;66:		}
;67:		weaponNum = WP_MACHINEGUN;
ADDRFP4 4
CNSTI4 2
ASGNI4
line 68
;68:		goto tryagain;
ADDRGP4 $89
JUMPV
LABELV $103
line 71
;69:	}
;70:
;71:	if ( weaponNum == WP_MACHINEGUN || weaponNum == WP_GAUNTLET || weaponNum == WP_BFG ) {
ADDRLP4 68
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 2
EQI4 $110
ADDRLP4 68
INDIRI4
CNSTI4 1
EQI4 $110
ADDRLP4 68
INDIRI4
CNSTI4 9
NEI4 $107
LABELV $110
line 72
;72:		COM_StripExtension( item->world_model[0], path, sizeof( path ) );
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 COM_StripExtension
CALLV
pop
line 73
;73:		Q_strcat( path, sizeof( path ), "_barrel.md3" );
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $111
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 74
;74:		pi->barrelModel = trap_R_RegisterModel( path );
ADDRLP4 4
ARGP4
ADDRLP4 72
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1160
ADDP4
ADDRLP4 72
INDIRI4
ASGNI4
line 75
;75:	}
LABELV $107
line 77
;76:
;77:	COM_StripExtension( item->world_model[0], path, sizeof( path ) );
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 COM_StripExtension
CALLV
pop
line 78
;78:	Q_strcat( path, sizeof( path ), "_flash.md3" );
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $112
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 79
;79:	pi->flashModel = trap_R_RegisterModel( path );
ADDRLP4 4
ARGP4
ADDRLP4 72
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1164
ADDP4
ADDRLP4 72
INDIRI4
ASGNI4
line 81
;80:
;81:	switch( weaponNum ) {
ADDRLP4 76
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 1
LTI4 $113
ADDRLP4 76
INDIRI4
CNSTI4 10
GTI4 $113
ADDRLP4 76
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $126-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $126
address $116
address $117
address $118
address $119
address $120
address $121
address $122
address $123
address $124
address $125
code
LABELV $116
line 83
;82:	case WP_GAUNTLET:
;83:		MAKERGB( pi->flashDlightColor, 0.6f, 0.6f, 1 );
ADDRFP4 0
INDIRP4
CNSTI4 1168
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1172
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1176
ADDP4
CNSTF4 1065353216
ASGNF4
line 84
;84:		break;
ADDRGP4 $114
JUMPV
LABELV $117
line 87
;85:
;86:	case WP_MACHINEGUN:
;87:		MAKERGB( pi->flashDlightColor, 1, 1, 0 );
ADDRFP4 0
INDIRP4
CNSTI4 1168
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1172
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1176
ADDP4
CNSTF4 0
ASGNF4
line 88
;88:		break;
ADDRGP4 $114
JUMPV
LABELV $118
line 91
;89:
;90:	case WP_SHOTGUN:
;91:		MAKERGB( pi->flashDlightColor, 1, 1, 0 );
ADDRFP4 0
INDIRP4
CNSTI4 1168
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1172
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1176
ADDP4
CNSTF4 0
ASGNF4
line 92
;92:		break;
ADDRGP4 $114
JUMPV
LABELV $119
line 95
;93:
;94:	case WP_GRENADE_LAUNCHER:
;95:		MAKERGB( pi->flashDlightColor, 1, 0.7f, 0.5f );
ADDRFP4 0
INDIRP4
CNSTI4 1168
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1172
ADDP4
CNSTF4 1060320051
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1176
ADDP4
CNSTF4 1056964608
ASGNF4
line 96
;96:		break;
ADDRGP4 $114
JUMPV
LABELV $120
line 99
;97:
;98:	case WP_ROCKET_LAUNCHER:
;99:		MAKERGB( pi->flashDlightColor, 1, 0.75f, 0 );
ADDRFP4 0
INDIRP4
CNSTI4 1168
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1172
ADDP4
CNSTF4 1061158912
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1176
ADDP4
CNSTF4 0
ASGNF4
line 100
;100:		break;
ADDRGP4 $114
JUMPV
LABELV $121
line 103
;101:
;102:	case WP_LIGHTNING:
;103:		MAKERGB( pi->flashDlightColor, 0.6f, 0.6f, 1 );
ADDRFP4 0
INDIRP4
CNSTI4 1168
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1172
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1176
ADDP4
CNSTF4 1065353216
ASGNF4
line 104
;104:		break;
ADDRGP4 $114
JUMPV
LABELV $122
line 107
;105:
;106:	case WP_RAILGUN:
;107:		MAKERGB( pi->flashDlightColor, 1, 0.5f, 0 );
ADDRFP4 0
INDIRP4
CNSTI4 1168
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1172
ADDP4
CNSTF4 1056964608
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1176
ADDP4
CNSTF4 0
ASGNF4
line 108
;108:		break;
ADDRGP4 $114
JUMPV
LABELV $123
line 111
;109:
;110:	case WP_PLASMAGUN:
;111:		MAKERGB( pi->flashDlightColor, 0.6f, 0.6f, 1 );
ADDRFP4 0
INDIRP4
CNSTI4 1168
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1172
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1176
ADDP4
CNSTF4 1065353216
ASGNF4
line 112
;112:		break;
ADDRGP4 $114
JUMPV
LABELV $124
line 115
;113:
;114:	case WP_BFG:
;115:		MAKERGB( pi->flashDlightColor, 1, 0.7f, 1 );
ADDRFP4 0
INDIRP4
CNSTI4 1168
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1172
ADDP4
CNSTF4 1060320051
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1176
ADDP4
CNSTF4 1065353216
ASGNF4
line 116
;116:		break;
ADDRGP4 $114
JUMPV
LABELV $125
line 119
;117:
;118:	case WP_GRAPPLING_HOOK:
;119:		MAKERGB( pi->flashDlightColor, 0.6f, 0.6f, 1 );
ADDRFP4 0
INDIRP4
CNSTI4 1168
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1172
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1176
ADDP4
CNSTF4 1065353216
ASGNF4
line 120
;120:		break;
ADDRGP4 $114
JUMPV
LABELV $113
line 123
;121:
;122:	default:
;123:		MAKERGB( pi->flashDlightColor, 1, 1, 1 );
ADDRFP4 0
INDIRP4
CNSTI4 1168
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1172
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1176
ADDP4
CNSTF4 1065353216
ASGNF4
line 124
;124:		break;
LABELV $114
line 126
;125:	}
;126:}
LABELV $88
endproc UI_PlayerInfo_SetWeapon 84 12
proc UI_ForceLegsAnim 4 0
line 134
;127:
;128:
;129:/*
;130:===============
;131:UI_ForceLegsAnim
;132:===============
;133:*/
;134:static void UI_ForceLegsAnim( playerInfo_t *pi, int anim ) {
line 135
;135:	pi->legsAnim = ( ( pi->legsAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT ) | anim;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 1212
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 1212
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 128
BXORI4
ADDRFP4 4
INDIRI4
BORI4
ASGNI4
line 137
;136:
;137:	if ( anim == LEGS_JUMP ) {
ADDRFP4 4
INDIRI4
CNSTI4 18
NEI4 $129
line 138
;138:		pi->legsAnimationTimer = UI_TIMER_JUMP;
ADDRFP4 0
INDIRP4
CNSTI4 1248
ADDP4
CNSTI4 1000
ASGNI4
line 139
;139:	}
LABELV $129
line 140
;140:}
LABELV $128
endproc UI_ForceLegsAnim 4 0
proc UI_SetLegsAnim 0 8
line 148
;141:
;142:
;143:/*
;144:===============
;145:UI_SetLegsAnim
;146:===============
;147:*/
;148:static void UI_SetLegsAnim( playerInfo_t *pi, int anim ) {
line 149
;149:	if ( pi->pendingLegsAnim ) {
ADDRFP4 0
INDIRP4
CNSTI4 1236
ADDP4
INDIRI4
CNSTI4 0
EQI4 $132
line 150
;150:		anim = pi->pendingLegsAnim;
ADDRFP4 4
ADDRFP4 0
INDIRP4
CNSTI4 1236
ADDP4
INDIRI4
ASGNI4
line 151
;151:		pi->pendingLegsAnim = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1236
ADDP4
CNSTI4 0
ASGNI4
line 152
;152:	}
LABELV $132
line 153
;153:	UI_ForceLegsAnim( pi, anim );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UI_ForceLegsAnim
CALLV
pop
line 154
;154:}
LABELV $131
endproc UI_SetLegsAnim 0 8
proc UI_ForceTorsoAnim 8 0
line 162
;155:
;156:
;157:/*
;158:===============
;159:UI_ForceTorsoAnim
;160:===============
;161:*/
;162:static void UI_ForceTorsoAnim( playerInfo_t *pi, int anim ) {
line 163
;163:	pi->torsoAnim = ( ( pi->torsoAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT ) | anim;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 1216
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 1216
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 128
BXORI4
ADDRFP4 4
INDIRI4
BORI4
ASGNI4
line 165
;164:
;165:	if ( anim == TORSO_GESTURE ) {
ADDRFP4 4
INDIRI4
CNSTI4 6
NEI4 $135
line 166
;166:		pi->torsoAnimationTimer = UI_TIMER_GESTURE;
ADDRFP4 0
INDIRP4
CNSTI4 1240
ADDP4
CNSTI4 2300
ASGNI4
line 167
;167:	}
LABELV $135
line 169
;168:
;169:	if ( anim == TORSO_ATTACK || anim == TORSO_ATTACK2 ) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 7
EQI4 $139
ADDRLP4 4
INDIRI4
CNSTI4 8
NEI4 $137
LABELV $139
line 170
;170:		pi->torsoAnimationTimer = UI_TIMER_ATTACK;
ADDRFP4 0
INDIRP4
CNSTI4 1240
ADDP4
CNSTI4 500
ASGNI4
line 171
;171:	}
LABELV $137
line 172
;172:}
LABELV $134
endproc UI_ForceTorsoAnim 8 0
proc UI_SetTorsoAnim 0 8
line 180
;173:
;174:
;175:/*
;176:===============
;177:UI_SetTorsoAnim
;178:===============
;179:*/
;180:static void UI_SetTorsoAnim( playerInfo_t *pi, int anim ) {
line 181
;181:	if ( pi->pendingTorsoAnim ) {
ADDRFP4 0
INDIRP4
CNSTI4 1244
ADDP4
INDIRI4
CNSTI4 0
EQI4 $141
line 182
;182:		anim = pi->pendingTorsoAnim;
ADDRFP4 4
ADDRFP4 0
INDIRP4
CNSTI4 1244
ADDP4
INDIRI4
ASGNI4
line 183
;183:		pi->pendingTorsoAnim = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1244
ADDP4
CNSTI4 0
ASGNI4
line 184
;184:	}
LABELV $141
line 186
;185:
;186:	UI_ForceTorsoAnim( pi, anim );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UI_ForceTorsoAnim
CALLV
pop
line 187
;187:}
LABELV $140
endproc UI_SetTorsoAnim 0 8
proc UI_TorsoSequencing 16 8
line 195
;188:
;189:
;190:/*
;191:===============
;192:UI_TorsoSequencing
;193:===============
;194:*/
;195:static void UI_TorsoSequencing( playerInfo_t *pi ) {
line 198
;196:	int		currentAnim;
;197:
;198:	currentAnim = pi->torsoAnim & ~ANIM_TOGGLEBIT;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1216
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 200
;199:
;200:	if ( pi->weapon != pi->currentWeapon ) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 1220
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 1208
ADDP4
INDIRI4
EQI4 $144
line 201
;201:		if ( currentAnim != TORSO_DROP ) {
ADDRLP4 0
INDIRI4
CNSTI4 9
EQI4 $146
line 202
;202:			pi->torsoAnimationTimer = UI_TIMER_WEAPON_SWITCH;
ADDRFP4 0
INDIRP4
CNSTI4 1240
ADDP4
CNSTI4 300
ASGNI4
line 203
;203:			UI_ForceTorsoAnim( pi, TORSO_DROP );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 9
ARGI4
ADDRGP4 UI_ForceTorsoAnim
CALLV
pop
line 204
;204:		}
LABELV $146
line 205
;205:	}
LABELV $144
line 207
;206:
;207:	if ( pi->torsoAnimationTimer > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 1240
ADDP4
INDIRI4
CNSTI4 0
LEI4 $148
line 208
;208:		return;
ADDRGP4 $143
JUMPV
LABELV $148
line 211
;209:	}
;210:
;211:	if( currentAnim == TORSO_GESTURE ) {
ADDRLP4 0
INDIRI4
CNSTI4 6
NEI4 $150
line 212
;212:		UI_SetTorsoAnim( pi, TORSO_STAND );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 11
ARGI4
ADDRGP4 UI_SetTorsoAnim
CALLV
pop
line 213
;213:		return;
ADDRGP4 $143
JUMPV
LABELV $150
line 216
;214:	}
;215:
;216:	if( currentAnim == TORSO_ATTACK || currentAnim == TORSO_ATTACK2 ) {
ADDRLP4 0
INDIRI4
CNSTI4 7
EQI4 $154
ADDRLP4 0
INDIRI4
CNSTI4 8
NEI4 $152
LABELV $154
line 217
;217:		UI_SetTorsoAnim( pi, TORSO_STAND );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 11
ARGI4
ADDRGP4 UI_SetTorsoAnim
CALLV
pop
line 218
;218:		return;
ADDRGP4 $143
JUMPV
LABELV $152
line 221
;219:	}
;220:
;221:	if ( currentAnim == TORSO_DROP ) {
ADDRLP4 0
INDIRI4
CNSTI4 9
NEI4 $155
line 222
;222:		UI_PlayerInfo_SetWeapon( pi, pi->weapon );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 1220
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_PlayerInfo_SetWeapon
CALLV
pop
line 223
;223:		pi->torsoAnimationTimer = UI_TIMER_WEAPON_SWITCH;
ADDRFP4 0
INDIRP4
CNSTI4 1240
ADDP4
CNSTI4 300
ASGNI4
line 224
;224:		UI_ForceTorsoAnim( pi, TORSO_RAISE );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 UI_ForceTorsoAnim
CALLV
pop
line 225
;225:		return;
ADDRGP4 $143
JUMPV
LABELV $155
line 228
;226:	}
;227:
;228:	if ( currentAnim == TORSO_RAISE ) {
ADDRLP4 0
INDIRI4
CNSTI4 10
NEI4 $157
line 229
;229:		UI_SetTorsoAnim( pi, TORSO_STAND );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 11
ARGI4
ADDRGP4 UI_SetTorsoAnim
CALLV
pop
line 230
;230:		return;
LABELV $157
line 232
;231:	}
;232:}
LABELV $143
endproc UI_TorsoSequencing 16 8
proc UI_LegsSequencing 8 8
line 240
;233:
;234:
;235:/*
;236:===============
;237:UI_LegsSequencing
;238:===============
;239:*/
;240:static void UI_LegsSequencing( playerInfo_t *pi ) {
line 243
;241:	int		currentAnim;
;242:
;243:	currentAnim = pi->legsAnim & ~ANIM_TOGGLEBIT;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1212
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 245
;244:
;245:	if ( pi->legsAnimationTimer > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
CNSTI4 0
LEI4 $160
line 246
;246:		if ( currentAnim == LEGS_JUMP ) {
ADDRLP4 0
INDIRI4
CNSTI4 18
NEI4 $159
line 247
;247:			jumpHeight = JUMP_HEIGHT * sin( M_PI * ( UI_TIMER_JUMP - pi->legsAnimationTimer ) / UI_TIMER_JUMP );
CNSTI4 1000
ADDRFP4 0
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
SUBI4
CVIF4 4
CNSTF4 994960174
MULF4
ARGF4
ADDRLP4 4
ADDRGP4 sin
CALLF4
ASGNF4
ADDRGP4 jumpHeight
ADDRLP4 4
INDIRF4
CNSTF4 1113587712
MULF4
ASGNF4
line 248
;248:		}
line 249
;249:		return;
ADDRGP4 $159
JUMPV
LABELV $160
line 252
;250:	}
;251:
;252:	if ( currentAnim == LEGS_JUMP ) {
ADDRLP4 0
INDIRI4
CNSTI4 18
NEI4 $164
line 253
;253:		UI_ForceLegsAnim( pi, LEGS_LAND );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 19
ARGI4
ADDRGP4 UI_ForceLegsAnim
CALLV
pop
line 254
;254:		pi->legsAnimationTimer = UI_TIMER_LAND;
ADDRFP4 0
INDIRP4
CNSTI4 1248
ADDP4
CNSTI4 130
ASGNI4
line 255
;255:		jumpHeight = 0;
ADDRGP4 jumpHeight
CNSTF4 0
ASGNF4
line 256
;256:		return;
ADDRGP4 $159
JUMPV
LABELV $164
line 259
;257:	}
;258:
;259:	if ( currentAnim == LEGS_LAND ) {
ADDRLP4 0
INDIRI4
CNSTI4 19
NEI4 $166
line 260
;260:		UI_SetLegsAnim( pi, LEGS_IDLE );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 22
ARGI4
ADDRGP4 UI_SetLegsAnim
CALLV
pop
line 261
;261:		return;
LABELV $166
line 263
;262:	}
;263:}
LABELV $159
endproc UI_LegsSequencing 8 8
proc UI_PositionEntityOnTag 80 24
line 272
;264:
;265:
;266:/*
;267:======================
;268:UI_PositionEntityOnTag
;269:======================
;270:*/
;271:static void UI_PositionEntityOnTag( refEntity_t *entity, const refEntity_t *parent, 
;272:							clipHandle_t parentModel, char *tagName ) {
line 277
;273:	int				i;
;274:	orientation_t	lerped;
;275:	
;276:	// lerp the tag
;277:	trap_CM_LerpTag( &lerped, parentModel, parent->oldframe, parent->frame,
ADDRLP4 4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 52
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 96
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ADDRLP4 52
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_CM_LerpTag
CALLI4
pop
line 281
;278:		1.0 - parent->backlerp, tagName );
;279:
;280:	// FIXME: allow origin offsets along tag?
;281:	VectorCopy( parent->origin, entity->origin );
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRB
ASGNB 12
line 282
;282:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $169
line 283
;283:		VectorMA( entity->origin, lerped.origin[i], parent->axis[i], entity->origin );
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 284
;284:	}
LABELV $170
line 282
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $169
line 287
;285:
;286:	// cast away const because of compiler problems
;287:	MatrixMultiply( lerped.axis, ((refEntity_t*)parent)->axis, entity->axis );
ADDRLP4 4+12
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 288
;288:	entity->backlerp = parent->backlerp;
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ASGNF4
line 289
;289:}
LABELV $168
endproc UI_PositionEntityOnTag 80 24
proc UI_PositionRotatedEntityOnTag 116 24
line 298
;290:
;291:
;292:/*
;293:======================
;294:UI_PositionRotatedEntityOnTag
;295:======================
;296:*/
;297:static void UI_PositionRotatedEntityOnTag( refEntity_t *entity, const refEntity_t *parent, 
;298:							clipHandle_t parentModel, char *tagName ) {
line 304
;299:	int				i;
;300:	orientation_t	lerped;
;301:	vec3_t			tempAxis[3];
;302:
;303:	// lerp the tag
;304:	trap_CM_LerpTag( &lerped, parentModel, parent->oldframe, parent->frame,
ADDRLP4 4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 88
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 96
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ADDRLP4 88
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_CM_LerpTag
CALLI4
pop
line 308
;305:		1.0 - parent->backlerp, tagName );
;306:
;307:	// FIXME: allow origin offsets along tag?
;308:	VectorCopy( parent->origin, entity->origin );
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRB
ASGNB 12
line 309
;309:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $175
line 310
;310:		VectorMA( entity->origin, lerped.origin[i], parent->axis[i], entity->origin );
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 100
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 108
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 108
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 311
;311:	}
LABELV $176
line 309
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $175
line 314
;312:
;313:	// cast away const because of compiler problems
;314:	MatrixMultiply( entity->axis, ((refEntity_t *)parent)->axis, tempAxis );
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRLP4 52
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 315
;315:	MatrixMultiply( lerped.axis, tempAxis, entity->axis );
ADDRLP4 4+12
ARGP4
ADDRLP4 52
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 316
;316:}
LABELV $174
endproc UI_PositionRotatedEntityOnTag 116 24
proc UI_SetLerpFrameAnimation 12 8
line 324
;317:
;318:
;319:/*
;320:===============
;321:UI_SetLerpFrameAnimation
;322:===============
;323:*/
;324:static void UI_SetLerpFrameAnimation( playerInfo_t *ci, lerpFrame_t *lf, int newAnimation ) {
line 327
;325:	animation_t	*anim;
;326:
;327:	lf->animationNumber = newAnimation;
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 328
;328:	newAnimation &= ~ANIM_TOGGLEBIT;
ADDRFP4 8
ADDRFP4 8
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 330
;329:
;330:	if ( newAnimation < 0 || newAnimation >= MAX_ANIMATIONS ) {
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $183
ADDRLP4 4
INDIRI4
CNSTI4 31
LTI4 $181
LABELV $183
line 331
;331:		trap_Error( va("Bad animation number: %i", newAnimation) );
ADDRGP4 $184
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 332
;332:	}
LABELV $181
line 334
;333:
;334:	anim = &ci->animations[ newAnimation ];
ADDRLP4 0
ADDRFP4 8
INDIRI4
CNSTI4 28
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDP4
ASGNP4
line 336
;335:
;336:	lf->animation = anim;
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 337
;337:	lf->animationTime = lf->frameTime + anim->initialLerp;
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDI4
ASGNI4
line 338
;338:}
LABELV $180
endproc UI_SetLerpFrameAnimation 12 8
proc UI_RunLerpFrame 28 12
line 346
;339:
;340:
;341:/*
;342:===============
;343:UI_RunLerpFrame
;344:===============
;345:*/
;346:static void UI_RunLerpFrame( playerInfo_t *ci, lerpFrame_t *lf, int newAnimation ) {
line 351
;347:	int			f;
;348:	animation_t	*anim;
;349:
;350:	// see if the animation sequence is switching
;351:	if ( newAnimation != lf->animationNumber || !lf->animation ) {
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 8
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
NEI4 $188
ADDRLP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $186
LABELV $188
line 352
;352:		UI_SetLerpFrameAnimation( ci, lf, newAnimation );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 UI_SetLerpFrameAnimation
CALLV
pop
line 353
;353:	}
LABELV $186
line 357
;354:
;355:	// if we have passed the current frame, move it to
;356:	// oldFrame and calculate a new frame
;357:	if ( dp_realtime >= lf->frameTime ) {
ADDRGP4 dp_realtime
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
LTI4 $189
line 358
;358:		lf->oldFrame = lf->frame;
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 359
;359:		lf->oldFrameTime = lf->frameTime;
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 362
;360:
;361:		// get the next frame based on the animation
;362:		anim = lf->animation;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
ASGNP4
line 363
;363:		if ( dp_realtime < lf->animationTime ) {
ADDRGP4 dp_realtime
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
GEI4 $191
line 364
;364:			lf->frameTime = lf->animationTime;		// initial lerp
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ASGNI4
line 365
;365:		} else {
ADDRGP4 $192
JUMPV
LABELV $191
line 366
;366:			lf->frameTime = lf->oldFrameTime + anim->frameLerp;
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDI4
ASGNI4
line 367
;367:		}
LABELV $192
line 368
;368:		f = ( lf->frameTime - lf->animationTime ) / anim->frameLerp;
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
SUBI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
DIVI4
ASGNI4
line 369
;369:		if ( f >= anim->numFrames ) {
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LTI4 $193
line 370
;370:			f -= anim->numFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 371
;371:			if ( anim->loopFrames ) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
EQI4 $195
line 372
;372:				f %= anim->loopFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MODI4
ASGNI4
line 373
;373:				f += anim->numFrames - anim->loopFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
ADDI4
ASGNI4
line 374
;374:			} else {
ADDRGP4 $196
JUMPV
LABELV $195
line 375
;375:				f = anim->numFrames - 1;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 378
;376:				// the animation is stuck at the end, so it
;377:				// can immediately transition to another sequence
;378:				lf->frameTime = dp_realtime;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 dp_realtime
INDIRI4
ASGNI4
line 379
;379:			}
LABELV $196
line 380
;380:		}
LABELV $193
line 381
;381:		lf->frame = anim->firstFrame + f;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 382
;382:		if ( dp_realtime > lf->frameTime ) {
ADDRGP4 dp_realtime
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
LEI4 $197
line 383
;383:			lf->frameTime = dp_realtime;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 dp_realtime
INDIRI4
ASGNI4
line 384
;384:		}
LABELV $197
line 385
;385:	}
LABELV $189
line 387
;386:
;387:	if ( lf->frameTime > dp_realtime + 200 ) {
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRGP4 dp_realtime
INDIRI4
CNSTI4 200
ADDI4
LEI4 $199
line 388
;388:		lf->frameTime = dp_realtime;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 dp_realtime
INDIRI4
ASGNI4
line 389
;389:	}
LABELV $199
line 391
;390:
;391:	if ( lf->oldFrameTime > dp_realtime ) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRGP4 dp_realtime
INDIRI4
LEI4 $201
line 392
;392:		lf->oldFrameTime = dp_realtime;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 dp_realtime
INDIRI4
ASGNI4
line 393
;393:	}
LABELV $201
line 395
;394:	// calculate current lerp value
;395:	if ( lf->frameTime == lf->oldFrameTime ) {
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
NEI4 $203
line 396
;396:		lf->backlerp = 0;
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 0
ASGNF4
line 397
;397:	} else {
ADDRGP4 $204
JUMPV
LABELV $203
line 398
;398:		lf->backlerp = 1.0 - (float)( dp_realtime - lf->oldFrameTime ) / ( lf->frameTime - lf->oldFrameTime );
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 1065353216
ADDRGP4 dp_realtime
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
SUBI4
CVIF4 4
DIVF4
SUBF4
ASGNF4
line 399
;399:	}
LABELV $204
line 400
;400:}
LABELV $185
endproc UI_RunLerpFrame 28 12
proc UI_PlayerAnimation 16 12
line 409
;401:
;402:
;403:/*
;404:===============
;405:UI_PlayerAnimation
;406:===============
;407:*/
;408:static void UI_PlayerAnimation( playerInfo_t *pi, int *legsOld, int *legs, float *legsBackLerp,
;409:						int *torsoOld, int *torso, float *torsoBackLerp ) {
line 412
;410:
;411:	// legs animation
;412:	pi->legsAnimationTimer -= uiInfo.uiDC.frameTime;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1248
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 uiInfo+212
INDIRI4
SUBI4
ASGNI4
line 413
;413:	if ( pi->legsAnimationTimer < 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
CNSTI4 0
GEI4 $207
line 414
;414:		pi->legsAnimationTimer = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1248
ADDP4
CNSTI4 0
ASGNI4
line 415
;415:	}
LABELV $207
line 417
;416:
;417:	UI_LegsSequencing( pi );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 UI_LegsSequencing
CALLV
pop
line 419
;418:
;419:	if ( pi->legs.yawing && ( pi->legsAnim & ~ANIM_TOGGLEBIT ) == LEGS_IDLE ) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $209
ADDRLP4 4
INDIRP4
CNSTI4 1212
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
CNSTI4 22
NEI4 $209
line 420
;420:		UI_RunLerpFrame( pi, &pi->legs, LEGS_TURN );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ARGP4
CNSTI4 24
ARGI4
ADDRGP4 UI_RunLerpFrame
CALLV
pop
line 421
;421:	} else {
ADDRGP4 $210
JUMPV
LABELV $209
line 422
;422:		UI_RunLerpFrame( pi, &pi->legs, pi->legsAnim );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1212
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_RunLerpFrame
CALLV
pop
line 423
;423:	}
LABELV $210
line 424
;424:	*legsOld = pi->legs.oldFrame;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 425
;425:	*legs = pi->legs.frame;
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 426
;426:	*legsBackLerp = pi->legs.backlerp;
ADDRFP4 12
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 429
;427:
;428:	// torso animation
;429:	pi->torsoAnimationTimer -= uiInfo.uiDC.frameTime;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 1240
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRGP4 uiInfo+212
INDIRI4
SUBI4
ASGNI4
line 430
;430:	if ( pi->torsoAnimationTimer < 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 1240
ADDP4
INDIRI4
CNSTI4 0
GEI4 $212
line 431
;431:		pi->torsoAnimationTimer = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1240
ADDP4
CNSTI4 0
ASGNI4
line 432
;432:	}
LABELV $212
line 434
;433:
;434:	UI_TorsoSequencing( pi );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 UI_TorsoSequencing
CALLV
pop
line 436
;435:
;436:	UI_RunLerpFrame( pi, &pi->torso, pi->torsoAnim );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 1216
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_RunLerpFrame
CALLV
pop
line 437
;437:	*torsoOld = pi->torso.oldFrame;
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
line 438
;438:	*torso = pi->torso.frame;
ADDRFP4 20
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
ASGNI4
line 439
;439:	*torsoBackLerp = pi->torso.backlerp;
ADDRFP4 24
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ASGNF4
line 440
;440:}
LABELV $205
endproc UI_PlayerAnimation 16 12
proc UI_SwingAngles 28 8
line 449
;441:
;442:
;443:/*
;444:==================
;445:UI_SwingAngles
;446:==================
;447:*/
;448:static void UI_SwingAngles( float destination, float swingTolerance, float clampTolerance,
;449:					float speed, float *angle, qboolean *swinging ) {
line 454
;450:	float	swing;
;451:	float	move;
;452:	float	scale;
;453:
;454:	if ( !*swinging ) {
ADDRFP4 20
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $215
line 456
;455:		// see if a swing should be started
;456:		swing = AngleSubtract( *angle, destination );
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 457
;457:		if ( swing > swingTolerance || swing < -swingTolerance ) {
ADDRLP4 20
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRF4
GTF4 $219
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRF4
NEGF4
GEF4 $217
LABELV $219
line 458
;458:			*swinging = qtrue;
ADDRFP4 20
INDIRP4
CNSTI4 1
ASGNI4
line 459
;459:		}
LABELV $217
line 460
;460:	}
LABELV $215
line 462
;461:
;462:	if ( !*swinging ) {
ADDRFP4 20
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $220
line 463
;463:		return;
ADDRGP4 $214
JUMPV
LABELV $220
line 468
;464:	}
;465:	
;466:	// modify the speed depending on the delta
;467:	// so it doesn't seem so linear
;468:	swing = AngleSubtract( destination, *angle );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 469
;469:	scale = fabs( swing );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 16
INDIRF4
ASGNF4
line 470
;470:	if ( scale < swingTolerance * 0.5 ) {
ADDRLP4 4
INDIRF4
ADDRFP4 4
INDIRF4
CNSTF4 1056964608
MULF4
GEF4 $222
line 471
;471:		scale = 0.5;
ADDRLP4 4
CNSTF4 1056964608
ASGNF4
line 472
;472:	} else if ( scale < swingTolerance ) {
ADDRGP4 $223
JUMPV
LABELV $222
ADDRLP4 4
INDIRF4
ADDRFP4 4
INDIRF4
GEF4 $224
line 473
;473:		scale = 1.0;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 474
;474:	} else {
ADDRGP4 $225
JUMPV
LABELV $224
line 475
;475:		scale = 2.0;
ADDRLP4 4
CNSTF4 1073741824
ASGNF4
line 476
;476:	}
LABELV $225
LABELV $223
line 479
;477:
;478:	// swing towards the destination angle
;479:	if ( swing >= 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LTF4 $226
line 480
;480:		move = uiInfo.uiDC.frameTime * scale * speed;
ADDRLP4 8
ADDRGP4 uiInfo+212
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
MULF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
line 481
;481:		if ( move >= swing ) {
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
LTF4 $229
line 482
;482:			move = swing;
ADDRLP4 8
ADDRLP4 0
INDIRF4
ASGNF4
line 483
;483:			*swinging = qfalse;
ADDRFP4 20
INDIRP4
CNSTI4 0
ASGNI4
line 484
;484:		}
LABELV $229
line 485
;485:		*angle = AngleMod( *angle + move );
ADDRLP4 20
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 486
;486:	} else if ( swing < 0 ) {
ADDRGP4 $227
JUMPV
LABELV $226
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $231
line 487
;487:		move = uiInfo.uiDC.frameTime * scale * -speed;
ADDRLP4 8
ADDRGP4 uiInfo+212
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
MULF4
ADDRFP4 12
INDIRF4
NEGF4
MULF4
ASGNF4
line 488
;488:		if ( move <= swing ) {
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
GTF4 $234
line 489
;489:			move = swing;
ADDRLP4 8
ADDRLP4 0
INDIRF4
ASGNF4
line 490
;490:			*swinging = qfalse;
ADDRFP4 20
INDIRP4
CNSTI4 0
ASGNI4
line 491
;491:		}
LABELV $234
line 492
;492:		*angle = AngleMod( *angle + move );
ADDRLP4 20
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 493
;493:	}
LABELV $231
LABELV $227
line 496
;494:
;495:	// clamp to no more than tolerance
;496:	swing = AngleSubtract( destination, *angle );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 497
;497:	if ( swing > clampTolerance ) {
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
LEF4 $236
line 498
;498:		*angle = AngleMod( destination - (clampTolerance - 1) );
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
SUBF4
SUBF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 16
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 499
;499:	} else if ( swing < -clampTolerance ) {
ADDRGP4 $237
JUMPV
LABELV $236
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
NEGF4
GEF4 $238
line 500
;500:		*angle = AngleMod( destination + (clampTolerance - 1) );
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
SUBF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 16
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 501
;501:	}
LABELV $238
LABELV $237
line 502
;502:}
LABELV $214
endproc UI_SwingAngles 28 8
proc UI_MovedirAdjustment 40 16
line 510
;503:
;504:
;505:/*
;506:======================
;507:UI_MovedirAdjustment
;508:======================
;509:*/
;510:static float UI_MovedirAdjustment( playerInfo_t *pi ) {
line 514
;511:	vec3_t		relativeAngles;
;512:	vec3_t		moveVector;
;513:
;514:	VectorSubtract( pi->viewAngles, pi->moveAngles, relativeAngles );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 24
INDIRP4
CNSTI4 1184
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 1196
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 24
INDIRP4
CNSTI4 1188
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 1200
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12+8
ADDRLP4 28
INDIRP4
CNSTI4 1192
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 1204
ADDP4
INDIRF4
SUBF4
ASGNF4
line 515
;515:	AngleVectors( relativeAngles, moveVector, NULL, NULL );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 516
;516:	if ( Q_fabs( moveVector[0] ) < 0.01 ) {
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 Q_fabs
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
CNSTF4 1008981770
GEF4 $243
line 517
;517:		moveVector[0] = 0.0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 518
;518:	}
LABELV $243
line 519
;519:	if ( Q_fabs( moveVector[1] ) < 0.01 ) {
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 Q_fabs
CALLF4
ASGNF4
ADDRLP4 36
INDIRF4
CNSTF4 1008981770
GEF4 $245
line 520
;520:		moveVector[1] = 0.0;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 521
;521:	}
LABELV $245
line 523
;522:
;523:	if ( moveVector[1] == 0 && moveVector[0] > 0 ) {
ADDRLP4 0+4
INDIRF4
CNSTF4 0
NEF4 $249
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $249
line 524
;524:		return 0;
CNSTF4 0
RETF4
ADDRGP4 $240
JUMPV
LABELV $249
line 526
;525:	}
;526:	if ( moveVector[1] < 0 && moveVector[0] > 0 ) {
ADDRLP4 0+4
INDIRF4
CNSTF4 0
GEF4 $252
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $252
line 527
;527:		return 22;
CNSTF4 1102053376
RETF4
ADDRGP4 $240
JUMPV
LABELV $252
line 529
;528:	}
;529:	if ( moveVector[1] < 0 && moveVector[0] == 0 ) {
ADDRLP4 0+4
INDIRF4
CNSTF4 0
GEF4 $255
ADDRLP4 0
INDIRF4
CNSTF4 0
NEF4 $255
line 530
;530:		return 45;
CNSTF4 1110704128
RETF4
ADDRGP4 $240
JUMPV
LABELV $255
line 532
;531:	}
;532:	if ( moveVector[1] < 0 && moveVector[0] < 0 ) {
ADDRLP4 0+4
INDIRF4
CNSTF4 0
GEF4 $258
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $258
line 533
;533:		return -22;
CNSTF4 3249537024
RETF4
ADDRGP4 $240
JUMPV
LABELV $258
line 535
;534:	}
;535:	if ( moveVector[1] == 0 && moveVector[0] < 0 ) {
ADDRLP4 0+4
INDIRF4
CNSTF4 0
NEF4 $261
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $261
line 536
;536:		return 0;
CNSTF4 0
RETF4
ADDRGP4 $240
JUMPV
LABELV $261
line 538
;537:	}
;538:	if ( moveVector[1] > 0 && moveVector[0] < 0 ) {
ADDRLP4 0+4
INDIRF4
CNSTF4 0
LEF4 $264
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $264
line 539
;539:		return 22;
CNSTF4 1102053376
RETF4
ADDRGP4 $240
JUMPV
LABELV $264
line 541
;540:	}
;541:	if ( moveVector[1] > 0 && moveVector[0] == 0 ) {
ADDRLP4 0+4
INDIRF4
CNSTF4 0
LEF4 $267
ADDRLP4 0
INDIRF4
CNSTF4 0
NEF4 $267
line 542
;542:		return  -45;
CNSTF4 3258187776
RETF4
ADDRGP4 $240
JUMPV
LABELV $267
line 545
;543:	}
;544:
;545:	return -22;
CNSTF4 3249537024
RETF4
LABELV $240
endproc UI_MovedirAdjustment 40 16
proc UI_PlayerAngles 68 24
line 554
;546:}
;547:
;548:
;549:/*
;550:===============
;551:UI_PlayerAngles
;552:===============
;553:*/
;554:static void UI_PlayerAngles( playerInfo_t *pi, vec3_t legs[3], vec3_t torso[3], vec3_t head[3] ) {
line 559
;555:	vec3_t		legsAngles, torsoAngles, headAngles;
;556:	float		dest;
;557:	float		adjust;
;558:
;559:	VectorCopy( pi->viewAngles, headAngles );
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 1184
ADDP4
INDIRB
ASGNB 12
line 560
;560:	headAngles[YAW] = AngleMod( headAngles[YAW] );
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 44
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 44
INDIRF4
ASGNF4
line 561
;561:	VectorClear( legsAngles );
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRLP4 24+4
CNSTF4 0
ASGNF4
ADDRLP4 24+8
CNSTF4 0
ASGNF4
line 562
;562:	VectorClear( torsoAngles );
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRLP4 0+4
CNSTF4 0
ASGNF4
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 567
;563:
;564:	// --------- yaw -------------
;565:
;566:	// allow yaw to drift a bit
;567:	if ( ( pi->legsAnim & ~ANIM_TOGGLEBIT ) != LEGS_IDLE 
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 1212
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
CNSTI4 22
NEI4 $279
ADDRLP4 48
INDIRP4
CNSTI4 1216
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
CNSTI4 11
EQI4 $277
LABELV $279
line 568
;568:		|| ( pi->torsoAnim & ~ANIM_TOGGLEBIT ) != TORSO_STAND  ) {
line 570
;569:		// if not standing still, always point all in the same direction
;570:		pi->torso.yawing = qtrue;	// always center
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 1
ASGNI4
line 571
;571:		pi->torso.pitching = qtrue;	// always center
ADDRFP4 0
INDIRP4
CNSTI4 96
ADDP4
CNSTI4 1
ASGNI4
line 572
;572:		pi->legs.yawing = qtrue;	// always center
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 1
ASGNI4
line 573
;573:	}
LABELV $277
line 576
;574:
;575:	// adjust legs for movement dir
;576:	adjust = UI_MovedirAdjustment( pi );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 UI_MovedirAdjustment
CALLF4
ASGNF4
ADDRLP4 36
ADDRLP4 52
INDIRF4
ASGNF4
line 577
;577:	legsAngles[YAW] = headAngles[YAW] + adjust;
ADDRLP4 24+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
line 578
;578:	torsoAngles[YAW] = headAngles[YAW] + 0.25 * adjust;
ADDRLP4 0+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 36
INDIRF4
CNSTF4 1048576000
MULF4
ADDF4
ASGNF4
line 582
;579:
;580:
;581:	// torso
;582:	UI_SwingAngles( torsoAngles[YAW], 25, 90, SWINGSPEED, &pi->torso.yawAngle, &pi->torso.yawing );
ADDRLP4 0+4
INDIRF4
ARGF4
CNSTF4 1103626240
ARGF4
CNSTF4 1119092736
ARGF4
CNSTF4 1050253722
ARGF4
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 84
ADDP4
ARGP4
ADDRLP4 56
INDIRP4
CNSTI4 88
ADDP4
ARGP4
ADDRGP4 UI_SwingAngles
CALLV
pop
line 583
;583:	UI_SwingAngles( legsAngles[YAW], 40, 90, SWINGSPEED, &pi->legs.yawAngle, &pi->legs.yawing );
ADDRLP4 24+4
INDIRF4
ARGF4
CNSTF4 1109393408
ARGF4
CNSTF4 1119092736
ARGF4
CNSTF4 1050253722
ARGF4
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 UI_SwingAngles
CALLV
pop
line 585
;584:
;585:	torsoAngles[YAW] = pi->torso.yawAngle;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
ASGNF4
line 586
;586:	legsAngles[YAW] = pi->legs.yawAngle;
ADDRLP4 24+4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ASGNF4
line 591
;587:
;588:	// --------- pitch -------------
;589:
;590:	// only show a fraction of the pitch angle in the torso
;591:	if ( headAngles[PITCH] > 180 ) {
ADDRLP4 12
INDIRF4
CNSTF4 1127481344
LEF4 $288
line 592
;592:		dest = (-360 + headAngles[PITCH]) * 0.75;
ADDRLP4 40
ADDRLP4 12
INDIRF4
CNSTF4 3283353600
ADDF4
CNSTF4 1061158912
MULF4
ASGNF4
line 593
;593:	} else {
ADDRGP4 $289
JUMPV
LABELV $288
line 594
;594:		dest = headAngles[PITCH] * 0.75;
ADDRLP4 40
ADDRLP4 12
INDIRF4
CNSTF4 1061158912
MULF4
ASGNF4
line 595
;595:	}
LABELV $289
line 596
;596:	UI_SwingAngles( dest, 15, 30, 0.1f, &pi->torso.pitchAngle, &pi->torso.pitching );
ADDRLP4 40
INDIRF4
ARGF4
CNSTF4 1097859072
ARGF4
CNSTF4 1106247680
ARGF4
CNSTF4 1036831949
ARGF4
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 64
INDIRP4
CNSTI4 96
ADDP4
ARGP4
ADDRGP4 UI_SwingAngles
CALLV
pop
line 597
;597:	torsoAngles[PITCH] = pi->torso.pitchAngle;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ASGNF4
line 600
;598:
;599:	// pull the angles back out of the hierarchial chain
;600:	AnglesSubtract( headAngles, torsoAngles, headAngles );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 AnglesSubtract
CALLV
pop
line 601
;601:	AnglesSubtract( torsoAngles, legsAngles, torsoAngles );
ADDRLP4 0
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 AnglesSubtract
CALLV
pop
line 602
;602:	AnglesToAxis( legsAngles, legs );
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 603
;603:	AnglesToAxis( torsoAngles, torso );
ADDRLP4 0
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 604
;604:	AnglesToAxis( headAngles, head );
ADDRLP4 12
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 605
;605:}
LABELV $270
endproc UI_PlayerAngles 68 24
proc UI_PlayerFloatSprite 140 12
line 613
;606:
;607:
;608:/*
;609:===============
;610:UI_PlayerFloatSprite
;611:===============
;612:*/
;613:static void UI_PlayerFloatSprite( playerInfo_t *pi, vec3_t origin, qhandle_t shader ) {
line 616
;614:	refEntity_t		ent;
;615:
;616:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTU4 140
ARGU4
ADDRGP4 memset
CALLP4
pop
line 617
;617:	VectorCopy( origin, ent.origin );
ADDRLP4 0+68
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 618
;618:	ent.origin[2] += 48;
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
CNSTF4 1111490560
ADDF4
ASGNF4
line 619
;619:	ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 620
;620:	ent.customShader = shader;
ADDRLP4 0+112
ADDRFP4 8
INDIRI4
ASGNI4
line 621
;621:	ent.radius = 10;
ADDRLP4 0+132
CNSTF4 1092616192
ASGNF4
line 622
;622:	ent.renderfx = 0;
ADDRLP4 0+4
CNSTI4 0
ASGNI4
line 623
;623:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 624
;624:}
LABELV $290
endproc UI_PlayerFloatSprite 140 12
export UI_MachinegunSpinAngle
proc UI_MachinegunSpinAngle 28 4
line 632
;625:
;626:
;627:/*
;628:======================
;629:UI_MachinegunSpinAngle
;630:======================
;631:*/
;632:float	UI_MachinegunSpinAngle( playerInfo_t *pi ) {
line 638
;633:	int		delta;
;634:	float	angle;
;635:	float	speed;
;636:	int		torsoAnim;
;637:
;638:	delta = dp_realtime - pi->barrelTime;
ADDRLP4 4
ADDRGP4 dp_realtime
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1268
ADDP4
INDIRI4
SUBI4
ASGNI4
line 639
;639:	if ( pi->barrelSpinning ) {
ADDRFP4 0
INDIRP4
CNSTI4 1260
ADDP4
INDIRI4
CNSTI4 0
EQI4 $298
line 640
;640:		angle = pi->barrelAngle + delta * SPIN_SPEED;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 1264
ADDP4
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
CNSTF4 1063675494
MULF4
ADDF4
ASGNF4
line 641
;641:	} else {
ADDRGP4 $299
JUMPV
LABELV $298
line 642
;642:		if ( delta > COAST_TIME ) {
ADDRLP4 4
INDIRI4
CNSTI4 1000
LEI4 $300
line 643
;643:			delta = COAST_TIME;
ADDRLP4 4
CNSTI4 1000
ASGNI4
line 644
;644:		}
LABELV $300
line 646
;645:
;646:		speed = 0.5 * ( SPIN_SPEED + (float)( COAST_TIME - delta ) / COAST_TIME );
ADDRLP4 12
CNSTI4 1000
ADDRLP4 4
INDIRI4
SUBI4
CVIF4 4
CNSTF4 981668463
MULF4
CNSTF4 1063675494
ADDF4
CNSTF4 1056964608
MULF4
ASGNF4
line 647
;647:		angle = pi->barrelAngle + delta * speed;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 1264
ADDP4
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 648
;648:	}
LABELV $299
line 650
;649:
;650:	torsoAnim = pi->torsoAnim  & ~ANIM_TOGGLEBIT;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1216
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 651
;651:	if( torsoAnim == TORSO_ATTACK2 ) {
ADDRLP4 0
INDIRI4
CNSTI4 8
NEI4 $302
line 652
;652:		torsoAnim = TORSO_ATTACK;
ADDRLP4 0
CNSTI4 7
ASGNI4
line 653
;653:	}
LABELV $302
line 654
;654:	if ( pi->barrelSpinning == !(torsoAnim == TORSO_ATTACK) ) {
ADDRLP4 0
INDIRI4
CNSTI4 7
EQI4 $307
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $308
JUMPV
LABELV $307
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $308
ADDRFP4 0
INDIRP4
CNSTI4 1260
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $304
line 655
;655:		pi->barrelTime = dp_realtime;
ADDRFP4 0
INDIRP4
CNSTI4 1268
ADDP4
ADDRGP4 dp_realtime
INDIRI4
ASGNI4
line 656
;656:		pi->barrelAngle = AngleMod( angle );
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1264
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
line 657
;657:		pi->barrelSpinning = !!(torsoAnim == TORSO_ATTACK);
ADDRLP4 0
INDIRI4
CNSTI4 7
NEI4 $310
ADDRLP4 24
CNSTI4 1
ASGNI4
ADDRGP4 $311
JUMPV
LABELV $310
ADDRLP4 24
CNSTI4 0
ASGNI4
LABELV $311
ADDRFP4 0
INDIRP4
CNSTI4 1260
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 658
;658:	}
LABELV $304
line 660
;659:
;660:	return angle;
ADDRLP4 8
INDIRF4
RETF4
LABELV $297
endproc UI_MachinegunSpinAngle 28 4
data
align 4
LABELV $313
byte 4 3246391296
byte 4 3246391296
byte 4 3250585600
align 4
LABELV $314
byte 4 1098907648
byte 4 1098907648
byte 4 1107296256
export UI_DrawPlayer
code
proc UI_DrawPlayer 1300 28
line 669
;661:}
;662:
;663:
;664:/*
;665:===============
;666:UI_DrawPlayer
;667:===============
;668:*/
;669:void UI_DrawPlayer( float x, float y, float w, float h, playerInfo_t *pi, int time ) {
line 679
;670:	refdef_t		refdef;
;671:	refEntity_t		legs;
;672:	refEntity_t		torso;
;673:	refEntity_t		head;
;674:	refEntity_t		gun;
;675:	refEntity_t		barrel;
;676:	refEntity_t		flash;
;677:	vec3_t			origin;
;678:	int				renderfx;
;679:	vec3_t			mins = {-16, -16, -24};
ADDRLP4 1084
ADDRGP4 $313
INDIRB
ASGNB 12
line 680
;680:	vec3_t			maxs = {16, 16, 32};
ADDRLP4 1096
ADDRGP4 $314
INDIRB
ASGNB 12
line 684
;681:	float			len;
;682:	float			xx;
;683:
;684:	if ( !pi->legsModel || !pi->torsoModel || !pi->headModel || !pi->animations[0].numFrames ) {
ADDRLP4 1256
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 1256
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $319
ADDRLP4 1256
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 0
EQI4 $319
ADDRLP4 1256
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
CNSTI4 0
EQI4 $319
ADDRLP4 1256
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 0
NEI4 $315
LABELV $319
line 685
;685:		return;
ADDRGP4 $312
JUMPV
LABELV $315
line 689
;686:	}
;687:
;688:	// this allows the ui to cache the player model on the main menu
;689:	if (w == 0 || h == 0) {
ADDRFP4 8
INDIRF4
CNSTF4 0
EQF4 $322
ADDRFP4 12
INDIRF4
CNSTF4 0
NEF4 $320
LABELV $322
line 690
;690:		return;
ADDRGP4 $312
JUMPV
LABELV $320
line 693
;691:	}
;692:
;693:	dp_realtime = time;
ADDRGP4 dp_realtime
ADDRFP4 20
INDIRI4
ASGNI4
line 695
;694:
;695:	if ( pi->pendingWeapon != -1 && dp_realtime > pi->weaponTimer ) {
ADDRLP4 1260
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 1260
INDIRP4
CNSTI4 1228
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $323
ADDRGP4 dp_realtime
INDIRI4
ADDRLP4 1260
INDIRP4
CNSTI4 1232
ADDP4
INDIRI4
LEI4 $323
line 696
;696:		pi->weapon = pi->pendingWeapon;
ADDRLP4 1264
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 1264
INDIRP4
CNSTI4 1220
ADDP4
ADDRLP4 1264
INDIRP4
CNSTI4 1228
ADDP4
INDIRI4
ASGNI4
line 697
;697:		pi->lastWeapon = pi->pendingWeapon;
ADDRLP4 1268
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 1268
INDIRP4
CNSTI4 1224
ADDP4
ADDRLP4 1268
INDIRP4
CNSTI4 1228
ADDP4
INDIRI4
ASGNI4
line 698
;698:		pi->pendingWeapon = -1;
ADDRFP4 16
INDIRP4
CNSTI4 1228
ADDP4
CNSTI4 -1
ASGNI4
line 699
;699:		pi->weaponTimer = 0;
ADDRFP4 16
INDIRP4
CNSTI4 1232
ADDP4
CNSTI4 0
ASGNI4
line 700
;700:		if( pi->currentWeapon != pi->weapon ) {
ADDRLP4 1272
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 1272
INDIRP4
CNSTI4 1208
ADDP4
INDIRI4
ADDRLP4 1272
INDIRP4
CNSTI4 1220
ADDP4
INDIRI4
EQI4 $325
line 701
;701:			trap_S_StartLocalSound( weaponChangeSound, CHAN_LOCAL );
ADDRGP4 weaponChangeSound
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 702
;702:		}
LABELV $325
line 703
;703:	}
LABELV $323
line 705
;704:
;705:	UI_AdjustFrom640( &x, &y, &w, &h );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 UI_AdjustFrom640
CALLV
pop
line 707
;706:
;707:	y -= jumpHeight;
ADDRFP4 4
ADDRFP4 4
INDIRF4
ADDRGP4 jumpHeight
INDIRF4
SUBF4
ASGNF4
line 709
;708:
;709:	memset( &refdef, 0, sizeof( refdef ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTU4 368
ARGU4
ADDRGP4 memset
CALLP4
pop
line 710
;710:	memset( &legs, 0, sizeof(legs) );
ADDRLP4 380
ARGP4
CNSTI4 0
ARGI4
CNSTU4 140
ARGU4
ADDRGP4 memset
CALLP4
pop
line 711
;711:	memset( &torso, 0, sizeof(torso) );
ADDRLP4 520
ARGP4
CNSTI4 0
ARGI4
CNSTU4 140
ARGU4
ADDRGP4 memset
CALLP4
pop
line 712
;712:	memset( &head, 0, sizeof(head) );
ADDRLP4 660
ARGP4
CNSTI4 0
ARGI4
CNSTU4 140
ARGU4
ADDRGP4 memset
CALLP4
pop
line 714
;713:
;714:	refdef.rdflags = RDF_NOWORLDMODEL;
ADDRLP4 0+76
CNSTI4 1
ASGNI4
line 716
;715:
;716:	AxisClear( refdef.viewaxis );
ADDRLP4 0+36
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 718
;717:
;718:	refdef.x = x;
ADDRLP4 0
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 719
;719:	refdef.y = y;
ADDRLP4 0+4
ADDRFP4 4
INDIRF4
CVFI4 4
ASGNI4
line 720
;720:	refdef.width = w;
ADDRLP4 0+8
ADDRFP4 8
INDIRF4
CVFI4 4
ASGNI4
line 721
;721:	refdef.height = h;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
CVFI4 4
ASGNI4
line 723
;722:
;723:	refdef.fov_x = (int)((float)refdef.width / 640.0f * 90.0f);
ADDRLP4 0+16
ADDRLP4 0+8
INDIRI4
CVIF4 4
CNSTF4 1041235968
MULF4
CVFI4 4
CVIF4 4
ASGNF4
line 724
;724:	xx = refdef.width / tan( refdef.fov_x / 360 * M_PI );
ADDRLP4 0+16
INDIRF4
CNSTF4 1007614517
MULF4
ARGF4
ADDRLP4 1264
ADDRGP4 tan
CALLF4
ASGNF4
ADDRLP4 1252
ADDRLP4 0+8
INDIRI4
CVIF4 4
ADDRLP4 1264
INDIRF4
DIVF4
ASGNF4
line 725
;725:	refdef.fov_y = atan2( refdef.height, xx );
ADDRLP4 0+12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 1252
INDIRF4
ARGF4
ADDRLP4 1268
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRLP4 0+20
ADDRLP4 1268
INDIRF4
ASGNF4
line 726
;726:	refdef.fov_y *= ( 360 / (float)M_PI );
ADDRLP4 0+20
ADDRLP4 0+20
INDIRF4
CNSTF4 1122316001
MULF4
ASGNF4
line 729
;727:
;728:	// calculate distance so the player nearly fills the box
;729:	len = 0.7 * ( maxs[2] - mins[2] );		
ADDRLP4 1248
ADDRLP4 1096+8
INDIRF4
ADDRLP4 1084+8
INDIRF4
SUBF4
CNSTF4 1060320051
MULF4
ASGNF4
line 730
;730:	origin[0] = len / tan( DEG2RAD(refdef.fov_x) * 0.5 );
ADDRLP4 0+16
INDIRF4
CNSTF4 1007614517
MULF4
ARGF4
ADDRLP4 1272
ADDRGP4 tan
CALLF4
ASGNF4
ADDRLP4 368
ADDRLP4 1248
INDIRF4
ADDRLP4 1272
INDIRF4
DIVF4
ASGNF4
line 731
;731:	origin[1] = 0.5 * ( mins[1] + maxs[1] );
ADDRLP4 368+4
ADDRLP4 1084+4
INDIRF4
ADDRLP4 1096+4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ASGNF4
line 732
;732:	origin[2] = -0.5 * ( mins[2] + maxs[2] );
ADDRLP4 368+8
ADDRLP4 1084+8
INDIRF4
ADDRLP4 1096+8
INDIRF4
ADDF4
CNSTF4 3204448256
MULF4
ASGNF4
line 734
;733:
;734:	refdef.time = dp_realtime;
ADDRLP4 0+72
ADDRGP4 dp_realtime
INDIRI4
ASGNI4
line 736
;735:
;736:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 739
;737:
;738:	// get the rotation information
;739:	UI_PlayerAngles( pi, legs.axis, torso.axis, head.axis );
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 380+28
ARGP4
ADDRLP4 520+28
ARGP4
ADDRLP4 660+28
ARGP4
ADDRGP4 UI_PlayerAngles
CALLV
pop
line 742
;740:	
;741:	// get the animation state (after rotation, to allow feet shuffle)
;742:	UI_PlayerAnimation( pi, &legs.oldframe, &legs.frame, &legs.backlerp,
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 380+96
ARGP4
ADDRLP4 380+80
ARGP4
ADDRLP4 380+100
ARGP4
ADDRLP4 520+96
ARGP4
ADDRLP4 520+80
ARGP4
ADDRLP4 520+100
ARGP4
ADDRGP4 UI_PlayerAnimation
CALLV
pop
line 745
;743:		 &torso.oldframe, &torso.frame, &torso.backlerp );
;744:
;745:	renderfx = RF_LIGHTING_ORIGIN | RF_NOSHADOW;
ADDRLP4 800
CNSTI4 192
ASGNI4
line 750
;746:
;747:	//
;748:	// add the legs
;749:	//
;750:	legs.hModel = pi->legsModel;
ADDRLP4 380+8
ADDRFP4 16
INDIRP4
INDIRI4
ASGNI4
line 751
;751:	legs.customSkin = pi->legsSkin;
ADDRLP4 380+108
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 753
;752:
;753:	VectorCopy( origin, legs.origin );
ADDRLP4 380+68
ADDRLP4 368
INDIRB
ASGNB 12
line 755
;754:
;755:	VectorCopy( origin, legs.lightingOrigin );
ADDRLP4 380+12
ADDRLP4 368
INDIRB
ASGNB 12
line 756
;756:	legs.renderfx = renderfx;
ADDRLP4 380+4
ADDRLP4 800
INDIRI4
ASGNI4
line 757
;757:	VectorCopy (legs.origin, legs.oldorigin);
ADDRLP4 380+84
ADDRLP4 380+68
INDIRB
ASGNB 12
line 759
;758:
;759:	trap_R_AddRefEntityToScene( &legs );
ADDRLP4 380
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 761
;760:
;761:	if (!legs.hModel) {
ADDRLP4 380+8
INDIRI4
CNSTI4 0
NEI4 $365
line 762
;762:		return;
ADDRGP4 $312
JUMPV
LABELV $365
line 768
;763:	}
;764:
;765:	//
;766:	// add the torso
;767:	//
;768:	torso.hModel = pi->torsoModel;
ADDRLP4 520+8
ADDRFP4 16
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ASGNI4
line 769
;769:	if (!torso.hModel) {
ADDRLP4 520+8
INDIRI4
CNSTI4 0
NEI4 $369
line 770
;770:		return;
ADDRGP4 $312
JUMPV
LABELV $369
line 773
;771:	}
;772:
;773:	torso.customSkin = pi->torsoSkin;
ADDRLP4 520+108
ADDRFP4 16
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ASGNI4
line 775
;774:
;775:	VectorCopy( origin, torso.lightingOrigin );
ADDRLP4 520+12
ADDRLP4 368
INDIRB
ASGNB 12
line 777
;776:
;777:	UI_PositionRotatedEntityOnTag( &torso, &legs, pi->legsModel, "tag_torso");
ADDRLP4 520
ARGP4
ADDRLP4 380
ARGP4
ADDRFP4 16
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $374
ARGP4
ADDRGP4 UI_PositionRotatedEntityOnTag
CALLV
pop
line 779
;778:
;779:	torso.renderfx = renderfx;
ADDRLP4 520+4
ADDRLP4 800
INDIRI4
ASGNI4
line 781
;780:
;781:	trap_R_AddRefEntityToScene( &torso );
ADDRLP4 520
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 786
;782:
;783:	//
;784:	// add the head
;785:	//
;786:	head.hModel = pi->headModel;
ADDRLP4 660+8
ADDRFP4 16
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ASGNI4
line 787
;787:	if (!head.hModel) {
ADDRLP4 660+8
INDIRI4
CNSTI4 0
NEI4 $377
line 788
;788:		return;
ADDRGP4 $312
JUMPV
LABELV $377
line 790
;789:	}
;790:	head.customSkin = pi->headSkin;
ADDRLP4 660+108
ADDRFP4 16
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
ASGNI4
line 792
;791:
;792:	VectorCopy( origin, head.lightingOrigin );
ADDRLP4 660+12
ADDRLP4 368
INDIRB
ASGNB 12
line 794
;793:
;794:	UI_PositionRotatedEntityOnTag( &head, &torso, pi->torsoModel, "tag_head");
ADDRLP4 660
ARGP4
ADDRLP4 520
ARGP4
ADDRFP4 16
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRGP4 $382
ARGP4
ADDRGP4 UI_PositionRotatedEntityOnTag
CALLV
pop
line 796
;795:
;796:	head.renderfx = renderfx;
ADDRLP4 660+4
ADDRLP4 800
INDIRI4
ASGNI4
line 798
;797:
;798:	trap_R_AddRefEntityToScene( &head );
ADDRLP4 660
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 803
;799:
;800:	//
;801:	// add the gun
;802:	//
;803:	if ( pi->currentWeapon != WP_NONE ) {
ADDRFP4 16
INDIRP4
CNSTI4 1208
ADDP4
INDIRI4
CNSTI4 0
EQI4 $384
line 804
;804:		memset( &gun, 0, sizeof(gun) );
ADDRLP4 804
ARGP4
CNSTI4 0
ARGI4
CNSTU4 140
ARGU4
ADDRGP4 memset
CALLP4
pop
line 805
;805:		gun.hModel = pi->weaponModel;
ADDRLP4 804+8
ADDRFP4 16
INDIRP4
CNSTI4 1156
ADDP4
INDIRI4
ASGNI4
line 806
;806:		VectorCopy( origin, gun.lightingOrigin );
ADDRLP4 804+12
ADDRLP4 368
INDIRB
ASGNB 12
line 807
;807:		UI_PositionEntityOnTag( &gun, &torso, pi->torsoModel, "tag_weapon");
ADDRLP4 804
ARGP4
ADDRLP4 520
ARGP4
ADDRFP4 16
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRGP4 $388
ARGP4
ADDRGP4 UI_PositionEntityOnTag
CALLV
pop
line 808
;808:		gun.renderfx = renderfx;
ADDRLP4 804+4
ADDRLP4 800
INDIRI4
ASGNI4
line 809
;809:		trap_R_AddRefEntityToScene( &gun );
ADDRLP4 804
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 810
;810:	}
LABELV $384
line 815
;811:
;812:	//
;813:	// add the spinning barrel
;814:	//
;815:	if ( pi->realWeapon == WP_MACHINEGUN || pi->realWeapon == WP_GAUNTLET || pi->realWeapon == WP_BFG ) {
ADDRLP4 1276
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 1276
INDIRP4
CNSTI4 1272
ADDP4
INDIRI4
CNSTI4 2
EQI4 $393
ADDRLP4 1276
INDIRP4
CNSTI4 1272
ADDP4
INDIRI4
CNSTI4 1
EQI4 $393
ADDRLP4 1276
INDIRP4
CNSTI4 1272
ADDP4
INDIRI4
CNSTI4 9
NEI4 $390
LABELV $393
line 818
;816:		vec3_t	angles;
;817:
;818:		memset( &barrel, 0, sizeof(barrel) );
ADDRLP4 944
ARGP4
CNSTI4 0
ARGI4
CNSTU4 140
ARGU4
ADDRGP4 memset
CALLP4
pop
line 819
;819:		VectorCopy( origin, barrel.lightingOrigin );
ADDRLP4 944+12
ADDRLP4 368
INDIRB
ASGNB 12
line 820
;820:		barrel.renderfx = renderfx;
ADDRLP4 944+4
ADDRLP4 800
INDIRI4
ASGNI4
line 822
;821:
;822:		barrel.hModel = pi->barrelModel;
ADDRLP4 944+8
ADDRFP4 16
INDIRP4
CNSTI4 1160
ADDP4
INDIRI4
ASGNI4
line 823
;823:		angles[YAW] = 0;
ADDRLP4 1280+4
CNSTF4 0
ASGNF4
line 824
;824:		angles[PITCH] = 0;
ADDRLP4 1280
CNSTF4 0
ASGNF4
line 825
;825:		angles[ROLL] = UI_MachinegunSpinAngle( pi );
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 1292
ADDRGP4 UI_MachinegunSpinAngle
CALLF4
ASGNF4
ADDRLP4 1280+8
ADDRLP4 1292
INDIRF4
ASGNF4
line 826
;826:		if( pi->realWeapon == WP_GAUNTLET || pi->realWeapon == WP_BFG ) {
ADDRLP4 1296
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 1296
INDIRP4
CNSTI4 1272
ADDP4
INDIRI4
CNSTI4 1
EQI4 $401
ADDRLP4 1296
INDIRP4
CNSTI4 1272
ADDP4
INDIRI4
CNSTI4 9
NEI4 $399
LABELV $401
line 827
;827:			angles[PITCH] = angles[ROLL];
ADDRLP4 1280
ADDRLP4 1280+8
INDIRF4
ASGNF4
line 828
;828:			angles[ROLL] = 0;
ADDRLP4 1280+8
CNSTF4 0
ASGNF4
line 829
;829:		}
LABELV $399
line 830
;830:		AnglesToAxis( angles, barrel.axis );
ADDRLP4 1280
ARGP4
ADDRLP4 944+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 832
;831:
;832:		UI_PositionRotatedEntityOnTag( &barrel, &gun, pi->weaponModel, "tag_barrel");
ADDRLP4 944
ARGP4
ADDRLP4 804
ARGP4
ADDRFP4 16
INDIRP4
CNSTI4 1156
ADDP4
INDIRI4
ARGI4
ADDRGP4 $405
ARGP4
ADDRGP4 UI_PositionRotatedEntityOnTag
CALLV
pop
line 834
;833:
;834:		trap_R_AddRefEntityToScene( &barrel );
ADDRLP4 944
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 835
;835:	}
LABELV $390
line 840
;836:
;837:	//
;838:	// add muzzle flash
;839:	//
;840:	if ( dp_realtime <= pi->muzzleFlashTime ) {
ADDRGP4 dp_realtime
INDIRI4
ADDRFP4 16
INDIRP4
CNSTI4 1180
ADDP4
INDIRI4
GTI4 $406
line 841
;841:		if ( pi->flashModel ) {
ADDRFP4 16
INDIRP4
CNSTI4 1164
ADDP4
INDIRI4
CNSTI4 0
EQI4 $408
line 842
;842:			memset( &flash, 0, sizeof(flash) );
ADDRLP4 1108
ARGP4
CNSTI4 0
ARGI4
CNSTU4 140
ARGU4
ADDRGP4 memset
CALLP4
pop
line 843
;843:			flash.hModel = pi->flashModel;
ADDRLP4 1108+8
ADDRFP4 16
INDIRP4
CNSTI4 1164
ADDP4
INDIRI4
ASGNI4
line 844
;844:			VectorCopy( origin, flash.lightingOrigin );
ADDRLP4 1108+12
ADDRLP4 368
INDIRB
ASGNB 12
line 845
;845:			UI_PositionEntityOnTag( &flash, &gun, pi->weaponModel, "tag_flash");
ADDRLP4 1108
ARGP4
ADDRLP4 804
ARGP4
ADDRFP4 16
INDIRP4
CNSTI4 1156
ADDP4
INDIRI4
ARGI4
ADDRGP4 $412
ARGP4
ADDRGP4 UI_PositionEntityOnTag
CALLV
pop
line 846
;846:			flash.renderfx = renderfx;
ADDRLP4 1108+4
ADDRLP4 800
INDIRI4
ASGNI4
line 847
;847:			trap_R_AddRefEntityToScene( &flash );
ADDRLP4 1108
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 848
;848:		}
LABELV $408
line 851
;849:
;850:		// make a dlight for the flash
;851:		if ( pi->flashDlightColor[0] || pi->flashDlightColor[1] || pi->flashDlightColor[2] ) {
ADDRLP4 1280
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 1280
INDIRP4
CNSTI4 1168
ADDP4
INDIRF4
CNSTF4 0
NEF4 $417
ADDRLP4 1280
INDIRP4
CNSTI4 1172
ADDP4
INDIRF4
CNSTF4 0
NEF4 $417
ADDRLP4 1280
INDIRP4
CNSTI4 1176
ADDP4
INDIRF4
CNSTF4 0
EQF4 $414
LABELV $417
line 852
;852:			trap_R_AddLightToScene( flash.origin, 200 + (rand()&31), pi->flashDlightColor[0],
ADDRLP4 1284
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1108+68
ARGP4
ADDRLP4 1284
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
ADDRLP4 1288
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 1288
INDIRP4
CNSTI4 1168
ADDP4
INDIRF4
ARGF4
ADDRLP4 1288
INDIRP4
CNSTI4 1172
ADDP4
INDIRF4
ARGF4
ADDRLP4 1288
INDIRP4
CNSTI4 1176
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 854
;853:				pi->flashDlightColor[1], pi->flashDlightColor[2] );
;854:		}
LABELV $414
line 855
;855:	}
LABELV $406
line 860
;856:
;857:	//
;858:	// add the chat icon
;859:	//
;860:	if ( pi->chat ) {
ADDRFP4 16
INDIRP4
CNSTI4 1252
ADDP4
INDIRI4
CNSTI4 0
EQI4 $419
line 861
;861:		UI_PlayerFloatSprite( pi, origin, trap_R_RegisterShaderNoMip( "sprites/balloon3" ) );
ADDRGP4 $421
ARGP4
ADDRLP4 1280
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 368
ARGP4
ADDRLP4 1280
INDIRI4
ARGI4
ADDRGP4 UI_PlayerFloatSprite
CALLV
pop
line 862
;862:	}
LABELV $419
line 867
;863:
;864:	//
;865:	// add an accent light
;866:	//
;867:	origin[0] -= 100;	// + = behind, - = in front
ADDRLP4 368
ADDRLP4 368
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 868
;868:	origin[1] += 100;	// + = left, - = right
ADDRLP4 368+4
ADDRLP4 368+4
INDIRF4
CNSTF4 1120403456
ADDF4
ASGNF4
line 869
;869:	origin[2] += 100;	// + = above, - = below
ADDRLP4 368+8
ADDRLP4 368+8
INDIRF4
CNSTF4 1120403456
ADDF4
ASGNF4
line 870
;870:	trap_R_AddLightToScene( origin, 500, 1.0, 1.0, 1.0 );
ADDRLP4 368
ARGP4
CNSTF4 1140457472
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 872
;871:
;872:	origin[0] -= 100;
ADDRLP4 368
ADDRLP4 368
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 873
;873:	origin[1] -= 100;
ADDRLP4 368+4
ADDRLP4 368+4
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 874
;874:	origin[2] -= 100;
ADDRLP4 368+8
ADDRLP4 368+8
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 875
;875:	trap_R_AddLightToScene( origin, 500, 1.0, 0.0, 0.0 );
ADDRLP4 368
ARGP4
CNSTF4 1140457472
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 877
;876:
;877:	trap_R_RenderScene( &refdef );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 878
;878:}
LABELV $312
endproc UI_DrawPlayer 1300 28
proc UI_FileExists 8 12
line 885
;879:
;880:/*
;881:==========================
;882:UI_FileExists
;883:==========================
;884:*/
;885:static qboolean	UI_FileExists(const char *filename) {
line 888
;886:	int len;
;887:
;888:	len = trap_FS_FOpenFile( filename, 0, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 889
;889:	if (len>0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $427
line 890
;890:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $426
JUMPV
LABELV $427
line 892
;891:	}
;892:	return qfalse;
CNSTI4 0
RETI4
LABELV $426
endproc UI_FileExists 8 12
proc UI_FindClientHeadFile 32 40
line 900
;893:}
;894:
;895:/*
;896:==========================
;897:UI_FindClientHeadFile
;898:==========================
;899:*/
;900:static qboolean	UI_FindClientHeadFile( char *filename, int length, const char *teamName, const char *headModelName, const char *headSkinName, const char *base, const char *ext ) {
line 904
;901:	char *team, *headsFolder;
;902:	int i;
;903:
;904:	team = "default";
ADDRLP4 8
ADDRGP4 $430
ASGNP4
line 906
;905:
;906:	if ( headModelName[0] == '*' ) {
ADDRFP4 12
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $431
line 907
;907:		headsFolder = "heads/";
ADDRLP4 4
ADDRGP4 $433
ASGNP4
line 908
;908:		headModelName++;
ADDRFP4 12
ADDRFP4 12
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 909
;909:	}
ADDRGP4 $436
JUMPV
LABELV $431
line 910
;910:	else {
line 911
;911:		headsFolder = "";
ADDRLP4 4
ADDRGP4 $434
ASGNP4
line 912
;912:	}
ADDRGP4 $436
JUMPV
LABELV $435
line 913
;913:	while(1) {
line 914
;914:		for ( i = 0; i < 2; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $438
line 915
;915:			if ( i == 0 && teamName && *teamName ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $442
ADDRLP4 12
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $442
ADDRLP4 12
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $442
line 916
;916:				Com_sprintf( filename, length, "models/players/%s%s/%s/%s%s_%s.%s", headsFolder, headModelName, headSkinName, teamName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $444
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 917
;917:			}
ADDRGP4 $443
JUMPV
LABELV $442
line 918
;918:			else {
line 919
;919:				Com_sprintf( filename, length, "models/players/%s%s/%s/%s_%s.%s", headsFolder, headModelName, headSkinName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $445
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 920
;920:			}
LABELV $443
line 921
;921:			if ( UI_FileExists( filename ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 UI_FileExists
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $446
line 922
;922:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $429
JUMPV
LABELV $446
line 924
;923:			}
;924:			if ( i == 0 && teamName && *teamName ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $448
ADDRLP4 20
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $448
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $448
line 925
;925:				Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s.%s", headsFolder, headModelName, teamName, base, headSkinName, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $450
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 926
;926:			}
ADDRGP4 $449
JUMPV
LABELV $448
line 927
;927:			else {
line 928
;928:				Com_sprintf( filename, length, "models/players/%s%s/%s_%s.%s", headsFolder, headModelName, base, headSkinName, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $451
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 929
;929:			}
LABELV $449
line 930
;930:			if ( UI_FileExists( filename ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 UI_FileExists
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $452
line 931
;931:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $429
JUMPV
LABELV $452
line 933
;932:			}
;933:			if ( !teamName || !*teamName ) {
ADDRLP4 28
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $456
ADDRLP4 28
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $454
LABELV $456
line 934
;934:				break;
ADDRGP4 $440
JUMPV
LABELV $454
line 936
;935:			}
;936:		}
LABELV $439
line 914
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $438
LABELV $440
line 938
;937:		// if tried the heads folder first
;938:		if ( headsFolder[0] ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $457
line 939
;939:			break;
ADDRGP4 $437
JUMPV
LABELV $457
line 941
;940:		}
;941:		headsFolder = "heads/";
ADDRLP4 4
ADDRGP4 $433
ASGNP4
line 942
;942:	}
LABELV $436
line 913
ADDRGP4 $435
JUMPV
LABELV $437
line 944
;943:
;944:	return qfalse;
CNSTI4 0
RETI4
LABELV $429
endproc UI_FindClientHeadFile 32 40
proc UI_RegisterClientSkin 152 28
line 952
;945:}
;946:
;947:/*
;948:==========================
;949:UI_RegisterClientSkin
;950:==========================
;951:*/
;952:static qboolean	UI_RegisterClientSkin( playerInfo_t *pi, const char *modelName, const char *skinName, const char *headModelName, const char *headSkinName , const char *teamName) {
line 955
;953:	char		filename[MAX_QPATH*2];
;954:
;955:	if (teamName && *teamName) {
ADDRLP4 128
ADDRFP4 20
INDIRP4
ASGNP4
ADDRLP4 128
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $460
ADDRLP4 128
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $460
line 956
;956:		Com_sprintf( filename, sizeof( filename ), "models/players/%s/%s/lower_%s.skin", modelName, teamName, skinName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $462
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 957
;957:	} else {
ADDRGP4 $461
JUMPV
LABELV $460
line 958
;958:		Com_sprintf( filename, sizeof( filename ), "models/players/%s/lower_%s.skin", modelName, skinName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $463
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 959
;959:	}
LABELV $461
line 960
;960:	pi->legsSkin = trap_R_RegisterSkin( filename );
ADDRLP4 0
ARGP4
ADDRLP4 132
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 132
INDIRI4
ASGNI4
line 961
;961:	if (!pi->legsSkin) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $464
line 962
;962:		if (teamName && *teamName) {
ADDRLP4 136
ADDRFP4 20
INDIRP4
ASGNP4
ADDRLP4 136
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $466
ADDRLP4 136
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $466
line 963
;963:			Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/%s/lower_%s.skin", modelName, teamName, skinName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $468
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 964
;964:		} else {
ADDRGP4 $467
JUMPV
LABELV $466
line 965
;965:			Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/lower_%s.skin", modelName, skinName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $469
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 966
;966:		}
LABELV $467
line 967
;967:		pi->legsSkin = trap_R_RegisterSkin( filename );
ADDRLP4 0
ARGP4
ADDRLP4 140
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 140
INDIRI4
ASGNI4
line 968
;968:	}
LABELV $464
line 970
;969:
;970:	if (teamName && *teamName) {
ADDRLP4 136
ADDRFP4 20
INDIRP4
ASGNP4
ADDRLP4 136
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $470
ADDRLP4 136
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $470
line 971
;971:		Com_sprintf( filename, sizeof( filename ), "models/players/%s/%s/upper_%s.skin", modelName, teamName, skinName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $472
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 972
;972:	} else {
ADDRGP4 $471
JUMPV
LABELV $470
line 973
;973:		Com_sprintf( filename, sizeof( filename ), "models/players/%s/upper_%s.skin", modelName, skinName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $473
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 974
;974:	}
LABELV $471
line 975
;975:	pi->torsoSkin = trap_R_RegisterSkin( filename );
ADDRLP4 0
ARGP4
ADDRLP4 140
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 140
INDIRI4
ASGNI4
line 976
;976:	if (!pi->torsoSkin) {
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
CNSTI4 0
NEI4 $474
line 977
;977:		if (teamName && *teamName) {
ADDRLP4 144
ADDRFP4 20
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $476
ADDRLP4 144
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $476
line 978
;978:			Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/%s/upper_%s.skin", modelName, teamName, skinName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $478
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 979
;979:		} else {
ADDRGP4 $477
JUMPV
LABELV $476
line 980
;980:			Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/upper_%s.skin", modelName, skinName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $479
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 981
;981:		}
LABELV $477
line 982
;982:		pi->torsoSkin = trap_R_RegisterSkin( filename );
ADDRLP4 0
ARGP4
ADDRLP4 148
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 148
INDIRI4
ASGNI4
line 983
;983:	}
LABELV $474
line 985
;984:
;985:	if ( UI_FindClientHeadFile( filename, sizeof(filename), teamName, headModelName, headSkinName, "head", "skin" ) ) {
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 $482
ARGP4
ADDRGP4 $483
ARGP4
ADDRLP4 144
ADDRGP4 UI_FindClientHeadFile
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $480
line 986
;986:		pi->headSkin = trap_R_RegisterSkin( filename );
ADDRLP4 0
ARGP4
ADDRLP4 148
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 148
INDIRI4
ASGNI4
line 987
;987:	}
LABELV $480
line 989
;988:
;989:	if ( !pi->legsSkin || !pi->torsoSkin || !pi->headSkin ) {
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $487
ADDRLP4 148
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
CNSTI4 0
EQI4 $487
ADDRLP4 148
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CNSTI4 0
NEI4 $484
LABELV $487
line 990
;990:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $459
JUMPV
LABELV $484
line 993
;991:	}
;992:
;993:	return qtrue;
CNSTI4 1
RETI4
LABELV $459
endproc UI_RegisterClientSkin 152 28
proc UI_ParseAnimationFile 20068 12
line 1002
;994:}
;995:
;996:
;997:/*
;998:======================
;999:UI_ParseAnimationFile
;1000:======================
;1001:*/
;1002:static qboolean UI_ParseAnimationFile( const char *filename, animation_t *animations ) {
line 1012
;1003:	char		*text_p, *prev;
;1004:	int			len;
;1005:	int			i;
;1006:	char		*token;
;1007:	float		fps;
;1008:	int			skip;
;1009:	char		text[20000];
;1010:	fileHandle_t	f;
;1011:
;1012:	memset( animations, 0, sizeof( animation_t ) * MAX_ANIMATIONS );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 868
ARGU4
ADDRGP4 memset
CALLP4
pop
line 1015
;1013:
;1014:	// load the file
;1015:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20028
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 20032
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 20032
INDIRI4
ASGNI4
line 1016
;1016:	if ( len <= 0 ) {
ADDRLP4 24
INDIRI4
CNSTI4 0
GTI4 $489
line 1017
;1017:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $488
JUMPV
LABELV $489
line 1019
;1018:	}
;1019:	if ( len >= ( sizeof( text ) - 1 ) ) {
ADDRLP4 24
INDIRI4
CVIU4 4
CNSTU4 19999
LTU4 $491
line 1020
;1020:		Com_Printf( "File %s too long\n", filename );
ADDRGP4 $493
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1021
;1021:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $488
JUMPV
LABELV $491
line 1023
;1022:	}
;1023:	trap_FS_Read( text, len, f );
ADDRLP4 28
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 20028
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 1024
;1024:	text[len] = 0;
ADDRLP4 24
INDIRI4
ADDRLP4 28
ADDP4
CNSTI1 0
ASGNI1
line 1025
;1025:	trap_FS_FCloseFile( f );
ADDRLP4 20028
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 1027
;1026:
;1027:	COM_Compress(text);
ADDRLP4 28
ARGP4
ADDRGP4 COM_Compress
CALLI4
pop
line 1030
;1028:
;1029:	// parse the text
;1030:	text_p = text;
ADDRLP4 8
ADDRLP4 28
ASGNP4
line 1031
;1031:	skip = 0;	// quite the compiler warning
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 $495
JUMPV
LABELV $494
line 1034
;1032:
;1033:	// read optional parameters
;1034:	while ( 1 ) {
line 1035
;1035:		prev = text_p;	// so we can unget
ADDRLP4 16
ADDRLP4 8
INDIRP4
ASGNP4
line 1036
;1036:		token = COM_Parse( &text_p );
ADDRLP4 8
ARGP4
ADDRLP4 20036
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20036
INDIRP4
ASGNP4
line 1037
;1037:		if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $497
line 1038
;1038:			break;
ADDRGP4 $496
JUMPV
LABELV $497
line 1040
;1039:		}
;1040:		if ( !Q_stricmp( token, "footsteps" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $501
ARGP4
ADDRLP4 20040
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20040
INDIRI4
CNSTI4 0
NEI4 $499
line 1041
;1041:			token = COM_Parse( &text_p );
ADDRLP4 8
ARGP4
ADDRLP4 20044
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20044
INDIRP4
ASGNP4
line 1042
;1042:			if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $495
line 1043
;1043:				break;
ADDRGP4 $496
JUMPV
line 1045
;1044:			}
;1045:			continue;
LABELV $499
line 1046
;1046:		} else if ( !Q_stricmp( token, "headoffset" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $506
ARGP4
ADDRLP4 20044
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20044
INDIRI4
CNSTI4 0
NEI4 $504
line 1047
;1047:			for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $507
line 1048
;1048:				token = COM_Parse( &text_p );
ADDRLP4 8
ARGP4
ADDRLP4 20048
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20048
INDIRP4
ASGNP4
line 1049
;1049:				if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $511
line 1050
;1050:					break;
ADDRGP4 $495
JUMPV
LABELV $511
line 1052
;1051:				}
;1052:			}
LABELV $508
line 1047
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 3
LTI4 $507
line 1053
;1053:			continue;
ADDRGP4 $495
JUMPV
LABELV $504
line 1054
;1054:		} else if ( !Q_stricmp( token, "sex" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $515
ARGP4
ADDRLP4 20048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20048
INDIRI4
CNSTI4 0
NEI4 $513
line 1055
;1055:			token = COM_Parse( &text_p );
ADDRLP4 8
ARGP4
ADDRLP4 20052
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20052
INDIRP4
ASGNP4
line 1056
;1056:			if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $495
line 1057
;1057:				break;
ADDRGP4 $496
JUMPV
line 1059
;1058:			}
;1059:			continue;
LABELV $513
line 1063
;1060:		}
;1061:
;1062:		// if it is a number, start parsing animations
;1063:		if ( token[0] >= '0' && token[0] <= '9' ) {
ADDRLP4 20052
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20052
INDIRI4
CNSTI4 48
LTI4 $518
ADDRLP4 20052
INDIRI4
CNSTI4 57
GTI4 $518
line 1064
;1064:			text_p = prev;	// unget the token
ADDRLP4 8
ADDRLP4 16
INDIRP4
ASGNP4
line 1065
;1065:			break;
ADDRGP4 $496
JUMPV
LABELV $518
line 1068
;1066:		}
;1067:
;1068:		Com_Printf( "unknown token '%s' is %s\n", token, filename );
ADDRGP4 $520
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1069
;1069:	}
LABELV $495
line 1034
ADDRGP4 $494
JUMPV
LABELV $496
line 1072
;1070:
;1071:	// read information for each frame
;1072:	for ( i = 0 ; i < MAX_ANIMATIONS ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $521
line 1074
;1073:
;1074:		token = COM_Parse( &text_p );
ADDRLP4 8
ARGP4
ADDRLP4 20036
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20036
INDIRP4
ASGNP4
line 1075
;1075:		if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $525
line 1076
;1076:			break;
ADDRGP4 $523
JUMPV
LABELV $525
line 1078
;1077:		}
;1078:		animations[i].firstFrame = atoi( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20040
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 20040
INDIRI4
ASGNI4
line 1080
;1079:		// leg only frames are adjusted to not count the upper body only frames
;1080:		if ( i == LEGS_WALKCR ) {
ADDRLP4 4
INDIRI4
CNSTI4 13
NEI4 $527
line 1081
;1081:			skip = animations[LEGS_WALKCR].firstFrame - animations[TORSO_GESTURE].firstFrame;
ADDRLP4 20044
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 20044
INDIRP4
CNSTI4 364
ADDP4
INDIRI4
ADDRLP4 20044
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1082
;1082:		}
LABELV $527
line 1083
;1083:		if ( i >= LEGS_WALKCR ) {
ADDRLP4 4
INDIRI4
CNSTI4 13
LTI4 $529
line 1084
;1084:			animations[i].firstFrame -= skip;
ADDRLP4 20044
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRFP4 4
INDIRP4
ADDP4
ASGNP4
ADDRLP4 20044
INDIRP4
ADDRLP4 20044
INDIRP4
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1085
;1085:		}
LABELV $529
line 1087
;1086:
;1087:		token = COM_Parse( &text_p );
ADDRLP4 8
ARGP4
ADDRLP4 20044
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20044
INDIRP4
ASGNP4
line 1088
;1088:		if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $531
line 1089
;1089:			break;
ADDRGP4 $523
JUMPV
LABELV $531
line 1091
;1090:		}
;1091:		animations[i].numFrames = atoi( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20048
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 20048
INDIRI4
ASGNI4
line 1093
;1092:
;1093:		token = COM_Parse( &text_p );
ADDRLP4 8
ARGP4
ADDRLP4 20052
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20052
INDIRP4
ASGNP4
line 1094
;1094:		if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $533
line 1095
;1095:			break;
ADDRGP4 $523
JUMPV
LABELV $533
line 1097
;1096:		}
;1097:		animations[i].loopFrames = atoi( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20056
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 20056
INDIRI4
ASGNI4
line 1099
;1098:
;1099:		token = COM_Parse( &text_p );
ADDRLP4 8
ARGP4
ADDRLP4 20060
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20060
INDIRP4
ASGNP4
line 1100
;1100:		if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $535
line 1101
;1101:			break;
ADDRGP4 $523
JUMPV
LABELV $535
line 1103
;1102:		}
;1103:		fps = atof( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20064
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 20064
INDIRF4
ASGNF4
line 1104
;1104:		if ( fps == 0 ) {
ADDRLP4 12
INDIRF4
CNSTF4 0
NEF4 $537
line 1105
;1105:			fps = 1;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 1106
;1106:		}
LABELV $537
line 1107
;1107:		animations[i].frameLerp = 1000 / fps;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI4 12
ADDP4
CNSTF4 1148846080
ADDRLP4 12
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 1108
;1108:		animations[i].initialLerp = 1000 / fps;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI4 16
ADDP4
CNSTF4 1148846080
ADDRLP4 12
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 1109
;1109:	}
LABELV $522
line 1072
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 31
LTI4 $521
LABELV $523
line 1111
;1110:
;1111:	if ( i != MAX_ANIMATIONS ) {
ADDRLP4 4
INDIRI4
CNSTI4 31
EQI4 $539
line 1112
;1112:		Com_Printf( "Error parsing animation file: %s", filename );
ADDRGP4 $541
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1113
;1113:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $488
JUMPV
LABELV $539
line 1116
;1114:	}
;1115:
;1116:	return qtrue;
CNSTI4 1
RETI4
LABELV $488
endproc UI_ParseAnimationFile 20068 12
export UI_RegisterClientModelname
proc UI_RegisterClientModelname 356 24
line 1124
;1117:}
;1118:
;1119:/*
;1120:==========================
;1121:UI_RegisterClientModelname
;1122:==========================
;1123:*/
;1124:qboolean UI_RegisterClientModelname( playerInfo_t *pi, const char *modelSkinName, const char *headModelSkinName, const char *teamName ) {
line 1132
;1125:	char		modelName[MAX_QPATH];
;1126:	char		skinName[MAX_QPATH];
;1127:	char		headModelName[MAX_QPATH];
;1128:	char		headSkinName[MAX_QPATH];
;1129:	char		filename[MAX_QPATH];
;1130:	char		*slash;
;1131:
;1132:	pi->torsoModel = 0;
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTI4 0
ASGNI4
line 1133
;1133:	pi->headModel = 0;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
CNSTI4 0
ASGNI4
line 1135
;1134:
;1135:	if ( !modelSkinName[0] ) {
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $543
line 1136
;1136:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $542
JUMPV
LABELV $543
line 1139
;1137:	}
;1138:
;1139:	Q_strncpyz( modelName, modelSkinName, sizeof( modelName ) );
ADDRLP4 128
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1141
;1140:
;1141:	slash = strchr( modelName, '/' );
ADDRLP4 128
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 324
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 192
ADDRLP4 324
INDIRP4
ASGNP4
line 1142
;1142:	if ( !slash ) {
ADDRLP4 192
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $545
line 1144
;1143:		// modelName did not include a skin name
;1144:		Q_strncpyz( skinName, "default", sizeof( skinName ) );
ADDRLP4 196
ARGP4
ADDRGP4 $430
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1145
;1145:	} else {
ADDRGP4 $546
JUMPV
LABELV $545
line 1146
;1146:		Q_strncpyz( skinName, slash + 1, sizeof( skinName ) );
ADDRLP4 196
ARGP4
ADDRLP4 192
INDIRP4
CNSTI4 1
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1147
;1147:		*slash = '\0';
ADDRLP4 192
INDIRP4
CNSTI1 0
ASGNI1
line 1148
;1148:	}
LABELV $546
line 1150
;1149:
;1150:	Q_strncpyz( headModelName, headModelSkinName, sizeof( headModelName ) );
ADDRLP4 64
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1151
;1151:	slash = strchr( headModelName, '/' );
ADDRLP4 64
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 328
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 192
ADDRLP4 328
INDIRP4
ASGNP4
line 1152
;1152:	if ( !slash ) {
ADDRLP4 192
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $547
line 1154
;1153:		// modelName did not include a skin name
;1154:		Q_strncpyz( headSkinName, "default", sizeof( skinName ) );
ADDRLP4 260
ARGP4
ADDRGP4 $430
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1155
;1155:	} else {
ADDRGP4 $548
JUMPV
LABELV $547
line 1156
;1156:		Q_strncpyz( headSkinName, slash + 1, sizeof( skinName ) );
ADDRLP4 260
ARGP4
ADDRLP4 192
INDIRP4
CNSTI4 1
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1157
;1157:		*slash = '\0';
ADDRLP4 192
INDIRP4
CNSTI1 0
ASGNI1
line 1158
;1158:	}
LABELV $548
line 1162
;1159:
;1160:	// load cmodels before models so filecache works
;1161:
;1162:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/lower.md3", modelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $549
ARGP4
ADDRLP4 128
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1163
;1163:	pi->legsModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 332
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 332
INDIRI4
ASGNI4
line 1164
;1164:	if ( !pi->legsModel ) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $550
line 1165
;1165:		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/lower.md3", modelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $552
ARGP4
ADDRLP4 128
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1166
;1166:		pi->legsModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 336
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 336
INDIRI4
ASGNI4
line 1167
;1167:		if ( !pi->legsModel ) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $553
line 1168
;1168:			Com_Printf( "Failed to load model file %s\n", filename );
ADDRGP4 $555
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1169
;1169:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $542
JUMPV
LABELV $553
line 1171
;1170:		}
;1171:	}
LABELV $550
line 1173
;1172:
;1173:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/upper.md3", modelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $556
ARGP4
ADDRLP4 128
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1174
;1174:	pi->torsoModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 336
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDRLP4 336
INDIRI4
ASGNI4
line 1175
;1175:	if ( !pi->torsoModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 0
NEI4 $557
line 1176
;1176:		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/upper.md3", modelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $559
ARGP4
ADDRLP4 128
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1177
;1177:		pi->torsoModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 340
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDRLP4 340
INDIRI4
ASGNI4
line 1178
;1178:		if ( !pi->torsoModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 0
NEI4 $560
line 1179
;1179:			Com_Printf( "Failed to load model file %s\n", filename );
ADDRGP4 $555
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1180
;1180:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $542
JUMPV
LABELV $560
line 1182
;1181:		}
;1182:	}
LABELV $557
line 1184
;1183:
;1184:	if (headModelName && headModelName[0] == '*' ) {
ADDRLP4 64
CVPU4 4
CNSTU4 0
EQU4 $562
ADDRLP4 64
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $562
line 1185
;1185:		Com_sprintf( filename, sizeof( filename ), "models/players/heads/%s/%s.md3", &headModelName[1], &headModelName[1] );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $564
ARGP4
ADDRLP4 64+1
ARGP4
ADDRLP4 64+1
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1186
;1186:	}
ADDRGP4 $563
JUMPV
LABELV $562
line 1187
;1187:	else {
line 1188
;1188:		Com_sprintf( filename, sizeof( filename ), "models/players/%s/head.md3", headModelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $567
ARGP4
ADDRLP4 64
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1189
;1189:	}
LABELV $563
line 1190
;1190:	pi->headModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 340
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 340
INDIRI4
ASGNI4
line 1191
;1191:	if ( !pi->headModel && headModelName[0] != '*') {
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
CNSTI4 0
NEI4 $568
ADDRLP4 64
INDIRI1
CVII4 1
CNSTI4 42
EQI4 $568
line 1192
;1192:		Com_sprintf( filename, sizeof( filename ), "models/players/heads/%s/%s.md3", headModelName, headModelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $564
ARGP4
ADDRLP4 64
ARGP4
ADDRLP4 64
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1193
;1193:		pi->headModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 344
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 344
INDIRI4
ASGNI4
line 1194
;1194:	}
LABELV $568
line 1196
;1195:
;1196:	if (!pi->headModel) {
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
CNSTI4 0
NEI4 $570
line 1197
;1197:		Com_Printf( "Failed to load model file %s\n", filename );
ADDRGP4 $555
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1198
;1198:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $542
JUMPV
LABELV $570
line 1202
;1199:	}
;1200:
;1201:	// if any skins failed to load, fall back to default
;1202:	if ( !UI_RegisterClientSkin( pi, modelName, skinName, headModelName, headSkinName, teamName) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 128
ARGP4
ADDRLP4 196
ARGP4
ADDRLP4 64
ARGP4
ADDRLP4 260
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 344
ADDRGP4 UI_RegisterClientSkin
CALLI4
ASGNI4
ADDRLP4 344
INDIRI4
CNSTI4 0
NEI4 $572
line 1203
;1203:		if ( !UI_RegisterClientSkin( pi, modelName, "default", headModelName, "default", teamName ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 128
ARGP4
ADDRLP4 348
ADDRGP4 $430
ASGNP4
ADDRLP4 348
INDIRP4
ARGP4
ADDRLP4 64
ARGP4
ADDRLP4 348
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 352
ADDRGP4 UI_RegisterClientSkin
CALLI4
ASGNI4
ADDRLP4 352
INDIRI4
CNSTI4 0
NEI4 $574
line 1204
;1204:			Com_Printf( "Failed to load skin file: %s : %s\n", modelName, skinName );
ADDRGP4 $576
ARGP4
ADDRLP4 128
ARGP4
ADDRLP4 196
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1205
;1205:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $542
JUMPV
LABELV $574
line 1207
;1206:		}
;1207:	}
LABELV $572
line 1210
;1208:
;1209:	// load the animations
;1210:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/animation.cfg", modelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $577
ARGP4
ADDRLP4 128
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1211
;1211:	if ( !UI_ParseAnimationFile( filename, pi->animations ) ) {
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
ARGP4
ADDRLP4 348
ADDRGP4 UI_ParseAnimationFile
CALLI4
ASGNI4
ADDRLP4 348
INDIRI4
CNSTI4 0
NEI4 $578
line 1212
;1212:		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/animation.cfg", modelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $580
ARGP4
ADDRLP4 128
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1213
;1213:		if ( !UI_ParseAnimationFile( filename, pi->animations ) ) {
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
ARGP4
ADDRLP4 352
ADDRGP4 UI_ParseAnimationFile
CALLI4
ASGNI4
ADDRLP4 352
INDIRI4
CNSTI4 0
NEI4 $581
line 1214
;1214:			Com_Printf( "Failed to load animation file %s\n", filename );
ADDRGP4 $583
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1215
;1215:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $542
JUMPV
LABELV $581
line 1217
;1216:		}
;1217:	}
LABELV $578
line 1219
;1218:
;1219:	return qtrue;
CNSTI4 1
RETI4
LABELV $542
endproc UI_RegisterClientModelname 356 24
export UI_PlayerInfo_SetModel
proc UI_PlayerInfo_SetModel 12 16
line 1228
;1220:}
;1221:
;1222:
;1223:/*
;1224:===============
;1225:UI_PlayerInfo_SetModel
;1226:===============
;1227:*/
;1228:void UI_PlayerInfo_SetModel( playerInfo_t *pi, const char *model, const char *headmodel, char *teamName ) {
line 1229
;1229:	memset( pi, 0, sizeof(*pi) );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 1276
ARGU4
ADDRGP4 memset
CALLP4
pop
line 1230
;1230:	UI_RegisterClientModelname( pi, model, headmodel, teamName );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 UI_RegisterClientModelname
CALLI4
pop
line 1231
;1231:	pi->weapon = WP_MACHINEGUN;
ADDRFP4 0
INDIRP4
CNSTI4 1220
ADDP4
CNSTI4 2
ASGNI4
line 1232
;1232:	pi->currentWeapon = pi->weapon;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 1208
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 1220
ADDP4
INDIRI4
ASGNI4
line 1233
;1233:	pi->lastWeapon = pi->weapon;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 1224
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 1220
ADDP4
INDIRI4
ASGNI4
line 1234
;1234:	pi->pendingWeapon = -1;
ADDRFP4 0
INDIRP4
CNSTI4 1228
ADDP4
CNSTI4 -1
ASGNI4
line 1235
;1235:	pi->weaponTimer = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1232
ADDP4
CNSTI4 0
ASGNI4
line 1236
;1236:	pi->chat = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 1252
ADDP4
CNSTI4 0
ASGNI4
line 1237
;1237:	pi->newModel = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 1256
ADDP4
CNSTI4 1
ASGNI4
line 1238
;1238:	UI_PlayerInfo_SetWeapon( pi, pi->weapon );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1220
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_PlayerInfo_SetWeapon
CALLV
pop
line 1239
;1239:}
LABELV $584
endproc UI_PlayerInfo_SetModel 12 16
export UI_PlayerInfo_SetInfo
proc UI_PlayerInfo_SetInfo 28 8
line 1247
;1240:
;1241:
;1242:/*
;1243:===============
;1244:UI_PlayerInfo_SetInfo
;1245:===============
;1246:*/
;1247:void UI_PlayerInfo_SetInfo( playerInfo_t *pi, int legsAnim, int torsoAnim, vec3_t viewAngles, vec3_t moveAngles, weapon_t weaponNumber, qboolean chat ) {
line 1251
;1248:	int			currentAnim;
;1249:	weapon_t	weaponNum;
;1250:
;1251:	pi->chat = chat;
ADDRFP4 0
INDIRP4
CNSTI4 1252
ADDP4
ADDRFP4 24
INDIRI4
ASGNI4
line 1254
;1252:
;1253:	// view angles
;1254:	VectorCopy( viewAngles, pi->viewAngles );
ADDRFP4 0
INDIRP4
CNSTI4 1184
ADDP4
ADDRFP4 12
INDIRP4
INDIRB
ASGNB 12
line 1257
;1255:
;1256:	// move angles
;1257:	VectorCopy( moveAngles, pi->moveAngles );
ADDRFP4 0
INDIRP4
CNSTI4 1196
ADDP4
ADDRFP4 16
INDIRP4
INDIRB
ASGNB 12
line 1259
;1258:
;1259:	if ( pi->newModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 1256
ADDP4
INDIRI4
CNSTI4 0
EQI4 $586
line 1260
;1260:		pi->newModel = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 1256
ADDP4
CNSTI4 0
ASGNI4
line 1262
;1261:
;1262:		jumpHeight = 0;
ADDRGP4 jumpHeight
CNSTF4 0
ASGNF4
line 1263
;1263:		pi->pendingLegsAnim = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1236
ADDP4
CNSTI4 0
ASGNI4
line 1264
;1264:		UI_ForceLegsAnim( pi, legsAnim );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UI_ForceLegsAnim
CALLV
pop
line 1265
;1265:		pi->legs.yawAngle = viewAngles[YAW];
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1266
;1266:		pi->legs.yawing = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 0
ASGNI4
line 1268
;1267:
;1268:		pi->pendingTorsoAnim = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1244
ADDP4
CNSTI4 0
ASGNI4
line 1269
;1269:		UI_ForceTorsoAnim( pi, torsoAnim );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 UI_ForceTorsoAnim
CALLV
pop
line 1270
;1270:		pi->torso.yawAngle = viewAngles[YAW];
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1271
;1271:		pi->torso.yawing = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 0
ASGNI4
line 1273
;1272:
;1273:		if ( weaponNumber != -1 ) {
ADDRFP4 20
INDIRI4
CNSTI4 -1
EQI4 $585
line 1274
;1274:			pi->weapon = weaponNumber;
ADDRFP4 0
INDIRP4
CNSTI4 1220
ADDP4
ADDRFP4 20
INDIRI4
ASGNI4
line 1275
;1275:			pi->currentWeapon = weaponNumber;
ADDRFP4 0
INDIRP4
CNSTI4 1208
ADDP4
ADDRFP4 20
INDIRI4
ASGNI4
line 1276
;1276:			pi->lastWeapon = weaponNumber;
ADDRFP4 0
INDIRP4
CNSTI4 1224
ADDP4
ADDRFP4 20
INDIRI4
ASGNI4
line 1277
;1277:			pi->pendingWeapon = -1;
ADDRFP4 0
INDIRP4
CNSTI4 1228
ADDP4
CNSTI4 -1
ASGNI4
line 1278
;1278:			pi->weaponTimer = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1232
ADDP4
CNSTI4 0
ASGNI4
line 1279
;1279:			UI_PlayerInfo_SetWeapon( pi, pi->weapon );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1220
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_PlayerInfo_SetWeapon
CALLV
pop
line 1280
;1280:		}
line 1282
;1281:
;1282:		return;
ADDRGP4 $585
JUMPV
LABELV $586
line 1286
;1283:	}
;1284:
;1285:	// weapon
;1286:	if ( weaponNumber == -1 ) {
ADDRFP4 20
INDIRI4
CNSTI4 -1
NEI4 $590
line 1287
;1287:		pi->pendingWeapon = -1;
ADDRFP4 0
INDIRP4
CNSTI4 1228
ADDP4
CNSTI4 -1
ASGNI4
line 1288
;1288:		pi->weaponTimer = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1232
ADDP4
CNSTI4 0
ASGNI4
line 1289
;1289:	}
ADDRGP4 $591
JUMPV
LABELV $590
line 1290
;1290:	else if ( weaponNumber != WP_NONE ) {
ADDRFP4 20
INDIRI4
CNSTI4 0
EQI4 $592
line 1291
;1291:		pi->pendingWeapon = weaponNumber;
ADDRFP4 0
INDIRP4
CNSTI4 1228
ADDP4
ADDRFP4 20
INDIRI4
ASGNI4
line 1292
;1292:		pi->weaponTimer = dp_realtime + UI_TIMER_WEAPON_DELAY;
ADDRFP4 0
INDIRP4
CNSTI4 1232
ADDP4
ADDRGP4 dp_realtime
INDIRI4
CNSTI4 250
ADDI4
ASGNI4
line 1293
;1293:	}
LABELV $592
LABELV $591
line 1294
;1294:	weaponNum = pi->lastWeapon;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 1224
ADDP4
INDIRI4
ASGNI4
line 1295
;1295:	pi->weapon = weaponNum;
ADDRFP4 0
INDIRP4
CNSTI4 1220
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1297
;1296:
;1297:	if ( torsoAnim == BOTH_DEATH1 || legsAnim == BOTH_DEATH1 ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $596
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $594
LABELV $596
line 1298
;1298:		torsoAnim = legsAnim = BOTH_DEATH1;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRFP4 4
ADDRLP4 8
INDIRI4
ASGNI4
ADDRFP4 8
ADDRLP4 8
INDIRI4
ASGNI4
line 1299
;1299:		pi->weapon = pi->currentWeapon = WP_NONE;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 1208
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 1220
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1300
;1300:		UI_PlayerInfo_SetWeapon( pi, pi->weapon );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 1220
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_PlayerInfo_SetWeapon
CALLV
pop
line 1302
;1301:
;1302:		jumpHeight = 0;
ADDRGP4 jumpHeight
CNSTF4 0
ASGNF4
line 1303
;1303:		pi->pendingLegsAnim = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1236
ADDP4
CNSTI4 0
ASGNI4
line 1304
;1304:		UI_ForceLegsAnim( pi, legsAnim );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UI_ForceLegsAnim
CALLV
pop
line 1306
;1305:
;1306:		pi->pendingTorsoAnim = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1244
ADDP4
CNSTI4 0
ASGNI4
line 1307
;1307:		UI_ForceTorsoAnim( pi, torsoAnim );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 UI_ForceTorsoAnim
CALLV
pop
line 1309
;1308:
;1309:		return;
ADDRGP4 $585
JUMPV
LABELV $594
line 1313
;1310:	}
;1311:
;1312:	// leg animation
;1313:	currentAnim = pi->legsAnim & ~ANIM_TOGGLEBIT;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1212
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1314
;1314:	if ( legsAnim != LEGS_JUMP && ( currentAnim == LEGS_JUMP || currentAnim == LEGS_LAND ) ) {
ADDRFP4 4
INDIRI4
CNSTI4 18
EQI4 $597
ADDRLP4 0
INDIRI4
CNSTI4 18
EQI4 $599
ADDRLP4 0
INDIRI4
CNSTI4 19
NEI4 $597
LABELV $599
line 1315
;1315:		pi->pendingLegsAnim = legsAnim;
ADDRFP4 0
INDIRP4
CNSTI4 1236
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 1316
;1316:	}
ADDRGP4 $598
JUMPV
LABELV $597
line 1317
;1317:	else if ( legsAnim != currentAnim ) {
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $600
line 1318
;1318:		jumpHeight = 0;
ADDRGP4 jumpHeight
CNSTF4 0
ASGNF4
line 1319
;1319:		pi->pendingLegsAnim = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1236
ADDP4
CNSTI4 0
ASGNI4
line 1320
;1320:		UI_ForceLegsAnim( pi, legsAnim );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UI_ForceLegsAnim
CALLV
pop
line 1321
;1321:	}
LABELV $600
LABELV $598
line 1324
;1322:
;1323:	// torso animation
;1324:	if ( torsoAnim == TORSO_STAND || torsoAnim == TORSO_STAND2 ) {
ADDRLP4 12
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 11
EQI4 $604
ADDRLP4 12
INDIRI4
CNSTI4 12
NEI4 $602
LABELV $604
line 1325
;1325:		if ( weaponNum == WP_NONE || weaponNum == WP_GAUNTLET ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $607
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $605
LABELV $607
line 1326
;1326:			torsoAnim = TORSO_STAND2;
ADDRFP4 8
CNSTI4 12
ASGNI4
line 1327
;1327:		}
ADDRGP4 $606
JUMPV
LABELV $605
line 1328
;1328:		else {
line 1329
;1329:			torsoAnim = TORSO_STAND;
ADDRFP4 8
CNSTI4 11
ASGNI4
line 1330
;1330:		}
LABELV $606
line 1331
;1331:	}
LABELV $602
line 1333
;1332:
;1333:	if ( torsoAnim == TORSO_ATTACK || torsoAnim == TORSO_ATTACK2 ) {
ADDRLP4 16
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 7
EQI4 $610
ADDRLP4 16
INDIRI4
CNSTI4 8
NEI4 $608
LABELV $610
line 1334
;1334:		if ( weaponNum == WP_NONE || weaponNum == WP_GAUNTLET ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $613
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $611
LABELV $613
line 1335
;1335:			torsoAnim = TORSO_ATTACK2;
ADDRFP4 8
CNSTI4 8
ASGNI4
line 1336
;1336:		}
ADDRGP4 $612
JUMPV
LABELV $611
line 1337
;1337:		else {
line 1338
;1338:			torsoAnim = TORSO_ATTACK;
ADDRFP4 8
CNSTI4 7
ASGNI4
line 1339
;1339:		}
LABELV $612
line 1340
;1340:		pi->muzzleFlashTime = dp_realtime + UI_TIMER_MUZZLE_FLASH;
ADDRFP4 0
INDIRP4
CNSTI4 1180
ADDP4
ADDRGP4 dp_realtime
INDIRI4
CNSTI4 20
ADDI4
ASGNI4
line 1342
;1341:		//FIXME play firing sound here
;1342:	}
LABELV $608
line 1344
;1343:
;1344:	currentAnim = pi->torsoAnim & ~ANIM_TOGGLEBIT;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1216
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1346
;1345:
;1346:	if ( weaponNum != pi->currentWeapon || currentAnim == TORSO_RAISE || currentAnim == TORSO_DROP ) {
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1208
ADDP4
INDIRI4
NEI4 $617
ADDRLP4 0
INDIRI4
CNSTI4 10
EQI4 $617
ADDRLP4 0
INDIRI4
CNSTI4 9
NEI4 $614
LABELV $617
line 1347
;1347:		pi->pendingTorsoAnim = torsoAnim;
ADDRFP4 0
INDIRP4
CNSTI4 1244
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 1348
;1348:	}
ADDRGP4 $615
JUMPV
LABELV $614
line 1349
;1349:	else if ( ( currentAnim == TORSO_GESTURE || currentAnim == TORSO_ATTACK ) && ( torsoAnim != currentAnim ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 6
EQI4 $620
ADDRLP4 0
INDIRI4
CNSTI4 7
NEI4 $618
LABELV $620
ADDRFP4 8
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $618
line 1350
;1350:		pi->pendingTorsoAnim = torsoAnim;
ADDRFP4 0
INDIRP4
CNSTI4 1244
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 1351
;1351:	}
ADDRGP4 $619
JUMPV
LABELV $618
line 1352
;1352:	else if ( torsoAnim != currentAnim ) {
ADDRFP4 8
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $621
line 1353
;1353:		pi->pendingTorsoAnim = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1244
ADDP4
CNSTI4 0
ASGNI4
line 1354
;1354:		UI_ForceTorsoAnim( pi, torsoAnim );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 UI_ForceTorsoAnim
CALLV
pop
line 1355
;1355:	}
LABELV $621
LABELV $619
LABELV $615
line 1356
;1356:}
LABELV $585
endproc UI_PlayerInfo_SetInfo 28 8
bss
align 4
LABELV jumpHeight
skip 4
align 4
LABELV dp_realtime
skip 4
import UI_RankStatusMenu
import RankStatus_Cache
import UI_SignupMenu
import Signup_Cache
import UI_LoginMenu
import Login_Cache
import UI_InitGameinfo
import UI_SPUnlockMedals_f
import UI_SPUnlock_f
import UI_GetAwardLevel
import UI_LogAwardData
import UI_NewGame
import UI_GetCurrentGame
import UI_CanShowTierVideo
import UI_ShowTierVideo
import UI_TierCompleted
import UI_SetBestScore
import UI_GetBestScore
import UI_GetBotNameByNumber
import UI_LoadBots
import UI_GetNumBots
import UI_GetBotInfoByName
import UI_GetBotInfoByNumber
import UI_GetNumSPTiers
import UI_GetNumSPArenas
import UI_GetNumArenas
import UI_GetSpecialArenaInfo
import UI_GetArenaInfoByMap
import UI_GetArenaInfoByNumber
import UI_NetworkOptionsMenu
import UI_NetworkOptionsMenu_Cache
import UI_SoundOptionsMenu
import UI_SoundOptionsMenu_Cache
import UI_DisplayOptionsMenu
import UI_DisplayOptionsMenu_Cache
import UI_SaveConfigMenu
import UI_SaveConfigMenu_Cache
import UI_LoadConfigMenu
import UI_LoadConfig_Cache
import UI_TeamOrdersMenu_Cache
import UI_TeamOrdersMenu_f
import UI_TeamOrdersMenu
import UI_RemoveBotsMenu
import UI_RemoveBots_Cache
import UI_AddBotsMenu
import UI_AddBots_Cache
import trap_SetPbClStatus
import trap_VerifyCDKey
import trap_R_RemapShader
import trap_RealTime
import trap_CIN_SetExtents
import trap_CIN_DrawCinematic
import trap_CIN_RunCinematic
import trap_CIN_StopCinematic
import trap_CIN_PlayCinematic
import trap_S_StartBackgroundTrack
import trap_S_StopBackgroundTrack
import trap_R_RegisterFont
import trap_SetCDKey
import trap_GetCDKey
import trap_MemoryRemaining
import trap_LAN_CompareServers
import trap_LAN_ServerStatus
import trap_LAN_ResetPings
import trap_LAN_RemoveServer
import trap_LAN_AddServer
import trap_LAN_UpdateVisiblePings
import trap_LAN_ServerIsVisible
import trap_LAN_MarkServerVisible
import trap_LAN_SaveCachedServers
import trap_LAN_LoadCachedServers
import trap_LAN_GetPingInfo
import trap_LAN_GetPing
import trap_LAN_ClearPing
import trap_LAN_GetPingQueueCount
import trap_LAN_GetServerPing
import trap_LAN_GetServerInfo
import trap_LAN_GetServerAddressString
import trap_LAN_GetServerCount
import trap_GetConfigString
import trap_GetGlconfig
import trap_GetClientState
import trap_GetClipboardData
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_ClearStates
import trap_Key_SetOverstrikeMode
import trap_Key_GetOverstrikeMode
import trap_Key_IsDown
import trap_Key_SetBinding
import trap_Key_GetBindingBuf
import trap_Key_KeynumToStringBuf
import trap_S_RegisterSound
import trap_S_StartLocalSound
import trap_CM_LerpTag
import trap_UpdateScreen
import trap_R_ModelBounds
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_AddLightToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Cmd_ExecuteText
import trap_Argv
import trap_Argc
import trap_Cvar_InfoStringBuffer
import trap_Cvar_Create
import trap_Cvar_Reset
import trap_Cvar_SetValue
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import UI_SPSkillMenu_Cache
import UI_SPSkillMenu
import UI_SPPostgameMenu_f
import UI_SPPostgameMenu_Cache
import UI_SPArena_Start
import UI_SPLevelMenu_ReInit
import UI_SPLevelMenu_f
import UI_SPLevelMenu
import UI_SPLevelMenu_Cache
import uis
import UI_LoadBestScores
import m_entersound
import UI_StartDemoLoop
import UI_Cvar_VariableString
import UI_Argv
import UI_ForceMenuOff
import UI_PopMenu
import UI_PushMenu
import UI_SetActiveMenu
import UI_IsFullscreen
import UI_DrawTextBox
import UI_AdjustFrom640
import UI_CursorInRect
import UI_DrawChar
import UI_DrawString
import UI_ProportionalStringWidth
import UI_DrawProportionalString
import UI_ProportionalSizeScale
import UI_DrawBannerString
import UI_LerpColor
import UI_SetColor
import UI_UpdateScreen
import UI_DrawSides
import UI_DrawTopBottom
import UI_DrawRect
import UI_FillRect
import UI_DrawHandlePic
import UI_DrawNamedPic
import UI_ClampCvar
import UI_ConsoleCommand
import UI_Refresh
import UI_MouseEvent
import UI_KeyEvent
import UI_Shutdown
import UI_Init
import uiInfo
import DriverInfo_Cache
import GraphicsOptions_Cache
import UI_GraphicsOptionsMenu
import ServerInfo_Cache
import UI_ServerInfoMenu
import UI_BotSelectMenu_Cache
import UI_BotSelectMenu
import ServerOptions_Cache
import StartServer_Cache
import UI_StartServerMenu
import ArenaServers_Cache
import UI_ArenaServersMenu
import SpecifyServer_Cache
import UI_SpecifyServerMenu
import SpecifyLeague_Cache
import UI_SpecifyLeagueMenu
import Preferences_Cache
import UI_PreferencesMenu
import PlayerSettings_Cache
import UI_PlayerSettingsMenu
import PlayerModel_Cache
import UI_PlayerModelMenu
import UI_CDKeyMenu_f
import UI_CDKeyMenu_Cache
import UI_CDKeyMenu
import UI_ModsMenu_Cache
import UI_ModsMenu
import UI_CinematicsMenu_Cache
import UI_CinematicsMenu_f
import UI_CinematicsMenu
import Demos_Cache
import UI_DemosMenu
import Controls_Cache
import UI_ControlsMenu
import UI_DrawConnectScreen
import TeamMain_Cache
import UI_TeamMainMenu
import UI_SetupMenu
import UI_SetupMenu_Cache
import UI_ConfirmMenu
import ConfirmMenu_Cache
import UI_InGameMenu
import InGame_Cache
import UI_CreditMenu
import UI_UpdateCvars
import UI_RegisterCvars
import UI_MainMenu
import MainMenu_Cache
import UI_VideoCheck
import UI_LoadArenas
import UI_ClearScores
import UI_ShowPostGame
import UI_AdjustTimeByGame
import _UI_SetActiveMenu
import UI_LoadMenus
import UI_Load
import UI_Report
import MenuField_Key
import MenuField_Draw
import MenuField_Init
import MField_Draw
import MField_CharEvent
import MField_KeyDownEvent
import MField_Clear
import ui_medalSounds
import ui_medalPicNames
import ui_medalNames
import text_color_highlight
import text_color_normal
import text_color_disabled
import listbar_color
import list_color
import name_color
import color_dim
import color_red
import color_orange
import color_blue
import color_yellow
import color_white
import color_black
import menu_dim_color
import menu_black_color
import menu_red_color
import menu_highlight_color
import menu_dark_color
import menu_grayed_color
import menu_text_color
export weaponChangeSound
align 4
LABELV weaponChangeSound
skip 4
import menu_null_sound
import menu_buzz_sound
import menu_out_sound
import menu_move_sound
import menu_in_sound
import ScrollList_Key
import ScrollList_Draw
import Bitmap_Draw
import Bitmap_Init
import Menu_DefaultKey
import Menu_SetCursorToItem
import Menu_SetCursor
import Menu_ActivateItem
import Menu_ItemAtCursor
import Menu_Draw
import Menu_AdjustCursor
import Menu_AddItem
import Menu_Focus
import Menu_Cache
import ui_serverStatusTimeOut
import ui_realCaptureLimit
import ui_realWarmUp
import ui_teamArenaFirstRun
import ui_recordSPDemo
import ui_hudFiles
import ui_Q3Model
import ui_findPlayer
import ui_bigFont
import ui_smallFont
import ui_captureLimit
import ui_fragLimit
import ui_scoreShutoutBonus
import ui_scoreSkillBonus
import ui_scoreTimeBonus
import ui_scoreTime
import ui_scoreBase
import ui_scoreTeam
import ui_scorePerfect
import ui_scoreScore
import ui_scoreGauntlets
import ui_scoreAssists
import ui_scoreDefends
import ui_scoreCaptures
import ui_scoreExcellents
import ui_scoreImpressives
import ui_scoreAccuracy
import ui_singlePlayerActive
import ui_lastServerRefresh_3
import ui_lastServerRefresh_2
import ui_lastServerRefresh_1
import ui_lastServerRefresh_0
import ui_selectedPlayerName
import ui_selectedPlayer
import ui_currentOpponent
import ui_mapIndex
import ui_currentNetMap
import ui_currentMap
import ui_currentTier
import ui_menuFiles
import ui_netSource
import ui_blueteam5
import ui_blueteam4
import ui_blueteam3
import ui_blueteam2
import ui_blueteam1
import ui_redteam5
import ui_redteam4
import ui_redteam3
import ui_redteam2
import ui_redteam1
import ui_actualNetGameType
import ui_netGameType
import ui_joinGameType
import ui_gameType
import ui_dedicated
import ui_blueteam
import ui_redteam
import ui_opponentName
import ui_teamName
import ui_initialized
import ui_debug
import ui_new
import ui_cdkeychecked
import ui_server16
import ui_server15
import ui_server14
import ui_server13
import ui_server12
import ui_server11
import ui_server10
import ui_server9
import ui_server8
import ui_server7
import ui_server6
import ui_server5
import ui_server4
import ui_server3
import ui_server2
import ui_server1
import ui_marks
import ui_drawCrosshairNames
import ui_drawCrosshair
import ui_brassTime
import ui_browserShowEmpty
import ui_browserShowFull
import ui_browserSortKey
import ui_browserGameType
import ui_browserMaster
import ui_spSelection
import ui_spSkill
import ui_spVideos
import ui_spAwards
import ui_spScores5
import ui_spScores4
import ui_spScores3
import ui_spScores2
import ui_spScores1
import ui_botsFile
import ui_arenasFile
import ui_ctf_friendly
import ui_ctf_timelimit
import ui_ctf_capturelimit
import ui_team_friendly
import ui_team_timelimit
import ui_team_fraglimit
import ui_tourney_timelimit
import ui_tourney_fraglimit
import ui_ffa_timelimit
import ui_ffa_fraglimit
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
LABELV $583
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $580
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $577
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $576
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $567
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $564
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $559
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $556
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $555
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $552
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $549
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $541
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $520
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $515
byte 1 115
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $506
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 111
byte 1 102
byte 1 102
byte 1 115
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $501
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $493
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $483
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $482
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $479
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $478
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $473
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $472
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $469
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $468
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $463
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $462
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $451
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $450
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $445
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $444
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $434
byte 1 0
align 1
LABELV $433
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 47
byte 1 0
align 1
LABELV $430
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $421
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 111
byte 1 110
byte 1 51
byte 1 0
align 1
LABELV $412
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $405
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 98
byte 1 97
byte 1 114
byte 1 114
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $388
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $382
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $374
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 116
byte 1 111
byte 1 114
byte 1 115
byte 1 111
byte 1 0
align 1
LABELV $184
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $112
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $111
byte 1 95
byte 1 98
byte 1 97
byte 1 114
byte 1 114
byte 1 101
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
