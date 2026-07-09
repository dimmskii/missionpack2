#include "q_shared.h"
#include "bg_public.h"

/*
===============
GT_IsTeam

Returns whether or not gametype is team-based. See GT_ enums in bg_public.h
===============
*/
qboolean GT_IsTeam( int gt ) {
	if (gt < GT_TEAM || gt > GT_MAX_TEAM) {
		return qfalse;
	}
	return qtrue;
}

/*
===============
GT_IsDMGame

Returns whether or not gametype is frag-based. See GT_ enums in bg_public.h
Should be equivalent of gt <= GT_TEAM
===============
*/
qboolean GT_IsDMGame( int gt ) {
	if (gt > GT_TEAM) {
		return qfalse;
	}
	return qtrue;
}

/*
===============
GT_IsArenaGame

Returns whether or not gametype is round-based. See GT_ enums in bg_public.h
===============
*/
qboolean GT_IsArenaGame( int gt ) {
	if (gt == GT_CLAN_ARENA || gt == GT_ARENA || gt == GT_FREEZE) { // GT_FREEZE should behave identically to Clan Arena; in that case, we might just flip on the g_freeze cvar upon detecting it. QL reverse-compat.
		return qtrue;
	}
	return qfalse;
}

/*
===============
GT_IsFlagGame

Returns whether or not gametype is flag-based. See GT_ enums in bg_public.h
Should be equivalent of pre-QL (i.e. MPP) gt >= GT_CTF. Matters a lot with bots.
===============
*/
qboolean GT_IsFlagGame( int gt ) {
	if (gt < GT_CTF || gt > GT_HARVESTER) {
		return qfalse;
	}
	return qtrue;
}
