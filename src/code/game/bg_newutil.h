// bg_newutil.h -- New shared utility helpers header -- included from bg_public.h
//
// By Dimmskii
//

// minimum average RGB brightness enforced on player model part colors
#define MIN_PLAYERCOLOR_BRIGHTNESS 0.25f

qboolean BG_ParseHexColor( const char *str, vec4_t color );
void BG_ClampColorBrightness( vec4_t color, float floor );
