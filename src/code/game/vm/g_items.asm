export SpawnTime
code
proc SpawnTime 8 0
file "../g_items.c"
line 41
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:#include "g_local.h"
;4:
;5:/*
;6:
;7:  Items are any object that a player can touch to gain some effect.
;8:
;9:  Pickup will return the number of seconds until they should respawn.
;10:
;11:  all items should pop when dropped in lava or slime
;12:
;13:  Respawnable items don't actually go away when picked up, they are
;14:  just made invisible and untouchable.  This allows them to ride
;15:  movers and respawn apropriately.
;16:*/
;17:
;18:// initial spawn times after warmup
;19:// in vq3 most of the items appears in one frame but we will delay that a bit
;20:// to reduce peak bandwidth and get some nice transition effects
;21:#define	SPAWN_WEAPONS		0		//changed from 333
;22:#define	SPAWN_ARMOR		0		//changed from 1200
;23:#define	SPAWN_HEALTH		0		//changed from 900
;24:#define	SPAWN_AMMO		0		//changed from 600
;25:#define	SPAWN_HOLDABLE		0		//changed from 2500
;26:#define	SPAWN_MEGAHEALTH	0		//changed from 10000
;27:#define	SPAWN_POWERUP		45000
;28:
;29:// periodic respawn times
;30:// g_weaponRespawn.integer || g_weaponTeamRespawn.integer
;31:#define	RESPAWN_ARMOR		25000
;32:#define	RESPAWN_HEALTH		35000
;33:#define	RESPAWN_AMMO		40000
;34:#define	RESPAWN_HOLDABLE	60000
;35:#define	RESPAWN_MEGAHEALTH	35000 //120000
;36:#define	RESPAWN_POWERUP		120000
;37:
;38://======================================================================
;39:
;40:int SpawnTime( gentity_t *ent, qboolean firstSpawn ) 
;41:{
line 42
;42:	if ( !ent->item )
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $55
line 43
;43:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $54
JUMPV
LABELV $55
line 45
;44:
;45:	switch( ent->item->giType ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $57
ADDRLP4 0
INDIRI4
CNSTI4 7
GTI4 $57
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $118-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $118
address $60
address $68
address $76
address $84
address $101
address $110
address $109
code
LABELV $60
line 48
;46:
;47:	case IT_WEAPON:
;48:		if ( firstSpawn )
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $61
line 49
;49:			return SPAWN_WEAPONS;
CNSTI4 0
RETI4
ADDRGP4 $54
JUMPV
LABELV $61
line 50
;50:		if ( g_gametype.integer == GT_TEAM )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $63
line 51
;51:			return g_weaponTeamRespawn.value * 1000;
ADDRGP4 g_weaponTeamRespawn+8
INDIRF4
CNSTF4 1148846080
MULF4
CVFI4 4
RETI4
ADDRGP4 $54
JUMPV
LABELV $63
line 53
;52:		else
;53:			return g_weaponRespawn.value * 1000 ;
ADDRGP4 g_weaponRespawn+8
INDIRF4
CNSTF4 1148846080
MULF4
CVFI4 4
RETI4
ADDRGP4 $54
JUMPV
LABELV $68
line 56
;54:
;55:	case IT_AMMO:
;56:		if ( firstSpawn )
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $69
line 57
;57:			return SPAWN_AMMO;
CNSTI4 0
RETI4
ADDRGP4 $54
JUMPV
LABELV $69
line 58
;58:		if ( g_gametype.integer == GT_TEAM )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $71
line 59
;59:			return g_ammoTeamRespawn.value * 1000;
ADDRGP4 g_ammoTeamRespawn+8
INDIRF4
CNSTF4 1148846080
MULF4
CVFI4 4
RETI4
ADDRGP4 $54
JUMPV
LABELV $71
line 61
;60:		else
;61:			return g_ammoRespawn.value * 1000;
ADDRGP4 g_ammoRespawn+8
INDIRF4
CNSTF4 1148846080
MULF4
CVFI4 4
RETI4
ADDRGP4 $54
JUMPV
LABELV $76
line 65
;62:		//return firstSpawn ? SPAWN_AMMO : RESPAWN_AMMO;
;63:
;64:	case IT_ARMOR:
;65:		if ( firstSpawn )
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $77
line 66
;66:			return SPAWN_ARMOR;
CNSTI4 0
RETI4
ADDRGP4 $54
JUMPV
LABELV $77
line 67
;67:		if ( g_gametype.integer == GT_TEAM )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $79
line 68
;68:			return g_armorTeamRespawn.value * 1000;
ADDRGP4 g_armorTeamRespawn+8
INDIRF4
CNSTF4 1148846080
MULF4
CVFI4 4
RETI4
ADDRGP4 $54
JUMPV
LABELV $79
line 70
;69:		else
;70:			return g_armorRespawn.value * 1000;
ADDRGP4 g_armorRespawn+8
INDIRF4
CNSTF4 1148846080
MULF4
CVFI4 4
RETI4
ADDRGP4 $54
JUMPV
LABELV $84
line 74
;71:		//return firstSpawn ? SPAWN_ARMOR : RESPAWN_ARMOR;
;72:
;73:	case IT_HEALTH:
;74:		if ( ent->item->quantity == 100 ) { // mega health respawns slow
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 100
NEI4 $85
line 75
;75:			if ( firstSpawn )
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $87
line 76
;76:				return SPAWN_MEGAHEALTH;
CNSTI4 0
RETI4
ADDRGP4 $54
JUMPV
LABELV $87
line 77
;77:			if ( g_gametype.integer == GT_TEAM )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $89
line 78
;78:				return g_megahealthTeamRespawn.value * 1000;
ADDRGP4 g_megahealthTeamRespawn+8
INDIRF4
CNSTF4 1148846080
MULF4
CVFI4 4
RETI4
ADDRGP4 $54
JUMPV
LABELV $89
line 80
;79:			else
;80:				return g_megahealthRespawn.value * 1000;
ADDRGP4 g_megahealthRespawn+8
INDIRF4
CNSTF4 1148846080
MULF4
CVFI4 4
RETI4
ADDRGP4 $54
JUMPV
LABELV $85
line 85
;81:			//return firstSpawn ? SPAWN_MEGAHEALTH : RESPAWN_MEGAHEALTH;
;82:		}
;83:
;84:		else
;85:			if ( firstSpawn )
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $94
line 86
;86:				return SPAWN_HEALTH;
CNSTI4 0
RETI4
ADDRGP4 $54
JUMPV
LABELV $94
line 87
;87:			if ( g_gametype.integer == GT_TEAM )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $96
line 88
;88:				return g_healthTeamRespawn.value * 1000;
ADDRGP4 g_healthTeamRespawn+8
INDIRF4
CNSTF4 1148846080
MULF4
CVFI4 4
RETI4
ADDRGP4 $54
JUMPV
LABELV $96
line 90
;89:			else
;90:				return g_healthRespawn.value * 1000;
ADDRGP4 g_healthRespawn+8
INDIRF4
CNSTF4 1148846080
MULF4
CVFI4 4
RETI4
ADDRGP4 $54
JUMPV
LABELV $101
line 94
;91:			//return firstSpawn ? SPAWN_HEALTH : RESPAWN_HEALTH;
;92:
;93:	case IT_POWERUP:
;94:		if ( firstSpawn )
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $102
line 95
;95:			return SPAWN_POWERUP;
CNSTI4 45000
RETI4
ADDRGP4 $54
JUMPV
LABELV $102
line 96
;96:		if ( g_gametype.integer == GT_TEAM )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $104
line 97
;97:			return g_powerupTeamRespawn.value * 1000;
ADDRGP4 g_powerupTeamRespawn+8
INDIRF4
CNSTF4 1148846080
MULF4
CVFI4 4
RETI4
ADDRGP4 $54
JUMPV
LABELV $104
line 99
;98:		else
;99:			return g_powerupRespawn.value * 1000;
ADDRGP4 g_powerupRespawn+8
INDIRF4
CNSTF4 1148846080
MULF4
CVFI4 4
RETI4
ADDRGP4 $54
JUMPV
LABELV $109
line 104
;100:		//return firstSpawn ? SPAWN_POWERUP : RESPAWN_POWERUP;
;101:
;102:#ifdef MISSIONPACK
;103:	case IT_PERSISTANT_POWERUP:
;104:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $54
JUMPV
line 105
;105:		break;
LABELV $110
line 109
;106:#endif
;107:
;108:	case IT_HOLDABLE:
;109:		if ( firstSpawn )
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $111
line 110
;110:			return SPAWN_HOLDABLE;
CNSTI4 0
RETI4
ADDRGP4 $54
JUMPV
LABELV $111
line 111
;111:		if ( g_gametype.integer == GT_TEAM )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $113
line 112
;112:			return g_holdableTeamRespawn.value * 1000;
ADDRGP4 g_holdableTeamRespawn+8
INDIRF4
CNSTF4 1148846080
MULF4
CVFI4 4
RETI4
ADDRGP4 $54
JUMPV
LABELV $113
line 114
;113:		else
;114:			return g_holdableRespawn.value * 1000;
ADDRGP4 g_holdableRespawn+8
INDIRF4
CNSTF4 1148846080
MULF4
CVFI4 4
RETI4
ADDRGP4 $54
JUMPV
LABELV $57
line 118
;115:		//return firstSpawn ? SPAWN_HOLDABLE : RESPAWN_HOLDABLE;
;116:
;117:	default: // IT_BAD and others
;118:		return 0;
CNSTI4 0
RETI4
LABELV $54
endproc SpawnTime 8 0
export Pickup_Powerup
proc Pickup_Powerup 116 28
line 123
;119:	}
;120:} 
;121:
;122:
;123:int Pickup_Powerup( gentity_t *ent, gentity_t *other ) {
line 128
;124:	int			quantity;
;125:	int			i;
;126:	gclient_t	*client;
;127:
;128:	if ( !other->client->ps.powerups[ent->item->giTag] ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $121
line 130
;129:		// round timing to seconds to make multiple powerup timers count in sync
;130:		other->client->ps.powerups[ent->item->giTag] = level.time - ( level.time % 1000 );
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
MODI4
SUBI4
ASGNI4
line 131
;131:	}
LABELV $121
line 133
;132:
;133:	if ( ent->count ) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $125
line 134
;134:		quantity = ent->count;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ASGNI4
line 135
;135:	} else {
ADDRGP4 $126
JUMPV
LABELV $125
line 136
;136:		quantity = ent->item->quantity;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
line 137
;137:	}
LABELV $126
line 139
;138:
;139:	other->client->ps.powerups[ent->item->giTag] += quantity * 1000;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 1000
MULI4
ADDI4
ASGNI4
line 142
;140:
;141:	// give any nearby players a "denied" anti-reward
;142:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $130
JUMPV
LABELV $127
line 148
;143:		vec3_t		delta;
;144:		float		len;
;145:		vec3_t		forward;
;146:		trace_t		tr;
;147:
;148:		client = &level.clients[i];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1644
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 149
;149:		if ( client == other->client ) {
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
NEU4 $132
line 150
;150:			continue;
ADDRGP4 $128
JUMPV
LABELV $132
line 152
;151:		}
;152:		if ( client->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $134
line 153
;153:			continue;
ADDRGP4 $128
JUMPV
LABELV $134
line 155
;154:		}
;155:		if ( client->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $136
line 156
;156:			continue;
ADDRGP4 $128
JUMPV
LABELV $136
line 161
;157:		}
;158:
;159:		// if same team in team game, no sound
;160:		// cannot use OnSameTeam as it expects to g_entities, not clients
;161:		if ( g_gametype.integer >= GT_TEAM && other->client->sess.sessionTeam == client->sess.sessionTeam  ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $138
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
NEI4 $138
line 162
;162:			continue;
ADDRGP4 $128
JUMPV
LABELV $138
line 166
;163:		}
;164:
;165:		// if too far away, no sound
;166:		VectorSubtract( ent->s.pos.trBase, client->ps.origin, delta );
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 100
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 100
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 16+8
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
line 167
;167:		len = VectorNormalize( delta );
ADDRLP4 16
ARGP4
ADDRLP4 108
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 108
INDIRF4
ASGNF4
line 168
;168:		if ( len > 192 ) {
ADDRLP4 40
INDIRF4
CNSTF4 1128267776
LEF4 $143
line 169
;169:			continue;
ADDRGP4 $128
JUMPV
LABELV $143
line 173
;170:		}
;171:
;172:		// if not facing, no sound
;173:		AngleVectors( client->ps.viewangles, forward, NULL, NULL );
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRLP4 28
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 174
;174:		if ( DotProduct( delta, forward ) < 0.4 ) {
ADDRLP4 16
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ADDRLP4 16+4
INDIRF4
ADDRLP4 28+4
INDIRF4
MULF4
ADDF4
ADDRLP4 16+8
INDIRF4
ADDRLP4 28+8
INDIRF4
MULF4
ADDF4
CNSTF4 1053609165
GEF4 $145
line 175
;175:			continue;
ADDRGP4 $128
JUMPV
LABELV $145
line 179
;176:		}
;177:
;178:		// if not line of sight, no sound
;179:		trap_Trace( &tr, client->ps.origin, NULL, NULL, ent->s.pos.trBase, ENTITYNUM_NONE, CONTENTS_SOLID );
ADDRLP4 44
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 180
;180:		if ( tr.fraction != 1.0 ) {
ADDRLP4 44+8
INDIRF4
CNSTF4 1065353216
EQF4 $151
line 181
;181:			continue;
ADDRGP4 $128
JUMPV
LABELV $151
line 185
;182:		}
;183:
;184:		// anti-reward
;185:		client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_DENIEDREWARD;
ADDRLP4 112
ADDRLP4 0
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 186
;186:	}
LABELV $128
line 142
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $130
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $127
line 188
;187:
;188:	return SpawnTime( ent, qfalse ); // return RESPAWN_POWERUP;
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 16
ADDRGP4 SpawnTime
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
RETI4
LABELV $120
endproc Pickup_Powerup 116 28
export Pickup_PersistantPowerup
proc Pickup_PersistantPowerup 1104 12
line 195
;189:}
;190:
;191:
;192://======================================================================
;193:
;194:#ifdef MISSIONPACK
;195:int Pickup_PersistantPowerup( gentity_t *ent, gentity_t *other ) {
line 201
;196:	int		clientNum;
;197:	char	userinfo[MAX_INFO_STRING];
;198:	float	handicap;
;199:	int		max;
;200:
;201:	other->client->ps.stats[STAT_PERSISTANT_POWERUP] = ent->item - bg_itemlist;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 192
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
ASGNI4
line 202
;202:	other->client->persistantPowerup = ent;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 780
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 204
;203:
;204:	switch( ent->item->giTag ) {
ADDRLP4 1036
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 10
LTI4 $155
ADDRLP4 1036
INDIRI4
CNSTI4 13
GTI4 $155
ADDRLP4 1036
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $178-40
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $178
address $163
address $158
address $167
address $171
code
LABELV $158
line 206
;205:	case PW_GUARD:
;206:		clientNum = other->client->ps.clientNum;
ADDRLP4 1028
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 207
;207:		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 208
;208:		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
ADDRLP4 4
ARGP4
ADDRGP4 $159
ARGP4
ADDRLP4 1044
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1044
INDIRP4
ARGP4
ADDRLP4 1048
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 1048
INDIRF4
ASGNF4
line 209
;209:		if( handicap<=0.0f || handicap>100.0f) {
ADDRLP4 1052
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 1052
INDIRF4
CNSTF4 0
LEF4 $162
ADDRLP4 1052
INDIRF4
CNSTF4 1120403456
LEF4 $160
LABELV $162
line 210
;210:			handicap = 100.0f;
ADDRLP4 0
CNSTF4 1120403456
ASGNF4
line 211
;211:		}
LABELV $160
line 212
;212:		max = (int)(2 *  handicap);
ADDRLP4 1032
ADDRLP4 0
INDIRF4
CNSTF4 1073741824
MULF4
CVFI4 4
ASGNI4
line 214
;213:
;214:		other->health = max;
ADDRFP4 4
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 1032
INDIRI4
ASGNI4
line 215
;215:		other->client->ps.stats[STAT_HEALTH] = max;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 1032
INDIRI4
ASGNI4
line 216
;216:		other->client->ps.stats[STAT_MAX_HEALTH] = max;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 212
ADDP4
ADDRLP4 1032
INDIRI4
ASGNI4
line 217
;217:		other->client->ps.stats[STAT_ARMOR] = max;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 1032
INDIRI4
ASGNI4
line 218
;218:		other->client->pers.maxHealth = max;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 544
ADDP4
ADDRLP4 1032
INDIRI4
ASGNI4
line 220
;219:
;220:		break;
ADDRGP4 $156
JUMPV
LABELV $163
line 223
;221:
;222:	case PW_SCOUT:
;223:		clientNum = other->client->ps.clientNum;
ADDRLP4 1028
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 224
;224:		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 225
;225:		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
ADDRLP4 4
ARGP4
ADDRGP4 $159
ARGP4
ADDRLP4 1056
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1056
INDIRP4
ARGP4
ADDRLP4 1060
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 1060
INDIRF4
ASGNF4
line 226
;226:		if( handicap<=0.0f || handicap>100.0f) {
ADDRLP4 1064
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 1064
INDIRF4
CNSTF4 0
LEF4 $166
ADDRLP4 1064
INDIRF4
CNSTF4 1120403456
LEF4 $164
LABELV $166
line 227
;227:			handicap = 100.0f;
ADDRLP4 0
CNSTF4 1120403456
ASGNF4
line 228
;228:		}
LABELV $164
line 229
;229:		other->client->pers.maxHealth = handicap;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 544
ADDP4
ADDRLP4 0
INDIRF4
CVFI4 4
ASGNI4
line 230
;230:		other->client->ps.stats[STAT_ARMOR] = 0;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 200
ADDP4
CNSTI4 0
ASGNI4
line 231
;231:		break;
ADDRGP4 $156
JUMPV
LABELV $167
line 234
;232:
;233:	case PW_DOUBLER:
;234:		clientNum = other->client->ps.clientNum;
ADDRLP4 1028
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 235
;235:		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 236
;236:		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
ADDRLP4 4
ARGP4
ADDRGP4 $159
ARGP4
ADDRLP4 1068
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1068
INDIRP4
ARGP4
ADDRLP4 1072
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 1072
INDIRF4
ASGNF4
line 237
;237:		if( handicap<=0.0f || handicap>100.0f) {
ADDRLP4 1076
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 1076
INDIRF4
CNSTF4 0
LEF4 $170
ADDRLP4 1076
INDIRF4
CNSTF4 1120403456
LEF4 $168
LABELV $170
line 238
;238:			handicap = 100.0f;
ADDRLP4 0
CNSTF4 1120403456
ASGNF4
line 239
;239:		}
LABELV $168
line 240
;240:		other->client->pers.maxHealth = handicap;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 544
ADDP4
ADDRLP4 0
INDIRF4
CVFI4 4
ASGNI4
line 241
;241:		break;
ADDRGP4 $156
JUMPV
LABELV $171
line 243
;242:	case PW_AMMOREGEN:
;243:		clientNum = other->client->ps.clientNum;
ADDRLP4 1028
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 244
;244:		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 245
;245:		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
ADDRLP4 4
ARGP4
ADDRGP4 $159
ARGP4
ADDRLP4 1080
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1080
INDIRP4
ARGP4
ADDRLP4 1084
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 1084
INDIRF4
ASGNF4
line 246
;246:		if( handicap<=0.0f || handicap>100.0f) {
ADDRLP4 1088
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 1088
INDIRF4
CNSTF4 0
LEF4 $174
ADDRLP4 1088
INDIRF4
CNSTF4 1120403456
LEF4 $172
LABELV $174
line 247
;247:			handicap = 100.0f;
ADDRLP4 0
CNSTF4 1120403456
ASGNF4
line 248
;248:		}
LABELV $172
line 249
;249:		other->client->pers.maxHealth = handicap;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 544
ADDP4
ADDRLP4 0
INDIRF4
CVFI4 4
ASGNI4
line 250
;250:		memset(other->client->ammoTimes, 0, sizeof(other->client->ammoTimes));
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 788
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 60
ARGU4
ADDRGP4 memset
CALLP4
pop
line 251
;251:		break;
ADDRGP4 $156
JUMPV
LABELV $155
line 253
;252:	default:
;253:		clientNum = other->client->ps.clientNum;
ADDRLP4 1028
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 254
;254:		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 255
;255:		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
ADDRLP4 4
ARGP4
ADDRGP4 $159
ARGP4
ADDRLP4 1092
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1092
INDIRP4
ARGP4
ADDRLP4 1096
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 1096
INDIRF4
ASGNF4
line 256
;256:		if( handicap<=0.0f || handicap>100.0f) {
ADDRLP4 1100
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 1100
INDIRF4
CNSTF4 0
LEF4 $177
ADDRLP4 1100
INDIRF4
CNSTF4 1120403456
LEF4 $175
LABELV $177
line 257
;257:			handicap = 100.0f;
ADDRLP4 0
CNSTF4 1120403456
ASGNF4
line 258
;258:		}
LABELV $175
line 259
;259:		other->client->pers.maxHealth = handicap;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 544
ADDP4
ADDRLP4 0
INDIRF4
CVFI4 4
ASGNI4
line 260
;260:		break;
LABELV $156
line 263
;261:	}
;262:
;263:	return SpawnTime( ent, qfalse ); // return -1;
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1044
ADDRGP4 SpawnTime
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
RETI4
LABELV $154
endproc Pickup_PersistantPowerup 1104 12
export Pickup_Holdable
proc Pickup_Holdable 4 8
line 269
;264:}
;265:
;266://======================================================================
;267:#endif
;268:
;269:int Pickup_Holdable( gentity_t *ent, gentity_t *other ) {
line 271
;270:
;271:	other->client->ps.stats[STAT_HOLDABLE_ITEM] = ent->item - bg_itemlist;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 188
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
ASGNI4
line 274
;272:
;273:#ifdef MISSIONPACK	
;274:	if( ent->item->giTag == HI_KAMIKAZE ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 3
NEI4 $181
line 275
;275:		other->client->ps.eFlags |= EF_KAMIKAZE;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 276
;276:	}
LABELV $181
line 279
;277:#endif
;278:
;279:	return SpawnTime( ent, qfalse ); // return RESPAWN_HOLDABLE;
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ADDRGP4 SpawnTime
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $180
endproc Pickup_Holdable 4 8
proc Add_Ammo 8 0
line 287
;280:}
;281:
;282:
;283://======================================================================
;284:
;285:
;286:static void Add_Ammo( gentity_t *ent, int weapon, int count )
;287:{
line 289
;288:	// if ammo already above limit from /give cheat don't bother
;289:	if ( ent->client->ps.ammo[weapon] > AMMO_HARD_LIMIT )
ADDRFP4 4
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
CNSTI4 200
LEI4 $184
line 290
;290:		return;
ADDRGP4 $183
JUMPV
LABELV $184
line 292
;291:
;292:	if ( weapon == WP_GAUNTLET || weapon == WP_GRAPPLING_HOOK ) {
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $188
ADDRLP4 0
INDIRI4
CNSTI4 10
NEI4 $186
LABELV $188
line 293
;293:		ent->client->ps.ammo[weapon] = -1;
ADDRFP4 4
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
CNSTI4 -1
ASGNI4
line 294
;294:		return;
ADDRGP4 $183
JUMPV
LABELV $186
line 297
;295:	}
;296:
;297:	ent->client->ps.ammo[weapon] += count;
ADDRLP4 4
ADDRFP4 4
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
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ASGNI4
line 298
;298:	if ( ent->client->ps.ammo[weapon] > AMMO_HARD_LIMIT ) {
ADDRFP4 4
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
CNSTI4 200
LEI4 $189
line 299
;299:		ent->client->ps.ammo[weapon] = AMMO_HARD_LIMIT;
ADDRFP4 4
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
CNSTI4 200
ASGNI4
line 300
;300:	}
LABELV $189
line 301
;301:}
LABELV $183
endproc Add_Ammo 8 0
proc Pickup_Ammo 8 12
line 305
;302:
;303:
;304:static int Pickup_Ammo( gentity_t *ent, gentity_t *other )
;305:{
line 308
;306:	int		quantity;
;307:
;308:	if ( ent->count ) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $192
line 309
;309:		quantity = ent->count;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ASGNI4
line 310
;310:	} else {
ADDRGP4 $193
JUMPV
LABELV $192
line 311
;311:		quantity = ent->item->quantity;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
line 312
;312:	}
LABELV $193
line 314
;313:
;314:	Add_Ammo( other, ent->item->giTag, quantity );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Add_Ammo
CALLV
pop
line 316
;315:
;316:	return SpawnTime( ent, qfalse ); // return RESPAWN_AMMO;
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 SpawnTime
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
LABELV $191
endproc Pickup_Ammo 8 12
proc Pickup_Weapon 16 12
line 322
;317:}
;318:
;319://======================================================================
;320:
;321:
;322:static int Pickup_Weapon( gentity_t *ent, gentity_t *other ) {
line 325
;323:	int		quantity;
;324:
;325:	if ( ent->count < 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
GEI4 $195
line 326
;326:		quantity = 0; // None for you, sir!
ADDRLP4 0
CNSTI4 0
ASGNI4
line 327
;327:	} else {
ADDRGP4 $196
JUMPV
LABELV $195
line 328
;328:		if ( ent->count ) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $197
line 329
;329:			quantity = ent->count;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ASGNI4
line 330
;330:		} else {
ADDRGP4 $198
JUMPV
LABELV $197
line 331
;331:			quantity = ent->item->quantity;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
line 332
;332:		}
LABELV $198
line 335
;333:
;334:		// dropped items and teamplay weapons always have full ammo
;335:		if ( ! (ent->flags & FL_DROPPED_ITEM) && g_gametype.integer != GT_TEAM ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $199
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
EQI4 $199
line 338
;336:			// respawning rules
;337:			// drop the quantity if the already have over the minimum
;338:			if ( other->client->ps.ammo[ ent->item->giTag ] < quantity ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
GEI4 $202
line 339
;339:				quantity = quantity - other->client->ps.ammo[ ent->item->giTag ];
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 340
;340:			} else {
ADDRGP4 $203
JUMPV
LABELV $202
line 341
;341:				quantity = 1;		// only add a single shot
ADDRLP4 0
CNSTI4 1
ASGNI4
line 342
;342:			}
LABELV $203
line 343
;343:		}
LABELV $199
line 344
;344:	}
LABELV $196
line 347
;345:
;346:	// add the weapon
;347:	other->client->ps.stats[STAT_WEAPONS] |= ( 1 << ent->item->giTag );
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
LSHI4
BORI4
ASGNI4
line 349
;348:
;349:	Add_Ammo( other, ent->item->giTag, quantity );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Add_Ammo
CALLV
pop
line 351
;350:
;351:	if (ent->item->giTag == WP_GAUNTLET || ent->item->giTag == WP_GRAPPLING_HOOK)
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 1
EQI4 $206
ADDRLP4 8
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 10
NEI4 $204
LABELV $206
line 352
;352:		other->client->ps.ammo[ent->item->giTag] = -1; // unlimited ammo
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
CNSTI4 -1
ASGNI4
LABELV $204
line 360
;353:
;354:	// team deathmatch has slow weapon respawns
;355:	//if ( g_gametype.integer == GT_TEAM ) {
;356:	//	return g_weaponTeamRespawn.integer;
;357:	//} else {
;358:	//	return g_weaponRespawn.integer;
;359:	//}
;360:	return SpawnTime( ent, qfalse );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 12
ADDRGP4 SpawnTime
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
LABELV $194
endproc Pickup_Weapon 16 12
proc Pickup_Health 28 8
line 366
;361:}
;362:
;363:
;364://======================================================================
;365:
;366:static int Pickup_Health( gentity_t *ent, gentity_t *other ) {
line 372
;367:	int			max;
;368:	int			quantity;
;369:
;370:	// small and mega healths will go over the max
;371:#ifdef MISSIONPACK
;372:	if( other->client && bg_itemlist[other->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $208
ADDRLP4 8
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
NEI4 $208
line 373
;373:		max = other->client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ASGNI4
line 374
;374:	}
ADDRGP4 $209
JUMPV
LABELV $208
line 377
;375:	else
;376:#endif
;377:	if ( ent->item->quantity != 5 && ent->item->quantity != 100 ) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 5
EQI4 $211
ADDRLP4 12
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 100
EQI4 $211
line 378
;378:		max = other->client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ASGNI4
line 379
;379:	} else {
ADDRGP4 $212
JUMPV
LABELV $211
line 380
;380:		max = other->client->ps.stats[STAT_MAX_HEALTH] * 2;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 381
;381:	}
LABELV $212
LABELV $209
line 383
;382:
;383:	if ( ent->count ) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $213
line 384
;384:		quantity = ent->count;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ASGNI4
line 385
;385:	} else {
ADDRGP4 $214
JUMPV
LABELV $213
line 386
;386:		quantity = ent->item->quantity;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
line 387
;387:	}
LABELV $214
line 389
;388:
;389:	other->health += quantity;
ADDRLP4 16
ADDRFP4 4
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 391
;390:
;391:	if (other->health > max ) {
ADDRFP4 4
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $215
line 392
;392:		other->health = max;
ADDRFP4 4
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 393
;393:	}
LABELV $215
line 394
;394:	other->client->ps.stats[STAT_HEALTH] = other->health;
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ASGNI4
line 401
;395:
;396:	//if ( ent->item->quantity == 100 ) { // mega health respawns slow
;397:	//	return RESPAWN_MEGAHEALTH;
;398:	//} else {
;399:	//	return RESPAWN_HEALTH;
;400:	//}
;401:	return SpawnTime( ent, qfalse );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 24
ADDRGP4 SpawnTime
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
RETI4
LABELV $207
endproc Pickup_Health 28 8
export Pickup_Armor
proc Pickup_Armor 16 8
line 407
;402:}
;403:
;404:
;405://======================================================================
;406:
;407:int Pickup_Armor( gentity_t *ent, gentity_t *other ) {
line 411
;408:#ifdef MISSIONPACK
;409:	int		upperBound;
;410:
;411:	other->client->ps.stats[STAT_ARMOR] += ent->item->quantity;
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 200
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ADDI4
ASGNI4
line 413
;412:
;413:	if( other->client && bg_itemlist[other->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $218
ADDRLP4 8
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
NEI4 $218
line 414
;414:		upperBound = other->client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ASGNI4
line 415
;415:	}
ADDRGP4 $219
JUMPV
LABELV $218
line 416
;416:	else {
line 417
;417:		upperBound = other->client->ps.stats[STAT_MAX_HEALTH] * 2;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 418
;418:	}
LABELV $219
line 420
;419:
;420:	if ( other->client->ps.stats[STAT_ARMOR] > upperBound ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $221
line 421
;421:		other->client->ps.stats[STAT_ARMOR] = upperBound;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 422
;422:	}
LABELV $221
line 430
;423:#else
;424:	other->client->ps.stats[STAT_ARMOR] += ent->item->quantity;
;425:	if ( other->client->ps.stats[STAT_ARMOR] > other->client->ps.stats[STAT_MAX_HEALTH] * 2 ) {
;426:		other->client->ps.stats[STAT_ARMOR] = other->client->ps.stats[STAT_MAX_HEALTH] * 2;
;427:	}
;428:#endif
;429:
;430:	return SpawnTime( ent, qfalse ); // return RESPAWN_ARMOR;
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 12
ADDRGP4 SpawnTime
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
LABELV $217
endproc Pickup_Armor 16 8
export RespawnItem
proc RespawnItem 24 12
line 440
;431:}
;432:
;433://======================================================================
;434:
;435:/*
;436:===============
;437:RespawnItem
;438:===============
;439:*/
;440:void RespawnItem( gentity_t *ent ) {
line 442
;441:	
;442:	if ( !ent ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $224
line 443
;443:		return;
ADDRGP4 $223
JUMPV
LABELV $224
line 447
;444:	}
;445:	
;446:	// randomly select from teamed entities
;447:	if ( ent->team ) {
ADDRFP4 0
INDIRP4
CNSTI4 656
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $226
line 452
;448:		gentity_t *master;
;449:		int	count;
;450:		int choice;
;451:
;452:		if ( !ent->teammaster ) {
ADDRFP4 0
INDIRP4
CNSTI4 780
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $228
line 453
;453:			G_Error( "RespawnItem: bad teammaster" );
ADDRGP4 $230
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 454
;454:		}
LABELV $228
line 456
;455:
;456:		master = ent->teammaster;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 780
ADDP4
INDIRP4
ASGNP4
line 458
;457:
;458:		for ( count = 0, ent = master; ent; ent = ent->teamchain, count++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRFP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $234
JUMPV
LABELV $231
line 460
;459:			// reset spawn timers on all teamed entities
;460:			ent->nextthink = 0;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
CNSTI4 0
ASGNI4
line 461
;461:		}
LABELV $232
line 458
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $234
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $231
line 463
;462:
;463:		choice = rand() % count;
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ADDRLP4 0
INDIRI4
MODI4
ASGNI4
line 465
;464:
;465:		for ( count = 0, ent = master; ent && count < choice; ent = ent->teamchain, count++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRFP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $238
JUMPV
LABELV $235
line 466
;466:			;
LABELV $236
line 465
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $238
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $239
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $235
LABELV $239
line 467
;467:	}
LABELV $226
line 469
;468:
;469:	if ( !ent ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $240
line 470
;470:		return;
ADDRGP4 $223
JUMPV
LABELV $240
line 473
;471:	}
;472:
;473:	ent->r.contents = CONTENTS_TRIGGER;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1073741824
ASGNI4
line 474
;474:	ent->s.eFlags &= ~EF_NODRAW;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 475
;475:	ent->r.svFlags &= ~SVF_NOCLIENT;
ADDRLP4 4
ADDRFP4 0
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
line 476
;476:	trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 478
;477:
;478:	if ( ent->item->giType == IT_POWERUP ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $242
line 483
;479:		// play powerup spawn sound to all clients
;480:		gentity_t	*te;
;481:
;482:		// if the powerup respawn sound should Not be global
;483:		if ( ent->speed ) {
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
CNSTF4 0
EQF4 $244
line 484
;484:			te = G_TempEntity( ent->s.pos.trBase, EV_GENERAL_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 45
ARGI4
ADDRLP4 12
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 485
;485:		} else {
ADDRGP4 $245
JUMPV
LABELV $244
line 486
;486:			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 46
ARGI4
ADDRLP4 12
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 487
;487:		}
LABELV $245
line 488
;488:		te->s.eventParm = G_SoundIndex( "sound/items/poweruprespawn.wav" );
ADDRGP4 $246
ARGP4
ADDRLP4 12
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 489
;489:		te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 16
ADDRLP4 8
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
line 490
;490:	}
LABELV $242
line 493
;491:
;492:#ifdef MISSIONPACK
;493:	if ( ent->item->giType == IT_HOLDABLE && ent->item->giTag == HI_KAMIKAZE ) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 6
NEI4 $247
ADDRLP4 8
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 3
NEI4 $247
line 498
;494:		// play powerup spawn sound to all clients
;495:		gentity_t	*te;
;496:
;497:		// if the powerup respawn sound should Not be global
;498:		if (ent->speed) {
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
CNSTF4 0
EQF4 $249
line 499
;499:			te = G_TempEntity( ent->s.pos.trBase, EV_GENERAL_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 45
ARGI4
ADDRLP4 16
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
ASGNP4
line 500
;500:		}
ADDRGP4 $250
JUMPV
LABELV $249
line 501
;501:		else {
line 502
;502:			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 46
ARGI4
ADDRLP4 16
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
ASGNP4
line 503
;503:		}
LABELV $250
line 504
;504:		te->s.eventParm = G_SoundIndex( "sound/items/kamikazerespawn.wav" );
ADDRGP4 $251
ARGP4
ADDRLP4 16
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 505
;505:		te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 20
ADDRLP4 12
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 506
;506:	}
LABELV $247
line 510
;507:#endif
;508:
;509:	// play the normal respawn sound only to nearby clients
;510:	G_AddEvent( ent, EV_ITEM_RESPAWN, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 40
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 512
;511:
;512:	ent->nextthink = 0;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
CNSTI4 0
ASGNI4
line 513
;513:}
LABELV $223
endproc RespawnItem 24 12
export Touch_Item
proc Touch_Item 56 12
line 521
;514:
;515:
;516:/*
;517:===============
;518:Touch_Item
;519:===============
;520:*/
;521:void Touch_Item (gentity_t *ent, gentity_t *other, trace_t *trace) {
line 525
;522:	int			respawn;
;523:	qboolean	predict;
;524:
;525:	if (!other->client)
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $253
line 526
;526:		return;
ADDRGP4 $252
JUMPV
LABELV $253
line 527
;527:	if (other->health < 1)
ADDRFP4 4
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 1
GEI4 $255
line 528
;528:		return;		// dead people can't pickup
ADDRGP4 $252
JUMPV
LABELV $255
line 531
;529:
;530:	// the same pickup rules are used for client side and server side
;531:	if ( !BG_CanItemBeGrabbed( g_gametype.integer, &ent->s, &other->client->ps ) ) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BG_CanItemBeGrabbed
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $257
line 532
;532:		return;
ADDRGP4 $252
JUMPV
LABELV $257
line 535
;533:	}
;534:
;535:	G_LogPrintf( "Item: %i %s\n", other->s.number, ent->item->classname );
ADDRGP4 $260
ARGP4
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 537
;536:
;537:	predict = other->client->pers.predictItemPickup;
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 504
ADDP4
INDIRI4
ASGNI4
line 540
;538:
;539:	// call the item-specific pickup function
;540:	switch( ent->item->giType ) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 1
LTI4 $252
ADDRLP4 12
INDIRI4
CNSTI4 8
GTI4 $252
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $274-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $274
address $264
address $265
address $266
address $267
address $268
address $273
address $271
address $272
code
LABELV $264
line 542
;541:	case IT_WEAPON:
;542:		respawn = Pickup_Weapon(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Pickup_Weapon
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
ASGNI4
line 543
;543:		break;
ADDRGP4 $262
JUMPV
LABELV $265
line 545
;544:	case IT_AMMO:
;545:		respawn = Pickup_Ammo(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 Pickup_Ammo
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRI4
ASGNI4
line 546
;546:		break;
ADDRGP4 $262
JUMPV
LABELV $266
line 548
;547:	case IT_ARMOR:
;548:		respawn = Pickup_Armor(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 Pickup_Armor
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 28
INDIRI4
ASGNI4
line 549
;549:		break;
ADDRGP4 $262
JUMPV
LABELV $267
line 551
;550:	case IT_HEALTH:
;551:		respawn = Pickup_Health(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 Pickup_Health
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 32
INDIRI4
ASGNI4
line 552
;552:		break;
ADDRGP4 $262
JUMPV
LABELV $268
line 554
;553:	case IT_POWERUP:
;554:		respawn = Pickup_Powerup(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 Pickup_Powerup
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 36
INDIRI4
ASGNI4
line 556
;555:		// allow prediction for some powerups
;556:		if ( ent->item->giTag >= PW_QUAD && ent->item->giTag <= PW_FLIGHT )
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 1
LTI4 $269
ADDRLP4 40
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 6
GTI4 $269
line 557
;557:			predict = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $262
JUMPV
LABELV $269
line 559
;558:		else
;559:			predict = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 560
;560:		break;
ADDRGP4 $262
JUMPV
LABELV $271
line 563
;561:#ifdef MISSIONPACK
;562:	case IT_PERSISTANT_POWERUP:
;563:		respawn = Pickup_PersistantPowerup(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 Pickup_PersistantPowerup
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 44
INDIRI4
ASGNI4
line 564
;564:		break;
ADDRGP4 $262
JUMPV
LABELV $272
line 567
;565:#endif
;566:	case IT_TEAM:
;567:		respawn = Pickup_Team(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 Pickup_Team
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 48
INDIRI4
ASGNI4
line 568
;568:		break;
ADDRGP4 $262
JUMPV
LABELV $273
line 570
;569:	case IT_HOLDABLE:
;570:		respawn = Pickup_Holdable(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 Pickup_Holdable
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 52
INDIRI4
ASGNI4
line 571
;571:		break;
line 573
;572:	default:
;573:		return;
LABELV $262
line 576
;574:	}
;575:
;576:	if ( !respawn ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $276
line 577
;577:		return;
ADDRGP4 $252
JUMPV
LABELV $276
line 581
;578:	}
;579:
;580:	// play the normal pickup sound
;581:	if ( predict ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $278
line 582
;582:		G_AddPredictableEvent( other, EV_ITEM_PICKUP, ent->s.modelindex );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 19
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddPredictableEvent
CALLV
pop
line 583
;583:	} else {
ADDRGP4 $279
JUMPV
LABELV $278
line 584
;584:		G_AddEvent( other, EV_ITEM_PICKUP, ent->s.modelindex );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 19
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 585
;585:	}
LABELV $279
line 588
;586:
;587:	// powerup pickups are global broadcasts
;588:	if ( ent->item->giType == IT_POWERUP || ent->item->giType == IT_TEAM) {
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
EQI4 $282
ADDRLP4 20
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $280
LABELV $282
line 590
;589:		// if we want the global sound to play
;590:		if (!ent->speed) {
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
CNSTF4 0
NEF4 $283
line 593
;591:			gentity_t	*te;
;592:
;593:			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_ITEM_PICKUP );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 20
ARGI4
ADDRLP4 28
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 28
INDIRP4
ASGNP4
line 594
;594:			te->s.eventParm = ent->s.modelindex;
ADDRLP4 24
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ASGNI4
line 595
;595:			te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 32
ADDRLP4 24
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 596
;596:		} else {
ADDRGP4 $284
JUMPV
LABELV $283
line 599
;597:			gentity_t	*te;
;598:
;599:			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_ITEM_PICKUP );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 20
ARGI4
ADDRLP4 28
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 28
INDIRP4
ASGNP4
line 600
;600:			te->s.eventParm = ent->s.modelindex;
ADDRLP4 24
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ASGNI4
line 602
;601:			// only send this temp entity to a single client
;602:			te->r.svFlags |= SVF_SINGLECLIENT;
ADDRLP4 32
ADDRLP4 24
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 603
;603:			te->r.singleClient = other->s.number;
ADDRLP4 24
INDIRP4
CNSTI4 428
ADDP4
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
line 604
;604:		}
LABELV $284
line 605
;605:	}
LABELV $280
line 608
;606:
;607:	// fire item targets
;608:	G_UseTargets (ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 G_UseTargets
CALLV
pop
line 611
;609:
;610:	// wait of -1 will not respawn
;611:	if ( ent->wait == -1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRF4
CNSTF4 3212836864
NEF4 $285
line 612
;612:		ent->r.svFlags |= SVF_NOCLIENT;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 613
;613:		ent->s.eFlags |= EF_NODRAW;
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
CNSTI4 128
BORI4
ASGNI4
line 614
;614:		ent->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 615
;615:		ent->unlinkAfterEvent = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
CNSTI4 1
ASGNI4
line 616
;616:		return;
ADDRGP4 $252
JUMPV
LABELV $285
line 620
;617:	}
;618:
;619:	// non zero wait overrides respawn time
;620:	if ( ent->wait ) {
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRF4
CNSTF4 0
EQF4 $287
line 621
;621:		respawn = ent->wait;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 622
;622:		respawn *= 1000;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1000
MULI4
ASGNI4
line 623
;623:	}
LABELV $287
line 626
;624:
;625:	// random can be used to vary the respawn time
;626:	if ( ent->random ) {
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRF4
CNSTF4 0
EQF4 $289
line 627
;627:		respawn += (crandom() * ent->random) * 1000;
ADDRLP4 24
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRLP4 24
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRF4
MULF4
CNSTF4 1148846080
MULF4
ADDF4
CVFI4 4
ASGNI4
line 628
;628:		if ( respawn < 1000 ) {
ADDRLP4 0
INDIRI4
CNSTI4 1000
GEI4 $291
line 629
;629:			respawn = 1000;
ADDRLP4 0
CNSTI4 1000
ASGNI4
line 630
;630:		}
LABELV $291
line 631
;631:	}
LABELV $289
line 634
;632:
;633:	// dropped items will not respawn
;634:	if ( ent->flags & FL_DROPPED_ITEM ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $293
line 635
;635:		ent->freeAfterEvent = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 1
ASGNI4
line 636
;636:	}
LABELV $293
line 641
;637:
;638:	// picked up items still stay around, they just don't
;639:	// draw anything.  This allows respawnable items
;640:	// to be placed on movers.
;641:	ent->r.svFlags |= SVF_NOCLIENT;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 642
;642:	ent->s.eFlags |= EF_NODRAW;
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
CNSTI4 128
BORI4
ASGNI4
line 643
;643:	ent->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 649
;644:
;645:	// ZOID
;646:	// A negative respawn times means to never respawn this item (but don't 
;647:	// delete it).  This is used by items that are respawned by third party 
;648:	// events such as ctf flags
;649:	if ( respawn <= 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $295
line 650
;650:		ent->nextthink = 0;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
CNSTI4 0
ASGNI4
line 651
;651:		ent->think = 0;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
CNSTP4 0
ASGNP4
line 652
;652:	} else {
ADDRGP4 $296
JUMPV
LABELV $295
line 653
;653:		ent->nextthink = level.time + respawn;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 654
;654:		ent->think = RespawnItem;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 RespawnItem
ASGNP4
line 655
;655:	}
LABELV $296
line 657
;656:
;657:	trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 658
;658:}
LABELV $252
endproc Touch_Item 56 12
export LaunchItem
proc LaunchItem 12 8
line 670
;659:
;660:
;661://======================================================================
;662:
;663:/*
;664:================
;665:LaunchItem
;666:
;667:Spawns an item and tosses it forward
;668:================
;669:*/
;670:gentity_t *LaunchItem( gitem_t *item, vec3_t origin, vec3_t velocity ) {
line 673
;671:	gentity_t	*dropped;
;672:
;673:	dropped = G_Spawn();
ADDRLP4 4
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 675
;674:
;675:	dropped->s.eType = ET_ITEM;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 2
ASGNI4
line 676
;676:	dropped->s.modelindex = item - bg_itemlist;	// store item number in modelindex
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
ASGNI4
line 677
;677:	dropped->s.modelindex2 = 1; // This is non-zero is it's a dropped item
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 1
ASGNI4
line 680
;678:
;679:	// item scale-down
;680:	dropped->s.time = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 682
;681:
;682:	dropped->classname = item->classname;
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
line 683
;683:	dropped->item = item;
ADDRLP4 0
INDIRP4
CNSTI4 812
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 684
;684:	VectorSet (dropped->r.mins, -ITEM_RADIUS, -ITEM_RADIUS, -ITEM_RADIUS);
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
CNSTF4 3245342720
ASGNF4
line 685
;685:	VectorSet (dropped->r.maxs, ITEM_RADIUS, ITEM_RADIUS, ITEM_RADIUS);
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
CNSTF4 1097859072
ASGNF4
line 686
;686:	dropped->r.contents = CONTENTS_TRIGGER;
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1073741824
ASGNI4
line 688
;687:
;688:	dropped->touch = Touch_Item;
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
ADDRGP4 Touch_Item
ASGNP4
line 690
;689:
;690:	G_SetOrigin( dropped, origin );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 691
;691:	dropped->s.pos.trType = TR_GRAVITY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
line 692
;692:	dropped->s.pos.trTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 693
;693:	VectorCopy( velocity, dropped->s.pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRP4
INDIRB
ASGNB 12
line 695
;694:
;695:	dropped->s.eFlags |= EF_BOUNCE_HALF;
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
CNSTI4 32
BORI4
ASGNI4
line 697
;696:#ifdef MISSIONPACK
;697:	if ((g_gametype.integer == GT_CTF || g_gametype.integer == GT_1FCTF)			&& item->giType == IT_TEAM) { // Special case for CTF flags
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
EQI4 $305
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
NEI4 $301
LABELV $305
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $301
line 701
;698:#else
;699:	if (g_gametype.integer == GT_CTF && item->giType == IT_TEAM) { // Special case for CTF flags
;700:#endif
;701:		dropped->think = Team_DroppedFlagThink;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 Team_DroppedFlagThink
ASGNP4
line 702
;702:		dropped->nextthink = level.time + 30000;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 30000
ADDI4
ASGNI4
line 703
;703:		Team_CheckDroppedItem( dropped );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Team_CheckDroppedItem
CALLV
pop
line 704
;704:	} else { // auto-remove after 30 seconds
ADDRGP4 $302
JUMPV
LABELV $301
line 705
;705:		dropped->think = G_FreeEntity;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_FreeEntity
ASGNP4
line 706
;706:		dropped->nextthink = level.time + 30000;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 30000
ADDI4
ASGNI4
line 707
;707:	}
LABELV $302
line 709
;708:
;709:	dropped->flags = FL_DROPPED_ITEM;
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
CNSTI4 4096
ASGNI4
line 711
;710:
;711:	trap_LinkEntity (dropped);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 713
;712:
;713:	return dropped;
ADDRLP4 0
INDIRP4
RETP4
LABELV $298
endproc LaunchItem 12 8
export Drop_Item
proc Drop_Item 32 16
line 723
;714:}
;715:
;716:/*
;717:================
;718:Drop_Item
;719:
;720:Spawns an item and tosses it forward
;721:================
;722:*/
;723:gentity_t *Drop_Item( gentity_t *ent, gitem_t *item, float angle ) {
line 727
;724:	vec3_t	velocity;
;725:	vec3_t	angles;
;726:
;727:	VectorCopy( ent->s.apos.trBase, angles );
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRB
ASGNB 12
line 728
;728:	angles[YAW] += angle;
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRFP4 8
INDIRF4
ADDF4
ASGNF4
line 729
;729:	angles[PITCH] = 0;	// always forward
ADDRLP4 12
CNSTF4 0
ASGNF4
line 731
;730:
;731:	AngleVectors( angles, velocity, NULL, NULL );
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
line 732
;732:	VectorScale( velocity, 150, velocity );
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
line 733
;733:	velocity[2] += 200 + crandom() * 50;
ADDRLP4 24
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 24
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
line 735
;734:	
;735:	return LaunchItem( item, ent->s.pos.trBase, velocity );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 28
ADDRGP4 LaunchItem
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
RETP4
LABELV $308
endproc Drop_Item 32 16
export Use_Item
proc Use_Item 0 4
line 746
;736:}
;737:
;738:
;739:/*
;740:================
;741:Use_Item
;742:
;743:Respawn the item
;744:================
;745:*/
;746:void Use_Item( gentity_t *ent, gentity_t *other, gentity_t *activator ) {
line 747
;747:	RespawnItem( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 RespawnItem
CALLV
pop
line 748
;748:}
LABELV $315
endproc Use_Item 0 4
export FinishSpawningItem
proc FinishSpawningItem 84 28
line 760
;749:
;750://======================================================================
;751:
;752:/*
;753:================
;754:FinishSpawningItem
;755:
;756:Traces down to find where an item should rest, instead of letting them
;757:free fall from their spawn points
;758:================
;759:*/
;760:void FinishSpawningItem( gentity_t *ent ) {
line 764
;761:	trace_t		tr;
;762:	vec3_t		dest;
;763:
;764:	VectorSet( ent->r.mins, -ITEM_RADIUS, -ITEM_RADIUS, -ITEM_RADIUS );
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
CNSTF4 3245342720
ASGNF4
line 765
;765:	VectorSet( ent->r.maxs, ITEM_RADIUS, ITEM_RADIUS, ITEM_RADIUS );
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 1097859072
ASGNF4
line 767
;766:
;767:	ent->s.eType = ET_ITEM;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 2
ASGNI4
line 768
;768:	ent->s.modelindex = ent->item - bg_itemlist;		// store item number in modelindex
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 160
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
ASGNI4
line 769
;769:	ent->s.modelindex2 = 0; // zero indicates this isn't a dropped item
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 0
ASGNI4
line 771
;770:
;771:	ent->r.contents = CONTENTS_TRIGGER;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1073741824
ASGNI4
line 772
;772:	ent->touch = Touch_Item;
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
ADDRGP4 Touch_Item
ASGNP4
line 774
;773:	// using an item causes it to respawn
;774:	ent->use = Use_Item;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 Use_Item
ASGNP4
line 777
;775:
;776:	// for pickup prediction
;777:	if ( ent->count ) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $317
line 778
;778:		ent->s.time2 = ent->count;
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ASGNI4
line 779
;779:	} else if ( ent->item ) {
ADDRGP4 $318
JUMPV
LABELV $317
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $319
line 780
;780:		ent->s.time2 = ent->item->quantity;	
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
line 781
;781:	}
LABELV $319
LABELV $318
line 783
;782:
;783:	if ( ent->spawnflags & 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $321
line 785
;784:		// suspended
;785:		G_SetOrigin( ent, ent->s.origin );
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 786
;786:	} else {
ADDRGP4 $322
JUMPV
LABELV $321
line 788
;787:		// drop to floor
;788:		VectorSet( dest, ent->s.origin[0], ent->s.origin[1], ent->s.origin[2] - 4096 );
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 72
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ASGNF4
ADDRLP4 56+4
ADDRLP4 72
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ASGNF4
ADDRLP4 56+8
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
CNSTF4 1166016512
SUBF4
ASGNF4
line 789
;789:		trap_Trace( &tr, ent->s.origin, ent->r.mins, ent->r.maxs, dest, ent->s.number, MASK_SOLID );
ADDRLP4 0
ARGP4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 76
INDIRP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 790
;790:		if ( tr.startsolid ) {
ADDRLP4 0+4
INDIRI4
CNSTI4 0
EQI4 $325
line 791
;791:			G_Printf ("FinishSpawningItem: %s startsolid at %s\n", ent->classname, vtos(ent->s.origin));
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 80
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $328
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 792
;792:			G_FreeEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 793
;793:			return;
ADDRGP4 $316
JUMPV
LABELV $325
line 797
;794:		}
;795:
;796:		// allow to ride movers
;797:		ent->s.groundEntityNum = tr.entityNum;
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
ADDRLP4 0+52
INDIRI4
ASGNI4
line 799
;798:
;799:		G_SetOrigin( ent, tr.endpos );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 800
;800:	}
LABELV $322
line 803
;801:
;802:	// team slaves and targeted items aren't present at start
;803:	if ( ( ent->flags & FL_TEAMSLAVE ) || ent->targetname ) {
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
NEI4 $333
ADDRLP4 72
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $331
LABELV $333
line 804
;804:		ent->s.eFlags |= EF_NODRAW;
ADDRLP4 76
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 805
;805:		ent->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 806
;806:		return;
ADDRGP4 $316
JUMPV
LABELV $331
line 809
;807:	}
;808:
;809:	trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 810
;810:}
LABELV $316
endproc FinishSpawningItem 84 28
export Registered
proc Registered 8 0
line 814
;811:
;812:
;813:qboolean	itemRegistered[MAX_ITEMS];
;814:qboolean Registered( gitem_t *item ) {
line 815
;815:	return ( item && itemRegistered[ item - bg_itemlist ] );
ADDRLP4 4
ADDRFP4 0
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 4
INDIRU4
CNSTU4 0
EQU4 $336
ADDRLP4 4
INDIRU4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
INDIRI4
CNSTI4 0
EQI4 $336
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $337
JUMPV
LABELV $336
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $337
ADDRLP4 0
INDIRI4
RETI4
LABELV $334
endproc Registered 8 0
export G_CheckTeamItems
proc G_CheckTeamItems 28 12
line 823
;816:}
;817:
;818:/*
;819:==================
;820:G_CheckTeamItems
;821:==================
;822:*/
;823:void G_CheckTeamItems( void ) {
line 826
;824:
;825:	// Set up team stuff
;826:	Team_InitGame();
ADDRGP4 Team_InitGame
CALLV
pop
line 828
;827:
;828:	if( g_gametype.integer == GT_CTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $339
line 832
;829:		gitem_t	*item;
;830:
;831:		// check for the two flags
;832:		item = BG_FindItem( "Red Flag" );
ADDRGP4 $342
ARGP4
ADDRLP4 4
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 833
;833:		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
ADDRLP4 8
ADDRLP4 0
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 8
INDIRU4
CNSTU4 0
EQU4 $345
ADDRLP4 8
INDIRU4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
INDIRI4
CNSTI4 0
NEI4 $343
LABELV $345
line 834
;834:			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_redflag in map\n" );
ADDRGP4 $346
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 835
;835:		}
LABELV $343
line 836
;836:		item = BG_FindItem( "Blue Flag" );
ADDRGP4 $347
ARGP4
ADDRLP4 12
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 837
;837:		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
ADDRLP4 16
ADDRLP4 0
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 16
INDIRU4
CNSTU4 0
EQU4 $350
ADDRLP4 16
INDIRU4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
INDIRI4
CNSTI4 0
NEI4 $348
LABELV $350
line 838
;838:			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_blueflag in map\n" );
ADDRGP4 $351
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 839
;839:		}
LABELV $348
line 840
;840:	}
LABELV $339
line 842
;841:#ifdef MISSIONPACK
;842:	if( g_gametype.integer == GT_1FCTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
NEI4 $352
line 846
;843:		gitem_t	*item;
;844:
;845:		// check for all three flags
;846:		item = BG_FindItem( "Red Flag" );
ADDRGP4 $342
ARGP4
ADDRLP4 4
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 847
;847:		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
ADDRLP4 8
ADDRLP4 0
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 8
INDIRU4
CNSTU4 0
EQU4 $357
ADDRLP4 8
INDIRU4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
INDIRI4
CNSTI4 0
NEI4 $355
LABELV $357
line 848
;848:			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_redflag in map\n" );
ADDRGP4 $346
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 849
;849:		}
LABELV $355
line 850
;850:		item = BG_FindItem( "Blue Flag" );
ADDRGP4 $347
ARGP4
ADDRLP4 12
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 851
;851:		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
ADDRLP4 16
ADDRLP4 0
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 16
INDIRU4
CNSTU4 0
EQU4 $360
ADDRLP4 16
INDIRU4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
INDIRI4
CNSTI4 0
NEI4 $358
LABELV $360
line 852
;852:			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_blueflag in map\n" );
ADDRGP4 $351
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 853
;853:		}
LABELV $358
line 854
;854:		item = BG_FindItem( "Neutral Flag" );
ADDRGP4 $361
ARGP4
ADDRLP4 20
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 855
;855:		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
ADDRLP4 24
ADDRLP4 0
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 24
INDIRU4
CNSTU4 0
EQU4 $364
ADDRLP4 24
INDIRU4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
INDIRI4
CNSTI4 0
NEI4 $362
LABELV $364
line 856
;856:			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_neutralflag in map\n" );
ADDRGP4 $365
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 857
;857:		}
LABELV $362
line 858
;858:	}
LABELV $352
line 860
;859:
;860:	if( g_gametype.integer == GT_OBELISK ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 6
NEI4 $366
line 864
;861:		gentity_t	*ent;
;862:
;863:		// check for the two obelisks
;864:		ent = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 865
;865:		ent = G_Find( ent, FOFS(classname), "team_redobelisk" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $369
ARGP4
ADDRLP4 4
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 866
;866:		if( !ent ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $370
line 867
;867:			G_Printf( S_COLOR_YELLOW "WARNING: No team_redobelisk in map\n" );
ADDRGP4 $372
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 868
;868:		}
LABELV $370
line 870
;869:
;870:		ent = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 871
;871:		ent = G_Find( ent, FOFS(classname), "team_blueobelisk" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $373
ARGP4
ADDRLP4 8
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 872
;872:		if( !ent ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $374
line 873
;873:			G_Printf( S_COLOR_YELLOW "WARNING: No team_blueobelisk in map\n" );
ADDRGP4 $376
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 874
;874:		}
LABELV $374
line 875
;875:	}
LABELV $366
line 877
;876:
;877:	if( g_gametype.integer == GT_HARVESTER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
NEI4 $377
line 881
;878:		gentity_t	*ent;
;879:
;880:		// check for all three obelisks
;881:		ent = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 882
;882:		ent = G_Find( ent, FOFS(classname), "team_redobelisk" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $369
ARGP4
ADDRLP4 4
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 883
;883:		if( !ent ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $380
line 884
;884:			G_Printf( S_COLOR_YELLOW "WARNING: No team_redobelisk in map\n" );
ADDRGP4 $372
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 885
;885:		}
LABELV $380
line 887
;886:
;887:		ent = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 888
;888:		ent = G_Find( ent, FOFS(classname), "team_blueobelisk" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $373
ARGP4
ADDRLP4 8
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 889
;889:		if( !ent ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $382
line 890
;890:			G_Printf( S_COLOR_YELLOW "WARNING: No team_blueobelisk in map\n" );
ADDRGP4 $376
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 891
;891:		}
LABELV $382
line 893
;892:
;893:		ent = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 894
;894:		ent = G_Find( ent, FOFS(classname), "team_neutralobelisk" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $384
ARGP4
ADDRLP4 12
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 895
;895:		if( !ent ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $385
line 896
;896:			G_Printf( S_COLOR_YELLOW "WARNING: No team_neutralobelisk in map\n" );
ADDRGP4 $387
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 897
;897:		}
LABELV $385
line 898
;898:	}
LABELV $377
line 900
;899:#endif
;900:}
LABELV $338
endproc G_CheckTeamItems 28 12
export ClearRegisteredItems
proc ClearRegisteredItems 12 12
line 907
;901:
;902:/*
;903:==============
;904:ClearRegisteredItems
;905:==============
;906:*/
;907:void ClearRegisteredItems( void ) {
line 908
;908:	memset( itemRegistered, 0, sizeof( itemRegistered ) );
ADDRGP4 itemRegistered
ARGP4
CNSTI4 0
ARGI4
CNSTU4 1024
ARGU4
ADDRGP4 memset
CALLP4
pop
line 911
;909:
;910:	// players always start with the base weapon	
;911:	if (g_instagib.integer) {
ADDRGP4 g_instagib+12
INDIRI4
CNSTI4 0
EQI4 $389
line 912
;912:		RegisterItem( BG_FindItemForWeapon( WP_RAILGUN ));
CNSTI4 7
ARGI4
ADDRLP4 0
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 913
;913:	} else {
ADDRGP4 $390
JUMPV
LABELV $389
line 914
;914:		RegisterItem( BG_FindItemForWeapon( WP_MACHINEGUN ) );
CNSTI4 2
ARGI4
ADDRLP4 0
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 915
;915:	}
LABELV $390
line 916
;916:	RegisterItem( BG_FindItemForWeapon( WP_GAUNTLET ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 918
;917:#ifdef MISSIONPACK
;918:	if( g_gametype.integer == GT_HARVESTER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
NEI4 $392
line 919
;919:		RegisterItem( BG_FindItem( "Red Cube" ) );
ADDRGP4 $395
ARGP4
ADDRLP4 4
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 920
;920:		RegisterItem( BG_FindItem( "Blue Cube" ) );
ADDRGP4 $396
ARGP4
ADDRLP4 8
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 921
;921:	}
LABELV $392
line 923
;922:#endif
;923:	G_RegisterWeapon();
ADDRGP4 G_RegisterWeapon
CALLV
pop
line 924
;924:}
LABELV $388
endproc ClearRegisteredItems 12 12
export RegisterItem
proc RegisterItem 0 4
line 933
;925:
;926:/*
;927:===============
;928:RegisterItem
;929:
;930:The item will be added to the precache list
;931:===============
;932:*/
;933:void RegisterItem( gitem_t *item ) {
line 934
;934:	if ( !item ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $398
line 935
;935:		G_Error( "RegisterItem: NULL" );
ADDRGP4 $400
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 936
;936:	}
LABELV $398
line 937
;937:	itemRegistered[ item - bg_itemlist ] = qtrue;
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
CNSTI4 1
ASGNI4
line 938
;938:}
LABELV $397
endproc RegisterItem 0 4
export SaveRegisteredItems
proc SaveRegisteredItems 268 8
line 949
;939:
;940:
;941:/*
;942:===============
;943:SaveRegisteredItems
;944:
;945:Write the needed items to a config string
;946:so the client will know which ones to precache
;947:===============
;948:*/
;949:void SaveRegisteredItems( void ) {
line 954
;950:	char	string[MAX_ITEMS+1];
;951:	int		i;
;952:	int		count;
;953:
;954:	count = 0;
ADDRLP4 264
CNSTI4 0
ASGNI4
line 955
;955:	for ( i = 0 ; i < bg_numItems ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $405
JUMPV
LABELV $402
line 956
;956:		if ( itemRegistered[i] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
INDIRI4
CNSTI4 0
EQI4 $406
line 957
;957:			count++;
ADDRLP4 264
ADDRLP4 264
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 958
;958:			string[i] = '1';
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 49
ASGNI1
line 959
;959:		} else {
ADDRGP4 $407
JUMPV
LABELV $406
line 960
;960:			string[i] = '0';
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 48
ASGNI1
line 961
;961:		}
LABELV $407
line 962
;962:	}
LABELV $403
line 955
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $405
ADDRLP4 0
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $402
line 963
;963:	string[ bg_numItems ] = 0;
ADDRGP4 bg_numItems
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 0
ASGNI1
line 965
;964:
;965:	G_Printf( "%i items registered\n", count );
ADDRGP4 $408
ARGP4
ADDRLP4 264
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 966
;966:	trap_SetConfigstring(CS_ITEMS, string);
CNSTI4 27
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 967
;967:}
LABELV $401
endproc SaveRegisteredItems 268 8
export G_ItemDisabled
proc G_ItemDisabled 132 16
line 974
;968:
;969:/*
;970:============
;971:G_ItemDisabled
;972:============
;973:*/
;974:int G_ItemDisabled( gitem_t *item ) {
line 978
;975:
;976:	char name[128];
;977:
;978:	Com_sprintf(name, sizeof(name), "disable_%s", item->classname);
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $410
ARGP4
ADDRFP4 0
INDIRP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 979
;979:	return trap_Cvar_VariableIntegerValue( name );
ADDRLP4 0
ARGP4
ADDRLP4 128
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
RETI4
LABELV $409
endproc G_ItemDisabled 132 16
export G_SpawnItem
proc G_SpawnItem 8 12
line 992
;980:}
;981:
;982:/*
;983:============
;984:G_SpawnItem
;985:
;986:Sets the clipping size and plants the object on the floor.
;987:
;988:Items can't be immediately dropped to floor, because they might
;989:be on an entity that hasn't spawned yet.
;990:============
;991:*/
;992:void G_SpawnItem( gentity_t *ent, gitem_t *item ) {
line 994
;993:
;994:	G_SpawnFloat( "random", "0", &ent->random );
ADDRGP4 $412
ARGP4
ADDRGP4 $413
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 995
;995:	G_SpawnFloat( "wait", "0", &ent->wait );
ADDRGP4 $414
ARGP4
ADDRGP4 $413
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 997
;996:
;997:	RegisterItem( item );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 999
;998:
;999:	if ( G_ItemDisabled( item ) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 G_ItemDisabled
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $415
line 1000
;1000:		ent->tag = TAG_DONTSPAWN;
ADDRFP4 0
INDIRP4
CNSTI4 820
ADDP4
CNSTI4 1
ASGNI4
line 1001
;1001:		return;
ADDRGP4 $411
JUMPV
LABELV $415
line 1004
;1002:	}
;1003:
;1004:	ent->item = item;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
ADDRFP4 4
INDIRP4
ASGNP4
line 1007
;1005:	// some movers spawn on the second frame, so delay item
;1006:	// spawns until the third frame so they can ride trains
;1007:	ent->nextthink = level.time + FRAMETIME * 2;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 1008
;1008:	ent->think = FinishSpawningItem;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 FinishSpawningItem
ASGNP4
line 1010
;1009:
;1010:	ent->physicsBounce = 0.50;		// items are bouncy
ADDRFP4 0
INDIRP4
CNSTI4 568
ADDP4
CNSTF4 1056964608
ASGNF4
line 1012
;1011:
;1012:	if ( item->giType == IT_POWERUP ) {
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $418
line 1013
;1013:		G_SoundIndex( "sound/items/poweruprespawn.wav" );
ADDRGP4 $246
ARGP4
ADDRGP4 G_SoundIndex
CALLI4
pop
line 1014
;1014:		G_SpawnFloat( "noglobalsound", "0", &ent->speed);
ADDRGP4 $420
ARGP4
ADDRGP4 $413
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 1015
;1015:	}
LABELV $418
line 1018
;1016:
;1017:#ifdef MISSIONPACK
;1018:	if ( item->giType == IT_PERSISTANT_POWERUP ) {
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 7
NEI4 $421
line 1019
;1019:		ent->s.generic1 = ent->spawnflags;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 204
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ASGNI4
line 1020
;1020:	}
LABELV $421
line 1022
;1021:#endif
;1022:}
LABELV $411
endproc G_SpawnItem 8 12
export G_BounceItem
proc G_BounceItem 52 12
line 1031
;1023:
;1024:
;1025:/*
;1026:================
;1027:G_BounceItem
;1028:
;1029:================
;1030:*/
;1031:void G_BounceItem( gentity_t *ent, trace_t *trace ) {
line 1037
;1032:	vec3_t	velocity;
;1033:	float	dot;
;1034:	int		hitTime;
;1035:
;1036:	// reflect the velocity on the trace plane
;1037:	hitTime = level.previousTime + ( level.time - level.previousTime ) * trace->fraction;
ADDRLP4 16
ADDRGP4 level+36
INDIRI4
CVIF4 4
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+36
INDIRI4
SUBI4
CVIF4 4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 1038
;1038:	BG_EvaluateTrajectoryDelta( &ent->s.pos, hitTime, velocity );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BG_EvaluateTrajectoryDelta
CALLV
pop
line 1039
;1039:	dot = DotProduct( velocity, trace->plane.normal );
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1040
;1040:	VectorMA( velocity, -2*dot, trace->plane.normal, ent->s.pos.trDelta );
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 3221225472
MULF4
MULF4
ADDF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0+4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 3221225472
MULF4
MULF4
ADDF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 0+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 3221225472
MULF4
MULF4
ADDF4
ASGNF4
line 1043
;1041:
;1042:	// cut the velocity to keep from bouncing forever
;1043:	VectorScale( ent->s.pos.trDelta, ent->physicsBounce, ent->s.pos.trDelta );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 568
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 568
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 568
ADDP4
INDIRF4
MULF4
ASGNF4
line 1046
;1044:
;1045:	// check for stop
;1046:	if ( trace->plane.normal[2] > 0 && ent->s.pos.trDelta[2] < 40 ) {
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 0
LEF4 $431
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
CNSTF4 1109393408
GEF4 $431
line 1047
;1047:		trace->endpos[2] += 1.0;	// make sure it is off ground
ADDRLP4 36
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1048
;1048:		SnapVector( trace->endpos );
ADDRLP4 40
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 44
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 48
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 1049
;1049:		G_SetOrigin( ent, trace->endpos );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 1050
;1050:		ent->s.groundEntityNum = trace->entityNum;
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ASGNI4
line 1051
;1051:		return;
ADDRGP4 $423
JUMPV
LABELV $431
line 1054
;1052:	}
;1053:
;1054:	VectorAdd( ent->r.currentOrigin, trace->plane.normal, ent->r.currentOrigin);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 492
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 496
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1055
;1055:	VectorCopy( ent->r.currentOrigin, ent->s.pos.trBase );
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 1056
;1056:	ent->s.pos.trTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1057
;1057:}
LABELV $423
endproc G_BounceItem 52 12
export G_RunItem
proc G_RunItem 88 28
line 1066
;1058:
;1059:
;1060:/*
;1061:================
;1062:G_RunItem
;1063:
;1064:================
;1065:*/
;1066:void G_RunItem( gentity_t *ent ) {
line 1073
;1067:	vec3_t		origin;
;1068:	trace_t		tr;
;1069:	int			contents;
;1070:	int			mask;
;1071:
;1072:	// if its groundentity has been set to ENTITYNUM_NONE, it may have been pushed off an edge
;1073:	if ( ent->s.groundEntityNum == ENTITYNUM_NONE ) {
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $435
line 1074
;1074:		if ( ent->s.pos.trType != TR_GRAVITY ) {
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 5
EQI4 $437
line 1075
;1075:			ent->s.pos.trType = TR_GRAVITY;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
line 1076
;1076:			ent->s.pos.trTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1077
;1077:		}
LABELV $437
line 1078
;1078:	}
LABELV $435
line 1080
;1079:
;1080:	if ( ent->s.pos.trType == TR_STATIONARY ) {
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
NEI4 $440
line 1082
;1081:		// check think function
;1082:		G_RunThink( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunThink
CALLV
pop
line 1083
;1083:		return;
ADDRGP4 $434
JUMPV
LABELV $440
line 1087
;1084:	}
;1085:
;1086:	// get current position
;1087:	BG_EvaluateTrajectory( &ent->s.pos, level.time, origin );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 56
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1090
;1088:
;1089:	// trace a line from the previous position to the current position
;1090:	if ( ent->clipmask ) {
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
CNSTI4 0
EQI4 $443
line 1091
;1091:		mask = ent->clipmask;
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
ASGNI4
line 1092
;1092:	} else {
ADDRGP4 $444
JUMPV
LABELV $443
line 1093
;1093:		mask = MASK_PLAYERSOLID & ~CONTENTS_BODY;//MASK_SOLID;
ADDRLP4 72
CNSTI4 65537
ASGNI4
line 1094
;1094:	}
LABELV $444
line 1095
;1095:	trap_Trace( &tr, ent->r.currentOrigin, ent->r.mins, ent->r.maxs, origin, 
ADDRLP4 0
ARGP4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1098
;1096:		ent->r.ownerNum, mask );
;1097:
;1098:	VectorCopy( tr.endpos, ent->r.currentOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 0+12
INDIRB
ASGNB 12
line 1100
;1099:
;1100:	if ( tr.startsolid ) {
ADDRLP4 0+4
INDIRI4
CNSTI4 0
EQI4 $446
line 1101
;1101:		tr.fraction = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1102
;1102:	}
LABELV $446
line 1104
;1103:
;1104:	trap_LinkEntity( ent );	// FIXME: avoid this for stationary?
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1107
;1105:
;1106:	// check think function
;1107:	G_RunThink( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunThink
CALLV
pop
line 1109
;1108:
;1109:	if ( tr.fraction == 1 ) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
NEF4 $450
line 1110
;1110:		return;
ADDRGP4 $434
JUMPV
LABELV $450
line 1114
;1111:	}
;1112:
;1113:	// if it is in a nodrop volume, remove it
;1114:	contents = trap_PointContents( ent->r.currentOrigin, -1 );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 80
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 68
ADDRLP4 80
INDIRI4
ASGNI4
line 1115
;1115:	if ( contents & CONTENTS_NODROP ) {
ADDRLP4 68
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
EQU4 $453
line 1116
;1116:		if (ent->item && ent->item->giType == IT_TEAM) {
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $455
ADDRLP4 84
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $455
line 1117
;1117:			Team_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Team_FreeEntity
CALLV
pop
line 1118
;1118:		} else {
ADDRGP4 $434
JUMPV
LABELV $455
line 1119
;1119:			G_FreeEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 1120
;1120:		}
line 1121
;1121:		return;
ADDRGP4 $434
JUMPV
LABELV $453
line 1124
;1122:	}
;1123:
;1124:	G_BounceItem( ent, &tr );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_BounceItem
CALLV
pop
line 1125
;1125:}
LABELV $434
endproc G_RunItem 88 28
bss
export itemRegistered
align 4
LABELV itemRegistered
skip 1024
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
import ArmorIndex
import Think_Weapon
import SetRespawn
import PrecacheItem
import UseHoldableItem
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
LABELV $420
byte 1 110
byte 1 111
byte 1 103
byte 1 108
byte 1 111
byte 1 98
byte 1 97
byte 1 108
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $414
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $413
byte 1 48
byte 1 0
align 1
LABELV $412
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $410
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 95
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $408
byte 1 37
byte 1 105
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $400
byte 1 82
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 0
align 1
LABELV $396
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
LABELV $395
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
LABELV $387
byte 1 94
byte 1 51
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 78
byte 1 111
byte 1 32
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
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $384
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
LABELV $376
byte 1 94
byte 1 51
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 78
byte 1 111
byte 1 32
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
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $373
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
LABELV $372
byte 1 94
byte 1 51
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 78
byte 1 111
byte 1 32
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
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $369
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
LABELV $365
byte 1 94
byte 1 51
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 78
byte 1 111
byte 1 32
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
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $361
byte 1 78
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $351
byte 1 94
byte 1 51
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 78
byte 1 111
byte 1 32
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
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $347
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $346
byte 1 94
byte 1 51
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 78
byte 1 111
byte 1 32
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
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $342
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $328
byte 1 70
byte 1 105
byte 1 110
byte 1 105
byte 1 115
byte 1 104
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 73
byte 1 116
byte 1 101
byte 1 109
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
LABELV $260
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $251
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 107
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 101
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $246
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $230
byte 1 82
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $159
byte 1 104
byte 1 97
byte 1 110
byte 1 100
byte 1 105
byte 1 99
byte 1 97
byte 1 112
byte 1 0
