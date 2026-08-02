// ui_ua.shader -- Ultimate Arena menu shaders
//
// By Dimmskii
//
// Shaders in here should be exclusively or mostly used in ui qvm (frontend)
//

centerconsole2
{

	nopicmip
	nomipmaps
        
        {
		clampmap textures/sfx/console01.tga
		blendfunc add   
		rgbgen wave sin .15 0 0 0         
		tcMod rotate 20
	}
        {
		clampmap textures/sfx/console02.tga
		rgbgen wave sin .5 0 0 0             
		tcMod rotate -60
		blendFunc add
	}
}

fight
{
	nopicmip
	nomipmaps
	{
		map ui/assets/fight.tga
		blendfunc add
		rgbgen wave sin .05 0 0 0
		tcmod scroll .04 0
	}
}

hudalert
{
	nopicmip
	nomipmaps
    
       		{	map ui/assets/red_box.tga
                	blendFunc GL_ONE GL_ZERO
                	tcMod scroll 7.1  0.2
               		tcmod scale .8 1
			rgbgen wave sin .25 .25 0 1
		}   
	}

hudalert_blue
{
	nopicmip
	nomipmaps
    
       		{	map ui/assets/blue_box.tga
                	blendFunc GL_ONE GL_ZERO
                	tcMod scroll 7.1  0.2
               		tcmod scale .8 1
			rgbgen wave sin .25 .25 0 1
		}   
	}

hudalert_good
{
	nopicmip
	nomipmaps
    
       		{	map ui/assets/green_box.tga
                	blendFunc GL_ONE GL_ZERO
                	tcMod scroll 7.1  0.2
               		tcmod scale .8 1
			rgbgen wave sin .25 .25 0 1
		}   
	}

hudalert_red
{
	nopicmip
	nomipmaps
    
       		{	map ui/assets/red_box.tga
                	blendFunc GL_ONE GL_ZERO
                	tcMod scroll 7.1  0.2
               		tcmod scale .8 1
			rgbgen wave sin .25 .25 0 1
		}   
	}

lightningkc
	{
	nopicmip
	nomipmaps
	{
		animMap 10 ui/assets/blu01.tga ui/assets/blu02.tga ui/assets/blu03.tga ui/assets/blu04.tga ui/assets/blu05.tga ui/assets/blu06.tga ui/assets/blu07.tga ui/assets/blu08.tga 
		blendFunc add	
		rgbGen wave inverseSawtooth 0 1 0 10	
	}	
	}

menuback_b_main
{
	
	nopicmip
	nomipmaps
	{
		map ui/assets/menuback_b.tga
		blendfunc add
		rgbgen wave sin .3 0 0 0
		tcmod scroll 0 .2
	}
	{
			map textures/effects2/console01.tga
                	blendFunc Add
                	tcMod scroll -.01  -.02 
                	tcmod scale .02 .01
                	tcmod rotate 3
	}
	
}

menuback_b
{
	
	nopicmip
	nomipmaps
	{
		map ui/assets/menuback_b.tga
		blendfunc add
		rgbgen wave sin .10 0 0 0
		tcmod scale 1.5 1.5
		tcmod scroll 0 .2.13
	}
	{
		map ui/assets/menuback_b.tga
		blendfunc add
		rgbgen wave sin .15 0 0 0
		tcmod scroll 0 .2
	}
	{
		map ui/assets/menuback_b.tga
		blendfunc add
		rgbgen wave sin .15 0 0 0
		tcmod scroll 0 .1.7
	}
	{
			map textures/effects2/console01.tga
                	blendFunc Add
                	tcMod scroll -.01  -.02 
                	tcmod scale .02 .01
                	tcmod rotate 3
	}
	
}

menuback_d
{
	nopicmip
	nomipmaps
	{
		map ui/assets/ultimatearena.tga
		blendfunc filter
	}
	
}

menuback_e
{
	nopicmip
	nomipmaps
	{
		clampmap ui/assets/radial.tga
		blendfunc add
		tcmod rotate 100
	}
	{
		clampmap ui/assets/radial.tga
		blendfunc add
		tcmod rotate -100
	}
}

menuscreen2
{
	nopicmip
	nomipmaps
    
       	{	
			map textures/sfx2/screen01.tga
                	blendFunc add
                	tcMod scroll 7  0.2
               	tcmod scale .4 .5
			rgbgen wave square .75 .05 0 5
		}


}

ui/assets/controls_shader1
{
	nopicmip
	nomipmaps
	{
		map ui/assets/controls.tga
		blendfunc add
		rgbgen wave sin .15 0 0 0
		tcmod scroll .02 0
	}
}

uibackground4
{
	nopicmip
	nomipmaps
    
       		{	
			map ui/assets/screen02.tga
                	blendFunc GL_ONE GL_ZERO
                	tcMod scroll 7.1  0.2
               		tcmod scale .8 1
			rgbgen wave square .5 .05 0 5
		}
		{
			map ui/assets/backscreen.tga
			blendfunc add
			//tcmod turb 1 .002 0 5	
		}
				
}

warning
{
	nopicmip
	nomipmaps
	
	{
		map ui/assets/warning.tga
		blendfunc blend
		tcmod scale 8 8 
	}
}


// UA loading screen text logo additive
textlogo_addpulse
{
	nopicmip
	nomipmaps
	{
		map ui/assets/backscreen.tga
		blendfunc add
		tcMod turb 0 0.005 0 0.05
	}
	{
		map ui/assets/backscreen.tga
		blendfunc add
		rgbGen wave sin 0.5 0.5 1.1 0.7
		tcMod turb 0 0.005 0 0.05
	}
	{
		map ui/assets/backscreen.tga
		blendfunc add
		rgbGen wave sin 0.5 0.5 1.1 0.7
		tcMod turb 0 0.005 0 0.05
	}
}

// Translucent UA-colorized Q3 logo with no bg
logo_diffuseadd
{
	nopicmip
	nomipmaps
	{
		map ui/assets/diffuseadd.tga
		blendfunc add
		rgbgen wave square .25 .05 0 5
	}
}
