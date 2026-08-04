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
BG_NormalizeHexColor

Rewrites any accepted hex form as canonical #RRGGBB, dropping alpha - model
rendering forces shaderRGBA[3] anyway. Unparsable input yields an empty string.
===============
*/
void BG_NormalizeHexColor( const char *in, char *out, int outSize ) {
	static const char hexDigits[] = "0123456789ABCDEF";
	vec4_t c;
	int i, v;

	if ( !out || outSize < 1 ) {
		return;
	}
	if ( outSize < MAX_HEXCOLOR_STRING || !BG_ParseHexColor( in, c ) ) {
		out[0] = '\0';
		return;
	}

	out[0] = '#';
	for ( i = 0 ; i < 3 ; i++ ) {
		v = (int)( c[i] * 255.0f + 0.5f );
		if ( v < 0 ) {
			v = 0;
		}
		if ( v > 255 ) {
			v = 255;
		}
		out[1 + i * 2] = hexDigits[( v >> 4 ) & 0xF];
		out[2 + i * 2] = hexDigits[v & 0xF];
	}
	out[7] = '\0';
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

/*
===============
BG_CompressColorBrightness

Squeezes a color into [floor,1] by its brightest channel, for additive shaders
where a dark color doesn't read as dark, it reads as invisible. Unlike
BG_ClampColorBrightness this lifts every color, not just ones under a floor -
the target rises with the input, so brighter stays brighter and white is
untouched. Keys on the max channel rather than the average on purpose: scaling by
the average drives saturated colors past 1.0, and the clamp then flattens the
whole dark end to full saturation, losing the depth this is meant to keep. A pure
scale of the max preserves hue and saturation exactly and can never overflow.
Alpha untouched.
===============
*/
void BG_CompressColorBrightness( vec4_t color, float floor ) {
	float value, target, scale;
	int i;

	value = color[0];
	for ( i = 1 ; i < 3 ; i++ ) {
		if ( color[i] > value ) {
			value = color[i];
		}
	}

	target = floor + value * ( 1.0f - floor );
	if ( value >= target ) {
		return;
	}

	if ( value < 0.01f ) {
		// no hue worth scaling; grey at the floor instead
		for ( i = 0 ; i < 3 ; i++ ) {
			color[i] = target;
		}
		return;
	}

	scale = target / value;
	for ( i = 0 ; i < 3 ; i++ ) {
		color[i] *= scale;
	}
}
