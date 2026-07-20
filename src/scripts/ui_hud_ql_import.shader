// ~Dimmskii
// Cherry-picked, unmodified shader stanzas from real Quake Live's
// scripts/ui_hud.shader and scripts/icons.shader (source: user-provided
// pak00.pk3), for the specific ui/assets referenced by the real QL
// hud.menu/hud3.menu that this codebase's CG_AdjustFrom640/widescreen and
// font work has been targeting this session.
//
// NOT wired into the build yet - this file exists so these stanzas can be
// reviewed and merged into scripts/ui_hud.shader / scripts/icons.shader (or
// kept standalone) manually, on purpose, rather than silently landing in a
// tracked shader file via an automated pass. See also the extraction/font
// baking tooling in /mnt/shared/pk3src/ (outside this repo, since it stages
// QL's original assets before any of them are chosen for a real commit).
//
// Only the 11 stanzas actually referenced by hud.menu/hud3.menu background
// paths were pulled (not the full 573+247 line source files) - grep hud.menu
// /hud3.menu for the exact ui/assets/... path if you need to check what's
// still missing.

ui/assets/hud/rteambgl
{
	nopicmip
	{	map ui/assets/hud/rteambgl.tga
		blendfunc blend
		//tcMod scroll 7.1  0.2
		//tcmod scale .8 1
		rgbgen wave sin .5 .5 0 1
	}
}

ui/assets/hud/rteambgr
{
	nopicmip
	{	map ui/assets/hud/rteambgr.tga
		blendfunc blend
		//tcMod scroll 7.1  0.2
		//tcmod scale .8 1
		rgbgen wave sin .5 .5 0 1
	}
}

ui/assets/hud/bteambgl
{
	nopicmip
	{	map ui/assets/hud/bteambgl.tga
		blendfunc blend
		//tcMod scroll 7.1  0.2
		//tcmod scale .8 1
		rgbgen wave sin .5 .5 0 1
	}
}

ui/assets/hud/bteambgr
{
	nopicmip
	{	map ui/assets/hud/bteambgr.tga
		blendfunc blend
		//tcMod scroll 7.1  0.2
		//tcmod scale .8 1
		rgbgen wave sin .5 .5 0 1
	}
}

ui/assets/hud/tdm
{
	nopicmip
	{	map ui/assets/hud/tdm.tga
		blendfunc blend
		alphaFunc GE128
	}
}

ui/assets/hud/ctf
{
	nopicmip
	{	map ui/assets/hud/ctf.tga
		blendfunc blend
		alphaFunc GE128
	}
}

ui/assets/hud/weaplit2
{
	nopicmip
	{
		map ui/assets/hud/weaplit2.tga
		blendfunc blend
	}
}

ui/assets/score/ca_score_red
{
	nopicmip
	{	map ui/assets/score/ca_score_red.tga
		blendfunc blend
	}
}

ui/assets/score/ca_score_blu
{
	nopicmip
	{	map ui/assets/score/ca_score_blu.tga
		blendfunc blend
	}
}

icons/skull_red
{
	nopicmip
	{
		map icons/skull_red.tga
		blendfunc blend
	}
}

icons/skull_blue
{
	nopicmip
	{
		map icons/skull_blue.tga
		blendfunc blend
	}
}
// END Dimmskii
