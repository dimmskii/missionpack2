// By Dimmskii

#include "g_local.h"

void Arena_BeginRound( void ) {
	int			i;
	gclient_t	*client;

	// Reset spectator follow state for dead arena players before respawning
	for ( i = 0; i < level.maxclients; i++ ) {
		client = &level.clients[i];
		if ( client->pers.connected != CON_CONNECTED ) {
			continue;
		}
		if ( client->sess.sessionTeam == TEAM_SPECTATOR ) {
			continue;
		}
		client->sess.spectatorState = SPECTATOR_NOT;
		client->sess.spectatorClient = i;
		client->ps.pm_flags &= ~PMF_FOLLOW;
	}

	// Begin new round code
	level.warmupTime = level.time + g_warmup.integer * 1000;
	trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );

	respawnAll();
	CalculateRanks(); // Make sure scoreboard is sorted immediately? -- AKA Fix my scores please fresh out of spec mod
}

vec3_t zeroVec3 = {0, 0, 0};
void Arena_EndRound( team_t winningTeam ) {
	
	if ( winningTeam == TEAM_RED || winningTeam == TEAM_BLUE ) { // CA
		AddTeamScore(zeroVec3, winningTeam, 1);
		trap_SetConfigstring( CS_SCORES1, va("%i", level.teamScores[TEAM_RED]) );
		trap_SetConfigstring( CS_SCORES2, va("%i", level.teamScores[TEAM_BLUE]) );
		CalculateRanks(); // Make sure clan arena scoreboard is sorted immediately
	} else if ( winningTeam != TEAM_SPECTATOR ) { // FFA
		int			i, aliveCount;
		gentity_t	*clientEnt;
		gentity_t	*clientEntWon;
	
		// Loop through all clients
		aliveCount = 0;
		for ( i = 0 ; i < level.maxclients ; i++ ) {
			clientEnt = g_entities + i;
			if ( !clientEnt->inuse )
				continue;
			
			// If not spectator and alive, add arena score
			if ( clientEnt->client->sess.sessionTeam != TEAM_SPECTATOR && clientEnt->health > 0 ) {
				clientEntWon = clientEnt;
				aliveCount ++;
			}
		}
		
		if (aliveCount == 1) { // We only award FFA arena point if exactly one person remains in the round (to conider: we assume it's a timeout draw otherwise)
			clientEntWon->client->ps.persistant[PERS_ROUNDWINS] ++;
			//clientEntWon->client->ps.persistant[PERS_CAPTURES] ++; // Temp hack to display
			CalculateRanks(); // Make sure FFA arena scoreboard is sorted immediately
			if ( g_roundlimit.integer ) {
				if ( clientEntWon->client->ps.persistant[PERS_ROUNDWINS] >= g_roundlimit.integer ) {
					level.arenaRoundQueued = level.time; // Stops CheckExitRules from re-triggering the round timeout every frame
					return; // Round enqueue after winning preventative measure
				}
			}
		}
	}
	
	if ( g_roundlimit.integer ) {
		if ( level.teamScores[TEAM_RED] >= g_roundlimit.integer || level.teamScores[TEAM_BLUE] >= g_roundlimit.integer ) {
			level.arenaRoundQueued = level.time; // Stops CheckExitRules from re-triggering the round timeout every frame
			return; // Round enqueue after winning preventative measure
		}
	}
	
	level.arenaRoundQueued = level.time;
	
}

void Arena_TimeoutRound( void ) {
	int totalRed, totalBlue;
	
	totalRed = Team_CountTotalHealth(TEAM_RED,qfalse)+Team_CountTotalArmor(TEAM_RED,qfalse);
	totalBlue = Team_CountTotalHealth(TEAM_BLUE,qfalse)+Team_CountTotalArmor(TEAM_BLUE,qfalse);
	
	// Decided Team Arena round end
	if ( totalRed > totalBlue ) {
		Arena_EndRound( TEAM_RED );
		return;
	} else if ( totalBlue > totalRed ) {
		Arena_EndRound( TEAM_BLUE );
		return;
	}
	
	Arena_EndRound( TEAM_FREE ); // FFA Arena and undecided Team Arena round end
}

/*
=============
Arena_MatchDecided

True once a side/player has already reached g_roundlimit. Lets callers in the
round-timeout path know the match outcome is final so they don't keep
re-triggering round-end logic (and re-broadcasting/re-scoring) while waiting
for CheckExitRules to queue the intermission.
=============
*/
qboolean Arena_MatchDecided( void ) {
	if ( !g_roundlimit.integer ) {
		return qfalse;
	}

	if ( g_gametype.integer == GT_ARENA ) {
		int			i;
		gclient_t	*cl;

		for ( i = 0 ; i < level.maxclients ; i++ ) {
			cl = level.clients + i;
			if ( cl->pers.connected != CON_CONNECTED ) {
				continue;
			}
			if ( cl->sess.sessionTeam != TEAM_FREE ) {
				continue;
			}
			if ( cl->ps.persistant[PERS_ROUNDWINS] >= g_roundlimit.integer ) {
				return qtrue;
			}
		}
		return qfalse;
	} else if ( g_gametype.integer == GT_CLAN_ARENA || g_gametype.integer == GT_FREEZE ) {
		return ( level.teamScores[TEAM_RED] >= g_roundlimit.integer || level.teamScores[TEAM_BLUE] >= g_roundlimit.integer );
	}

	return qfalse;
}

void Arena_CheckRules( void ) {
	if ( level.warmupTime || level.intermissiontime || level.intermissionQueued ) {
		return;
	}
	
	if ( level.numPlayingClients < 2 ) {
		return;
	}
	
	if ( level.arenaRoundQueued ) {
		if ( level.time - level.arenaRoundQueued >= ARENA_ROUND_DELAY_TIME ) {
			// Don't spin up a new round once the match is already decided;
			// CheckExitRules will queue the intermission shortly.
			if ( Arena_MatchDecided() ) {
				return;
			}
			level.arenaRoundQueued = 0;
			Arena_BeginRound();
		}
		return;
	}
	
	if ( g_gametype.integer == GT_ARENA ) {
		// Check if one person remains on FFA team
		if ( Team_PlayerCountAlive(TEAM_FREE) < 2 ) {
			Arena_EndRound( TEAM_FREE ); // The round wins the round
		}
	} else if ( g_gametype.integer == GT_CLAN_ARENA || g_gametype.integer == GT_FREEZE ) {
		// Check if either team has no players remaining ; if so, call Arena_EndRound
		if ( Team_PlayerCountAlive(TEAM_RED) < 1 ) {
			Arena_EndRound( TEAM_BLUE ); // Blue wins the round
		} else if ( Team_PlayerCountAlive(TEAM_BLUE) < 1 ) {
			Arena_EndRound( TEAM_RED ); // Red wins the round
		}
	} 
}

