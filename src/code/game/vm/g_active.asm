export P_DamageFeedback
code
proc P_DamageFeedback 36 12
file "../g_active.c"
line 17
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:#include "g_local.h"
;5:
;6:
;7:/*
;8:===============
;9:G_DamageFeedback
;10:
;11:Called just before a snapshot is sent to the given player.
;12:Totals up all damage and generates both the player_state_t
;13:damage values to that client for pain blends and kicks, and
;14:global pain sound events for all clients.
;15:===============
;16:*/
;17:void P_DamageFeedback( gentity_t *player ) {
line 22
;18:	gclient_t	*client;
;19:	float	count;
;20:	vec3_t	angles;
;21:
;22:	client = player->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 23
;23:	if ( client->ps.pm_type == PM_DEAD ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $55
line 24
;24:		return;
ADDRGP4 $54
JUMPV
LABELV $55
line 28
;25:	}
;26:
;27:	// total points of damage shot at the player this frame
;28:	count = client->damage_blood + client->damage_armor;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 29
;29:	if ( count == 0 ) {
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $57
line 30
;30:		return;		// didn't take any damage
ADDRGP4 $54
JUMPV
LABELV $57
line 33
;31:	}
;32:
;33:	if ( count > 255 ) {
ADDRLP4 4
INDIRF4
CNSTF4 1132396544
LEF4 $59
line 34
;34:		count = 255;
ADDRLP4 4
CNSTF4 1132396544
ASGNF4
line 35
;35:	}
LABELV $59
line 41
;36:
;37:	// send the information to the client
;38:
;39:	// world damage (falling, slime, etc) uses a special code
;40:	// to make the blend blob centered instead of positional
;41:	if ( client->damage_fromWorld ) {
ADDRLP4 0
INDIRP4
CNSTI4 712
ADDP4
INDIRI4
CNSTI4 0
EQI4 $61
line 42
;42:		client->ps.damagePitch = 255;
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
CNSTI4 255
ASGNI4
line 43
;43:		client->ps.damageYaw = 255;
ADDRLP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 255
ASGNI4
line 45
;44:
;45:		client->damage_fromWorld = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 712
ADDP4
CNSTI4 0
ASGNI4
line 46
;46:	} else {
ADDRGP4 $62
JUMPV
LABELV $61
line 47
;47:		vectoangles( client->damage_from, angles );
ADDRLP4 0
INDIRP4
CNSTI4 700
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 48
;48:		client->ps.damagePitch = angles[PITCH]/360.0 * 256;
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
ADDRLP4 8
INDIRF4
CNSTF4 1060506465
MULF4
CVFI4 4
ASGNI4
line 49
;49:		client->ps.damageYaw = angles[YAW]/360.0 * 256;
ADDRLP4 0
INDIRP4
CNSTI4 172
ADDP4
ADDRLP4 8+4
INDIRF4
CNSTF4 1060506465
MULF4
CVFI4 4
ASGNI4
line 50
;50:	}
LABELV $62
line 53
;51:
;52:	// play an apropriate pain sound
;53:	if ( (level.time > player->pain_debounce_time) && !(player->flags & FL_GODMODE) ) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 720
ADDP4
INDIRI4
LEI4 $64
ADDRLP4 24
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $64
line 54
;54:		player->pain_debounce_time = level.time + 700;
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 700
ADDI4
ASGNI4
line 55
;55:		G_AddEvent( player, EV_PAIN, player->health );
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 56
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 56
;56:		client->ps.damageEvent++;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 57
;57:	}
LABELV $64
line 60
;58:
;59:
;60:	client->ps.damageCount = count;
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 65
;61:
;62:	//
;63:	// clear totals
;64:	//
;65:	client->damage_blood = 0;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
CNSTI4 0
ASGNI4
line 66
;66:	client->damage_armor = 0;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
CNSTI4 0
ASGNI4
line 67
;67:	client->damage_knockback = 0;
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
CNSTI4 0
ASGNI4
line 68
;68:}
LABELV $54
endproc P_DamageFeedback 36 12
export P_WorldEffects
proc P_WorldEffects 24 32
line 79
;69:
;70:
;71:
;72:/*
;73:=============
;74:P_WorldEffects
;75:
;76:Check for lava / slime contents and drowning
;77:=============
;78:*/
;79:void P_WorldEffects( gentity_t *ent ) {
line 83
;80:	qboolean	envirosuit;
;81:	int			waterlevel;
;82:
;83:	if ( ent->client->noclip ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 656
ADDP4
INDIRI4
CNSTI4 0
EQI4 $69
line 84
;84:		ent->client->airOutTime = level.time + 12000;	// don't need air
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 756
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 12000
ADDI4
ASGNI4
line 85
;85:		return;
ADDRGP4 $68
JUMPV
LABELV $69
line 88
;86:	}
;87:
;88:	waterlevel = ent->waterlevel;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
INDIRI4
ASGNI4
line 90
;89:
;90:	envirosuit = ent->client->ps.powerups[PW_BATTLESUIT] > level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 320
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $74
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $75
JUMPV
LABELV $74
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $75
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 95
;91:
;92:	//
;93:	// check for drowning
;94:	//
;95:	if ( waterlevel == 3 ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
NEI4 $76
line 97
;96:		// envirosuit give air
;97:		if ( envirosuit ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $78
line 98
;98:			ent->client->airOutTime = level.time + 10000;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 756
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
ADDI4
ASGNI4
line 99
;99:		}
LABELV $78
line 102
;100:
;101:		// if out of air, start drowning
;102:		if ( ent->client->airOutTime < level.time) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $77
line 104
;103:			// drown!
;104:			ent->client->airOutTime += 1000;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 756
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 105
;105:			if ( ent->health > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
LEI4 $77
line 107
;106:				// take more damage the longer underwater
;107:				ent->damage += 2;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 108
;108:				if (ent->damage > 15)
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 15
LEI4 $86
line 109
;109:					ent->damage = 15;
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 15
ASGNI4
LABELV $86
line 112
;110:
;111:				// don't play a normal pain sound
;112:				ent->pain_debounce_time = level.time + 200;
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 114
;113:
;114:				G_Damage (ent, NULL, NULL, NULL, NULL, 
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
CNSTI4 14
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 116
;115:					ent->damage, DAMAGE_NO_ARMOR, MOD_WATER);
;116:			}
line 117
;117:		}
line 118
;118:	} else {
ADDRGP4 $77
JUMPV
LABELV $76
line 119
;119:		ent->client->airOutTime = level.time + 12000;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 756
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 12000
ADDI4
ASGNI4
line 120
;120:		ent->damage = 2;
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 2
ASGNI4
line 121
;121:	}
LABELV $77
line 126
;122:
;123:	//
;124:	// check for sizzle damage (move to pmove?)
;125:	//
;126:	if (waterlevel && 
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $90
ADDRFP4 0
INDIRP4
CNSTI4 792
ADDP4
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
EQI4 $90
line 127
;127:		(ent->watertype&(CONTENTS_LAVA|CONTENTS_SLIME)) ) {
line 128
;128:		if (ent->health > 0
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
LEI4 $92
ADDRLP4 12
INDIRP4
CNSTI4 720
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GTI4 $92
line 129
;129:			&& ent->pain_debounce_time <= level.time	) {
line 131
;130:
;131:			if ( envirosuit ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $95
line 132
;132:				G_AddEvent( ent, EV_POWERUP_BATTLESUIT, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 62
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 133
;133:			} else {
ADDRGP4 $96
JUMPV
LABELV $95
line 134
;134:				if (ent->watertype & CONTENTS_LAVA) {
ADDRFP4 0
INDIRP4
CNSTI4 792
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $97
line 135
;135:					G_Damage (ent, NULL, NULL, NULL, NULL, 
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 30
MULI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 137
;136:						30*waterlevel, 0, MOD_LAVA);
;137:				}
LABELV $97
line 139
;138:
;139:				if (ent->watertype & CONTENTS_SLIME) {
ADDRFP4 0
INDIRP4
CNSTI4 792
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $99
line 140
;140:					G_Damage (ent, NULL, NULL, NULL, NULL, 
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 10
MULI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 15
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 142
;141:						10*waterlevel, 0, MOD_SLIME);
;142:				}
LABELV $99
line 143
;143:			}
LABELV $96
line 144
;144:		}
LABELV $92
line 145
;145:	}
LABELV $90
line 146
;146:}
LABELV $68
endproc P_WorldEffects 24 32
export G_SetClientSound
proc G_SetClientSound 4 4
line 155
;147:
;148:
;149:
;150:/*
;151:===============
;152:G_SetClientSound
;153:===============
;154:*/
;155:void G_SetClientSound( gentity_t *ent ) {
line 157
;156:#ifdef MISSIONPACK
;157:	if( ent->s.eFlags & EF_TICKING ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $102
line 158
;158:		ent->client->ps.loopSound = G_SoundIndex( "sound/weapons/proxmine/wstbtick.wav");
ADDRGP4 $104
ARGP4
ADDRLP4 0
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 444
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 159
;159:	}
ADDRGP4 $103
JUMPV
LABELV $102
line 162
;160:	else
;161:#endif
;162:	if (ent->waterlevel && (ent->watertype&(CONTENTS_LAVA|CONTENTS_SLIME)) ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 796
ADDP4
INDIRI4
CNSTI4 0
EQI4 $105
ADDRLP4 0
INDIRP4
CNSTI4 792
ADDP4
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
EQI4 $105
line 163
;163:		ent->client->ps.loopSound = level.snd_fry;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 444
ADDP4
ADDRGP4 level+352
INDIRI4
ASGNI4
line 164
;164:	} else {
ADDRGP4 $106
JUMPV
LABELV $105
line 165
;165:		ent->client->ps.loopSound = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 444
ADDP4
CNSTI4 0
ASGNI4
line 166
;166:	}
LABELV $106
LABELV $103
line 167
;167:}
LABELV $101
endproc G_SetClientSound 4 4
export ClientImpacts
proc ClientImpacts 76 12
line 178
;168:
;169:
;170:
;171://==============================================================
;172:
;173:/*
;174:==============
;175:ClientImpacts
;176:==============
;177:*/
;178:void ClientImpacts( gentity_t *ent, pmove_t *pm ) {
line 183
;179:	int		i, j;
;180:	trace_t	trace;
;181:	gentity_t	*other;
;182:
;183:	memset( &trace, 0, sizeof( trace ) );
ADDRLP4 12
ARGP4
CNSTI4 0
ARGI4
CNSTU4 56
ARGU4
ADDRGP4 memset
CALLP4
pop
line 184
;184:	for (i=0 ; i<pm->numtouch ; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $112
JUMPV
LABELV $109
line 185
;185:		for (j=0 ; j<i ; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $116
JUMPV
LABELV $113
line 186
;186:			if (pm->touchents[j] == pm->touchents[i] ) {
ADDRLP4 68
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
INDIRP4
CNSTI4 48
ADDP4
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
INDIRP4
CNSTI4 48
ADDP4
ADDP4
INDIRI4
NEI4 $117
line 187
;187:				break;
ADDRGP4 $115
JUMPV
LABELV $117
line 189
;188:			}
;189:		}
LABELV $114
line 185
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $116
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $113
LABELV $115
line 190
;190:		if (j != i) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $119
line 191
;191:			continue;	// duplicated
ADDRGP4 $110
JUMPV
LABELV $119
line 193
;192:		}
;193:		other = &g_entities[ pm->touchents[i] ];
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
ADDP4
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 195
;194:
;195:		if ( ( ent->r.svFlags & SVF_BOT ) && ( ent->touch ) ) {
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $121
ADDRLP4 68
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $121
line 196
;196:			ent->touch( ent, other, &trace );
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CALLV
pop
line 197
;197:		}
LABELV $121
line 199
;198:
;199:		if ( !other->touch ) {
ADDRLP4 8
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $123
line 200
;200:			continue;
ADDRGP4 $110
JUMPV
LABELV $123
line 203
;201:		}
;202:
;203:		other->touch( other, ent, &trace );
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CALLV
pop
line 204
;204:	}
LABELV $110
line 184
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $112
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
LTI4 $109
line 206
;205:
;206:}
LABELV $108
endproc ClientImpacts 76 12
data
align 4
LABELV $126
byte 4 1109393408
byte 4 1109393408
byte 4 1112539136
export G_TouchTriggers
code
proc G_TouchTriggers 4224 16
line 216
;207:
;208:/*
;209:============
;210:G_TouchTriggers
;211:
;212:Find all trigger entities that ent's current position touches.
;213:Spectators will only interact with teleporters.
;214:============
;215:*/
;216:void	G_TouchTriggers( gentity_t *ent ) {
line 224
;217:	int			i, num;
;218:	int			touch[MAX_GENTITIES];
;219:	gentity_t	*hit;
;220:	trace_t		trace;
;221:	vec3_t		mins, maxs;
;222:	static vec3_t	range = { 40, 40, 52 };
;223:
;224:	if ( !ent->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $127
line 225
;225:		return;
ADDRGP4 $125
JUMPV
LABELV $127
line 229
;226:	}
;227:
;228:	// dead clients don't activate triggers!
;229:	if ( ent->client->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $129
line 230
;230:		return;
ADDRGP4 $125
JUMPV
LABELV $129
line 233
;231:	}
;232:
;233:	VectorSubtract( ent->client->ps.origin, range, mins );
ADDRLP4 4188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
ADDRLP4 4188
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRGP4 $126
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 4188
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRGP4 $126+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64+8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRGP4 $126+8
INDIRF4
SUBF4
ASGNF4
line 234
;234:	VectorAdd( ent->client->ps.origin, range, maxs );
ADDRLP4 4192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
ADDRLP4 4192
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRGP4 $126
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76+4
ADDRLP4 4192
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRGP4 $126+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76+8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRGP4 $126+8
INDIRF4
ADDF4
ASGNF4
line 236
;235:
;236:	num = trap_EntitiesInBox( mins, maxs, touch, MAX_GENTITIES );
ADDRLP4 64
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 92
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4196
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 88
ADDRLP4 4196
INDIRI4
ASGNI4
line 239
;237:
;238:	// can't use ent->absmin, because that has a one unit pad
;239:	VectorAdd( ent->client->ps.origin, ent->r.mins, mins );
ADDRLP4 4200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
ADDRLP4 4200
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 4200
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 4200
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 4200
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64+8
ADDRLP4 4204
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 4204
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDF4
ASGNF4
line 240
;240:	VectorAdd( ent->client->ps.origin, ent->r.maxs, maxs );
ADDRLP4 4208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
ADDRLP4 4208
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 4208
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76+4
ADDRLP4 4208
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 4208
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76+8
ADDRLP4 4212
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 4212
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
ASGNF4
line 242
;241:
;242:	for ( i=0 ; i<num ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $146
JUMPV
LABELV $143
line 243
;243:		hit = &g_entities[touch[i]];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 92
ADDP4
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 245
;244:
;245:		if ( !hit->touch && !ent->touch ) {
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $147
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $147
line 246
;246:			continue;
ADDRGP4 $144
JUMPV
LABELV $147
line 248
;247:		}
;248:		if ( !( hit->r.contents & CONTENTS_TRIGGER ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
CNSTI4 1073741824
BANDI4
CNSTI4 0
NEI4 $149
line 249
;249:			continue;
ADDRGP4 $144
JUMPV
LABELV $149
line 253
;250:		}
;251:
;252:		// ignore most entities if a spectator
;253:		if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
NEI4 $151
line 254
;254:			if ( hit->s.eType != ET_TELEPORT_TRIGGER &&
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 9
EQI4 $153
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 Touch_DoorTrigger
CVPU4 4
EQU4 $153
line 257
;255:				// this is ugly but adding a new ET_? type will
;256:				// most likely cause network incompatibilities
;257:				hit->touch != Touch_DoorTrigger) {
line 258
;258:				continue;
ADDRGP4 $144
JUMPV
LABELV $153
line 260
;259:			}
;260:		}
LABELV $151
line 264
;261:
;262:		// use seperate code for determining if an item is picked up
;263:		// so you don't have to actually contact its bounding box
;264:		if ( hit->s.eType == ET_ITEM ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $155
line 265
;265:			if ( !BG_PlayerTouchesItem( &ent->client->ps, &hit->s, level.time ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 4216
ADDRGP4 BG_PlayerTouchesItem
CALLI4
ASGNI4
ADDRLP4 4216
INDIRI4
CNSTI4 0
NEI4 $156
line 266
;266:				continue;
ADDRGP4 $144
JUMPV
line 268
;267:			}
;268:		} else {
LABELV $155
line 269
;269:			if ( !trap_EntityContact( mins, maxs, hit ) ) {
ADDRLP4 64
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4216
ADDRGP4 trap_EntityContact
CALLI4
ASGNI4
ADDRLP4 4216
INDIRI4
CNSTI4 0
NEI4 $160
line 270
;270:				continue;
ADDRGP4 $144
JUMPV
LABELV $160
line 272
;271:			}
;272:		}
LABELV $156
line 274
;273:
;274:		memset( &trace, 0, sizeof(trace) );
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
CNSTU4 56
ARGU4
ADDRGP4 memset
CALLP4
pop
line 276
;275:
;276:		if ( hit->touch ) {
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $162
line 277
;277:			hit->touch (hit, ent, &trace);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CALLV
pop
line 278
;278:		}
LABELV $162
line 280
;279:
;280:		if ( ( ent->r.svFlags & SVF_BOT ) && ( ent->touch ) ) {
ADDRLP4 4216
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4216
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $164
ADDRLP4 4216
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $164
line 281
;281:			ent->touch( ent, hit, &trace );
ADDRLP4 4220
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4220
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 4220
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CALLV
pop
line 282
;282:		}
LABELV $164
line 283
;283:	}
LABELV $144
line 242
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $146
ADDRLP4 4
INDIRI4
ADDRLP4 88
INDIRI4
LTI4 $143
line 286
;284:
;285:	// if we didn't touch a jump pad this pmove frame
;286:	if ( ent->client->ps.jumppad_frame != ent->client->ps.pmove_framecount ) {
ADDRLP4 4216
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4216
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
ADDRLP4 4216
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 456
ADDP4
INDIRI4
EQI4 $166
line 287
;287:		ent->client->ps.jumppad_frame = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 288
;288:		ent->client->ps.jumppad_ent = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 448
ADDP4
CNSTI4 0
ASGNI4
line 289
;289:	}
LABELV $166
line 290
;290:}
LABELV $125
endproc G_TouchTriggers 4224 16
export SpectatorThink
proc SpectatorThink 240 12
line 297
;291:
;292:/*
;293:=================
;294:SpectatorThink
;295:=================
;296:*/
;297:void SpectatorThink( gentity_t *ent, usercmd_t *ucmd ) {
line 301
;298:	pmove_t	pm;
;299:	gclient_t	*client;
;300:
;301:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 303
;302:
;303:	if ( client->sess.spectatorState != SPECTATOR_FOLLOW ) {
ADDRLP4 0
INDIRP4
CNSTI4 632
ADDP4
INDIRI4
CNSTI4 2
EQI4 $169
line 304
;304:		client->ps.pm_type = PM_SPECTATOR;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 2
ASGNI4
line 305
;305:		client->ps.speed = g_speed.value * 1.25f; // faster than normal
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ADDRGP4 g_speed+8
INDIRF4
CNSTF4 1067450368
MULF4
CVFI4 4
ASGNI4
line 308
;306:
;307:		// set up for pmove
;308:		memset( &pm, 0, sizeof( pm ) );
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 228
ARGU4
ADDRGP4 memset
CALLP4
pop
line 309
;309:		pm.ps = &client->ps;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 310
;310:		pm.cmd = *ucmd;
ADDRLP4 4+4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 24
line 311
;311:		if ( client->noclip )
ADDRLP4 0
INDIRP4
CNSTI4 656
ADDP4
INDIRI4
CNSTI4 0
EQI4 $173
line 312
;312:			pm.tracemask = 0;
ADDRLP4 4+28
CNSTI4 0
ASGNI4
ADDRGP4 $174
JUMPV
LABELV $173
line 314
;313:		else
;314:			pm.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;	// spectators can fly through bodies
ADDRLP4 4+28
CNSTI4 65537
ASGNI4
LABELV $174
line 315
;315:		pm.trace = trap_Trace;
ADDRLP4 4+220
ADDRGP4 trap_Trace
ASGNP4
line 316
;316:		pm.pointcontents = trap_PointContents;
ADDRLP4 4+224
ADDRGP4 trap_PointContents
ASGNP4
line 319
;317:
;318:		// perform a pmove
;319:		Pmove( &pm );
ADDRLP4 4
ARGP4
ADDRGP4 Pmove
CALLV
pop
line 321
;320:		// save results of pmove
;321:		VectorCopy( client->ps.origin, ent->s.origin );
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 323
;322:
;323:		G_TouchTriggers( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_TouchTriggers
CALLV
pop
line 324
;324:		trap_UnlinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 325
;325:	}
LABELV $169
line 327
;326:
;327:	client->oldbuttons = client->buttons;
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 664
ADDP4
INDIRI4
ASGNI4
line 328
;328:	client->buttons = ucmd->buttons;
ADDRLP4 0
INDIRP4
CNSTI4 664
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 331
;329:
;330:	// attack button cycles through spectators
;331:	if ( ( client->buttons & BUTTON_ATTACK ) && ! ( client->oldbuttons & BUTTON_ATTACK ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 664
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $179
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $179
line 332
;332:		Cmd_FollowCycle_f( ent, 1 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Cmd_FollowCycle_f
CALLV
pop
line 333
;333:	}
LABELV $179
line 334
;334:}
LABELV $168
endproc SpectatorThink 240 12
export ClientInactivityTimer
proc ClientInactivityTimer 8 8
line 345
;335:
;336:
;337:
;338:/*
;339:=================
;340:ClientInactivityTimer
;341:
;342:Returns qfalse if the client is dropped
;343:=================
;344:*/
;345:qboolean ClientInactivityTimer( gclient_t *client ) {
line 346
;346:	if ( ! g_inactivity.integer ) {
ADDRGP4 g_inactivity+12
INDIRI4
CNSTI4 0
NEI4 $182
line 349
;347:		// give everyone some time, so if the operator sets g_inactivity during
;348:		// gameplay, everyone isn't kicked
;349:		client->inactivityTime = level.time + 60 * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 744
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 60000
ADDI4
ASGNI4
line 350
;350:		client->inactivityWarning = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 748
ADDP4
CNSTI4 0
ASGNI4
line 351
;351:	} else if ( client->pers.cmd.forwardmove || 
ADDRGP4 $183
JUMPV
LABELV $182
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 493
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $190
ADDRLP4 0
INDIRP4
CNSTI4 494
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $190
ADDRLP4 0
INDIRP4
CNSTI4 495
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $190
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $186
LABELV $190
line 354
;352:		client->pers.cmd.rightmove || 
;353:		client->pers.cmd.upmove ||
;354:		(client->pers.cmd.buttons & BUTTON_ATTACK) ) {
line 355
;355:		client->inactivityTime = level.time + g_inactivity.integer * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 744
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRGP4 g_inactivity+12
INDIRI4
CNSTI4 1000
MULI4
ADDI4
ASGNI4
line 356
;356:		client->inactivityWarning = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 748
ADDP4
CNSTI4 0
ASGNI4
line 357
;357:	} else if ( !client->pers.localClient ) {
ADDRGP4 $187
JUMPV
LABELV $186
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRI4
CNSTI4 0
NEI4 $193
line 358
;358:		if ( level.time > client->inactivityTime ) {
ADDRGP4 level+32
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 744
ADDP4
INDIRI4
LEI4 $195
line 359
;359:			trap_DropClient( client - level.clients, "Dropped due to inactivity" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1644
DIVI4
ARGI4
ADDRGP4 $198
ARGP4
ADDRGP4 trap_DropClient
CALLV
pop
line 360
;360:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $181
JUMPV
LABELV $195
line 362
;361:		}
;362:		if ( level.time > client->inactivityTime - 10000 && !client->inactivityWarning ) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 744
ADDP4
INDIRI4
CNSTI4 10000
SUBI4
LEI4 $199
ADDRLP4 4
INDIRP4
CNSTI4 748
ADDP4
INDIRI4
CNSTI4 0
NEI4 $199
line 363
;363:			client->inactivityWarning = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 748
ADDP4
CNSTI4 1
ASGNI4
line 364
;364:			trap_SendServerCommand( client - level.clients, "cp \"Ten seconds until inactivity drop!\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1644
DIVI4
ARGI4
ADDRGP4 $202
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 365
;365:		}
LABELV $199
line 366
;366:	}
LABELV $193
LABELV $187
LABELV $183
line 367
;367:	return qtrue;
CNSTI4 1
RETI4
LABELV $181
endproc ClientInactivityTimer 8 8
data
align 4
LABELV $234
byte 4 2
byte 4 3
byte 4 4
byte 4 5
byte 4 6
byte 4 7
byte 4 8
byte 4 9
byte 4 11
byte 4 12
byte 4 13
export ClientTimerActions
code
proc ClientTimerActions 96 12
line 377
;368:}
;369:
;370:/*
;371:==================
;372:ClientTimerActions
;373:
;374:Actions that happen once a second
;375:==================
;376:*/
;377:void ClientTimerActions( gentity_t *ent, int msec ) {
line 383
;378:	gclient_t	*client;
;379:#ifdef MISSIONPACK
;380:	int			maxHealth;
;381:#endif
;382:
;383:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 384
;384:	client->timeResidual += msec;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
ADDRGP4 $205
JUMPV
LABELV $204
line 386
;385:
;386:	while ( client->timeResidual >= 1000 ) {
line 387
;387:		client->timeResidual -= 1000;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1000
SUBI4
ASGNI4
line 390
;388:
;389:		//release hook if over time
;390:		if(( client->grapple_release_time > 0 ) && ( client->hook )) {
ADDRLP4 0
INDIRP4
CNSTI4 856
ADDP4
INDIRU4
CNSTU4 0
EQU4 $207
ADDRLP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $207
line 391
;391:			if( level.time > client->grapple_release_time ) {
ADDRGP4 level+32
INDIRI4
CVIU4 4
ADDRLP4 0
INDIRP4
CNSTI4 856
ADDP4
INDIRU4
LEU4 $209
line 392
;392:				Weapon_HookFree(client->hook);
ADDRLP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
line 393
;393:			}
LABELV $209
line 394
;394:		}
LABELV $207
line 398
;395:
;396:		// regenerate
;397:#ifdef MISSIONPACK
;398:		if( bg_itemlist[client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 11
NEI4 $212
line 399
;399:			maxHealth = client->ps.stats[STAT_MAX_HEALTH] / 2;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 2
DIVI4
ASGNI4
line 400
;400:		}
ADDRGP4 $213
JUMPV
LABELV $212
line 401
;401:		else if ( client->ps.powerups[PW_REGEN] ) {
ADDRLP4 0
INDIRP4
CNSTI4 332
ADDP4
INDIRI4
CNSTI4 0
EQI4 $215
line 402
;402:			maxHealth = client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ASGNI4
line 403
;403:		}
ADDRGP4 $216
JUMPV
LABELV $215
line 404
;404:		else {
line 405
;405:			maxHealth = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 406
;406:		}
LABELV $216
LABELV $213
line 407
;407:		if( maxHealth ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $217
line 408
;408:			if ( ent->health < maxHealth ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
GEI4 $219
line 409
;409:				ent->health += 15;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 15
ADDI4
ASGNI4
line 410
;410:				if ( ent->health > maxHealth * 1.1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRI4
CVIF4 4
CNSTF4 1066192077
MULF4
LEF4 $221
line 411
;411:					ent->health = maxHealth * 1.1;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 4
INDIRI4
CVIF4 4
CNSTF4 1066192077
MULF4
CVFI4 4
ASGNI4
line 412
;412:				}
LABELV $221
line 413
;413:				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
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
line 414
;414:			} else if ( ent->health < maxHealth * 2) {
ADDRGP4 $218
JUMPV
LABELV $219
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 1
LSHI4
GEI4 $218
line 415
;415:				ent->health += 5;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 5
ADDI4
ASGNI4
line 416
;416:				if ( ent->health > maxHealth * 2 ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 1
LSHI4
LEI4 $225
line 417
;417:					ent->health = maxHealth * 2;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 418
;418:				}
LABELV $225
line 419
;419:				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
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
line 420
;420:			}
line 437
;421:#else
;422:		if ( client->ps.powerups[PW_REGEN] ) {
;423:			if ( ent->health < client->ps.stats[STAT_MAX_HEALTH]) {
;424:				ent->health += 15;
;425:				if ( ent->health > client->ps.stats[STAT_MAX_HEALTH] * 1.1 ) {
;426:					ent->health = client->ps.stats[STAT_MAX_HEALTH] * 1.1;
;427:				}
;428:				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
;429:			} else if ( ent->health < client->ps.stats[STAT_MAX_HEALTH] * 2) {
;430:				ent->health += 5;
;431:				if ( ent->health > client->ps.stats[STAT_MAX_HEALTH] * 2 ) {
;432:					ent->health = client->ps.stats[STAT_MAX_HEALTH] * 2;
;433:				}
;434:				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
;435:			}
;436:#endif
;437:		} else {
ADDRGP4 $218
JUMPV
LABELV $217
line 439
;438:			// count down health when over max
;439:			if ( ent->health > client->ps.stats[STAT_MAX_HEALTH] ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
LEI4 $227
line 440
;440:				ent->health--;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 441
;441:			}
LABELV $227
line 442
;442:		}
LABELV $218
line 445
;443:
;444:		// count down armor when over max
;445:		if ( client->ps.stats[STAT_ARMOR] > client->ps.stats[STAT_MAX_HEALTH] ) {
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
LEI4 $229
line 446
;446:			client->ps.stats[STAT_ARMOR]--;
ADDRLP4 24
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 447
;447:		}
LABELV $229
line 448
;448:	}
LABELV $205
line 386
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRI4
CNSTI4 1000
GEI4 $204
line 450
;449:#ifdef MISSIONPACK
;450:	if( bg_itemlist[client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_AMMOREGEN ) {
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 13
NEI4 $231
line 452
;451:		int w, max, inc, t, i;
;452:    int weapList[]={WP_MACHINEGUN,WP_SHOTGUN,WP_GRENADE_LAUNCHER,WP_ROCKET_LAUNCHER,WP_LIGHTNING,WP_RAILGUN,WP_PLASMAGUN,WP_BFG,WP_NAILGUN,WP_PROX_LAUNCHER,WP_CHAINGUN};
ADDRLP4 32
ADDRGP4 $234
INDIRB
ASGNB 44
line 453
;453:    int weapCount = ARRAY_LEN( weapList );
ADDRLP4 76
CNSTI4 11
ASGNI4
line 455
;454:		//
;455:    for (i = 0; i < weapCount; i++) {
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 $238
JUMPV
LABELV $235
line 456
;456:		  w = weapList[i];
ADDRLP4 12
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ASGNI4
line 458
;457:
;458:		  switch(w) {
ADDRLP4 12
INDIRI4
CNSTI4 2
LTI4 $239
ADDRLP4 12
INDIRI4
CNSTI4 13
GTI4 $239
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $252-8
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $252
address $241
address $242
address $243
address $244
address $245
address $246
address $247
address $248
address $239
address $249
address $250
address $251
code
LABELV $241
line 459
;459:			  case WP_MACHINEGUN: max = 50; inc = 4; t = 1000; break;
ADDRLP4 24
CNSTI4 50
ASGNI4
ADDRLP4 28
CNSTI4 4
ASGNI4
ADDRLP4 16
CNSTI4 1000
ASGNI4
ADDRGP4 $240
JUMPV
LABELV $242
line 460
;460:			  case WP_SHOTGUN: max = 10; inc = 1; t = 1500; break;
ADDRLP4 24
CNSTI4 10
ASGNI4
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRLP4 16
CNSTI4 1500
ASGNI4
ADDRGP4 $240
JUMPV
LABELV $243
line 461
;461:			  case WP_GRENADE_LAUNCHER: max = 10; inc = 1; t = 2000; break;
ADDRLP4 24
CNSTI4 10
ASGNI4
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRLP4 16
CNSTI4 2000
ASGNI4
ADDRGP4 $240
JUMPV
LABELV $244
line 462
;462:			  case WP_ROCKET_LAUNCHER: max = 10; inc = 1; t = 1750; break;
ADDRLP4 24
CNSTI4 10
ASGNI4
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRLP4 16
CNSTI4 1750
ASGNI4
ADDRGP4 $240
JUMPV
LABELV $245
line 463
;463:			  case WP_LIGHTNING: max = 50; inc = 5; t = 1500; break;
ADDRLP4 24
CNSTI4 50
ASGNI4
ADDRLP4 28
CNSTI4 5
ASGNI4
ADDRLP4 16
CNSTI4 1500
ASGNI4
ADDRGP4 $240
JUMPV
LABELV $246
line 464
;464:			  case WP_RAILGUN: max = 10; inc = 1; t = 1750; break;
ADDRLP4 24
CNSTI4 10
ASGNI4
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRLP4 16
CNSTI4 1750
ASGNI4
ADDRGP4 $240
JUMPV
LABELV $247
line 465
;465:			  case WP_PLASMAGUN: max = 50; inc = 5; t = 1500; break;
ADDRLP4 24
CNSTI4 50
ASGNI4
ADDRLP4 28
CNSTI4 5
ASGNI4
ADDRLP4 16
CNSTI4 1500
ASGNI4
ADDRGP4 $240
JUMPV
LABELV $248
line 466
;466:			  case WP_BFG: max = 10; inc = 1; t = 4000; break;
ADDRLP4 24
CNSTI4 10
ASGNI4
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRLP4 16
CNSTI4 4000
ASGNI4
ADDRGP4 $240
JUMPV
LABELV $249
line 467
;467:			  case WP_NAILGUN: max = 10; inc = 1; t = 1250; break;
ADDRLP4 24
CNSTI4 10
ASGNI4
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRLP4 16
CNSTI4 1250
ASGNI4
ADDRGP4 $240
JUMPV
LABELV $250
line 468
;468:			  case WP_PROX_LAUNCHER: max = 5; inc = 1; t = 2000; break;
ADDRLP4 24
CNSTI4 5
ASGNI4
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRLP4 16
CNSTI4 2000
ASGNI4
ADDRGP4 $240
JUMPV
LABELV $251
line 469
;469:			  case WP_CHAINGUN: max = 100; inc = 5; t = 1000; break;
ADDRLP4 24
CNSTI4 100
ASGNI4
ADDRLP4 28
CNSTI4 5
ASGNI4
ADDRLP4 16
CNSTI4 1000
ASGNI4
ADDRGP4 $240
JUMPV
LABELV $239
line 470
;470:			  default: max = 0; inc = 0; t = 1000; break;
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 16
CNSTI4 1000
ASGNI4
LABELV $240
line 472
;471:		  }
;472:		  client->ammoTimes[w] += msec;
ADDRLP4 84
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 788
ADDP4
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
line 473
;473:		  if ( client->ps.ammo[w] >= max ) {
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
LTI4 $254
line 474
;474:			  client->ammoTimes[w] = 0;
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 788
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 475
;475:		  }
LABELV $254
line 476
;476:		  if ( client->ammoTimes[w] >= t ) {
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 788
ADDP4
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $256
ADDRGP4 $259
JUMPV
LABELV $258
line 478
;477:			  while ( client->ammoTimes[w] >= t )
;478:				  client->ammoTimes[w] -= t;
ADDRLP4 88
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 788
ADDP4
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
ADDRLP4 16
INDIRI4
SUBI4
ASGNI4
LABELV $259
line 477
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 788
ADDP4
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
GEI4 $258
line 479
;479:			  client->ps.ammo[w] += inc;
ADDRLP4 92
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 376
ADDP4
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
ADDRLP4 28
INDIRI4
ADDI4
ASGNI4
line 480
;480:			  if ( client->ps.ammo[w] > max ) {
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $261
line 481
;481:				  client->ps.ammo[w] = max;
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 376
ADDP4
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 482
;482:			  }
LABELV $261
line 483
;483:		  }
LABELV $256
line 484
;484:    }
LABELV $236
line 455
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $238
ADDRLP4 20
INDIRI4
ADDRLP4 76
INDIRI4
LTI4 $235
line 485
;485:	}
LABELV $231
line 487
;486:#endif
;487:}
LABELV $203
endproc ClientTimerActions 96 12
export ClientIntermissionThink
proc ClientIntermissionThink 20 0
line 494
;488:
;489:/*
;490:====================
;491:ClientIntermissionThink
;492:====================
;493:*/
;494:void ClientIntermissionThink( gclient_t *client ) {
line 495
;495:	client->ps.eFlags &= ~EF_TALK;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -4097
BANDI4
ASGNI4
line 496
;496:	client->ps.eFlags &= ~EF_FIRING;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 501
;497:
;498:	// the level will exit when everyone wants to or after timeouts
;499:
;500:	// swap and latch button actions
;501:	client->oldbuttons = client->buttons;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 668
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 664
ADDP4
INDIRI4
ASGNI4
line 502
;502:	client->buttons = client->pers.cmd.buttons;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 664
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 488
ADDP4
INDIRI4
ASGNI4
line 503
;503:	if ( client->buttons & ( BUTTON_ATTACK | BUTTON_USE_HOLDABLE ) & ( client->oldbuttons ^ client->buttons ) ) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 664
ADDP4
INDIRI4
CNSTI4 5
BANDI4
ADDRLP4 16
INDIRP4
CNSTI4 668
ADDP4
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 664
ADDP4
INDIRI4
BXORI4
BANDI4
CNSTI4 0
EQI4 $264
line 505
;504:		// this used to be an ^1 but once a player says ready, it should stick
;505:		client->readyToExit = 1;
ADDRFP4 0
INDIRP4
CNSTI4 652
ADDP4
CNSTI4 1
ASGNI4
line 506
;506:	}
LABELV $264
line 507
;507:}
LABELV $263
endproc ClientIntermissionThink 20 0
export ClientEvents
proc ClientEvents 68 32
line 518
;508:
;509:
;510:/*
;511:================
;512:ClientEvents
;513:
;514:Events will be passed on to the clients for presentation,
;515:but any server game effects are handled here
;516:================
;517:*/
;518:void ClientEvents( gentity_t *ent, int oldEventSequence ) {
line 528
;519:	int		i, j;
;520:	int		event;
;521:	gclient_t *client;
;522:	int		damage;
;523:	vec3_t	origin, angles;
;524://	qboolean	fired;
;525:	gitem_t *item;
;526:	gentity_t *drop;
;527:
;528:	client = ent->client;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 530
;529:
;530:	if ( oldEventSequence < client->ps.eventSequence - MAX_PS_EVENTS ) {
ADDRFP4 4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 2
SUBI4
GEI4 $267
line 531
;531:		oldEventSequence = client->ps.eventSequence - MAX_PS_EVENTS;
ADDRFP4 4
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 532
;532:	}
LABELV $267
line 533
;533:	for ( i = oldEventSequence ; i < client->ps.eventSequence ; i++ ) {
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRGP4 $272
JUMPV
LABELV $269
line 534
;534:		event = client->ps.events[ i & (MAX_PS_EVENTS-1) ];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ASGNI4
line 536
;535:
;536:		switch ( event ) {
ADDRLP4 4
INDIRI4
CNSTI4 11
EQI4 $275
ADDRLP4 4
INDIRI4
CNSTI4 12
EQI4 $275
ADDRLP4 4
INDIRI4
CNSTI4 11
LTI4 $274
LABELV $321
ADDRLP4 4
INDIRI4
CNSTI4 23
LTI4 $274
ADDRLP4 4
INDIRI4
CNSTI4 29
GTI4 $274
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $322-92
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $322
address $284
address $274
address $285
address $314
address $315
address $316
address $319
code
LABELV $275
line 539
;537:		case EV_FALL_MEDIUM:
;538:		case EV_FALL_FAR:
;539:			if ( ent->s.eType != ET_PLAYER ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
EQI4 $276
line 540
;540:				break;		// not in the player model
ADDRGP4 $274
JUMPV
LABELV $276
line 542
;541:			}
;542:			if ( g_dmflags.integer & DF_NO_FALLING ) {
ADDRGP4 g_dmflags+12
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $278
line 543
;543:				break;
ADDRGP4 $274
JUMPV
LABELV $278
line 545
;544:			}
;545:			if ( event == EV_FALL_FAR ) {
ADDRLP4 4
INDIRI4
CNSTI4 12
NEI4 $281
line 546
;546:				damage = 10;
ADDRLP4 24
CNSTI4 10
ASGNI4
line 547
;547:			} else {
ADDRGP4 $282
JUMPV
LABELV $281
line 548
;548:				damage = 5;
ADDRLP4 24
CNSTI4 5
ASGNI4
line 549
;549:			}
LABELV $282
line 550
;550:			ent->pain_debounce_time = level.time + 200;	// no normal pain sound
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 551
;551:			G_Damage (ent, NULL, NULL, NULL, NULL, damage, 0, MOD_FALLING);
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 19
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 552
;552:			break;
ADDRGP4 $274
JUMPV
LABELV $284
line 555
;553:
;554:		case EV_FIRE_WEAPON:
;555:			FireWeapon( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 FireWeapon
CALLV
pop
line 556
;556:			break;
ADDRGP4 $274
JUMPV
LABELV $285
line 560
;557:
;558:		case EV_USE_ITEM1:		// teleporter
;559:			// drop flags in CTF
;560:			item = NULL;
ADDRLP4 20
CNSTP4 0
ASGNP4
line 561
;561:			j = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 563
;562:
;563:			if ( ent->client->ps.powerups[ PW_REDFLAG ] ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $286
line 564
;564:				item = BG_FindItemForPowerup( PW_REDFLAG );
CNSTI4 7
ARGI4
ADDRLP4 60
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 60
INDIRP4
ASGNP4
line 565
;565:				j = PW_REDFLAG;
ADDRLP4 12
CNSTI4 7
ASGNI4
line 566
;566:			} else if ( ent->client->ps.powerups[ PW_BLUEFLAG ] ) {
ADDRGP4 $287
JUMPV
LABELV $286
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $288
line 567
;567:				item = BG_FindItemForPowerup( PW_BLUEFLAG );
CNSTI4 8
ARGI4
ADDRLP4 60
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 60
INDIRP4
ASGNP4
line 568
;568:				j = PW_BLUEFLAG;
ADDRLP4 12
CNSTI4 8
ASGNI4
line 569
;569:			} else if ( ent->client->ps.powerups[ PW_NEUTRALFLAG ] ) {
ADDRGP4 $289
JUMPV
LABELV $288
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $290
line 570
;570:				item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
CNSTI4 9
ARGI4
ADDRLP4 60
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 60
INDIRP4
ASGNP4
line 571
;571:				j = PW_NEUTRALFLAG;
ADDRLP4 12
CNSTI4 9
ASGNI4
line 572
;572:			}
LABELV $290
LABELV $289
LABELV $287
line 574
;573:
;574:			if ( item ) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $292
line 575
;575:				drop = Drop_Item( ent, item, 0 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 60
ADDRGP4 Drop_Item
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 60
INDIRP4
ASGNP4
line 577
;576:				// decide how many seconds it has left
;577:				drop->count = ( ent->client->ps.powerups[ j ] - level.time ) / 1000;
ADDRLP4 16
INDIRP4
CNSTI4 760
ADDP4
ADDRLP4 12
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
ADDRGP4 level+32
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 578
;578:				if ( drop->count < 1 ) {
ADDRLP4 16
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 1
GEI4 $295
line 579
;579:					drop->count = 1;
ADDRLP4 16
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 1
ASGNI4
line 580
;580:				}
LABELV $295
line 582
;581:				// for pickup prediction
;582:				drop->s.time2 = drop->count;
ADDRLP4 16
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ASGNI4
line 584
;583:
;584:				ent->client->ps.powerups[ j ] = 0;
ADDRLP4 12
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
CNSTI4 0
ASGNI4
line 585
;585:			}
LABELV $292
line 588
;586:
;587:#ifdef MISSIONPACK
;588:			if ( g_gametype.integer == GT_HARVESTER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
NEI4 $297
line 589
;589:				if ( ent->client->ps.generic1 > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
CNSTI4 0
LEI4 $300
line 590
;590:					if ( ent->client->sess.sessionTeam == TEAM_RED ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 1
NEI4 $302
line 591
;591:						item = BG_FindItem( "Blue Cube" );
ADDRGP4 $304
ARGP4
ADDRLP4 60
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 60
INDIRP4
ASGNP4
line 592
;592:					} else {
ADDRGP4 $303
JUMPV
LABELV $302
line 593
;593:						item = BG_FindItem( "Red Cube" );
ADDRGP4 $305
ARGP4
ADDRLP4 60
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 60
INDIRP4
ASGNP4
line 594
;594:					}
LABELV $303
line 595
;595:					if ( item ) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $306
line 596
;596:						for ( j = 0; j < ent->client->ps.generic1; j++ ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $311
JUMPV
LABELV $308
line 597
;597:							drop = Drop_Item( ent, item, 0 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 60
ADDRGP4 Drop_Item
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 60
INDIRP4
ASGNP4
line 598
;598:							if ( ent->client->sess.sessionTeam == TEAM_RED ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 1
NEI4 $312
line 599
;599:								drop->spawnflags = TEAM_BLUE;
ADDRLP4 16
INDIRP4
CNSTI4 528
ADDP4
CNSTI4 2
ASGNI4
line 600
;600:							} else {
ADDRGP4 $313
JUMPV
LABELV $312
line 601
;601:								drop->spawnflags = TEAM_RED;
ADDRLP4 16
INDIRP4
CNSTI4 528
ADDP4
CNSTI4 1
ASGNI4
line 602
;602:							}
LABELV $313
line 603
;603:						}
LABELV $309
line 596
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $311
ADDRLP4 12
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
LTI4 $308
line 604
;604:					}
LABELV $306
line 605
;605:					ent->client->ps.generic1 = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 440
ADDP4
CNSTI4 0
ASGNI4
line 606
;606:				}
LABELV $300
line 607
;607:			}
LABELV $297
line 609
;608:#endif
;609:			SelectSpawnPoint( ent, ent->client->ps.origin, origin, angles );
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 40
ARGP4
ADDRGP4 SelectSpawnPoint
CALLP4
pop
line 610
;610:			TeleportPlayer( ent, origin, angles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 40
ARGP4
ADDRGP4 TeleportPlayer
CALLV
pop
line 611
;611:			break;
ADDRGP4 $274
JUMPV
LABELV $314
line 614
;612:
;613:		case EV_USE_ITEM2:		// medkit
;614:			ent->health = ent->client->ps.stats[STAT_MAX_HEALTH] + 25;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 25
ADDI4
ASGNI4
line 616
;615:
;616:			break;
ADDRGP4 $274
JUMPV
LABELV $315
line 621
;617:
;618:#ifdef MISSIONPACK
;619:		case EV_USE_ITEM3:		// kamikaze
;620:			// make sure the invulnerability is off
;621:			ent->client->invulnerabilityTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 848
ADDP4
CNSTI4 0
ASGNI4
line 623
;622:			// start the kamikze
;623:			G_StartKamikaze( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_StartKamikaze
CALLV
pop
line 624
;624:			break;
ADDRGP4 $274
JUMPV
LABELV $316
line 627
;625:
;626:		case EV_USE_ITEM4:		// portal
;627:			if( ent->client->portalID ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 784
ADDP4
INDIRI4
CNSTI4 0
EQI4 $317
line 628
;628:				DropPortalSource( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 DropPortalSource
CALLV
pop
line 629
;629:			}
ADDRGP4 $274
JUMPV
LABELV $317
line 630
;630:			else {
line 631
;631:				DropPortalDestination( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 DropPortalDestination
CALLV
pop
line 632
;632:			}
line 633
;633:			break;
ADDRGP4 $274
JUMPV
LABELV $319
line 635
;634:		case EV_USE_ITEM5:		// invulnerability
;635:			ent->client->invulnerabilityTime = level.time + 10000;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 848
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
ADDI4
ASGNI4
line 636
;636:			break;
line 640
;637:#endif
;638:
;639:		default:
;640:			break;
LABELV $274
line 642
;641:		}
;642:	}
LABELV $270
line 533
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $272
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
LTI4 $269
line 644
;643:
;644:}
LABELV $266
endproc ClientEvents 68 32
proc StuckInOtherClient 8 0
line 652
;645:
;646:#ifdef MISSIONPACK
;647:/*
;648:==============
;649:StuckInOtherClient
;650:==============
;651:*/
;652:static int StuckInOtherClient(gentity_t *ent) {
line 656
;653:	int i;
;654:	gentity_t	*ent2;
;655:
;656:	ent2 = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 657
;657:	for ( i = 0; i < MAX_CLIENTS; i++, ent2++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $325
line 658
;658:		if ( ent2 == ent ) {
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $329
line 659
;659:			continue;
ADDRGP4 $326
JUMPV
LABELV $329
line 661
;660:		}
;661:		if ( !ent2->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $331
line 662
;662:			continue;
ADDRGP4 $326
JUMPV
LABELV $331
line 664
;663:		}
;664:		if ( !ent2->client ) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $333
line 665
;665:			continue;
ADDRGP4 $326
JUMPV
LABELV $333
line 667
;666:		}
;667:		if ( ent2->health <= 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
GTI4 $335
line 668
;668:			continue;
ADDRGP4 $326
JUMPV
LABELV $335
line 671
;669:		}
;670:		//
;671:		if (ent2->r.absmin[0] > ent->r.absmax[0])
ADDRLP4 0
INDIRP4
CNSTI4 464
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
LEF4 $337
line 672
;672:			continue;
ADDRGP4 $326
JUMPV
LABELV $337
line 673
;673:		if (ent2->r.absmin[1] > ent->r.absmax[1])
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
LEF4 $339
line 674
;674:			continue;
ADDRGP4 $326
JUMPV
LABELV $339
line 675
;675:		if (ent2->r.absmin[2] > ent->r.absmax[2])
ADDRLP4 0
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
LEF4 $341
line 676
;676:			continue;
ADDRGP4 $326
JUMPV
LABELV $341
line 677
;677:		if (ent2->r.absmax[0] < ent->r.absmin[0])
ADDRLP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
INDIRF4
GEF4 $343
line 678
;678:			continue;
ADDRGP4 $326
JUMPV
LABELV $343
line 679
;679:		if (ent2->r.absmax[1] < ent->r.absmin[1])
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
GEF4 $345
line 680
;680:			continue;
ADDRGP4 $326
JUMPV
LABELV $345
line 681
;681:		if (ent2->r.absmax[2] < ent->r.absmin[2])
ADDRLP4 0
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
GEF4 $347
line 682
;682:			continue;
ADDRGP4 $326
JUMPV
LABELV $347
line 683
;683:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $324
JUMPV
LABELV $326
line 657
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 824
ADDP4
ASGNP4
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $325
line 685
;684:	}
;685:	return qfalse;
CNSTI4 0
RETI4
LABELV $324
endproc StuckInOtherClient 8 0
export SendPendingPredictableEvents
proc SendPendingPredictableEvents 40 12
line 696
;686:}
;687:#endif
;688:
;689:void BotTestSolid(vec3_t origin);
;690:
;691:/*
;692:==============
;693:SendPendingPredictableEvents
;694:==============
;695:*/
;696:void SendPendingPredictableEvents( playerState_t *ps ) {
line 702
;697:	gentity_t *t;
;698:	int event, seq;
;699:	int extEvent, number;
;700:
;701:	// if there are still events pending
;702:	if ( ps->entityEventSequence < ps->eventSequence ) {
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 464
ADDP4
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
GEI4 $350
line 705
;703:		// create a temporary entity for this event which is sent to everyone
;704:		// except the client who generated the event
;705:		seq = ps->entityEventSequence & (MAX_PS_EVENTS-1);
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ASGNI4
line 706
;706:		event = ps->events[ seq ] | ( ( ps->entityEventSequence & 3 ) << 8 );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 464
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 8
LSHI4
BORI4
ASGNI4
line 708
;707:		// set external event to zero before calling BG_PlayerStateToEntityState
;708:		extEvent = ps->externalEvent;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
ASGNI4
line 709
;709:		ps->externalEvent = 0;
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
CNSTI4 0
ASGNI4
line 711
;710:		// create temporary entity for event
;711:		t = G_TempEntity( ps->origin, event );
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 712
;712:		number = t->s.number;
ADDRLP4 16
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 713
;713:		BG_PlayerStateToEntityState( ps, &t->s, qtrue );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 714
;714:		t->s.number = number;
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ASGNI4
line 715
;715:		t->s.eType = ET_EVENTS + event;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 13
ADDI4
ASGNI4
line 716
;716:		t->s.eFlags |= EF_PLAYER_EVENT;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 717
;717:		t->s.otherEntityNum = ps->clientNum;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 719
;718:		// send to everyone except the client who generated the event
;719:		t->r.svFlags |= SVF_NOTSINGLECLIENT;
ADDRLP4 36
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 720
;720:		t->r.singleClient = ps->clientNum;
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 722
;721:		// set back external event
;722:		ps->externalEvent = extEvent;
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 723
;723:	}
LABELV $350
line 724
;724:}
LABELV $349
endproc SendPendingPredictableEvents 40 12
data
align 4
LABELV $418
byte 4 3257401344
byte 4 3257401344
byte 4 3257401344
align 4
LABELV $419
byte 4 1109917696
byte 4 1109917696
byte 4 1109917696
export ClientThink_real
code
proc ClientThink_real 320 12
line 737
;725:
;726:/*
;727:==============
;728:ClientThink
;729:
;730:This will be called once for each client frame, which will
;731:usually be a couple times for each server frame on fast clients.
;732:
;733:If "g_synchronousClients 1" is set, this will be called exactly
;734:once for each server frame, which makes for smooth demo recording.
;735:==============
;736:*/
;737:void ClientThink_real( gentity_t *ent ) {
line 744
;738:	gclient_t	*client;
;739:	pmove_t		pm;
;740:	int			oldEventSequence;
;741:	int			msec;
;742:	usercmd_t	*ucmd;
;743:
;744:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 747
;745:
;746:	// don't think if the client is not yet connected (and thus not yet spawned in)
;747:	if (client->pers.connected != CON_CONNECTED) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $353
line 748
;748:		return;
ADDRGP4 $352
JUMPV
LABELV $353
line 751
;749:	}
;750:	// mark the time, so the connection sprite can be removed
;751:	ucmd = &ent->client->pers.cmd;
ADDRLP4 232
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ASGNP4
line 754
;752:
;753:	// sanity check the command time to prevent speedup cheating
;754:	if ( ucmd->serverTime > level.time + 200 ) {
ADDRLP4 232
INDIRP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
LEI4 $355
line 755
;755:		ucmd->serverTime = level.time + 200;
ADDRLP4 232
INDIRP4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 757
;756://		G_Printf("serverTime <<<<<\n" );
;757:	} else
ADDRGP4 $356
JUMPV
LABELV $355
line 758
;758:	if ( ucmd->serverTime < level.time - 1000 ) {
ADDRLP4 232
INDIRP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
SUBI4
GEI4 $359
line 759
;759:		ucmd->serverTime = level.time - 1000;
ADDRLP4 232
INDIRP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
SUBI4
ASGNI4
line 761
;760://		G_Printf("serverTime >>>>>\n" );
;761:	}
LABELV $359
LABELV $356
line 764
;762:
;763:	// unlagged
;764:	client->frameOffset = trap_Milliseconds() - level.frameStartTime;
ADDRLP4 244
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 1624
ADDP4
ADDRLP4 244
INDIRI4
ADDRGP4 level+11804
INDIRI4
SUBI4
ASGNI4
line 765
;765:	client->lastCmdTime = ucmd->serverTime;
ADDRLP4 0
INDIRP4
CNSTI4 660
ADDP4
ADDRLP4 232
INDIRP4
INDIRI4
ASGNI4
line 766
;766:	client->lastUpdateFrame = level.framenum;
ADDRLP4 0
INDIRP4
CNSTI4 1628
ADDP4
ADDRGP4 level+28
INDIRI4
ASGNI4
line 768
;767:
;768:	msec = ucmd->serverTime - client->ps.commandTime;
ADDRLP4 236
ADDRLP4 232
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
SUBI4
ASGNI4
line 771
;769:	// following others may result in bad times, but we still want
;770:	// to check for follow toggles
;771:	if ( msec < 1 && client->sess.spectatorState != SPECTATOR_FOLLOW ) {
ADDRLP4 236
INDIRI4
CNSTI4 1
GEI4 $365
ADDRLP4 0
INDIRP4
CNSTI4 632
ADDP4
INDIRI4
CNSTI4 2
EQI4 $365
line 772
;772:		return;
ADDRGP4 $352
JUMPV
LABELV $365
line 774
;773:	}
;774:	if ( msec > 200 ) {
ADDRLP4 236
INDIRI4
CNSTI4 200
LEI4 $367
line 775
;775:		msec = 200;
ADDRLP4 236
CNSTI4 200
ASGNI4
line 776
;776:	}
LABELV $367
line 778
;777:
;778:	if ( pmove_msec.integer < 8 ) {
ADDRGP4 pmove_msec+12
INDIRI4
CNSTI4 8
GEI4 $369
line 779
;779:		trap_Cvar_Set( "pmove_msec", "8" );
ADDRGP4 $372
ARGP4
ADDRGP4 $373
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 780
;780:		trap_Cvar_Update( &pmove_msec );
ADDRGP4 pmove_msec
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 781
;781:	} else if ( pmove_msec.integer > 33 ) {
ADDRGP4 $370
JUMPV
LABELV $369
ADDRGP4 pmove_msec+12
INDIRI4
CNSTI4 33
LEI4 $374
line 782
;782:		trap_Cvar_Set( "pmove_msec", "33" );
ADDRGP4 $372
ARGP4
ADDRGP4 $377
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 783
;783:		trap_Cvar_Update( &pmove_msec );
ADDRGP4 pmove_msec
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 784
;784:	}
LABELV $374
LABELV $370
line 786
;785:
;786:	if ( pmove_fixed.integer ) {
ADDRGP4 pmove_fixed+12
INDIRI4
CNSTI4 0
EQI4 $378
line 787
;787:		ucmd->serverTime = ((ucmd->serverTime + pmove_msec.integer-1) / pmove_msec.integer) * pmove_msec.integer;
ADDRLP4 232
INDIRP4
ADDRLP4 232
INDIRP4
INDIRI4
ADDRGP4 pmove_msec+12
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ADDRGP4 pmove_msec+12
INDIRI4
DIVI4
ADDRGP4 pmove_msec+12
INDIRI4
MULI4
ASGNI4
line 790
;788:		//if (ucmd->serverTime - client->ps.commandTime <= 0)
;789:		//	return;
;790:	}
LABELV $378
line 795
;791:
;792:	//
;793:	// check for exiting intermission
;794:	//
;795:	if ( level.intermissiontime ) {
ADDRGP4 level+7604
INDIRI4
CNSTI4 0
EQI4 $384
line 796
;796:		ClientIntermissionThink( client );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ClientIntermissionThink
CALLV
pop
line 797
;797:		return;
ADDRGP4 $352
JUMPV
LABELV $384
line 801
;798:	}
;799:
;800:	// spectators don't do much
;801:	if ( client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
NEI4 $387
line 802
;802:		if ( client->sess.spectatorState == SPECTATOR_SCOREBOARD ) {
ADDRLP4 0
INDIRP4
CNSTI4 632
ADDP4
INDIRI4
CNSTI4 3
NEI4 $389
line 803
;803:			return;
ADDRGP4 $352
JUMPV
LABELV $389
line 805
;804:		}
;805:		SpectatorThink( ent, ucmd );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 232
INDIRP4
ARGP4
ADDRGP4 SpectatorThink
CALLV
pop
line 806
;806:		return;
ADDRGP4 $352
JUMPV
LABELV $387
line 810
;807:	}
;808:
;809:	// check for inactivity timer, but never drop the local client of a non-dedicated server
;810:	if ( !ClientInactivityTimer( client ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 248
ADDRGP4 ClientInactivityTimer
CALLI4
ASGNI4
ADDRLP4 248
INDIRI4
CNSTI4 0
NEI4 $391
line 811
;811:		return;
ADDRGP4 $352
JUMPV
LABELV $391
line 815
;812:	}
;813:
;814:	// clear the rewards if time
;815:	if ( level.time > client->rewardTime ) {
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 752
ADDP4
INDIRI4
LEI4 $393
line 816
;816:		client->ps.eFlags &= ~EF_AWARDS;
ADDRLP4 252
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 252
INDIRP4
ADDRLP4 252
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 817
;817:	}
LABELV $393
line 819
;818:
;819:	if ( client->noclip ) {
ADDRLP4 0
INDIRP4
CNSTI4 656
ADDP4
INDIRI4
CNSTI4 0
EQI4 $396
line 820
;820:		client->ps.pm_type = PM_NOCLIP;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 1
ASGNI4
line 821
;821:	} else if ( client->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 $397
JUMPV
LABELV $396
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $398
line 822
;822:		client->ps.pm_type = PM_DEAD;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 823
;823:	} else {
ADDRGP4 $399
JUMPV
LABELV $398
line 824
;824:		client->ps.pm_type = PM_NORMAL;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 825
;825:	}
LABELV $399
LABELV $397
line 827
;826:
;827:	client->ps.gravity = g_gravity.value;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDRGP4 g_gravity+8
INDIRF4
CVFI4 4
ASGNI4
line 830
;828:
;829:	// set speed
;830:	client->ps.speed = g_speed.value;
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ADDRGP4 g_speed+8
INDIRF4
CVFI4 4
ASGNI4
line 833
;831:
;832:#ifdef MISSIONPACK
;833:	if( bg_itemlist[client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_SCOUT ) {
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 10
NEI4 $402
line 834
;834:		client->ps.speed *= 1.5;
ADDRLP4 252
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
ADDRLP4 252
INDIRP4
ADDRLP4 252
INDIRP4
INDIRI4
CVIF4 4
CNSTF4 1069547520
MULF4
CVFI4 4
ASGNI4
line 835
;835:	}
ADDRGP4 $403
JUMPV
LABELV $402
line 838
;836:	else
;837:#endif
;838:	if ( client->ps.powerups[PW_HASTE] ) {
ADDRLP4 0
INDIRP4
CNSTI4 324
ADDP4
INDIRI4
CNSTI4 0
EQI4 $405
line 839
;839:		client->ps.speed *= 1.3;
ADDRLP4 252
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
ADDRLP4 252
INDIRP4
ADDRLP4 252
INDIRP4
INDIRI4
CVIF4 4
CNSTF4 1067869798
MULF4
CVFI4 4
ASGNI4
line 840
;840:	}
LABELV $405
LABELV $403
line 843
;841:
;842:	// Let go of the hook if we aren't firing
;843:	if ( client->ps.weapon == WP_GRAPPLING_HOOK &&
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 10
NEI4 $407
ADDRLP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $407
ADDRLP4 232
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $407
line 844
;844:		client->hook && !( ucmd->buttons & BUTTON_ATTACK ) ) {
line 845
;845:		Weapon_HookFree(client->hook);
ADDRLP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
line 846
;846:	}
LABELV $407
line 848
;847:
;848:	Hook_Fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Hook_Fire
CALLV
pop
line 851
;849:
;850:	// set up for pmove
;851:	oldEventSequence = client->ps.eventSequence;
ADDRLP4 240
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ASGNI4
line 853
;852:
;853:	memset (&pm, 0, sizeof(pm));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 228
ARGU4
ADDRGP4 memset
CALLP4
pop
line 857
;854:
;855:	// check for the hit-scan gauntlet, don't let the action
;856:	// go through as an attack unless it actually hits something
;857:	if ( client->ps.weapon == WP_GAUNTLET && !( ucmd->buttons & BUTTON_TALK ) &&
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $409
ADDRLP4 232
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $409
ADDRLP4 232
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $409
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
GTI4 $409
line 858
;858:		( ucmd->buttons & BUTTON_ATTACK ) && client->ps.weaponTime <= 0 ) {
line 859
;859:		pm.gauntletHit = CheckGauntletAttack( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 CheckGauntletAttack
CALLI4
ASGNI4
ADDRLP4 4+36
ADDRLP4 264
INDIRI4
ASGNI4
line 860
;860:	}
LABELV $409
line 862
;861:
;862:	if ( ent->flags & FL_FORCE_GESTURE ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $412
line 863
;863:		ent->flags &= ~FL_FORCE_GESTURE;
ADDRLP4 264
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 264
INDIRP4
ADDRLP4 264
INDIRP4
INDIRI4
CNSTI4 -32769
BANDI4
ASGNI4
line 864
;864:		ent->client->pers.cmd.buttons |= BUTTON_GESTURE;
ADDRLP4 268
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 488
ADDP4
ASGNP4
ADDRLP4 268
INDIRP4
ADDRLP4 268
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 865
;865:	}
LABELV $412
line 869
;866:
;867:#ifdef MISSIONPACK
;868:	// check for invulnerability expansion before doing the Pmove
;869:	if (client->ps.powerups[PW_INVULNERABILITY] ) {
ADDRLP4 0
INDIRP4
CNSTI4 368
ADDP4
INDIRI4
CNSTI4 0
EQI4 $414
line 870
;870:		if ( !(client->ps.pm_flags & PMF_INVULEXPAND) ) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
NEI4 $416
line 871
;871:			vec3_t mins = { -42, -42, -42 };
ADDRLP4 264
ADDRGP4 $418
INDIRB
ASGNB 12
line 872
;872:			vec3_t maxs = { 42, 42, 42 };
ADDRLP4 276
ADDRGP4 $419
INDIRB
ASGNB 12
line 875
;873:			vec3_t oldmins, oldmaxs;
;874:
;875:			VectorCopy (ent->r.mins, oldmins);
ADDRLP4 288
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRB
ASGNB 12
line 876
;876:			VectorCopy (ent->r.maxs, oldmaxs);
ADDRLP4 300
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRB
ASGNB 12
line 878
;877:			// expand
;878:			VectorCopy (mins, ent->r.mins);
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 264
INDIRB
ASGNB 12
line 879
;879:			VectorCopy (maxs, ent->r.maxs);
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDRLP4 276
INDIRB
ASGNB 12
line 880
;880:			trap_LinkEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 882
;881:			// check if this would get anyone stuck in this player
;882:			if ( !StuckInOtherClient(ent) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 312
ADDRGP4 StuckInOtherClient
CALLI4
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 0
NEI4 $420
line 884
;883:				// set flag so the expanded size will be set in PM_CheckDuck
;884:				client->ps.pm_flags |= PMF_INVULEXPAND;
ADDRLP4 316
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 316
INDIRP4
ADDRLP4 316
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 885
;885:			}
LABELV $420
line 887
;886:			// set back
;887:			VectorCopy (oldmins, ent->r.mins);
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 288
INDIRB
ASGNB 12
line 888
;888:			VectorCopy (oldmaxs, ent->r.maxs);
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDRLP4 300
INDIRB
ASGNB 12
line 889
;889:			trap_LinkEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 890
;890:		}
LABELV $416
line 891
;891:	}
LABELV $414
line 894
;892:#endif
;893:
;894:	pm.ps = &client->ps;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 895
;895:	pm.cmd = *ucmd;
ADDRLP4 4+4
ADDRLP4 232
INDIRP4
INDIRB
ASGNB 24
line 896
;896:	if ( pm.ps->pm_type == PM_DEAD ) {
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $423
line 897
;897:		pm.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;
ADDRLP4 4+28
CNSTI4 65537
ASGNI4
line 898
;898:	}
ADDRGP4 $424
JUMPV
LABELV $423
line 899
;899:	else if ( ent->r.svFlags & SVF_BOT ) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $426
line 900
;900:		pm.tracemask = MASK_PLAYERSOLID | CONTENTS_BOTCLIP;
ADDRLP4 4+28
CNSTI4 37814273
ASGNI4
line 901
;901:	}
ADDRGP4 $427
JUMPV
LABELV $426
line 902
;902:	else {
line 903
;903:		pm.tracemask = MASK_PLAYERSOLID;
ADDRLP4 4+28
CNSTI4 33619969
ASGNI4
line 904
;904:	}
LABELV $427
LABELV $424
line 905
;905:	pm.trace = trap_Trace;
ADDRLP4 4+220
ADDRGP4 trap_Trace
ASGNP4
line 906
;906:	pm.pointcontents = trap_PointContents;
ADDRLP4 4+224
ADDRGP4 trap_PointContents
ASGNP4
line 907
;907:	pm.debugLevel = g_debugMove.integer;
ADDRLP4 4+32
ADDRGP4 g_debugMove+12
INDIRI4
ASGNI4
line 909
;908:
;909:	pm.pmove_fixed = pmove_fixed.integer;
ADDRLP4 4+208
ADDRGP4 pmove_fixed+12
INDIRI4
ASGNI4
line 910
;910:	pm.pmove_msec = pmove_msec.integer;
ADDRLP4 4+212
ADDRGP4 pmove_msec+12
INDIRI4
ASGNI4
line 911
;911:	pm.grapplePull = g_grapplePull.integer;
ADDRLP4 4+216
ADDRGP4 g_grapplePull+12
INDIRI4
ASGNI4
line 913
;912:
;913:	VectorCopy( client->ps.origin, client->oldOrigin );
ADDRLP4 0
INDIRP4
CNSTI4 676
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 916
;914:
;915:#ifdef MISSIONPACK
;916:		if (level.intermissionQueued != 0 && g_singlePlayer.integer) {
ADDRGP4 level+7600
INDIRI4
CNSTI4 0
EQI4 $440
ADDRGP4 g_singlePlayer+12
INDIRI4
CNSTI4 0
EQI4 $440
line 917
;917:			if ( level.time - level.intermissionQueued >= 1000  ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+7600
INDIRI4
SUBI4
CNSTI4 1000
LTI4 $444
line 918
;918:				pm.cmd.buttons = 0;
ADDRLP4 4+4+16
CNSTI4 0
ASGNI4
line 919
;919:				pm.cmd.forwardmove = 0;
ADDRLP4 4+4+21
CNSTI1 0
ASGNI1
line 920
;920:				pm.cmd.rightmove = 0;
ADDRLP4 4+4+22
CNSTI1 0
ASGNI1
line 921
;921:				pm.cmd.upmove = 0;
ADDRLP4 4+4+23
CNSTI1 0
ASGNI1
line 922
;922:				if ( level.time - level.intermissionQueued >= 2000 && level.time - level.intermissionQueued <= 2500 ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+7600
INDIRI4
SUBI4
CNSTI4 2000
LTI4 $456
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+7600
INDIRI4
SUBI4
CNSTI4 2500
GTI4 $456
line 923
;923:					trap_SendConsoleCommand( EXEC_APPEND, "centerview\n");
CNSTI4 2
ARGI4
ADDRGP4 $462
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 924
;924:				}
LABELV $456
line 925
;925:				ent->client->ps.pm_type = PM_SPINTERMISSION;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 6
ASGNI4
line 926
;926:			}
LABELV $444
line 927
;927:		}
LABELV $440
line 928
;928:		Pmove (&pm);
ADDRLP4 4
ARGP4
ADDRGP4 Pmove
CALLV
pop
line 934
;929:#else
;930:		Pmove (&pm);
;931:#endif
;932:
;933:	// save results of pmove
;934:	if ( ent->client->ps.eventSequence != oldEventSequence ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ADDRLP4 240
INDIRI4
EQI4 $463
line 935
;935:		ent->eventTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 552
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 936
;936:	}
LABELV $463
line 938
;937:
;938:	BG_PlayerStateToEntityState( &ent->client->ps, &ent->s, qtrue );
ADDRLP4 268
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 268
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 268
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 940
;939:
;940:	SendPendingPredictableEvents( &ent->client->ps );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRGP4 SendPendingPredictableEvents
CALLV
pop
line 942
;941:
;942:	if ( !( ent->client->ps.eFlags & EF_FIRING ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
NEI4 $466
line 943
;943:		client->fireHeld = qfalse;		// for grapple
ADDRLP4 0
INDIRP4
CNSTI4 764
ADDP4
CNSTI4 0
ASGNI4
line 944
;944:	}
LABELV $466
line 947
;945:
;946:	// use the snapped origin for linking so it matches client predicted versions
;947:	VectorCopy( ent->s.pos.trBase, ent->r.currentOrigin );
ADDRLP4 272
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 272
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 272
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 949
;948:
;949:	VectorCopy (pm.mins, ent->r.mins);
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 4+176
INDIRB
ASGNB 12
line 950
;950:	VectorCopy (pm.maxs, ent->r.maxs);
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDRLP4 4+188
INDIRB
ASGNB 12
line 952
;951:
;952:	ent->waterlevel = pm.waterlevel;
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
ADDRLP4 4+204
INDIRI4
ASGNI4
line 953
;953:	ent->watertype = pm.watertype;
ADDRFP4 0
INDIRP4
CNSTI4 792
ADDP4
ADDRLP4 4+200
INDIRI4
ASGNI4
line 956
;954:
;955:	// execute client events
;956:	ClientEvents( ent, oldEventSequence );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 240
INDIRI4
ARGI4
ADDRGP4 ClientEvents
CALLV
pop
line 959
;957:
;958:	// link entity now, after any personal teleporters have been used
;959:	trap_LinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 960
;960:	if ( !ent->client->noclip ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 656
ADDP4
INDIRI4
CNSTI4 0
NEI4 $472
line 961
;961:		G_TouchTriggers( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_TouchTriggers
CALLV
pop
line 962
;962:	}
LABELV $472
line 965
;963:
;964:	// NOTE: now copy the exact origin over otherwise clients can be snapped into solid
;965:	VectorCopy( ent->client->ps.origin, ent->r.currentOrigin );
ADDRLP4 276
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 276
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 276
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 968
;966:
;967:	//test for solid areas in the AAS file
;968:	BotTestAAS(ent->r.currentOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRGP4 BotTestAAS
CALLV
pop
line 971
;969:
;970:	// touch other objects
;971:	ClientImpacts( ent, &pm );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 ClientImpacts
CALLV
pop
line 974
;972:
;973:	// save results of triggers and client events
;974:	if (ent->client->ps.eventSequence != oldEventSequence) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ADDRLP4 240
INDIRI4
EQI4 $474
line 975
;975:		ent->eventTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 552
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 976
;976:	}
LABELV $474
line 979
;977:
;978:	// swap and latch button actions
;979:	client->oldbuttons = client->buttons;
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 664
ADDP4
INDIRI4
ASGNI4
line 980
;980:	client->buttons = ucmd->buttons;
ADDRLP4 0
INDIRP4
CNSTI4 664
ADDP4
ADDRLP4 232
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 981
;981:	client->latched_buttons |= client->buttons & ~client->oldbuttons;
ADDRLP4 288
ADDRLP4 0
INDIRP4
CNSTI4 672
ADDP4
ASGNP4
ADDRLP4 288
INDIRP4
ADDRLP4 288
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 664
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRI4
BCOMI4
BANDI4
BORI4
ASGNI4
line 984
;982:
;983:	// check for respawning
;984:	if ( client->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $477
line 986
;985:		// wait for the attack button to be pressed
;986:		if ( level.time > client->respawnTime ) {
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
LEI4 $352
line 988
;987:			// forcerespawn is to prevent users from waiting out powerups
;988:			if ( g_forcerespawn.integer > 0 && 
ADDRGP4 g_forcerespawn+12
INDIRI4
CNSTI4 0
LEI4 $482
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
SUBI4
ADDRGP4 g_forcerespawn+12
INDIRI4
CNSTI4 1000
MULI4
LEI4 $482
line 989
;989:				( level.time - client->respawnTime ) > g_forcerespawn.integer * 1000 ) {
line 990
;990:				respawn( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 respawn
CALLV
pop
line 991
;991:				return;
ADDRGP4 $352
JUMPV
LABELV $482
line 995
;992:			}
;993:		
;994:			// pressing attack or use is the normal respawn method
;995:			if ( ucmd->buttons & ( BUTTON_ATTACK | BUTTON_USE_HOLDABLE ) ) {
ADDRLP4 232
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 5
BANDI4
CNSTI4 0
EQI4 $352
line 996
;996:				respawn( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 respawn
CALLV
pop
line 997
;997:			}
line 998
;998:		}
line 999
;999:		return;
ADDRGP4 $352
JUMPV
LABELV $477
line 1003
;1000:	}
;1001:
;1002:	// perform once-a-second actions
;1003:	ClientTimerActions( ent, msec );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 236
INDIRI4
ARGI4
ADDRGP4 ClientTimerActions
CALLV
pop
line 1004
;1004:}
LABELV $352
endproc ClientThink_real 320 12
export ClientThink
proc ClientThink 4 8
line 1014
;1005:
;1006:
;1007:/*
;1008:==================
;1009:ClientThink
;1010:
;1011:A new command has arrived from the client
;1012:==================
;1013:*/
;1014:void ClientThink( int clientNum ) {
line 1017
;1015:	gentity_t *ent;
;1016:
;1017:	ent = g_entities + clientNum;
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1018
;1018:	trap_GetUsercmd( clientNum, &ent->client->pers.cmd );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ARGP4
ADDRGP4 trap_GetUsercmd
CALLV
pop
line 1026
;1019:
;1020:	// mark the time we got info, so we can display the
;1021:	// phone jack if they don't get any for a while
;1022:#if 0 // unlagged
;1023:	ent->client->lastCmdTime = level.time;
;1024:#endif
;1025:
;1026:	if ( !(ent->r.svFlags & SVF_BOT) && !g_synchronousClients.integer ) {
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $490
ADDRGP4 g_synchronousClients+12
INDIRI4
CNSTI4 0
NEI4 $490
line 1027
;1027:		ClientThink_real( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ClientThink_real
CALLV
pop
line 1028
;1028:	}
LABELV $490
line 1029
;1029:}
LABELV $489
endproc ClientThink 4 8
export G_RunClient
proc G_RunClient 0 4
line 1032
;1030:
;1031:
;1032:void G_RunClient( gentity_t *ent ) {
line 1033
;1033:	if ( !(ent->r.svFlags & SVF_BOT) && !g_synchronousClients.integer ) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $494
ADDRGP4 g_synchronousClients+12
INDIRI4
CNSTI4 0
NEI4 $494
line 1034
;1034:		return;
ADDRGP4 $493
JUMPV
LABELV $494
line 1036
;1035:	}
;1036:	ent->client->pers.cmd.serverTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1037
;1037:	ClientThink_real( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ClientThink_real
CALLV
pop
line 1038
;1038:}
LABELV $493
endproc G_RunClient 0 4
export SpectatorClientEndFrame
proc SpectatorClientEndFrame 20 4
line 1047
;1039:
;1040:
;1041:/*
;1042:==================
;1043:SpectatorClientEndFrame
;1044:
;1045:==================
;1046:*/
;1047:void SpectatorClientEndFrame( gentity_t *ent ) {
line 1051
;1048:	gclient_t	*cl;
;1049:
;1050:	// if we are doing a chase cam or a remote view, grab the latest info
;1051:	if ( ent->client->sess.spectatorState == SPECTATOR_FOLLOW ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 632
ADDP4
INDIRI4
CNSTI4 2
NEI4 $499
line 1054
;1052:		int		clientNum, flags;
;1053:
;1054:		clientNum = ent->client->sess.spectatorClient;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 636
ADDP4
INDIRI4
ASGNI4
line 1057
;1055:
;1056:		// team follow1 and team follow2 go to whatever clients are playing
;1057:		if ( clientNum == -1 ) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
NEI4 $501
line 1058
;1058:			clientNum = level.follow1;
ADDRLP4 4
ADDRGP4 level+344
INDIRI4
ASGNI4
line 1059
;1059:		} else if ( clientNum == -2 ) {
ADDRGP4 $502
JUMPV
LABELV $501
ADDRLP4 4
INDIRI4
CNSTI4 -2
NEI4 $504
line 1060
;1060:			clientNum = level.follow2;
ADDRLP4 4
ADDRGP4 level+348
INDIRI4
ASGNI4
line 1061
;1061:		}
LABELV $504
LABELV $502
line 1062
;1062:		if ( (unsigned)clientNum < MAX_CLIENTS ) {
ADDRLP4 4
INDIRI4
CVIU4 4
CNSTU4 64
GEU4 $507
line 1063
;1063:			cl = &level.clients[ clientNum ];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1644
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1064
;1064:			if ( cl->pers.connected == CON_CONNECTED && cl->sess.sessionTeam != TEAM_SPECTATOR ) {
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $509
ADDRLP4 12
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
EQI4 $509
line 1065
;1065:				flags = (cl->ps.eFlags & ~(EF_VOTED | EF_TEAMVOTED)) | (ent->client->ps.eFlags & (EF_VOTED | EF_TEAMVOTED));
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 -540673
BANDI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 540672
BANDI4
BORI4
ASGNI4
line 1066
;1066:				ent->client->ps = cl->ps;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ADDRLP4 0
INDIRP4
INDIRB
ASGNB 468
line 1067
;1067:				ent->client->ps.pm_flags |= PMF_FOLLOW;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 1068
;1068:				ent->client->ps.eFlags = flags;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 1069
;1069:				return;
ADDRGP4 $498
JUMPV
LABELV $509
line 1070
;1070:			} else {
line 1072
;1071:				// drop them to free spectators unless they are dedicated camera followers
;1072:				if ( ent->client->sess.spectatorClient >= 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 636
ADDP4
INDIRI4
CNSTI4 0
LTI4 $511
line 1073
;1073:					ent->client->sess.spectatorState = SPECTATOR_FREE;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 632
ADDP4
CNSTI4 1
ASGNI4
line 1074
;1074:					ClientBegin( ent->client - level.clients );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1644
DIVI4
ARGI4
ADDRGP4 ClientBegin
CALLV
pop
line 1075
;1075:				}
LABELV $511
line 1076
;1076:			}
line 1077
;1077:		}
LABELV $507
line 1078
;1078:	}
LABELV $499
line 1080
;1079:
;1080:	if ( ent->client->sess.spectatorState == SPECTATOR_SCOREBOARD ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 632
ADDP4
INDIRI4
CNSTI4 3
NEI4 $513
line 1081
;1081:		ent->client->ps.pm_flags |= PMF_SCOREBOARD;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 8192
BORI4
ASGNI4
line 1082
;1082:	} else {
ADDRGP4 $514
JUMPV
LABELV $513
line 1083
;1083:		ent->client->ps.pm_flags &= ~PMF_SCOREBOARD;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -8193
BANDI4
ASGNI4
line 1084
;1084:	}
LABELV $514
line 1085
;1085:}
LABELV $498
endproc SpectatorClientEndFrame 20 4
bss
align 4
LABELV $516
skip 824
export ClientEndFrame
code
proc ClientEndFrame 40 12
line 1097
;1086:
;1087:
;1088:/*
;1089:==============
;1090:ClientEndFrame
;1091:
;1092:Called at the end of each server frame for each connected client
;1093:A fast client will have multiple ClientThink for each ClientEdFrame,
;1094:while a slow client may have multiple ClientEndFrame between ClientThink.
;1095:==============
;1096:*/
;1097:void ClientEndFrame( gentity_t *ent ) {
line 1104
;1098:	static gentity_t sent;
;1099:	int			i;
;1100:	gclient_t	*client;
;1101:	// unlagged
;1102:	int			frames;
;1103:
;1104:	if ( !ent->client )
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $517
line 1105
;1105:		return;
ADDRGP4 $515
JUMPV
LABELV $517
line 1107
;1106:
;1107:	ent->r.svFlags &= ~svf_self_portal2;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRGP4 svf_self_portal2
INDIRI4
BCOMI4
BANDI4
ASGNI4
line 1109
;1108:
;1109:	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
NEI4 $519
line 1110
;1110:		SpectatorClientEndFrame( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 SpectatorClientEndFrame
CALLV
pop
line 1111
;1111:		return;
ADDRGP4 $515
JUMPV
LABELV $519
line 1114
;1112:	}
;1113:
;1114:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 1117
;1115:
;1116:	// turn off any expired powerups
;1117:	for ( i = 0 ; i < MAX_POWERUPS ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $521
line 1118
;1118:		if ( client->ps.powerups[ i ] < client->pers.cmd.serverTime ) {
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 472
ADDP4
INDIRI4
GEI4 $525
line 1119
;1119:			client->ps.powerups[ i ] = 0;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 312
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 1120
;1120:		}
LABELV $525
line 1121
;1121:	}
LABELV $522
line 1117
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 16
LTI4 $521
line 1125
;1122:
;1123:#ifdef MISSIONPACK
;1124:	// set powerup for player animation
;1125:	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 11
NEI4 $527
line 1126
;1126:		ent->client->ps.powerups[PW_GUARD] = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 356
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1127
;1127:	}
LABELV $527
line 1128
;1128:	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_SCOUT ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 10
NEI4 $531
line 1129
;1129:		ent->client->ps.powerups[PW_SCOUT] = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 352
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1130
;1130:	}
LABELV $531
line 1131
;1131:	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_DOUBLER ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 12
NEI4 $535
line 1132
;1132:		ent->client->ps.powerups[PW_DOUBLER] = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 360
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1133
;1133:	}
LABELV $535
line 1134
;1134:	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_AMMOREGEN ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 13
NEI4 $539
line 1135
;1135:		ent->client->ps.powerups[PW_AMMOREGEN] = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 364
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1136
;1136:	}
LABELV $539
line 1137
;1137:	if ( ent->client->invulnerabilityTime > level.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $543
line 1138
;1138:		ent->client->ps.powerups[PW_INVULNERABILITY] = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 368
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1139
;1139:	}
LABELV $543
line 1154
;1140:#endif
;1141:
;1142:	// save network bandwidth
;1143:#if 0
;1144:	if ( !g_synchronousClients->integer && ent->client->ps.pm_type == PM_NORMAL ) {
;1145:		// FIXME: this must change eventually for non-sync demo recording
;1146:		VectorClear( ent->client->ps.viewangles );
;1147:	}
;1148:#endif
;1149:
;1150:	//
;1151:	// If the end of unit layout is displayed, don't give
;1152:	// the player any normal movement attributes
;1153:	//
;1154:	if ( level.intermissiontime ) {
ADDRGP4 level+7604
INDIRI4
CNSTI4 0
EQI4 $547
line 1155
;1155:		client->ps.commandTime = client->pers.cmd.serverTime;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 472
ADDP4
INDIRI4
ASGNI4
line 1156
;1156:		return;
ADDRGP4 $515
JUMPV
LABELV $547
line 1160
;1157:	}
;1158:
;1159:	// burn from lava, etc
;1160:	P_WorldEffects (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 P_WorldEffects
CALLV
pop
line 1163
;1161:
;1162:	// apply all the damage taken this frame
;1163:	P_DamageFeedback (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 P_DamageFeedback
CALLV
pop
line 1165
;1164:
;1165:	client->ps.stats[STAT_HEALTH] = ent->health;	// FIXME: get rid of ent->health...
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ASGNI4
line 1167
;1166:
;1167:	G_SetClientSound( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_SetClientSound
CALLV
pop
line 1170
;1168:
;1169:	// set the latest info
;1170:	BG_PlayerStateToEntityState( &client->ps, &ent->s, qtrue );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 1172
;1171:
;1172:	SendPendingPredictableEvents( &client->ps );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 SendPendingPredictableEvents
CALLV
pop
line 1174
;1173:
;1174:	client->ps.eFlags &= ~EF_CONNECTION;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 -8193
BANDI4
ASGNI4
line 1175
;1175:	ent->s.eFlags &= ~EF_CONNECTION;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 -8193
BANDI4
ASGNI4
line 1177
;1176:
;1177:	frames = level.framenum - client->lastUpdateFrame - 1;
ADDRLP4 8
ADDRGP4 level+28
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1628
ADDP4
INDIRI4
SUBI4
CNSTI4 1
SUBI4
ASGNI4
line 1180
;1178:
;1179:	// PVS prediction
;1180:	if ( g_predictPVS.integer && svf_self_portal2 ) {
ADDRGP4 g_predictPVS+12
INDIRI4
CNSTI4 0
EQI4 $551
ADDRGP4 svf_self_portal2
INDIRI4
CNSTI4 0
EQI4 $551
line 1182
;1181:		int lag;
;1182:		sent.s = ent->s;
ADDRGP4 $516
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 208
line 1183
;1183:		sent.r = ent->r;
ADDRGP4 $516+208
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRB
ASGNB 308
line 1184
;1184:		sent.clipmask = ent->clipmask;
ADDRGP4 $516+572
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
ASGNI4
line 1187
;1185:		//VectorCopy( client->ps.origin, sent.s.pos.trBase );
;1186:		//VectorCopy( client->ps.velocity, sent.s.pos.trDelta );
;1187:		lag = level.time - client->ps.commandTime + 50;
ADDRLP4 24
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
SUBI4
CNSTI4 50
ADDI4
ASGNI4
line 1188
;1188:		if ( lag > 500 )
ADDRLP4 24
INDIRI4
CNSTI4 500
LEI4 $557
line 1189
;1189:			lag = 500;
ADDRLP4 24
CNSTI4 500
ASGNI4
LABELV $557
line 1190
;1190:		G_PredictPlayerMove( &sent, (float)lag * 0.001f );
ADDRGP4 $516
ARGP4
ADDRLP4 24
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ARGF4
ADDRGP4 G_PredictPlayerMove
CALLV
pop
line 1191
;1191:		VectorCopy( sent.s.pos.trBase, ent->r.unused.origin2 );
ADDRFP4 0
INDIRP4
CNSTI4 312
ADDP4
ADDRGP4 $516+12+12
INDIRB
ASGNB 12
line 1192
;1192:		ent->r.unused.origin2[2] += client->ps.viewheight;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 320
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1193
;1193:		ent->r.svFlags |= svf_self_portal2;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
ADDRGP4 svf_self_portal2
INDIRI4
BORI4
ASGNI4
line 1194
;1194:	}
LABELV $551
line 1196
;1195:
;1196:	if ( frames > 2 ) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LEI4 $561
line 1198
;1197:		// limit lagged player prediction to 2 server frames
;1198:		frames = 2;
ADDRLP4 8
CNSTI4 2
ASGNI4
line 1200
;1199:		// and add the EF_CONNECTION flag if we haven't gotten commands recently
;1200:		if ( !( ent->r.svFlags & SVF_BOT ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $563
line 1201
;1201:			client->ps.eFlags |= EF_CONNECTION;
ADDRLP4 24
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 8192
BORI4
ASGNI4
line 1202
;1202:			ent->s.eFlags |= EF_CONNECTION;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 8192
BORI4
ASGNI4
line 1203
;1203:		}
LABELV $563
line 1204
;1204:	}
LABELV $561
line 1206
;1205:
;1206:	if ( frames > 0 && g_smoothClients.integer ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LEI4 $565
ADDRGP4 g_smoothClients+12
INDIRI4
CNSTI4 0
EQI4 $565
line 1207
;1207:		G_PredictPlayerMove( ent, (float)frames / sv_fps.value );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
CVIF4 4
ADDRGP4 sv_fps+8
INDIRF4
DIVF4
ARGF4
ADDRGP4 G_PredictPlayerMove
CALLV
pop
line 1208
;1208:		SnapVector( ent->s.pos.trBase );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 1209
;1209:	}
LABELV $565
line 1212
;1210:
;1211:	// unlagged
;1212:	G_StoreHistory( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_StoreHistory
CALLV
pop
line 1215
;1213:
;1214:	// hitsounds
;1215:	if ( client->damage.enemy && client->damage.amount ) {
ADDRLP4 0
INDIRP4
CNSTI4 1636
ADDP4
INDIRI4
CNSTI4 0
EQI4 $569
ADDRLP4 0
INDIRP4
CNSTI4 1640
ADDP4
INDIRI4
CNSTI4 0
EQI4 $569
line 1216
;1216:		client->ps.persistant[PERS_HITS] += client->damage.enemy;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 252
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1636
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1217
;1217:		client->damage.enemy = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1636
ADDP4
CNSTI4 0
ASGNI4
line 1219
;1218:		// scale damage by max.health
;1219:		i = client->damage.amount * 100 / client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 1640
ADDP4
INDIRI4
CNSTI4 100
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
DIVI4
ASGNI4
line 1221
;1220:		// avoid high-byte setup
;1221:		if ( i > 255 )
ADDRLP4 4
INDIRI4
CNSTI4 255
LEI4 $571
line 1222
;1222:			i = 255;
ADDRLP4 4
CNSTI4 255
ASGNI4
LABELV $571
line 1223
;1223:		client->ps.persistant[PERS_ATTACKEE_ARMOR] = i;
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1224
;1224:		client->damage.amount = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1640
ADDP4
CNSTI4 0
ASGNI4
line 1225
;1225:	} else if ( client->damage.team ) {
ADDRGP4 $570
JUMPV
LABELV $569
ADDRLP4 0
INDIRP4
CNSTI4 1632
ADDP4
INDIRI4
CNSTI4 0
EQI4 $573
line 1226
;1226:		client->ps.persistant[PERS_HITS] -= client->damage.team;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 252
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1632
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1227
;1227:		client->damage.team = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1632
ADDP4
CNSTI4 0
ASGNI4
line 1228
;1228:	}
LABELV $573
LABELV $570
line 1233
;1229:
;1230:	// set the bit for the reachability area the client is currently in
;1231://	i = trap_AAS_PointReachabilityAreaIndex( ent->client->ps.origin );
;1232://	ent->client->areabits[i >> 3] |= 1 << (i & 7);
;1233:}
LABELV $515
endproc ClientEndFrame 40 12
import BotTestSolid
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
import AddTeamScore
import Pickup_Team
import CheckTeamStatus
import TeamplayInfoMessage
import Team_GetLocationMsg
import Team_GetLocation
import SelectCTFSpawnPoint
import Team_FreeEntity
import Team_ReturnFlag
import Team_InitGame
import Team_CheckHurtCarrier
import Team_FragBonuses
import Team_DroppedFlagThink
import TeamColorString
import OtherTeamName
import TeamName
import OtherTeam
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
import Team_ResetFlags
import CheckObeliskAttack
import Team_CheckDroppedItem
import OnSameTeam
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
LABELV $462
byte 1 99
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 10
byte 1 0
align 1
LABELV $377
byte 1 51
byte 1 51
byte 1 0
align 1
LABELV $373
byte 1 56
byte 1 0
align 1
LABELV $372
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
LABELV $305
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 67
byte 1 117
byte 1 98
byte 1 101
byte 1 0
align 1
LABELV $304
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 67
byte 1 117
byte 1 98
byte 1 101
byte 1 0
align 1
LABELV $202
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 84
byte 1 101
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 32
byte 1 117
byte 1 110
byte 1 116
byte 1 105
byte 1 108
byte 1 32
byte 1 105
byte 1 110
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $198
byte 1 68
byte 1 114
byte 1 111
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 100
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 105
byte 1 110
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $104
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 47
byte 1 119
byte 1 115
byte 1 116
byte 1 98
byte 1 116
byte 1 105
byte 1 99
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
