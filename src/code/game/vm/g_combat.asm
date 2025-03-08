export ScorePlum
code
proc ScorePlum 12 8
file "../g_combat.c"
line 13
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// g_combat.c
;4:
;5:#include "g_local.h"
;6:
;7:
;8:/*
;9:============
;10:ScorePlum
;11:============
;12:*/
;13:void ScorePlum( gentity_t *ent, vec3_t origin, int score ) {
line 16
;14:	gentity_t *plum;
;15:
;16:	plum = G_TempEntity( origin, EV_SCOREPLUM );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 65
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 18
;17:	// only send this temp entity to a single client
;18:	plum->r.svFlags |= SVF_SINGLECLIENT;
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
CNSTI4 256
BORI4
ASGNI4
line 19
;19:	plum->r.singleClient = ent->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 21
;20:	//
;21:	plum->s.otherEntityNum = ent->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 22
;22:	plum->s.time = score;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 23
;23:}
LABELV $54
endproc ScorePlum 12 8
export AddScore
proc AddScore 4 12
line 32
;24:
;25:/*
;26:============
;27:AddScore
;28:
;29:Adds score to both the client and his team
;30:============
;31:*/
;32:void AddScore( gentity_t *ent, vec3_t origin, int score ) {
line 33
;33:	if ( !ent->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $56
line 34
;34:		return;
ADDRGP4 $55
JUMPV
LABELV $56
line 37
;35:	}
;36:	// no scoring during pre-match warmup
;37:	if ( level.warmupTime ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 0
EQI4 $58
line 38
;38:		return;
ADDRGP4 $55
JUMPV
LABELV $58
line 41
;39:	}
;40:	// show score plum
;41:	ScorePlum(ent, origin, score);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 ScorePlum
CALLV
pop
line 43
;42:	//
;43:	ent->client->ps.persistant[PERS_SCORE] += score;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 248
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ASGNI4
line 44
;44:	if ( g_gametype.integer == GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $61
line 45
;45:		AddTeamScore( origin, ent->client->ps.persistant[PERS_TEAM], score );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 AddTeamScore
CALLV
pop
line 46
;46:	}
LABELV $61
line 47
;47:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 48
;48:}
LABELV $55
endproc AddScore 4 12
export TossClientItems
proc TossClientItems 40 12
line 57
;49:
;50:/*
;51:=================
;52:TossClientItems
;53:
;54:Toss the weapon and powerups for the killed player
;55:=================
;56:*/
;57:void TossClientItems( gentity_t *self ) {
line 65
;58:	gitem_t		*item;
;59:	int			weapon;
;60:	float		angle;
;61:	int			i;
;62:	gentity_t	*drop;
;63:
;64:	// drop the weapon if not a gauntlet or machinegun
;65:	weapon = self->s.weapon;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
line 71
;66:
;67:	// make a special check to see if they are changing to a new
;68:	// weapon that isn't the mg or gauntlet.  Without this, a client
;69:	// can pick up a weapon, be killed, and not drop the weapon because
;70:	// their weapon change hasn't completed yet and they are still holding the MG.
;71:	if ( weapon == WP_MACHINEGUN || weapon == WP_GRAPPLING_HOOK ) {
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $67
ADDRLP4 12
INDIRI4
CNSTI4 10
NEI4 $65
LABELV $67
line 72
;72:		if ( self->client->ps.weaponstate == WEAPON_DROPPING ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $68
line 73
;73:			weapon = self->client->pers.cmd.weapon;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 492
ADDP4
INDIRU1
CVUI4 1
ASGNI4
line 74
;74:		}
LABELV $68
line 75
;75:		if ( !( self->client->ps.stats[STAT_WEAPONS] & ( 1 << weapon ) ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 12
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $70
line 76
;76:			weapon = WP_NONE;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 77
;77:		}
LABELV $70
line 78
;78:	}
LABELV $65
line 80
;79:
;80:	if ( weapon > WP_MACHINEGUN && weapon != WP_GRAPPLING_HOOK && 
ADDRLP4 12
INDIRI4
CNSTI4 2
LEI4 $72
ADDRLP4 12
INDIRI4
CNSTI4 10
EQI4 $72
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $72
ADDRGP4 g_instagib+12
INDIRI4
CNSTI4 0
NEI4 $72
line 81
;81:		self->client->ps.ammo[ weapon ] && !g_instagib.integer ) {
line 83
;82:		// find the item type for this weapon
;83:		item = BG_FindItemForWeapon( weapon );
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 28
INDIRP4
ASGNP4
line 86
;84:
;85:		// spawn the item
;86:		drop = Drop_Item( self, item, 0 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 32
ADDRGP4 Drop_Item
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 32
INDIRP4
ASGNP4
line 89
;87:
;88:		// for pickup prediction
;89:		drop->s.time2 = item->quantity;
ADDRLP4 4
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
line 90
;90:	}
LABELV $72
line 93
;91:
;92:	// drop all the powerups if not in teamplay
;93:	if ( g_gametype.integer != GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
EQI4 $75
line 94
;94:		angle = 45;
ADDRLP4 16
CNSTF4 1110704128
ASGNF4
line 95
;95:		for ( i = 1 ; i < PW_NUM_POWERUPS ; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $78
line 96
;96:			if ( self->client->ps.powerups[ i ] > level.time ) {
ADDRLP4 0
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
LEI4 $82
line 97
;97:				item = BG_FindItemForPowerup( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 28
INDIRP4
ASGNP4
line 98
;98:				if ( !item ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $85
line 99
;99:					continue;
ADDRGP4 $79
JUMPV
LABELV $85
line 101
;100:				}
;101:				drop = Drop_Item( self, item, angle );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 Drop_Item
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 32
INDIRP4
ASGNP4
line 103
;102:				// decide how many seconds it has left
;103:				drop->count = ( self->client->ps.powerups[ i ] - level.time ) / 1000;
ADDRLP4 4
INDIRP4
CNSTI4 760
ADDP4
ADDRLP4 0
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
line 104
;104:				if ( drop->count < 1 ) {
ADDRLP4 4
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 1
GEI4 $88
line 105
;105:					drop->count = 1;
ADDRLP4 4
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 1
ASGNI4
line 106
;106:				}
LABELV $88
line 108
;107:				// for pickup prediction
;108:				drop->s.time2 = drop->count;
ADDRLP4 4
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ASGNI4
line 109
;109:				angle += 45;
ADDRLP4 16
ADDRLP4 16
INDIRF4
CNSTF4 1110704128
ADDF4
ASGNF4
line 110
;110:			}
LABELV $82
line 111
;111:		}
LABELV $79
line 95
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 15
LTI4 $78
line 112
;112:	}
LABELV $75
line 113
;113:}
LABELV $64
endproc TossClientItems 40 12
export TossClientCubes
proc TossClientCubes 56 16
line 124
;114:
;115:
;116:#ifdef MISSIONPACK
;117:/*
;118:=================
;119:TossClientCubes
;120:=================
;121:*/
;122:extern gentity_t	*neutralObelisk;
;123:
;124:void TossClientCubes( gentity_t *self ) {
line 131
;125:	gitem_t		*item;
;126:	gentity_t	*drop;
;127:	vec3_t		velocity;
;128:	vec3_t		angles;
;129:	vec3_t		origin;
;130:
;131:	self->client->ps.generic1 = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 440
ADDP4
CNSTI4 0
ASGNI4
line 135
;132:
;133:	// this should never happen but we should never
;134:	// get the server to crash due to skull being spawned in
;135:	if (!G_EntitiesFree()) {
ADDRLP4 44
ADDRGP4 G_EntitiesFree
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $91
line 136
;136:		return;
ADDRGP4 $90
JUMPV
LABELV $91
line 139
;137:	}
;138:
;139:	if( self->client->sess.sessionTeam == TEAM_RED ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 1
NEI4 $93
line 140
;140:		item = BG_FindItem( "Red Cube" );
ADDRGP4 $95
ARGP4
ADDRLP4 48
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 40
ADDRLP4 48
INDIRP4
ASGNP4
line 141
;141:	}
ADDRGP4 $94
JUMPV
LABELV $93
line 142
;142:	else {
line 143
;143:		item = BG_FindItem( "Blue Cube" );
ADDRGP4 $96
ARGP4
ADDRLP4 48
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 40
ADDRLP4 48
INDIRP4
ASGNP4
line 144
;144:	}
LABELV $94
line 146
;145:
;146:	angles[YAW] = (float)(level.time % 360);
ADDRLP4 16+4
ADDRGP4 level+32
INDIRI4
CNSTI4 360
MODI4
CVIF4 4
ASGNF4
line 147
;147:	angles[PITCH] = 0;	// always forward
ADDRLP4 16
CNSTF4 0
ASGNF4
line 148
;148:	angles[ROLL] = 0;
ADDRLP4 16+8
CNSTF4 0
ASGNF4
line 150
;149:
;150:	AngleVectors( angles, velocity, NULL, NULL );
ADDRLP4 16
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
line 151
;151:	VectorScale( velocity, 150, velocity );
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1125515264
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1125515264
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1125515264
MULF4
ASGNF4
line 152
;152:	velocity[2] += 200 + crandom() * 50;
ADDRLP4 48
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 48
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1120403456
MULF4
CNSTF4 1128792064
ADDF4
ADDF4
ASGNF4
line 154
;153:
;154:	if( neutralObelisk ) {
ADDRGP4 neutralObelisk
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $105
line 155
;155:		VectorCopy( neutralObelisk->s.pos.trBase, origin );
ADDRLP4 28
ADDRGP4 neutralObelisk
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 156
;156:		origin[2] += 44;
ADDRLP4 28+8
ADDRLP4 28+8
INDIRF4
CNSTF4 1110441984
ADDF4
ASGNF4
line 157
;157:	} else {
ADDRGP4 $106
JUMPV
LABELV $105
line 158
;158:		VectorClear( origin ) ;
ADDRLP4 28
CNSTF4 0
ASGNF4
ADDRLP4 28+4
CNSTF4 0
ASGNF4
ADDRLP4 28+8
CNSTF4 0
ASGNF4
line 159
;159:	}
LABELV $106
line 161
;160:
;161:	drop = LaunchItem( item, origin, velocity );
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 52
ADDRGP4 LaunchItem
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 52
INDIRP4
ASGNP4
line 163
;162:
;163:	drop->nextthink = level.time + g_cubeTimeout.integer * 1000;
ADDRLP4 12
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRGP4 g_cubeTimeout+12
INDIRI4
CNSTI4 1000
MULI4
ADDI4
ASGNI4
line 164
;164:	drop->think = G_FreeEntity;
ADDRLP4 12
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_FreeEntity
ASGNP4
line 165
;165:	drop->spawnflags = self->client->sess.sessionTeam;
ADDRLP4 12
INDIRP4
CNSTI4 528
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ASGNI4
line 166
;166:}
LABELV $90
endproc TossClientCubes 56 16
export TossClientPersistantPowerups
proc TossClientPersistantPowerups 12 4
line 174
;167:
;168:
;169:/*
;170:=================
;171:TossClientPersistantPowerups
;172:=================
;173:*/
;174:void TossClientPersistantPowerups( gentity_t *ent ) {
line 177
;175:	gentity_t	*powerup;
;176:
;177:	if( !ent->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $113
line 178
;178:		return;
ADDRGP4 $112
JUMPV
LABELV $113
line 181
;179:	}
;180:
;181:	if( !ent->client->persistantPowerup ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 780
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $115
line 182
;182:		return;
ADDRGP4 $112
JUMPV
LABELV $115
line 185
;183:	}
;184:
;185:	powerup = ent->client->persistantPowerup;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 780
ADDP4
INDIRP4
ASGNP4
line 187
;186:
;187:	powerup->r.svFlags &= ~SVF_NOCLIENT;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 188
;188:	powerup->s.eFlags &= ~EF_NODRAW;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 189
;189:	powerup->r.contents = CONTENTS_TRIGGER;
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1073741824
ASGNI4
line 190
;190:	trap_LinkEntity( powerup );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 192
;191:
;192:	ent->client->ps.stats[STAT_PERSISTANT_POWERUP] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 193
;193:	ent->client->persistantPowerup = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 780
ADDP4
CNSTP4 0
ASGNP4
line 194
;194:}
LABELV $112
endproc TossClientPersistantPowerups 12 4
export LookAtKiller
proc LookAtKiller 28 4
line 203
;195:#endif
;196:
;197:
;198:/*
;199:==================
;200:LookAtKiller
;201:==================
;202:*/
;203:void LookAtKiller( gentity_t *self, gentity_t *inflictor, gentity_t *attacker ) {
line 206
;204:	vec3_t		dir;
;205:
;206:	if ( attacker && attacker != self ) {
ADDRLP4 12
ADDRFP4 8
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 12
INDIRU4
CNSTU4 0
EQU4 $118
ADDRLP4 12
INDIRU4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $118
line 207
;207:		VectorSubtract (attacker->s.pos.trBase, self->s.pos.trBase, dir);
ADDRLP4 16
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 16
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
line 208
;208:	} else if ( inflictor && inflictor != self ) {
ADDRGP4 $119
JUMPV
LABELV $118
ADDRLP4 16
ADDRFP4 4
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 16
INDIRU4
CNSTU4 0
EQU4 $122
ADDRLP4 16
INDIRU4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $122
line 209
;209:		VectorSubtract (inflictor->s.pos.trBase, self->s.pos.trBase, dir);
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 20
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
line 210
;210:	} else {
ADDRGP4 $123
JUMPV
LABELV $122
line 211
;211:		self->client->ps.stats[STAT_DEAD_YAW] = self->s.angles[YAW];
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 204
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 212
;212:		return;
ADDRGP4 $117
JUMPV
LABELV $123
LABELV $119
line 215
;213:	}
;214:
;215:	self->client->ps.stats[STAT_DEAD_YAW] = vectoyaw ( dir );
ADDRLP4 0
ARGP4
ADDRLP4 20
ADDRGP4 vectoyaw
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 204
ADDP4
ADDRLP4 20
INDIRF4
CVFI4 4
ASGNI4
line 216
;216:}
LABELV $117
endproc LookAtKiller 28 4
export GibEntity
proc GibEntity 12 12
line 223
;217:
;218:/*
;219:==================
;220:GibEntity
;221:==================
;222:*/
;223:void GibEntity( gentity_t *self, int killer ) {
line 229
;224:#ifdef MISSIONPACK
;225:	gentity_t *ent;
;226:	int i;
;227:
;228:	//if this entity still has kamikaze
;229:	if (self->s.eFlags & EF_KAMIKAZE) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $127
line 231
;230:		// check if there is a kamikaze timer around for this owner
;231:		for (i = 0; i < level.num_entities; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $132
JUMPV
LABELV $129
line 232
;232:			ent = &g_entities[i];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 233
;233:			if (!ent->inuse)
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $134
line 234
;234:				continue;
ADDRGP4 $130
JUMPV
LABELV $134
line 235
;235:			if (ent->activator != self)
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $136
line 236
;236:				continue;
ADDRGP4 $130
JUMPV
LABELV $136
line 237
;237:			if (strcmp(ent->classname, "kamikaze timer"))
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $140
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $138
line 238
;238:				continue;
ADDRGP4 $130
JUMPV
LABELV $138
line 239
;239:			G_FreeEntity(ent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 240
;240:			break;
ADDRGP4 $131
JUMPV
LABELV $130
line 231
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $132
ADDRLP4 4
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $129
LABELV $131
line 242
;241:		}
;242:	}
LABELV $127
line 245
;243:#endif
;244:
;245:	G_AddEvent( self, EV_GIB_PLAYER, killer );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 246
;246:	self->takedamage = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 0
ASGNI4
line 247
;247:	self->s.eType = ET_INVISIBLE;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 10
ASGNI4
line 248
;248:	self->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 249
;249:}
LABELV $126
endproc GibEntity 12 12
export body_die
proc body_die 0 8
line 256
;250:
;251:/*
;252:==================
;253:body_die
;254:==================
;255:*/
;256:void body_die( gentity_t *self, gentity_t *inflictor, gentity_t *attacker, int damage, int meansOfDeath ) {
line 257
;257:	if ( self->health > GIB_HEALTH ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 -40
LEI4 $142
line 258
;258:		return;
ADDRGP4 $141
JUMPV
LABELV $142
line 260
;259:	}
;260:	if ( !g_blood.integer ) {
ADDRGP4 g_blood+12
INDIRI4
CNSTI4 0
NEI4 $144
line 261
;261:		self->health = GIB_HEALTH+1;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTI4 -39
ASGNI4
line 262
;262:		return;
ADDRGP4 $141
JUMPV
LABELV $144
line 265
;263:	}
;264:
;265:	GibEntity( self, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 GibEntity
CALLV
pop
line 266
;266:}
LABELV $141
endproc body_die 0 8
data
export modNames
align 4
LABELV modNames
address $147
address $148
address $149
address $150
address $151
address $152
address $153
address $154
address $155
address $156
address $157
address $158
address $159
address $160
address $161
address $162
address $163
address $164
address $165
address $166
address $167
address $168
address $169
address $170
address $171
address $172
address $173
address $174
address $175
export Kamikaze_DeathActivate
code
proc Kamikaze_DeathActivate 0 4
line 310
;267:
;268:
;269:// these are just for logging, the client prints its own messages
;270:char	*modNames[] = {
;271:	"MOD_UNKNOWN",
;272:	"MOD_SHOTGUN",
;273:	"MOD_GAUNTLET",
;274:	"MOD_MACHINEGUN",
;275:	"MOD_GRENADE",
;276:	"MOD_GRENADE_SPLASH",
;277:	"MOD_ROCKET",
;278:	"MOD_ROCKET_SPLASH",
;279:	"MOD_PLASMA",
;280:	"MOD_PLASMA_SPLASH",
;281:	"MOD_RAILGUN",
;282:	"MOD_LIGHTNING",
;283:	"MOD_BFG",
;284:	"MOD_BFG_SPLASH",
;285:	"MOD_WATER",
;286:	"MOD_SLIME",
;287:	"MOD_LAVA",
;288:	"MOD_CRUSH",
;289:	"MOD_TELEFRAG",
;290:	"MOD_FALLING",
;291:	"MOD_SUICIDE",
;292:	"MOD_TARGET_LASER",
;293:	"MOD_TRIGGER_HURT",
;294:#ifdef MISSIONPACK
;295:	"MOD_NAIL",
;296:	"MOD_CHAINGUN",
;297:	"MOD_PROXIMITY_MINE",
;298:	"MOD_KAMIKAZE",
;299:	"MOD_JUICED",
;300:#endif
;301:	"MOD_GRAPPLE"
;302:};
;303:
;304:#ifdef MISSIONPACK
;305:/*
;306:==================
;307:Kamikaze_DeathActivate
;308:==================
;309:*/
;310:void Kamikaze_DeathActivate( gentity_t *ent ) {
line 311
;311:	G_StartKamikaze(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_StartKamikaze
CALLV
pop
line 312
;312:	G_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 313
;313:}
LABELV $176
endproc Kamikaze_DeathActivate 0 4
export Kamikaze_DeathTimer
proc Kamikaze_DeathTimer 12 0
line 320
;314:
;315:/*
;316:==================
;317:Kamikaze_DeathTimer
;318:==================
;319:*/
;320:void Kamikaze_DeathTimer( gentity_t *self ) {
line 323
;321:	gentity_t *ent;
;322:
;323:	ent = G_Spawn();
ADDRLP4 4
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 324
;324:	ent->classname = "kamikaze timer";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $140
ASGNP4
line 325
;325:	VectorCopy(self->s.pos.trBase, ent->s.pos.trBase);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 326
;326:	ent->r.svFlags |= SVF_NOCLIENT;
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
CNSTI4 1
BORI4
ASGNI4
line 327
;327:	ent->think = Kamikaze_DeathActivate;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 Kamikaze_DeathActivate
ASGNP4
line 328
;328:	ent->nextthink = level.time + 5 * 1000;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 330
;329:
;330:	ent->activator = self;
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 331
;331:}
LABELV $177
endproc Kamikaze_DeathTimer 12 0
export CheckAlmostCapture
proc CheckAlmostCapture 52 12
line 340
;332:
;333:#endif
;334:
;335:/*
;336:==================
;337:CheckAlmostCapture
;338:==================
;339:*/
;340:void CheckAlmostCapture( gentity_t *self, gentity_t *attacker ) {
line 346
;341:	gentity_t	*ent;
;342:	vec3_t		dir;
;343:	char		*classname;
;344:
;345:	// if this player was carrying a flag
;346:	if ( self->client->ps.powerups[PW_REDFLAG] ||
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
NEI4 $183
ADDRLP4 20
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
NEI4 $183
ADDRLP4 20
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $180
LABELV $183
line 348
;347:		self->client->ps.powerups[PW_BLUEFLAG] ||
;348:		self->client->ps.powerups[PW_NEUTRALFLAG] ) {
line 350
;349:		// get the goal flag this player should have been going for
;350:		if ( g_gametype.integer == GT_CTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $184
line 351
;351:			if ( self->client->sess.sessionTeam == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 2
NEI4 $187
line 352
;352:				classname = "team_CTF_blueflag";
ADDRLP4 4
ADDRGP4 $189
ASGNP4
line 353
;353:			}
ADDRGP4 $185
JUMPV
LABELV $187
line 354
;354:			else {
line 355
;355:				classname = "team_CTF_redflag";
ADDRLP4 4
ADDRGP4 $190
ASGNP4
line 356
;356:			}
line 357
;357:		}
ADDRGP4 $185
JUMPV
LABELV $184
line 358
;358:		else {
line 359
;359:			if ( self->client->sess.sessionTeam == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 2
NEI4 $191
line 360
;360:				classname = "team_CTF_redflag";
ADDRLP4 4
ADDRGP4 $190
ASGNP4
line 361
;361:			}
ADDRGP4 $192
JUMPV
LABELV $191
line 362
;362:			else {
line 363
;363:				classname = "team_CTF_blueflag";
ADDRLP4 4
ADDRGP4 $189
ASGNP4
line 364
;364:			}
LABELV $192
line 365
;365:		}
LABELV $185
line 366
;366:		ent = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
LABELV $193
line 368
;367:		do
;368:		{
line 369
;369:			ent = G_Find(ent, FOFS(classname), classname);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
line 370
;370:		} while (ent && (ent->flags & FL_DROPPED_ITEM));
LABELV $194
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $196
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $193
LABELV $196
line 372
;371:		// if we found the destination flag and it's not picked up
;372:		if (ent && !(ent->r.svFlags & SVF_NOCLIENT) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $197
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $197
line 374
;373:			// if the player was *very* close
;374:			VectorSubtract( self->client->ps.origin, ent->s.origin, dir );
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 32
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 32
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 375
;375:			if ( VectorLength(dir) < 200 ) {
ADDRLP4 8
ARGP4
ADDRLP4 40
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 40
INDIRF4
CNSTF4 1128792064
GEF4 $201
line 376
;376:				self->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 377
;377:				if ( attacker->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $203
line 378
;378:					attacker->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
ADDRLP4 48
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 379
;379:				}
LABELV $203
line 380
;380:			}
LABELV $201
line 381
;381:		}
LABELV $197
line 382
;382:	}
LABELV $180
line 383
;383:}
LABELV $179
endproc CheckAlmostCapture 52 12
export CheckAlmostScored
proc CheckAlmostScored 44 12
line 390
;384:
;385:/*
;386:==================
;387:CheckAlmostScored
;388:==================
;389:*/
;390:void CheckAlmostScored( gentity_t *self, gentity_t *attacker ) {
line 396
;391:	gentity_t	*ent;
;392:	vec3_t		dir;
;393:	char		*classname;
;394:
;395:	// if the player was carrying cubes
;396:	if ( self->client->ps.generic1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
CNSTI4 0
EQI4 $206
line 397
;397:		if ( self->client->sess.sessionTeam == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 2
NEI4 $208
line 398
;398:			classname = "team_redobelisk";
ADDRLP4 16
ADDRGP4 $210
ASGNP4
line 399
;399:		}
ADDRGP4 $209
JUMPV
LABELV $208
line 400
;400:		else {
line 401
;401:			classname = "team_blueobelisk";
ADDRLP4 16
ADDRGP4 $211
ASGNP4
line 402
;402:		}
LABELV $209
line 403
;403:		ent = G_Find(NULL, FOFS(classname), classname);
CNSTP4 0
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 16
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
line 405
;404:		// if we found the destination obelisk
;405:		if ( ent ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $212
line 407
;406:			// if the player was *very* close
;407:			VectorSubtract( self->client->ps.origin, ent->s.origin, dir );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 24
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 408
;408:			if ( VectorLength(dir) < 200 ) {
ADDRLP4 4
ARGP4
ADDRLP4 32
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
CNSTF4 1128792064
GEF4 $216
line 409
;409:				self->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 410
;410:				if ( attacker->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $218
line 411
;411:					attacker->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
ADDRLP4 40
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 412
;412:				}
LABELV $218
line 413
;413:			}
LABELV $216
line 414
;414:		}
LABELV $212
line 415
;415:	}
LABELV $206
line 416
;416:}
LABELV $205
endproc CheckAlmostScored 44 12
export G_GenericDeathCleanup
proc G_GenericDeathCleanup 12 4
line 418
;417:
;418:void G_GenericDeathCleanup( gentity_t *self ) {
line 419
;419:	if (self->client && self->client->hook) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $221
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $221
line 420
;420:		Weapon_HookFree(self->client->hook);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
line 421
;421:	}
LABELV $221
line 424
;422:
;423:#ifdef MISSIONPACK
;424:	if ((self->client->ps.eFlags & EF_TICKING) && self->activator) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $223
ADDRLP4 4
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $223
line 425
;425:		self->client->ps.eFlags &= ~EF_TICKING;
ADDRLP4 8
ADDRFP4 0
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
CNSTI4 -3
BANDI4
ASGNI4
line 426
;426:		self->activator->think = G_FreeEntity;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_FreeEntity
ASGNP4
line 427
;427:		self->activator->nextthink = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 428
;428:	}
LABELV $223
line 430
;429:#endif
;430:}
LABELV $220
endproc G_GenericDeathCleanup 12 4
bss
align 4
LABELV $300
skip 4
export player_die
code
proc player_die 84 28
line 437
;431:
;432:/*
;433:==================
;434:player_die
;435:==================
;436:*/
;437:void player_die( gentity_t *self, gentity_t *inflictor, gentity_t *attacker, int damage, int meansOfDeath ) {
line 445
;438:	gentity_t	*ent;
;439:	int			anim;
;440:	int			contents;
;441:	int			killer;
;442:	int			i;
;443:	char		*killerName, *obit;
;444:
;445:	if ( self->client->ps.pm_type == PM_DEAD ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $227
line 446
;446:		return;
ADDRGP4 $226
JUMPV
LABELV $227
line 449
;447:	}
;448:
;449:	if ( level.intermissiontime ) {
ADDRGP4 level+7604
INDIRI4
CNSTI4 0
EQI4 $229
line 450
;450:		return;
ADDRGP4 $226
JUMPV
LABELV $229
line 454
;451:	}
;452:
;453:	//unlag the client
;454:	G_UnTimeShiftClient( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_UnTimeShiftClient
CALLV
pop
line 457
;455:
;456:	// check for an almost capture
;457:	CheckAlmostCapture( self, attacker );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 CheckAlmostCapture
CALLV
pop
line 459
;458:	// check for a player that almost brought in cubes
;459:	CheckAlmostScored( self, attacker );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 CheckAlmostScored
CALLV
pop
line 461
;460:
;461:	if (self->client && self->client->hook) {
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $232
ADDRLP4 28
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $232
line 462
;462:		Weapon_HookFree(self->client->hook);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
line 463
;463:	}
LABELV $232
line 465
;464:#ifdef MISSIONPACK
;465:	if ((self->client->ps.eFlags & EF_TICKING) && self->activator) {
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $234
ADDRLP4 32
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $234
line 466
;466:		self->client->ps.eFlags &= ~EF_TICKING;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 467
;467:		self->activator->think = G_FreeEntity;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_FreeEntity
ASGNP4
line 468
;468:		self->activator->nextthink = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 469
;469:	}
LABELV $234
line 471
;470:#endif
;471:	G_GenericDeathCleanup(self); // removes hook and prox mines stuck to victim
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_GenericDeathCleanup
CALLV
pop
line 473
;472:
;473:	self->client->ps.pm_type = PM_DEAD;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 475
;474:
;475:	if ( attacker ) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $237
line 476
;476:		killer = attacker->s.number;
ADDRLP4 4
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 477
;477:		if ( attacker->client ) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $239
line 478
;478:			killerName = attacker->client->pers.netname;
ADDRLP4 16
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 508
ADDP4
ASGNP4
line 479
;479:		} else {
ADDRGP4 $238
JUMPV
LABELV $239
line 480
;480:			killerName = "<non-client>";
ADDRLP4 16
ADDRGP4 $241
ASGNP4
line 481
;481:		}
line 482
;482:	} else {
ADDRGP4 $238
JUMPV
LABELV $237
line 483
;483:		killer = ENTITYNUM_WORLD;
ADDRLP4 4
CNSTI4 1022
ASGNI4
line 484
;484:		killerName = "<world>";
ADDRLP4 16
ADDRGP4 $242
ASGNP4
line 485
;485:	}
LABELV $238
line 487
;486:
;487:	if ( killer < 0 || killer >= MAX_CLIENTS ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $245
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $243
LABELV $245
line 488
;488:		killer = ENTITYNUM_WORLD;
ADDRLP4 4
CNSTI4 1022
ASGNI4
line 489
;489:		killerName = "<world>";
ADDRLP4 16
ADDRGP4 $242
ASGNP4
line 490
;490:	}
LABELV $243
line 492
;491:
;492:	if ( (unsigned)meansOfDeath >= ARRAY_LEN( modNames ) ) {
ADDRFP4 16
INDIRI4
CVIU4 4
CNSTU4 29
LTU4 $246
line 493
;493:		obit = "<bad obituary>";
ADDRLP4 20
ADDRGP4 $248
ASGNP4
line 494
;494:	} else {
ADDRGP4 $247
JUMPV
LABELV $246
line 495
;495:		obit = modNames[ meansOfDeath ];
ADDRLP4 20
ADDRFP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 modNames
ADDP4
INDIRP4
ASGNP4
line 496
;496:	}
LABELV $247
line 498
;497:
;498:	G_LogPrintf("Kill: %i %i %i: %s killed %s by %s\n", 
ADDRGP4 $249
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 503
;499:		killer, self->s.number, meansOfDeath, killerName, 
;500:		self->client->pers.netname, obit );
;501:
;502:	// broadcast the death event to everyone
;503:	ent = G_TempEntity( self->r.currentOrigin, EV_OBITUARY );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 60
ARGI4
ADDRLP4 44
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 44
INDIRP4
ASGNP4
line 504
;504:	ent->s.eventParm = meansOfDeath;
ADDRLP4 8
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 16
INDIRI4
ASGNI4
line 505
;505:	ent->s.otherEntityNum = self - g_entities;
ADDRLP4 8
INDIRP4
CNSTI4 140
ADDP4
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
line 506
;506:	ent->s.otherEntityNum2 = killer;
ADDRLP4 8
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 507
;507:	ent->r.svFlags = SVF_BROADCAST;	// send to everyone
ADDRLP4 8
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 32
ASGNI4
line 509
;508:
;509:	self->enemy = attacker;
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
ADDRFP4 8
INDIRP4
ASGNP4
line 511
;510:
;511:	self->client->ps.persistant[PERS_KILLED]++;
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 280
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
line 513
;512:
;513:	if (attacker && attacker->client) {
ADDRLP4 52
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $250
ADDRLP4 52
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $250
line 514
;514:		attacker->client->lastkilled_client = self->s.number;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 728
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 516
;515:
;516:		if ( attacker == self || OnSameTeam (self, attacker ) ) {
ADDRLP4 56
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CVPU4 4
ADDRLP4 60
INDIRP4
CVPU4 4
EQU4 $254
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $252
LABELV $254
line 517
;517:			AddScore( attacker, self->r.currentOrigin, -1 );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 518
;518:		} else {
ADDRGP4 $251
JUMPV
LABELV $252
line 519
;519:			AddScore( attacker, self->r.currentOrigin, 1 );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 521
;520:
;521:			if( meansOfDeath == MOD_GAUNTLET ) {
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $255
line 524
;522:				
;523:				// play humiliation on player
;524:				attacker->client->ps.persistant[PERS_GAUNTLET_FRAG_COUNT]++;
ADDRLP4 68
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 300
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
line 527
;525:
;526:				// add the sprite over the player's head
;527:				attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 72
ADDRFP4 8
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
line 528
;528:				attacker->client->ps.eFlags |= EF_AWARD_GAUNTLET;
ADDRLP4 76
ADDRFP4 8
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
CNSTI4 64
BORI4
ASGNI4
line 529
;529:				attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
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
line 532
;530:
;531:				// also play humiliation on target
;532:				self->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_GAUNTLETREWARD;
ADDRLP4 80
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 2
BXORI4
ASGNI4
line 533
;533:			}
LABELV $255
line 537
;534:
;535:			// check for two kills in a short amount of time
;536:			// if this is close enough to the last kill, give a reward sound
;537:			if ( level.time - attacker->client->lastKillTime < CARNAGE_REWARD_TIME ) {
ADDRGP4 level+32
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
SUBI4
CNSTI4 3000
GEI4 $258
line 539
;538:				// play excellent on player
;539:				attacker->client->ps.persistant[PERS_EXCELLENT_COUNT]++;
ADDRLP4 68
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 288
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
line 542
;540:
;541:				// add the sprite over the player's head
;542:				attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 72
ADDRFP4 8
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
line 543
;543:				attacker->client->ps.eFlags |= EF_AWARD_EXCELLENT;
ADDRLP4 76
ADDRFP4 8
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
CNSTI4 8
BORI4
ASGNI4
line 544
;544:				attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
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
line 545
;545:			}
LABELV $258
line 546
;546:			attacker->client->lastKillTime = level.time;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 760
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 548
;547:
;548:		}
line 549
;549:	} else {
ADDRGP4 $251
JUMPV
LABELV $250
line 550
;550:		AddScore( self, self->r.currentOrigin, -1 );
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 551
;551:	}
LABELV $251
line 554
;552:
;553:	// Add team bonuses
;554:	Team_FragBonuses(self, inflictor, attacker);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Team_FragBonuses
CALLV
pop
line 557
;555:
;556:	// if I committed suicide, the flag does not fall, it returns.
;557:	if (meansOfDeath == MOD_SUICIDE) {
ADDRFP4 16
INDIRI4
CNSTI4 20
NEI4 $263
line 559
;558:#ifdef MISSIONPACK
;559:		if ( self->client->ps.powerups[PW_NEUTRALFLAG] ) {		// only happens in One Flag CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $265
line 560
;560:			Team_ReturnFlag( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 561
;561:			self->client->ps.powerups[PW_NEUTRALFLAG] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
CNSTI4 0
ASGNI4
line 562
;562:		} else 
ADDRGP4 $266
JUMPV
LABELV $265
line 564
;563:#endif
;564:		if ( self->client->ps.powerups[PW_REDFLAG] ) {		// only happens in standard CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $267
line 565
;565:			Team_ReturnFlag( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 566
;566:			self->client->ps.powerups[PW_REDFLAG] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
CNSTI4 0
ASGNI4
line 567
;567:		}
ADDRGP4 $268
JUMPV
LABELV $267
line 568
;568:		else if ( self->client->ps.powerups[PW_BLUEFLAG] ) {	// only happens in standard CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $269
line 569
;569:			Team_ReturnFlag( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 570
;570:			self->client->ps.powerups[PW_BLUEFLAG] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
CNSTI4 0
ASGNI4
line 571
;571:		}
LABELV $269
LABELV $268
LABELV $266
line 572
;572:	}
LABELV $263
line 575
;573:
;574:	// if client is in a nodrop area, don't drop anything (but return CTF flags!)
;575:	contents = trap_PointContents( self->r.currentOrigin, -1 );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 56
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 56
INDIRI4
ASGNI4
line 576
;576:	if ( !( contents & CONTENTS_NODROP )) {
ADDRLP4 12
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
NEU4 $271
line 577
;577:		TossClientItems( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TossClientItems
CALLV
pop
line 578
;578:	}
ADDRGP4 $272
JUMPV
LABELV $271
line 579
;579:	else {
line 580
;580:		if ( self->client->ps.powerups[PW_NEUTRALFLAG] ) {		// only happens in One Flag CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $273
line 581
;581:			Team_ReturnFlag( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 582
;582:		}
ADDRGP4 $274
JUMPV
LABELV $273
line 583
;583:		else if ( self->client->ps.powerups[PW_REDFLAG] ) {		// only happens in standard CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $275
line 584
;584:			Team_ReturnFlag( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 585
;585:		}
ADDRGP4 $276
JUMPV
LABELV $275
line 586
;586:		else if ( self->client->ps.powerups[PW_BLUEFLAG] ) {	// only happens in standard CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $277
line 587
;587:			Team_ReturnFlag( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 588
;588:		}
LABELV $277
LABELV $276
LABELV $274
line 589
;589:	}
LABELV $272
line 591
;590:#ifdef MISSIONPACK
;591:	TossClientPersistantPowerups( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TossClientPersistantPowerups
CALLV
pop
line 592
;592:	if( g_gametype.integer == GT_HARVESTER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
NEI4 $279
line 593
;593:		TossClientCubes( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TossClientCubes
CALLV
pop
line 594
;594:	}
LABELV $279
line 597
;595:#endif
;596:
;597:	Cmd_Score_f( self );		// show scores
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Cmd_Score_f
CALLV
pop
line 600
;598:	// send updated scores to any clients that are following this one,
;599:	// or they would get stale scoreboards
;600:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $285
JUMPV
LABELV $282
line 603
;601:		gclient_t	*client;
;602:
;603:		client = &level.clients[i];
ADDRLP4 60
ADDRLP4 0
INDIRI4
CNSTI4 1644
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 604
;604:		if ( client->pers.connected != CON_CONNECTED ) {
ADDRLP4 60
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $287
line 605
;605:			continue;
ADDRGP4 $283
JUMPV
LABELV $287
line 607
;606:		}
;607:		if ( client->sess.sessionTeam != TEAM_SPECTATOR ) {
ADDRLP4 60
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
EQI4 $289
line 608
;608:			continue;
ADDRGP4 $283
JUMPV
LABELV $289
line 610
;609:		}
;610:		if ( client->sess.spectatorClient == self->s.number ) {
ADDRLP4 60
INDIRP4
CNSTI4 636
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
NEI4 $291
line 611
;611:			Cmd_Score_f( g_entities + i );
ADDRLP4 0
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 Cmd_Score_f
CALLV
pop
line 612
;612:		}
LABELV $291
line 613
;613:	}
LABELV $283
line 600
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $285
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $282
line 615
;614:
;615:	self->takedamage = qtrue;	// can still be gibbed
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 617
;616:
;617:	self->s.weapon = WP_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 618
;618:	self->s.powerups = 0;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 619
;619:	self->r.contents = CONTENTS_CORPSE;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 67108864
ASGNI4
line 621
;620:
;621:	self->s.angles[0] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 0
ASGNF4
line 622
;622:	self->s.angles[2] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
CNSTF4 0
ASGNF4
line 623
;623:	LookAtKiller (self, inflictor, attacker);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 LookAtKiller
CALLV
pop
line 625
;624:
;625:	VectorCopy( self->s.angles, self->client->ps.viewangles );
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 627
;626:
;627:	self->s.loopSound = 0;
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 629
;628:
;629:	self->r.maxs[2] = -8;
ADDRFP4 0
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 3238002688
ASGNF4
line 633
;630:
;631:	// don't allow respawn until the death anim is done
;632:	// g_forcerespawn may force spawning at some later time
;633:	self->client->respawnTime = level.time + 1700;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 740
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1700
ADDI4
ASGNI4
line 636
;634:
;635:	// remove powerups
;636:	memset( self->client->ps.powerups, 0, sizeof(self->client->ps.powerups) );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 64
ARGU4
ADDRGP4 memset
CALLP4
pop
line 639
;637:
;638:	// never gib in a nodrop
;639:	if ( (self->health <= GIB_HEALTH && !(contents & CONTENTS_NODROP) && g_blood.integer) || meansOfDeath == MOD_SUICIDE) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 -40
GTI4 $299
ADDRLP4 12
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
NEU4 $299
ADDRGP4 g_blood+12
INDIRI4
CNSTI4 0
NEI4 $297
LABELV $299
ADDRFP4 16
INDIRI4
CNSTI4 20
NEI4 $294
LABELV $297
line 641
;640:		// gib death
;641:		GibEntity( self, killer );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 GibEntity
CALLV
pop
line 642
;642:	} else {
ADDRGP4 $295
JUMPV
LABELV $294
line 646
;643:		// normal death
;644:		static int i;
;645:
;646:		switch ( i ) {
ADDRLP4 64
ADDRGP4 $300
INDIRI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $303
ADDRLP4 64
INDIRI4
CNSTI4 1
EQI4 $304
ADDRLP4 64
INDIRI4
CNSTI4 2
EQI4 $305
ADDRGP4 $301
JUMPV
LABELV $303
line 648
;647:		case 0:
;648:			anim = BOTH_DEATH1;
ADDRLP4 24
CNSTI4 0
ASGNI4
line 649
;649:			break;
ADDRGP4 $302
JUMPV
LABELV $304
line 651
;650:		case 1:
;651:			anim = BOTH_DEATH2;
ADDRLP4 24
CNSTI4 2
ASGNI4
line 652
;652:			break;
ADDRGP4 $302
JUMPV
LABELV $305
LABELV $301
line 655
;653:		case 2:
;654:		default:
;655:			anim = BOTH_DEATH3;
ADDRLP4 24
CNSTI4 4
ASGNI4
line 656
;656:			break;
LABELV $302
line 661
;657:		}
;658:
;659:		// for the no-blood option, we need to prevent the health
;660:		// from going to gib level
;661:		if ( self->health <= GIB_HEALTH ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 -40
GTI4 $306
line 662
;662:			self->health = GIB_HEALTH+1;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTI4 -39
ASGNI4
line 663
;663:		}
LABELV $306
line 665
;664:
;665:		self->client->ps.legsAnim = 
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 128
BXORI4
ADDRLP4 24
INDIRI4
BORI4
ASGNI4
line 667
;666:			( ( self->client->ps.legsAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT ) | anim;
;667:		self->client->ps.torsoAnim = 
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 128
BXORI4
ADDRLP4 24
INDIRI4
BORI4
ASGNI4
line 670
;668:			( ( self->client->ps.torsoAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT ) | anim;
;669:
;670:		G_AddEvent( self, EV_DEATH1 + i, killer );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $300
INDIRI4
CNSTI4 57
ADDI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 673
;671:
;672:		// the body can still be gibbed
;673:		self->die = body_die;
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 body_die
ASGNP4
line 676
;674:
;675:		// globally cycle through the different death animations
;676:		i = ( i + 1 ) % 3;
ADDRLP4 76
ADDRGP4 $300
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 3
MODI4
ASGNI4
line 679
;677:
;678:#ifdef MISSIONPACK
;679:		if (self->s.eFlags & EF_KAMIKAZE) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $308
line 680
;680:			Kamikaze_DeathTimer( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Kamikaze_DeathTimer
CALLV
pop
line 681
;681:		}
LABELV $308
line 683
;682:#endif
;683:	}
LABELV $295
line 685
;684:
;685:	trap_LinkEntity (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 687
;686:
;687:}
LABELV $226
endproc player_die 84 28
export CheckArmor
proc CheckArmor 20 4
line 696
;688:
;689:
;690:/*
;691:================
;692:CheckArmor
;693:================
;694:*/
;695:int CheckArmor (gentity_t *ent, int damage, int dflags)
;696:{
line 701
;697:	gclient_t	*client;
;698:	int			save;
;699:	int			count;
;700:
;701:	if (!damage)
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $311
line 702
;702:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $310
JUMPV
LABELV $311
line 704
;703:
;704:	client = ent->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 706
;705:
;706:	if (!client)
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $313
line 707
;707:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $310
JUMPV
LABELV $313
line 709
;708:
;709:	if (dflags & DAMAGE_NO_ARMOR)
ADDRFP4 8
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $315
line 710
;710:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $310
JUMPV
LABELV $315
line 713
;711:
;712:	// armor
;713:	count = client->ps.stats[STAT_ARMOR];
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ASGNI4
line 714
;714:	save = ceil( damage * ARMOR_PROTECTION );
ADDRFP4 4
INDIRI4
CVIF4 4
CNSTF4 1059648963
MULF4
ARGF4
ADDRLP4 12
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 715
;715:	if (save >= count)
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $317
line 716
;716:		save = count;
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
LABELV $317
line 718
;717:
;718:	if (!save)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $319
line 719
;719:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $310
JUMPV
LABELV $319
line 721
;720:
;721:	client->ps.stats[STAT_ARMOR] -= save;
ADDRLP4 16
ADDRLP4 4
INDIRP4
CNSTI4 200
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ASGNI4
line 723
;722:
;723:	return save;
ADDRLP4 0
INDIRI4
RETI4
LABELV $310
endproc CheckArmor 20 4
export RaySphereIntersections
proc RaySphereIntersections 56 4
line 731
;724:}
;725:
;726:/*
;727:================
;728:RaySphereIntersections
;729:================
;730:*/
;731:int RaySphereIntersections( vec3_t origin, float radius, vec3_t point, vec3_t dir, vec3_t intersections[2] ) {
line 740
;732:	float b, c, d, t;
;733:
;734:	//	| origin - (point + t * dir) | = radius
;735:	//	a = dir[0]^2 + dir[1]^2 + dir[2]^2;
;736:	//	b = 2 * (dir[0] * (point[0] - origin[0]) + dir[1] * (point[1] - origin[1]) + dir[2] * (point[2] - origin[2]));
;737:	//	c = (point[0] - origin[0])^2 + (point[1] - origin[1])^2 + (point[2] - origin[2])^2 - radius^2;
;738:
;739:	// normalize dir so a = 1
;740:	VectorNormalize(dir);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 741
;741:	b = 2 * (dir[0] * (point[0] - origin[0]) + dir[1] * (point[1] - origin[1]) + dir[2] * (point[2] - origin[2]));
ADDRLP4 16
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 20
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
INDIRF4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 24
INDIRP4
INDIRF4
SUBF4
MULF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
CNSTF4 1073741824
MULF4
ASGNF4
line 742
;742:	c = (point[0] - origin[0]) * (point[0] - origin[0]) +
ADDRLP4 28
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 40
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 36
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ADDRLP4 28
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ADDRLP4 28
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ADDRLP4 40
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
SUBF4
ASGNF4
line 747
;743:		(point[1] - origin[1]) * (point[1] - origin[1]) +
;744:		(point[2] - origin[2]) * (point[2] - origin[2]) -
;745:		radius * radius;
;746:
;747:	d = b * b - 4 * c;
ADDRLP4 8
ADDRLP4 4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDRLP4 12
INDIRF4
CNSTF4 1082130432
MULF4
SUBF4
ASGNF4
line 748
;748:	if (d > 0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
LEF4 $322
line 749
;749:		t = (- b + sqrt(d)) / 2;
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
NEGF4
ADDRLP4 48
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ASGNF4
line 750
;750:		VectorMA(point, t, dir, intersections[0]);
ADDRFP4 16
INDIRP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRFP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 751
;751:		t = (- b - sqrt(d)) / 2;
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 52
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
NEGF4
ADDRLP4 52
INDIRF4
SUBF4
CNSTF4 1056964608
MULF4
ASGNF4
line 752
;752:		VectorMA(point, t, dir, intersections[1]);
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRFP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 753
;753:		return 2;
CNSTI4 2
RETI4
ADDRGP4 $321
JUMPV
LABELV $322
line 755
;754:	}
;755:	else if (d == 0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
NEF4 $324
line 756
;756:		t = (- b ) / 2;
ADDRLP4 0
ADDRLP4 4
INDIRF4
NEGF4
CNSTF4 1056964608
MULF4
ASGNF4
line 757
;757:		VectorMA(point, t, dir, intersections[0]);
ADDRFP4 16
INDIRP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRFP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 758
;758:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $321
JUMPV
LABELV $324
line 760
;759:	}
;760:	return 0;
CNSTI4 0
RETI4
LABELV $321
endproc RaySphereIntersections 56 4
export G_InvulnerabilityEffect
proc G_InvulnerabilityEffect 64 20
line 769
;761:}
;762:
;763:#ifdef MISSIONPACK
;764:/*
;765:================
;766:G_InvulnerabilityEffect
;767:================
;768:*/
;769:int G_InvulnerabilityEffect( gentity_t *targ, vec3_t dir, vec3_t point, vec3_t impactpoint, vec3_t bouncedir ) {
line 774
;770:	gentity_t	*impact;
;771:	vec3_t		intersections[2], vec;
;772:	int			n;
;773:
;774:	if ( !targ->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $327
line 775
;775:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $326
JUMPV
LABELV $327
line 777
;776:	}
;777:	VectorCopy(dir, vec);
ADDRLP4 0
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 778
;778:	VectorInverse(vec);
ADDRLP4 0
ARGP4
ADDRGP4 VectorInverse
CALLV
pop
line 780
;779:	// sphere model radius = 42 units
;780:	n = RaySphereIntersections( targ->client->ps.origin, 42, point, vec, intersections);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTF4 1109917696
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 44
ADDRGP4 RaySphereIntersections
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 44
INDIRI4
ASGNI4
line 781
;781:	if (n > 0) {
ADDRLP4 40
INDIRI4
CNSTI4 0
LEI4 $329
line 782
;782:		impact = G_TempEntity( targ->client->ps.origin, EV_INVUL_IMPACT );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 71
ARGI4
ADDRLP4 48
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 36
ADDRLP4 48
INDIRP4
ASGNP4
line 783
;783:		VectorSubtract(intersections[0], targ->client->ps.origin, vec);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 12+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
line 784
;784:		vectoangles(vec, impact->s.angles);
ADDRLP4 0
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 785
;785:		impact->s.angles[0] += 90;
ADDRLP4 56
ADDRLP4 36
INDIRP4
CNSTI4 116
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
CNSTF4 1119092736
ADDF4
ASGNF4
line 786
;786:		if (impact->s.angles[0] > 360)
ADDRLP4 36
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
CNSTF4 1135869952
LEF4 $335
line 787
;787:			impact->s.angles[0] -= 360;
ADDRLP4 60
ADDRLP4 36
INDIRP4
CNSTI4 116
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $335
line 788
;788:		if ( impactpoint ) {
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $337
line 789
;789:			VectorCopy( intersections[0], impactpoint );
ADDRFP4 12
INDIRP4
ADDRLP4 12
INDIRB
ASGNB 12
line 790
;790:		}
LABELV $337
line 791
;791:		if ( bouncedir ) {
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $339
line 792
;792:			VectorCopy( vec, bouncedir );
ADDRFP4 16
INDIRP4
ADDRLP4 0
INDIRB
ASGNB 12
line 793
;793:			VectorNormalize( bouncedir );
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 794
;794:		}
LABELV $339
line 795
;795:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $326
JUMPV
LABELV $329
line 797
;796:	}
;797:	else {
line 798
;798:		return qfalse;
CNSTI4 0
RETI4
LABELV $326
endproc G_InvulnerabilityEffect 64 20
export G_Damage
proc G_Damage 100 24
line 827
;799:	}
;800:}
;801:#endif
;802:/*
;803:============
;804:G_Damage
;805:
;806:targ		entity that is being damaged
;807:inflictor	entity that is causing the damage
;808:attacker	entity that caused the inflictor to damage targ
;809:	example: targ=monster, inflictor=rocket, attacker=player
;810:
;811:dir			direction of the attack for knockback
;812:point		point at which the damage is being inflicted, used for headshots
;813:damage		amount of damage being inflicted
;814:knockback	force to be applied against targ as a result of the damage
;815:
;816:inflictor, attacker, dir, and point can be NULL for environmental effects
;817:
;818:dflags		these flags are used to control how T_Damage works
;819:	DAMAGE_RADIUS			damage was indirect (from a nearby explosion)
;820:	DAMAGE_NO_ARMOR			armor does not protect from this damage
;821:	DAMAGE_NO_KNOCKBACK		do not affect velocity, just view angles
;822:	DAMAGE_NO_PROTECTION	kills godmode, armor, everything
;823:============
;824:*/
;825:
;826:void G_Damage( gentity_t *targ, gentity_t *inflictor, gentity_t *attacker,
;827:			   vec3_t dir, vec3_t point, int damage, int dflags, int mod ) {
line 837
;828:	gclient_t	*client;
;829:	int			take;
;830:	int			asave;
;831:	int			knockback;
;832:	int			max;
;833:#ifdef MISSIONPACK
;834:	vec3_t		bouncedir, impactpoint;
;835:#endif
;836:
;837:	if (!targ->takedamage) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
NEI4 $342
line 838
;838:		return;
ADDRGP4 $341
JUMPV
LABELV $342
line 843
;839:	}
;840:
;841:	// the intermission has allready been qualified for, so don't
;842:	// allow any extra scoring
;843:	if ( level.intermissionQueued ) {
ADDRGP4 level+7600
INDIRI4
CNSTI4 0
EQI4 $344
line 844
;844:		return;
ADDRGP4 $341
JUMPV
LABELV $344
line 847
;845:	}
;846:#ifdef MISSIONPACK
;847:	if ( targ->client && mod != MOD_JUICED) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $347
ADDRFP4 28
INDIRI4
CNSTI4 27
EQI4 $347
line 848
;848:		if ( targ->client->invulnerabilityTime > level.time) {
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
LEI4 $349
line 849
;849:			if ( dir && point ) {
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $341
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $341
line 850
;850:				G_InvulnerabilityEffect( targ, dir, point, impactpoint, bouncedir );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 G_InvulnerabilityEffect
CALLI4
pop
line 851
;851:			}
line 852
;852:			return;
ADDRGP4 $341
JUMPV
LABELV $349
line 854
;853:		}
;854:	}
LABELV $347
line 856
;855:#endif
;856:	if ( !inflictor ) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $354
line 857
;857:		inflictor = &g_entities[ENTITYNUM_WORLD];
ADDRFP4 4
ADDRGP4 g_entities+842128
ASGNP4
line 858
;858:	}
LABELV $354
line 859
;859:	if ( !attacker ) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $357
line 860
;860:		attacker = &g_entities[ENTITYNUM_WORLD];
ADDRFP4 8
ADDRGP4 g_entities+842128
ASGNP4
line 861
;861:	}
LABELV $357
line 864
;862:
;863:	// shootable doors / buttons don't actually have any health
;864:	if ( targ->s.eType == ET_MOVER ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 4
NEI4 $360
line 865
;865:		if ( targ->use && targ->moverState == MOVER_POS1 ) {
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $341
ADDRLP4 44
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 0
NEI4 $341
line 866
;866:			targ->use( targ, inflictor, attacker );
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CALLV
pop
line 867
;867:		}
line 868
;868:		return;
ADDRGP4 $341
JUMPV
LABELV $360
line 871
;869:	}
;870:#ifdef MISSIONPACK
;871:	if( g_gametype.integer == GT_OBELISK && CheckObeliskAttack( targ, attacker ) ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 6
NEI4 $364
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 CheckObeliskAttack
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $364
line 872
;872:		return;
ADDRGP4 $341
JUMPV
LABELV $364
line 877
;873:	}
;874:#endif
;875:	// reduce damage by the attacker's handicap value
;876:	// unless they are rocket jumping
;877:	if ( attacker->client && attacker != targ ) {
ADDRLP4 48
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $367
ADDRLP4 48
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $367
line 878
;878:		max = attacker->client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 16
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ASGNI4
line 880
;879:#ifdef MISSIONPACK
;880:		if( bg_itemlist[attacker->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
ADDRFP4 8
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
NEI4 $369
line 881
;881:			max /= 2;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 2
DIVI4
ASGNI4
line 882
;882:		}
LABELV $369
line 884
;883:#endif
;884:		damage = damage * max / 100;
ADDRFP4 20
ADDRFP4 20
INDIRI4
ADDRLP4 16
INDIRI4
MULI4
CNSTI4 100
DIVI4
ASGNI4
line 885
;885:	}
LABELV $367
line 887
;886:
;887:	client = targ->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 889
;888:
;889:	if ( client ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $372
line 890
;890:		if ( client->noclip ) {
ADDRLP4 0
INDIRP4
CNSTI4 656
ADDP4
INDIRI4
CNSTI4 0
EQI4 $374
line 891
;891:			return;
ADDRGP4 $341
JUMPV
LABELV $374
line 893
;892:		}
;893:	}
LABELV $372
line 895
;894:
;895:	if ( !dir ) {
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $376
line 896
;896:		dflags |= DAMAGE_NO_KNOCKBACK;
ADDRFP4 24
ADDRFP4 24
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 897
;897:	} else {
ADDRGP4 $377
JUMPV
LABELV $376
line 898
;898:		VectorNormalize(dir);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 899
;899:	}
LABELV $377
line 901
;900:
;901:	knockback = damage;
ADDRLP4 4
ADDRFP4 20
INDIRI4
ASGNI4
line 902
;902:	if ( knockback > 200 ) {
ADDRLP4 4
INDIRI4
CNSTI4 200
LEI4 $378
line 903
;903:		knockback = 200;
ADDRLP4 4
CNSTI4 200
ASGNI4
line 904
;904:	}
LABELV $378
line 905
;905:	if ( targ->flags & FL_NO_KNOCKBACK ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $380
line 906
;906:		knockback = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 907
;907:	}
LABELV $380
line 908
;908:	if ( dflags & DAMAGE_NO_KNOCKBACK ) {
ADDRFP4 24
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $382
line 909
;909:		knockback = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 910
;910:	}
LABELV $382
line 913
;911:
;912:	// figure momentum add, even if the damage won't be taken
;913:	if ( knockback && targ->client ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $384
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $384
line 917
;914:		vec3_t	kvel;
;915:		float	mass;
;916:
;917:		mass = 200;
ADDRLP4 64
CNSTF4 1128792064
ASGNF4
line 919
;918:
;919:		if (targ != attacker) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
EQU4 $386
line 920
;920:			if (g_instagib.integer) {
ADDRGP4 g_instagib+12
INDIRI4
CNSTI4 0
EQI4 $388
line 921
;921:				switch (mod) {
ADDRLP4 68
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 2
EQI4 $393
ADDRLP4 68
INDIRI4
CNSTI4 2
LTI4 $391
LABELV $394
ADDRFP4 28
INDIRI4
CNSTI4 10
EQI4 $393
ADDRGP4 $391
JUMPV
LABELV $393
line 924
;922:					case MOD_GAUNTLET:
;923:					case MOD_RAILGUN:
;924:						damage = INFINITE;
ADDRFP4 20
CNSTI4 1000000
ASGNI4
line 925
;925:				}
LABELV $391
line 926
;926:			}
LABELV $388
line 927
;927:		}
LABELV $386
line 929
;928:
;929:		VectorScale (dir, g_knockback.value * (float)knockback / mass, kvel);
ADDRLP4 68
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 4
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 76
ADDRLP4 64
INDIRF4
ASGNF4
ADDRLP4 52
ADDRLP4 68
INDIRP4
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 72
INDIRF4
MULF4
ADDRLP4 76
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 52+4
ADDRLP4 68
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 72
INDIRF4
MULF4
ADDRLP4 76
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 52+8
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
MULF4
ADDRLP4 64
INDIRF4
DIVF4
MULF4
ASGNF4
line 930
;930:		VectorAdd (targ->client->ps.velocity, kvel, targ->client->ps.velocity);
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 80
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 52
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 84
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 52+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 88
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 52+8
INDIRF4
ADDF4
ASGNF4
line 934
;931:
;932:		// set the timer so that the other client can't cancel
;933:		// out the movement immediately
;934:		if ( !targ->client->ps.pm_time ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
NEI4 $402
line 937
;935:			int		t;
;936:
;937:			t = knockback * 2;
ADDRLP4 92
ADDRLP4 4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 938
;938:			if ( t < 50 ) {
ADDRLP4 92
INDIRI4
CNSTI4 50
GEI4 $404
line 939
;939:				t = 50;
ADDRLP4 92
CNSTI4 50
ASGNI4
line 940
;940:			}
LABELV $404
line 941
;941:			if ( t > 200 ) {
ADDRLP4 92
INDIRI4
CNSTI4 200
LEI4 $406
line 942
;942:				t = 200;
ADDRLP4 92
CNSTI4 200
ASGNI4
line 943
;943:			}
LABELV $406
line 944
;944:			targ->client->ps.pm_time = t;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 92
INDIRI4
ASGNI4
line 945
;945:			targ->client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
ADDRLP4 96
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 946
;946:		}
LABELV $402
line 947
;947:	}
LABELV $384
line 950
;948:
;949:	// check for completely getting out of the damage
;950:	if ( !(dflags & DAMAGE_NO_PROTECTION) ) {
ADDRFP4 24
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $408
line 955
;951:
;952:		// if TF_NO_FRIENDLY_FIRE is set, don't do damage to the target
;953:		// if the attacker was on the same team
;954:#ifdef MISSIONPACK
;955:		if ( mod != MOD_JUICED && targ != attacker && !(dflags & DAMAGE_NO_TEAM_PROTECTION) && OnSameTeam (targ, attacker)  ) {
ADDRFP4 28
INDIRI4
CNSTI4 27
EQI4 $410
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CVPU4 4
ADDRLP4 56
INDIRP4
CVPU4 4
EQU4 $410
ADDRFP4 24
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $410
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $410
line 959
;956:#else	
;957:		if ( targ != attacker && OnSameTeam (targ, attacker)  ) {
;958:#endif
;959:			if ( !g_friendlyFire.integer ) {
ADDRGP4 g_friendlyFire+12
INDIRI4
CNSTI4 0
NEI4 $412
line 960
;960:				return;
ADDRGP4 $341
JUMPV
LABELV $412
line 962
;961:			}
;962:		}
LABELV $410
line 964
;963:#ifdef MISSIONPACK
;964:		if (mod == MOD_PROXIMITY_MINE) {
ADDRFP4 28
INDIRI4
CNSTI4 25
NEI4 $415
line 965
;965:			if (inflictor && inflictor->parent && OnSameTeam(targ, inflictor->parent)) {
ADDRLP4 64
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $417
ADDRLP4 64
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $417
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $417
line 966
;966:				return;
ADDRGP4 $341
JUMPV
LABELV $417
line 968
;967:			}
;968:			if (targ == attacker) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
NEU4 $419
line 969
;969:				return;
ADDRGP4 $341
JUMPV
LABELV $419
line 971
;970:			}
;971:		}
LABELV $415
line 975
;972:#endif
;973:
;974:		// check for godmode
;975:		if ( targ->flags & FL_GODMODE ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $421
line 976
;976:			return;
ADDRGP4 $341
JUMPV
LABELV $421
line 980
;977:		}
;978:
;979:#ifdef MISSIONPACK
;980:        if ( targ == attacker && g_noSelfDamage.integer && mod != MOD_KAMIKAZE )
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
NEU4 $423
ADDRGP4 g_noSelfDamage+12
INDIRI4
CNSTI4 0
EQI4 $423
ADDRFP4 28
INDIRI4
CNSTI4 26
EQI4 $423
line 981
;981:            return;
ADDRGP4 $341
JUMPV
LABELV $423
line 986
;982:#else
;983:        if ( targ == attacker && g_noSelfDamage.integer )
;984:            return;
;985:#endif
;986:	}
LABELV $408
line 990
;987:
;988:	// battlesuit protects from all radius damage (but takes knockback)
;989:	// and protects 50% against all damage
;990:	if ( client && client->ps.powerups[PW_BATTLESUIT] ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $426
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
INDIRI4
CNSTI4 0
EQI4 $426
line 991
;991:		G_AddEvent( targ, EV_POWERUP_BATTLESUIT, 0 );
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
line 992
;992:		if ( ( dflags & DAMAGE_RADIUS ) || ( mod == MOD_FALLING ) ) {
ADDRFP4 24
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $430
ADDRFP4 28
INDIRI4
CNSTI4 19
NEI4 $428
LABELV $430
line 993
;993:			return;
ADDRGP4 $341
JUMPV
LABELV $428
line 995
;994:		}
;995:		damage *= 0.5;
ADDRFP4 20
ADDRFP4 20
INDIRI4
CVIF4 4
CNSTF4 1056964608
MULF4
CVFI4 4
ASGNI4
line 996
;996:	}
LABELV $426
line 1000
;997:
;998:	// always give half damage if hurting self
;999:	// calculated after knockback, so rocket jumping works
;1000:	if ( targ == attacker) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
NEU4 $431
line 1001
;1001:		damage *= 0.5;
ADDRFP4 20
ADDRFP4 20
INDIRI4
CVIF4 4
CNSTF4 1056964608
MULF4
CVFI4 4
ASGNI4
line 1002
;1002:	}
LABELV $431
line 1004
;1003:
;1004:	if ( damage < 1 ) {
ADDRFP4 20
INDIRI4
CNSTI4 1
GEI4 $433
line 1005
;1005:		damage = 1;
ADDRFP4 20
CNSTI4 1
ASGNI4
line 1006
;1006:	}
LABELV $433
line 1007
;1007:	take = damage;
ADDRLP4 8
ADDRFP4 20
INDIRI4
ASGNI4
line 1010
;1008:
;1009:    // save some from armor
;1010:    asave = CheckArmor( targ, take, dflags );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 CheckArmor
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 56
INDIRI4
ASGNI4
line 1011
;1011:    take -= asave;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
SUBI4
ASGNI4
line 1013
;1012:
;1013:	if ( g_debugDamage.integer ) {
ADDRGP4 g_debugDamage+12
INDIRI4
CNSTI4 0
EQI4 $435
line 1014
;1014:		G_Printf( "%i: client:%i health:%i damage:%i armor:%i\n", level.time, targ->s.number,
ADDRGP4 $438
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 1016
;1015:			targ->health, take, asave );
;1016:	}
LABELV $435
line 1019
;1017:
;1018:	// add to the attacker's hit counter (if the target isn't a general entity like a prox mine)
;1019:	if ( attacker->client && client && targ != attacker && targ->health > 0
ADDRLP4 60
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $440
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $440
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CVPU4 4
ADDRLP4 60
INDIRP4
CVPU4 4
EQU4 $440
ADDRLP4 64
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
LEI4 $440
ADDRLP4 64
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
EQI4 $440
ADDRLP4 64
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $440
line 1021
;1020:			&& targ->s.eType != ET_MISSILE
;1021:			&& targ->s.eType != ET_GENERAL) {
line 1023
;1022:#ifdef MISSIONPACK
;1023:		if ( OnSameTeam( targ, attacker ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $442
line 1024
;1024:			attacker->client->ps.persistant[PERS_HITS]--;
ADDRLP4 72
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 252
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1025
;1025:		} else {
ADDRGP4 $443
JUMPV
LABELV $442
line 1026
;1026:			attacker->client->ps.persistant[PERS_HITS]++;
ADDRLP4 72
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 252
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1027
;1027:		}
LABELV $443
line 1028
;1028:		attacker->client->ps.persistant[PERS_ATTACKEE_ARMOR] = (targ->health<<8)|(client->ps.stats[STAT_ARMOR]);
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 276
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 8
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
BORI4
ASGNI4
line 1040
;1029:#else
;1030:		// we may hit multiple targets from different teams
;1031:		// so usual PERS_HITS increments/decrements could result in ZERO delta
;1032:		if ( OnSameTeam( targ, attacker ) ) {
;1033:			attacker->client->damage.team++;
;1034:		} else {
;1035:			attacker->client->damage.enemy++;
;1036:			// accumulate damage during server frame
;1037:			attacker->client->damage.amount += take + asave;
;1038:		}
;1039:#endif
;1040:	}
LABELV $440
line 1045
;1041:
;1042:	// add to the damage inflicted on a player this frame
;1043:	// the total will be turned into screen blends and view angle kicks
;1044:	// at the end of the frame
;1045:	if ( client ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $444
line 1046
;1046:		if ( attacker ) { // FIXME: always true?
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $446
line 1047
;1047:			client->ps.persistant[PERS_ATTACKER] = attacker->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 1048
;1048:		} else {
ADDRGP4 $447
JUMPV
LABELV $446
line 1049
;1049:			client->ps.persistant[PERS_ATTACKER] = ENTITYNUM_WORLD;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
CNSTI4 1022
ASGNI4
line 1050
;1050:		}
LABELV $447
line 1051
;1051:		client->damage_armor += asave;
ADDRLP4 68
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
ADDI4
ASGNI4
line 1052
;1052:		client->damage_blood += take;
ADDRLP4 72
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 1053
;1053:		client->damage_knockback += knockback;
ADDRLP4 76
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1054
;1054:		if ( dir ) {
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $448
line 1055
;1055:			VectorCopy ( dir, client->damage_from );
ADDRLP4 0
INDIRP4
CNSTI4 700
ADDP4
ADDRFP4 12
INDIRP4
INDIRB
ASGNB 12
line 1056
;1056:			client->damage_fromWorld = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 712
ADDP4
CNSTI4 0
ASGNI4
line 1057
;1057:		} else {
ADDRGP4 $449
JUMPV
LABELV $448
line 1058
;1058:			VectorCopy ( targ->r.currentOrigin, client->damage_from );
ADDRLP4 0
INDIRP4
CNSTI4 700
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 1059
;1059:			client->damage_fromWorld = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 712
ADDP4
CNSTI4 1
ASGNI4
line 1060
;1060:		}
LABELV $449
line 1061
;1061:	}
LABELV $444
line 1065
;1062:
;1063:	// See if it's the player hurting the emeny flag carrier
;1064:#ifdef MISSIONPACK
;1065:	if( g_gametype.integer == GT_CTF || g_gametype.integer == GT_1FCTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
EQI4 $454
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
NEI4 $450
LABELV $454
line 1069
;1066:#else
;1067:	if( g_gametype.integer == GT_CTF) {
;1068:#endif
;1069:		Team_CheckHurtCarrier(targ, attacker);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Team_CheckHurtCarrier
CALLV
pop
line 1070
;1070:	}
LABELV $450
line 1072
;1071:
;1072:	if (targ->client) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $455
line 1074
;1073:		// set the last client who damaged the target
;1074:		targ->client->lasthurt_client = attacker->s.number;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 732
ADDP4
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 1075
;1075:		targ->client->lasthurt_mod = mod;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 736
ADDP4
ADDRFP4 28
INDIRI4
ASGNI4
line 1076
;1076:	}
LABELV $455
line 1079
;1077:
;1078:	// do the damage
;1079:	if (take) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $457
line 1080
;1080:		targ->health = targ->health - take;
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1081
;1081:		if ( targ->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $459
line 1082
;1082:			targ->client->ps.stats[STAT_HEALTH] = targ->health;
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ASGNI4
line 1083
;1083:		}
LABELV $459
line 1085
;1084:			
;1085:		if ( targ->health <= 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
GTI4 $461
line 1086
;1086:			if ( client )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $463
line 1087
;1087:				targ->flags |= FL_NO_KNOCKBACK;
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
LABELV $463
line 1089
;1088:
;1089:			if (targ->health < -999)
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 -999
GEI4 $465
line 1090
;1090:				targ->health = -999;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTI4 -999
ASGNI4
LABELV $465
line 1092
;1091:
;1092:			targ->enemy = attacker;
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
ADDRFP4 8
INDIRP4
ASGNP4
line 1093
;1093:			targ->die (targ, inflictor, attacker, take, mod);
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRFP4 28
INDIRI4
ARGI4
ADDRLP4 76
INDIRP4
CNSTI4 716
ADDP4
INDIRP4
CALLV
pop
line 1094
;1094:			return;
ADDRGP4 $341
JUMPV
LABELV $461
line 1095
;1095:		} else if ( targ->pain ) {
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $467
line 1096
;1096:			targ->pain (targ, attacker, take);
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 712
ADDP4
INDIRP4
CALLV
pop
line 1097
;1097:		}
LABELV $467
line 1098
;1098:	}
LABELV $457
line 1100
;1099:
;1100:}
LABELV $341
endproc G_Damage 100 24
export CanDamage
proc CanDamage 144 28
line 1112
;1101:
;1102:
;1103:/*
;1104:============
;1105:CanDamage
;1106:
;1107:Returns qtrue if the inflictor can directly damage the target.  Used for
;1108:explosions and melee attacks.
;1109:============
;1110:*/
;1111:qboolean CanDamage( gentity_t *targ, vec3_t origin )
;1112:{
line 1120
;1113:	//we check if the attacker can damage the target, return qtrue if yes, qfalse if no
;1114:	vec3_t	dest;
;1115:	trace_t	tr;
;1116:	vec3_t	midpoint;
;1117:	vec3_t				size;
;1118:
;1119:	// use the midpoint of the bounds instead of the origin, because bmodels may have their origin 0,0,0
;1120:	VectorAdd (targ->r.absmin, targ->r.absmax, midpoint);
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
ADDRLP4 92
INDIRP4
CNSTI4 464
ADDP4
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 80+4
ADDRLP4 92
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80+8
ADDRLP4 96
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ADDRLP4 96
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1121
;1121:	VectorScale( midpoint, 0.5, dest );
ADDRLP4 0
ADDRLP4 80
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 80+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 80+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 1123
;1122:
;1123:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1124
;1124:	if (tr.fraction == 1.0 || tr.entityNum == targ->s.number)
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
EQF4 $480
ADDRLP4 12+52
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
NEI4 $476
LABELV $480
line 1125
;1125:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $469
JUMPV
LABELV $476
line 1127
;1126:
;1127:	VectorSubtract( targ->r.absmax, targ->r.absmin, size );
ADDRLP4 104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
ADDRLP4 104
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
ADDRLP4 104
INDIRP4
CNSTI4 464
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 104
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ADDRLP4 104
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68+8
ADDRLP4 108
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDRLP4 108
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1133
;1128:	
;1129:	// top quad
;1130:
;1131:	// - +
;1132:	// - -
;1133:	VectorCopy( targ->r.absmax, dest );
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRB
ASGNB 12
line 1134
;1134:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 112
INDIRP4
ARGP4
ADDRLP4 112
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1135
;1135:	if (tr.fraction == 1.0)
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $483
line 1136
;1136:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $469
JUMPV
LABELV $483
line 1140
;1137:
;1138:	// + -
;1139:	// - -
;1140:	dest[0] -= size[0];
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 68
INDIRF4
SUBF4
ASGNF4
line 1141
;1141:	trap_Trace( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID );
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 116
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1142
;1142:	if ( tr.fraction == 1.0 )
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $486
line 1143
;1143:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $469
JUMPV
LABELV $486
line 1147
;1144:
;1145:	// - -
;1146:	// + -
;1147:	dest[1] -= size[1];
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 68+4
INDIRF4
SUBF4
ASGNF4
line 1148
;1148:	trap_Trace( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID );
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 120
INDIRP4
ARGP4
ADDRLP4 120
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1149
;1149:	if ( tr.fraction == 1.0 )
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $491
line 1150
;1150:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $469
JUMPV
LABELV $491
line 1154
;1151:
;1152:	// - -
;1153:	// - +
;1154:	dest[0] += size[0];
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 68
INDIRF4
ADDF4
ASGNF4
line 1155
;1155:	trap_Trace( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID );
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 124
INDIRP4
ARGP4
ADDRLP4 124
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1156
;1156:	if ( tr.fraction == 1.0 )
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $494
line 1157
;1157:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $469
JUMPV
LABELV $494
line 1163
;1158:
;1159:	// bottom quad
;1160:
;1161:	// - -
;1162:	// + -
;1163:	VectorCopy( targ->r.absmin, dest );
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
INDIRB
ASGNB 12
line 1164
;1164:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1165
;1165:	if (tr.fraction == 1.0)
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $497
line 1166
;1166:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $469
JUMPV
LABELV $497
line 1170
;1167:
;1168:	// - -
;1169:	// - +
;1170:	dest[0] += size[0];
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 68
INDIRF4
ADDF4
ASGNF4
line 1171
;1171:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 132
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1172
;1172:	if (tr.fraction == 1.0)
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $500
line 1173
;1173:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $469
JUMPV
LABELV $500
line 1177
;1174:
;1175:	// - +
;1176:	// - -
;1177:	dest[1] += size[1];
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 68+4
INDIRF4
ADDF4
ASGNF4
line 1178
;1178:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 136
INDIRP4
ARGP4
ADDRLP4 136
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1179
;1179:	if (tr.fraction == 1.0)
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $505
line 1180
;1180:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $469
JUMPV
LABELV $505
line 1184
;1181:
;1182:	// + -
;1183:	// - -
;1184:	dest[0] -= size[0];
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 68
INDIRF4
SUBF4
ASGNF4
line 1185
;1185:	trap_Trace( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID );
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 140
INDIRP4
ARGP4
ADDRLP4 140
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1186
;1186:	if ( tr.fraction == 1.0 )
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $508
line 1187
;1187:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $469
JUMPV
LABELV $508
line 1189
;1188:
;1189:	return qfalse;
CNSTI4 0
RETI4
LABELV $469
endproc CanDamage 144 28
export G_RadiusDamage
proc G_RadiusDamage 4196 32
line 1199
;1190:}
;1191:
;1192:
;1193:/*
;1194:============
;1195:G_RadiusDamage
;1196:============
;1197:*/
;1198:qboolean G_RadiusDamage ( vec3_t origin, gentity_t *attacker, float damage, float radius,
;1199:					 gentity_t *ignore, int mod) {
line 1208
;1200:	float		points, dist;
;1201:	gentity_t	*ent;
;1202:	int			entityList[MAX_GENTITIES];
;1203:	int			numListedEntities;
;1204:	vec3_t		mins, maxs;
;1205:	vec3_t		v;
;1206:	vec3_t		dir;
;1207:	int			i, e;
;1208:	qboolean	hitClient = qfalse;
ADDRLP4 4168
CNSTI4 0
ASGNI4
line 1210
;1209:
;1210:	if ( radius < 1 ) {
ADDRFP4 12
INDIRF4
CNSTF4 1065353216
GEF4 $512
line 1211
;1211:		radius = 1;
ADDRFP4 12
CNSTF4 1065353216
ASGNF4
line 1212
;1212:	}
LABELV $512
line 1214
;1213:
;1214:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $514
line 1215
;1215:		mins[i] = origin[i] - radius;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4144
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
SUBF4
ASGNF4
line 1216
;1216:		maxs[i] = origin[i] + radius;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4156
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
ADDF4
ASGNF4
line 1217
;1217:	}
LABELV $515
line 1214
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $514
line 1219
;1218:
;1219:	numListedEntities = trap_EntitiesInBox( mins, maxs, entityList, MAX_GENTITIES );
ADDRLP4 4144
ARGP4
ADDRLP4 4156
ARGP4
ADDRLP4 44
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4172
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 4140
ADDRLP4 4172
INDIRI4
ASGNI4
line 1221
;1220:
;1221:	for ( e = 0 ; e < numListedEntities ; e++ ) {
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 $521
JUMPV
LABELV $518
line 1222
;1222:		ent = &g_entities[entityList[ e ]];
ADDRLP4 4
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 44
ADDP4
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1224
;1223:
;1224:		if (ent == ignore)
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRFP4 16
INDIRP4
CVPU4 4
NEU4 $522
line 1225
;1225:			continue;
ADDRGP4 $519
JUMPV
LABELV $522
line 1226
;1226:		if (!ent->takedamage)
ADDRLP4 4
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
NEI4 $524
line 1227
;1227:			continue;
ADDRGP4 $519
JUMPV
LABELV $524
line 1230
;1228:
;1229:		// find the distance from the edge of the bounding box
;1230:		for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $526
line 1231
;1231:			if ( origin[i] < ent->r.absmin[i] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
GEF4 $530
line 1232
;1232:				v[i] = ent->r.absmin[i] - origin[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1233
;1233:			} else if ( origin[i] > ent->r.absmax[i] ) {
ADDRGP4 $531
JUMPV
LABELV $530
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
LEF4 $532
line 1234
;1234:				v[i] = origin[i] - ent->r.absmax[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1235
;1235:			} else {
ADDRGP4 $533
JUMPV
LABELV $532
line 1236
;1236:				v[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
CNSTF4 0
ASGNF4
line 1237
;1237:			}
LABELV $533
LABELV $531
line 1238
;1238:		}
LABELV $527
line 1230
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $526
line 1240
;1239:
;1240:		dist = VectorLength( v );
ADDRLP4 8
ARGP4
ADDRLP4 4176
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 4176
INDIRF4
ASGNF4
line 1241
;1241:		if ( dist >= radius ) {
ADDRLP4 24
INDIRF4
ADDRFP4 12
INDIRF4
LTF4 $534
line 1242
;1242:			continue;
ADDRGP4 $519
JUMPV
LABELV $534
line 1245
;1243:		}
;1244:
;1245:		points = damage * ( 1.0 - dist / radius );
ADDRLP4 40
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
ADDRLP4 24
INDIRF4
ADDRFP4 12
INDIRF4
DIVF4
SUBF4
MULF4
ASGNF4
line 1247
;1246:
;1247:		if( CanDamage (ent, origin) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4180
ADDRGP4 CanDamage
CALLI4
ASGNI4
ADDRLP4 4180
INDIRI4
CNSTI4 0
EQI4 $536
line 1248
;1248:			if( LogAccuracyHit( ent, attacker ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4184
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 4184
INDIRI4
CNSTI4 0
EQI4 $538
line 1249
;1249:				hitClient = qtrue;
ADDRLP4 4168
CNSTI4 1
ASGNI4
line 1250
;1250:			}
LABELV $538
line 1251
;1251:			VectorSubtract (ent->r.currentOrigin, origin, dir);
ADDRLP4 4192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 4192
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28+4
ADDRLP4 4
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 4192
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28+8
ADDRLP4 4
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1254
;1252:			// push the center of mass higher than the origin so players
;1253:			// get knocked into the air more
;1254:			dir[2] += 24;
ADDRLP4 28+8
ADDRLP4 28+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 1255
;1255:			G_Damage (ent, NULL, attacker, dir, origin, (int)points, DAMAGE_RADIUS, mod);
ADDRLP4 4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
INDIRF4
CVFI4 4
ARGI4
CNSTI4 1
ARGI4
ADDRFP4 20
INDIRI4
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 1256
;1256:		}
LABELV $536
line 1257
;1257:	}
LABELV $519
line 1221
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $521
ADDRLP4 20
INDIRI4
ADDRLP4 4140
INDIRI4
LTI4 $518
line 1259
;1258:
;1259:	return hitClient;
ADDRLP4 4168
INDIRI4
RETI4
LABELV $511
endproc G_RadiusDamage 4196 32
import neutralObelisk
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
LABELV $438
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 58
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $249
byte 1 75
byte 1 105
byte 1 108
byte 1 108
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $248
byte 1 60
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 111
byte 1 98
byte 1 105
byte 1 116
byte 1 117
byte 1 97
byte 1 114
byte 1 121
byte 1 62
byte 1 0
align 1
LABELV $242
byte 1 60
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 62
byte 1 0
align 1
LABELV $241
byte 1 60
byte 1 110
byte 1 111
byte 1 110
byte 1 45
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 62
byte 1 0
align 1
LABELV $211
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
LABELV $210
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
LABELV $190
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
LABELV $189
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
LABELV $175
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 82
byte 1 65
byte 1 80
byte 1 80
byte 1 76
byte 1 69
byte 1 0
align 1
LABELV $174
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 74
byte 1 85
byte 1 73
byte 1 67
byte 1 69
byte 1 68
byte 1 0
align 1
LABELV $173
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 75
byte 1 65
byte 1 77
byte 1 73
byte 1 75
byte 1 65
byte 1 90
byte 1 69
byte 1 0
align 1
LABELV $172
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 80
byte 1 82
byte 1 79
byte 1 88
byte 1 73
byte 1 77
byte 1 73
byte 1 84
byte 1 89
byte 1 95
byte 1 77
byte 1 73
byte 1 78
byte 1 69
byte 1 0
align 1
LABELV $171
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 67
byte 1 72
byte 1 65
byte 1 73
byte 1 78
byte 1 71
byte 1 85
byte 1 78
byte 1 0
align 1
LABELV $170
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 78
byte 1 65
byte 1 73
byte 1 76
byte 1 0
align 1
LABELV $169
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 84
byte 1 82
byte 1 73
byte 1 71
byte 1 71
byte 1 69
byte 1 82
byte 1 95
byte 1 72
byte 1 85
byte 1 82
byte 1 84
byte 1 0
align 1
LABELV $168
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 84
byte 1 65
byte 1 82
byte 1 71
byte 1 69
byte 1 84
byte 1 95
byte 1 76
byte 1 65
byte 1 83
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $167
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 83
byte 1 85
byte 1 73
byte 1 67
byte 1 73
byte 1 68
byte 1 69
byte 1 0
align 1
LABELV $166
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 70
byte 1 65
byte 1 76
byte 1 76
byte 1 73
byte 1 78
byte 1 71
byte 1 0
align 1
LABELV $165
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 84
byte 1 69
byte 1 76
byte 1 69
byte 1 70
byte 1 82
byte 1 65
byte 1 71
byte 1 0
align 1
LABELV $164
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 67
byte 1 82
byte 1 85
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $163
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 76
byte 1 65
byte 1 86
byte 1 65
byte 1 0
align 1
LABELV $162
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 83
byte 1 76
byte 1 73
byte 1 77
byte 1 69
byte 1 0
align 1
LABELV $161
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $160
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 66
byte 1 70
byte 1 71
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $159
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 66
byte 1 70
byte 1 71
byte 1 0
align 1
LABELV $158
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 76
byte 1 73
byte 1 71
byte 1 72
byte 1 84
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 0
align 1
LABELV $157
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 82
byte 1 65
byte 1 73
byte 1 76
byte 1 71
byte 1 85
byte 1 78
byte 1 0
align 1
LABELV $156
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 77
byte 1 65
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $155
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 77
byte 1 65
byte 1 0
align 1
LABELV $154
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 82
byte 1 79
byte 1 67
byte 1 75
byte 1 69
byte 1 84
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $153
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 82
byte 1 79
byte 1 67
byte 1 75
byte 1 69
byte 1 84
byte 1 0
align 1
LABELV $152
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 68
byte 1 69
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $151
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 68
byte 1 69
byte 1 0
align 1
LABELV $150
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 77
byte 1 65
byte 1 67
byte 1 72
byte 1 73
byte 1 78
byte 1 69
byte 1 71
byte 1 85
byte 1 78
byte 1 0
align 1
LABELV $149
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 65
byte 1 85
byte 1 78
byte 1 84
byte 1 76
byte 1 69
byte 1 84
byte 1 0
align 1
LABELV $148
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 83
byte 1 72
byte 1 79
byte 1 84
byte 1 71
byte 1 85
byte 1 78
byte 1 0
align 1
LABELV $147
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 85
byte 1 78
byte 1 75
byte 1 78
byte 1 79
byte 1 87
byte 1 78
byte 1 0
align 1
LABELV $140
byte 1 107
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 101
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $96
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
LABELV $95
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 67
byte 1 117
byte 1 98
byte 1 101
byte 1 0
