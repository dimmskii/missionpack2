//**********************************************//
//	models/weapons3/hmg subfolder		//
//**********************************************//

models/weapons3/hmg/hmg
{
	cull disable
	nopicmip
    {
	    map textures/effects/tinfx.tga
		tcGen environment
		blendfunc GL_ONE GL_ZERO
        rgbGen identity
    }
	{
		map	models/weapons3/hmg/hmg.tga
		blendfunc blend
		rgbGen lightingDiffuse	
	}
}

models/weapons3/hmg/f_hmg
{
	nopicmip
	sort additive
	cull disable
	{
		map	models/weapons3/hmg/f_hmg.tga
		blendfunc add
	}
}

models/powerups/ammo/hmgammo
{
	nopicmip
    {
	    map textures/effects/tinfx2d.tga
		tcGen environment
		blendfunc GL_ONE GL_ZERO
        rgbGen identity
    }
    {
	    map models/powerups/ammo/hmgammo.tga
		blendfunc blend
        rgbGen lightingDiffuse
    }
}

models/powerups/ammo/hmgammo1
{
	nopicmip
    {
	    map textures/effects/envmapmach.tga
		tcGen environment
		blendfunc GL_ONE GL_ZERO
        rgbGen lightingDiffuse
    }
}

models/powerups/ammo/hmgammo2
{
	nopicmip
	{
		map models/powerups/ammo/hmgammo2.tga
		rgbGen identity
	}
}