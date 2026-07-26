// bg_newutil.c -- New shared utility helpers
//
// By Dimmskii
//

#include "q_shared.h"
#include "bg_public.h"

static int BG_HexDigit( char c ) {
	if ( c >= '0' && c <= '9' )
		return c - '0';
	if ( c >= 'a' && c <= 'f' )
		return c - 'a' + 10;
	if ( c >= 'A' && c <= 'F' )
		return c - 'A' + 10;
	return -1;
}

/*
===============
BG_ParseHexColor

Parses RGB, RRGGBB or RRGGBBAA (QL order, alpha last) into color.
Accepts #/0x/bare prefix; alpha defaults to 1.0. Returns qfalse if unparsable.
===============
*/
qboolean BG_ParseHexColor( const char *str, vec4_t color ) {
	int digits[8];
	int len, i;

	if ( !str || !str[0] || !Q_stricmp( str, "NULL" ) ) {
		return qfalse;
	}

	if ( str[0] == '#' ) {
		str++;
	} else if ( str[0] == '0' && ( str[1] == 'x' || str[1] == 'X' ) ) {
		str += 2;
	}

	for ( len = 0 ; str[len] ; len++ ) {
		if ( len == 8 ) {
			return qfalse;
		}
		digits[len] = BG_HexDigit( str[len] );
		if ( digits[len] < 0 ) {
			return qfalse;
		}
	}

	if ( len == 3 ) {
		for ( i = 0 ; i < 3 ; i++ ) {
			color[i] = ( digits[i] * 17 ) / 255.0f;
		}
		color[3] = 1.0f;
	} else if ( len == 6 || len == 8 ) {
		for ( i = 0 ; i < 3 ; i++ ) {
			color[i] = ( digits[i * 2] * 16 + digits[i * 2 + 1] ) / 255.0f;
		}
		color[3] = ( len == 8 ) ? ( digits[6] * 16 + digits[7] ) / 255.0f : 1.0f;
	} else {
		return qfalse;
	}

	return qtrue;
}

/*
===============
BG_ClampColorBrightness

Raises color to at least floor average RGB brightness so players can't force
black models. Scales existing hue up; near-black offsets toward grey. Alpha untouched.
===============
*/
void BG_ClampColorBrightness( vec4_t color, float floor ) {
	float avg, scale;
	int i;

	avg = ( color[0] + color[1] + color[2] ) / 3.0f;
	if ( avg >= floor ) {
		return;
	}

	if ( avg < 0.01f ) {
		// no hue worth scaling; offset all channels up instead
		for ( i = 0 ; i < 3 ; i++ ) {
			color[i] += floor - avg;
		}
		return;
	}

	scale = floor / avg;
	for ( i = 0 ; i < 3 ; i++ ) {
		color[i] *= scale;
		if ( color[i] > 1.0f ) {
			color[i] = 1.0f;
		}
	}
}
