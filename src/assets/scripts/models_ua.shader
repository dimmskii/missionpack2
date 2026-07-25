models/ammo/grenade
{
	nopicmip
        {
                map models/ammo/grenade.tga
        }
	{
		AnimMap 7 models/ammo/grenade_r.tga models/ammo/grenade_g.tga
	       blendfunc GL_ONE GL_ONE
	}
}

models/ammo/rocket/rockflar
{
	nopicmip
	cull disable
	{
		map models/ammo/rocket/rockflar.tga
		blendfunc GL_ONE GL_ONE
	}
}

models/ammo/rocket/rockfls1
{
	nopicmip
	cull disable
	{
		map models/ammo/rocket/rockfls1.tga
		blendfunc GL_ONE GL_ONE
	}
}

models/ammo/rocket/rockfls2
{
	nopicmip
	cull disable
	{
		map models/ammo/rocket/rockfls2.tga
		blendfunc GL_ONE GL_ONE
	}
}




//******************************//
//								//
//		MODELS/POWERUPS			//
//								//
//******************************//

//******************************************//
//	models/powerups/ammo subfolder			//
//******************************************//

models/powerups/ammo/bfgammo
{
	nopicmip
   cull none
       {
	        map textures/effects/envmapbfg.tga
		 //tcmod scale 3 3
                tcmod rotate 350
                tcmod scroll 3 1
		//tcGen environment
		blendfunc GL_ONE GL_ZERO
                rgbGen identity
       }
        {
	        map textures/effects/tinfx2.tga
		tcGen environment
		blendfunc GL_ONE GL_ONE
                rgbGen identity
       }
       {
	        map models/powerups/ammo/bfgammo.tga
		blendfunc blend
                rgbGen lightingDiffuse
       }
}

models/powerups/ammo/bfgammo1
{
	nopicmip
        {
	        map textures/effects/envmapbfg.tga
		tcGen environment
		blendfunc GL_ONE GL_ZERO
                rgbGen lightingDiffuse
        }
}

models/powerups/ammo/bfgammo2
{
	nopicmip
	{
		map models/powerups/ammo/bfgammo2.tga
		rgbGen identity
	}
	
}

models/powerups/ammo/grenammo
{
	nopicmip
       {
	        map textures/effects/tinfx2d.tga
		tcGen environment
		blendfunc GL_ONE GL_ZERO
                rgbGen identity
       }
       {
	        map models/powerups/ammo/grenammo.tga
		blendfunc blend
                rgbGen lightingDiffuse
       }
}

models/powerups/ammo/grenammo1
{
	nopicmip
	{
	        map textures/effects/envmapgren.tga
		tcGen environment
		blendfunc GL_ONE GL_ZERO
                rgbGen lightingDiffuse
       }
}

models/powerups/ammo/grenammo2
{
	nopicmip
	{
		map models/powerups/ammo/grenammo2.tga
		rgbGen identity
	}
	
}

models/powerups/ammo/lighammo
{
	nopicmip
       {
	        map textures/effects/envmapligh.tga
                tcmod rotate 350
                tcmod scroll 3 1
		blendfunc GL_ONE GL_ZERO
                rgbGen identity
       }
       {
	        map models/powerups/ammo/lighammo.tga
		blendfunc blend
                rgbGen lightingDiffuse
       }
}

models/powerups/ammo/lighammo1
{
	nopicmip
	{
	        map textures/effects/envmapligh.tga
                tcGen environment
                tcmod rotate 6
                tcmod scroll .09 .09
		blendfunc GL_ONE GL_ZERO
                rgbGen lightingDiffuse
       }
}

models/powerups/ammo/lighammo2
{
	nopicmip
	{
		map models/powerups/ammo/lighammo2.tga
		rgbGen identity
	}
	
}

models/powerups/ammo/machammo
{
	nopicmip
       {
	        map textures/effects/tinfx2d.tga
		tcGen environment
		blendfunc GL_ONE GL_ZERO
                rgbGen identity
       }
       {
	        map models/powerups/ammo/machammo.tga
		blendfunc blend
                rgbGen lightingDiffuse
       }
}

models/powerups/ammo/machammo1
{
	nopicmip
       {
	        map textures/effects/envmapmach.tga
		tcGen environment
		blendfunc GL_ONE GL_ZERO
                rgbGen lightingDiffuse
       }
}

models/powerups/ammo/machammo2
{
	nopicmip
	{
		map models/powerups/ammo/machammo2.tga
		rgbGen identity
	}
	
}

models/powerups/ammo/plasammo
{
	nopicmip
       {
	        map textures/effects/envmapplas.tga
                //tcmod scale 3 3
                tcmod rotate 350
                tcmod scroll 3 1
		//tcGen environment
		blendfunc GL_ONE GL_ZERO
                rgbGen identity
       }
       {
	        map models/powerups/ammo/plasammo.tga
		blendfunc blend
                rgbGen lightingDiffuse
       }
}

models/powerups/ammo/plasammo1
{
	nopicmip
       {
	        map textures/effects/envmapplas.tga
		tcGen environment
		blendfunc GL_ONE GL_ZERO
                rgbGen lightingDiffuse
       }
}

models/powerups/ammo/plasammo2
{
	nopicmip
	{
		map models/powerups/ammo/plasammo2.tga
		rgbGen identity
	}
	
}

models/powerups/ammo/railammo
{
	nopicmip
       {
	        map textures/effects/envmaprail.tga
                //tcmod scale 3 3
                tcmod rotate 350
                tcmod scroll 3 1
		//tcGen environment
		blendfunc GL_ONE GL_ZERO
                rgbGen identity
       }
       {
	        map models/powerups/ammo/railammo.tga
		blendfunc blend
                rgbGen lightingDiffuse
       }
}

models/powerups/ammo/railammo1
{
	nopicmip
       {
	        map textures/effects/envmaprail.tga
                tcGen environment
		//tcmod scale 4 4
                //tcmod rotate 70
                //tcmod scroll .5 .5
		blendfunc GL_ONE GL_ZERO
                rgbGen lightingDiffuse
       }
}

models/powerups/ammo/railammo2
{
	nopicmip
	{
		map models/powerups/ammo/railammo2.tga
		rgbGen identity
	}
	
}

models/powerups/ammo/rockammo
{
	nopicmip
       {
	        map textures/effects/tinfx2d.tga
		tcGen environment
		blendfunc GL_ONE GL_ZERO
                rgbGen identity
       }
       {
	        map models/powerups/ammo/rockammo.tga
		blendfunc blend
                rgbGen lightingDiffuse
       }
}

models/powerups/ammo/rockammo1
{
	nopicmip
       {
	        map textures/effects/envmaproc.tga
		tcGen environment
		blendfunc GL_ONE GL_ZERO
                rgbGen lightingDiffuse
       }
}

models/powerups/ammo/rockammo2
{
	nopicmip
	{
		map models/powerups/ammo/rockammo2.tga
		rgbGen identity
	}
	
}

models/powerups/ammo/shotammo
{
	nopicmip
       {
	        map textures/effects/tinfx2c.tga
		tcGen environment
		blendfunc GL_ONE GL_ZERO
                rgbGen identity
       }
       {
	        map models/powerups/ammo/shotammo.tga
		blendfunc blend
                rgbGen lightingDiffuse
       }
}

models/powerups/ammo/shotammo1
{
	nopicmip
       {
	        map textures/effects/envmapgold3.tga
		tcGen environment
		blendfunc GL_ONE GL_ZERO
                rgbGen lightingDiffuse
       }
}

models/powerups/ammo/shotammo2
{
	nopicmip
	{
		map models/powerups/ammo/shotammo2.tga
		rgbGen identity
	}

}


//******************************************//
//	models/powerups/health subfolder		//
//******************************************//

models/powerups/health/blue
{
	nopicmip
	{
		map textures/effects/envmapbfg.tga
		tcGen environment
		
	}
}

models/powerups/health/blue_sphere
{
	nopicmip
	{
		map textures/effects/tinfx2b.tga
		tcGen environment
		blendfunc GL_ONE GL_ONE
	}
}

models/powerups/health/green
{
	nopicmip
	
	{
		map textures/effects/envmaprail.tga
		tcGen environment
		
	}
}

models/powerups/health/green_sphere
{
	nopicmip
	{
		map textures/effects/tinfx2b.tga
		tcGen environment
		blendfunc GL_ONE GL_ONE
	}
}

models/powerups/health/mega1
{
	nopicmip
	{
		map textures/effects/envmapblue2.tga
                tcGen environment
                tcmod rotate 33
                tcmod scroll 1 1
		blendfunc GL_ONE GL_ONE
	}
}

models/powerups/health/mega2
{	
	nopicmip
	
	{
		map textures/effects/envmapblue.tga
                tcGen environment
		blendfunc GL_ONE GL_ZERO
		
	}
        {
		map textures/sfx/kenelectric.tga
                tcmod scale 2 2
                tcmod rotate 333
                tcmod scroll 9 9
		blendfunc GL_ONE GL_ONE
		
	}
}

models/powerups/health/red
{	
	nopicmip
	
	{
		map textures/effects/envmapgold.tga
                tcGen environment
		blendfunc GL_ONE GL_ZERO
		
	}
        {
		map textures/sfx/kenelectric.tga
                tcmod scale 2 2
                tcmod rotate 333
                tcmod scroll 9 9
		blendfunc GL_ONE GL_ONE
		
	}
}

models/powerups/health/red_sphere
{
	nopicmip
	{
		map textures/effects/envmapgold2.tga
                tcGen environment
                tcmod rotate 33
                tcmod scroll 1 1
		blendfunc GL_ONE GL_ONE
	}
}

models/powerups/health/yellow
{
	nopicmip
	
	{
		map textures/effects/envmapyel.tga
                tcGen environment	
		blendfunc GL_ONE GL_ZERO	
	}
        
}

models/powerups/health/yellow_sphere
{
	nopicmip
	{
		map textures/effects/tinfx2b.tga
		tcGen environment
		blendfunc GL_ONE GL_ONE
	}
}

//******************************************//
//	models/powerups/holdable subfolder		//
//******************************************//

models/powerups/holdable/medkit_base
{
	nopicmip
	{
		map textures/effects/envmap.tga
		tcgen environment
	}
	
}

models/powerups/holdable/medkit_fluid
{
	nopicmip
	sort additive
	cull back
	{
		map models/powerups/holdable/medkit_fluid.tga
		tcMod scroll 0 2
		blendfunc GL_ONE GL_ONE
	}
	
}

models/powerups/holdable/medkit_sphere
{
	nopicmip
	{
		map textures/effects/envmapdim.tga
		tcgen environment
		blendfunc GL_ONE GL_ONE
	}
	
}

models/powerups/holdable/teleport_base
{
	nopicmip
	{
		map textures/effects/envmap.tga
		tcgen environment
	}
	
}

models/powerups/holdable/teleport_fluid
{
	nopicmip
	sort additive
	cull back
	{
		map models/powerups/holdable/teleport_fluid.tga
		tcMod scroll 0 2
		blendfunc GL_ONE GL_ONE
	}
	
}

models/powerups/holdable/teleport_sphere
{
	nopicmip
	{
		map textures/effects/envmapdim.tga
		tcgen environment
		blendfunc GL_ONE GL_ONE
	}
	
}

//******************************************//
//	models/powerups/instant subfolder		//
//******************************************//

models/powerups/instant/enviro
{
	nopicmip
	{
		map textures/effects/envmapgold.tga
		blendfunc GL_ONE GL_ZERO
		tcGen environment
                rgbGen identity
	}
}

models/powerups/instant/flight
{
	nopicmip
	{
		map textures/effects/envmappurp.tga
		blendfunc GL_ONE GL_ZERO
		tcGen environment
                rgbGen identity
	}
}

models/powerups/instant/haste
{
	nopicmip
	{
		map textures/effects/envmapyel.tga
		blendfunc GL_ONE GL_ZERO
		tcGen environment
                rgbGen identity
	}
}

models/powerups/instant/invis
{
	nopicmip
	{
		map textures/effects/tinfx2c.tga
                //map textures/sfx/specular.tga
		blendfunc GL_ONE GL_ONE
		tcGen environment
	}
}

models/powerups/instant/quad
{
	nopicmip
	{
		map textures/effects/envmapblue.tga
		blendfunc GL_ONE GL_ZERO
		tcGen environment
                rgbGen identity
	}
}

models/powerups/instant/regen
{
	nopicmip
	{
		map textures/effects/envmapred.tga
		tcGen environment
		blendfunc GL_ONE GL_ZERO
                rgbGen identity
	}
}

models/powerups/instant/scan
{
	nopicmip
	{
		map models/powerups/instant/scan.tga
	}
	{
		map textures/effects/envmapdim.tga
		blendfunc GL_ONE GL_ONE
		tcGen environment
	}
}




























// TU ES EN BAS


models/powerups/ob2_1
{
	nopicmip
        {
	        map models/powerups/overload_map.tga
                blendFunc GL_ONE GL_ZERO
		tcGen environment
		rgbGen identity
        }
}

models/powerups/ob2_2
{
	nopicmip
        {
	        map models/powerups/overload_mapbw.tga
                blendFunc GL_ONE GL_ZERO
		tcGen environment
		rgbGen entity
        }
}

models/powerups/ob2_3
{
	nopicmip
        {
		map models/powerups/overload_lights.tga
		tcmod scroll 1 1
	        rgbGen entity
        }
}

models/powerups/ob2_4
{
	nopicmip
 cull disable
	{
		map models/powerups/pop_bw.tga
		tcMod turb 0 0.1 0 0.1
                tcmod rotate 311
                tcmod scroll 1 1
		blendfunc Add
                rgbGen entity
	}
}


models/powerups/shield_1
{
	nopicmip
        {
	        map models/powerups/shield_map.tga
		tcGen environment
		rgbGen identity
        }
}

models/powerups/shield_3
{
	nopicmip
        {
	        map models/powerups/shield_map.tga
		tcGen environment
		blendfunc add
                rgbGen identity
        }
}

models/powerups/shield_2
{
	nopicmip
   	
        {
	        map models/powerups/shield_fx.tga
		blendfunc Add
                tcmod Scroll 0 1
                rgbGen identity
        }

}

models/powerups/porter1
{
	nopicmip
        {
	        map models/powerups/porter_map.tga
                blendFunc GL_ONE GL_ZERO
		tcGen environment
		rgbGen identity
        }
}

models/powerups/porter2
{
	nopicmip
   	
        {
	        map models/powerups/porter_fx.tga
		blendfunc Add
                tcmod Scroll 0 1
                rgbGen identity
        }

}


models/powerups/shield/shield
{
	nopicmip
 cull disable
	{
		map models/powerups/shield/shield.tga
		tcGen environment
                tcmod scale .5 .5
		tcMod turb 0 0.3 0 0.3
                tcmod rotate 333
                tcmod scroll 1 1
		blendfunc Add
	}
}

models/powerups/shield/shield2
{
	nopicmip
 cull disable
	{
		map models/powerups/shield/shield2.tga
                tcmod rotate 313
		blendfunc Add
	}
        {
		map models/powerups/shield/shield2.tga
                tcmod rotate -483
		blendfunc Add
	}
}


models/powerups/ob2_target
{
	nopicmip
	cull none
             
        {
		map models/powerups/ob2_target.tga
		//rgbGen identity
		rgbGen entity		
	}
                
}

models/powerups/ob2_energy
{
	nopicmip
	cull none
             
        {
		map models/powerups/ob2_energy.tga
		//rgbGen identity
		rgbGen entity
		blendfunc add
	}
                
}

models/powerups/ob2_energy2
{
	nopicmip
	cull none    
        
	{
		map models/powerups/ob2_energy2.tga
		//rgbGen identity
		rgbGen entity
		
	}
                
}

models/powerups/ob2_lightning1
{
	nopicmip
      
	deformVertexes wave 100 sin 4 3 0 0.3
        deformVertexes wave 30 sin 0 3 0 .8
        deformVertexes normal .3 .2
        cull none
        
        {
		AnimMap 15 models/powerups/ob2_lightn1.tga models/powerups/ob2_lightn2.tga models/powerups/ob2_lightn3.tga models/powerups/ob2_lightn4.tga models/powerups/ob2_lightn5.tga models/powerups/ob2_lightn6.tga models/powerups/ob2_lightn7.tga models/powerups/ob2_lightn8.tga  
		rgbGen identity
		blendfunc add
	}
        
        
}

models/powerups/ob2_lightning2
{
	nopicmip
      
	deformVertexes wave 30 sin 0 3 0 .1
        cull none
        
        {
		AnimMap 15 models/powerups/ob2_lightn3.tga models/powerups/ob2_lightn1.tga models/powerups/ob2_lightn4.tga models/powerups/ob2_lightn2.tga models/powerups/ob2_lightn6.tga models/powerups/ob2_lightn5.tga models/powerups/ob2_lightn8.tga models/powerups/ob2_lightn7.tga  
		rgbGen identity
		blendfunc add
	}
        
        
}

models/powerups/ob2_lightning3
{
	nopicmip
      
	deformVertexes wave 100 sin 4 3 0 0.3
        cull none
        
        {
		AnimMap 15 models/powerups/ob2_lightn4.tga models/powerups/ob2_lightn6.tga models/powerups/ob2_lightn1.tga models/powerups/ob2_lightn3.tga models/powerups/ob2_lightn8.tga models/powerups/ob2_lightn4.tga models/powerups/ob2_lightn5.tga models/powerups/ob2_lightn3.tga  
		rgbGen identity
		blendfunc add
	}
        
        
}

models/weaphits/kamiwave01
{
	nopicmip
	
        surfaceparm trans	
	cull disable
        nomipmaps
	{
	        clampmap models/weaphits/kamiwave01.tga 
		blendFunc Add
                tcmod rotate 20
		rgbGen entity
	}
	{
	        clampmap models/weaphits/kamiwave01.tga 
		blendFunc Add
  		tcmod rotate -20
		rgbGen entity
	}
}
models/weaphits/kamiwave02
{
	nopicmip
	
        surfaceparm trans	
	cull disable
	{
	        map models/weaphits/kamiwave02.tga 
		blendFunc Add
                tcmod scroll 1 0
		rgbGen entity
	}
}


models/powerups/kamitrail
{
	nopicmip
	
        surfaceparm trans	
	cull disable
        nomipmaps
	{
	        map models/powerups/kamitrail.tga 
		blendFunc Add
		rgbGen identity
	}
}
models/weaphits/proxminet
{
	nopicmip
        cull disable  
        {
                map models/weaphits/proxmine.tga
                rgbGen lightingdiffuse
        }
        {
                map models/weaphits/proxminebt.tga
                blendFunc add
                rgbGen wave sin .5 .5 0 2
        }

}

models/weaphits/proxmine2t
{
	nopicmip
        cull disable  
        nomipmaps
        {
                clampmap models/weaphits/proxmine2t.tga
                blendFunc add
                tcmod rotate 200
                tcMod stretch sin .6 0.2 0 .11
                rgbGen identity
        }
        {
                clampmap models/weaphits/proxmine2t.tga
                blendFunc add
                tcmod rotate -200
                tcMod stretch sin .6 0.2 0 .2
                rgbGen identity
        }

}
models/weaphits/kamikred
{
	nopicmip
  cull disable
       {
	        map textures/effects/tinfx2d.tga
                tcGen environment
		blendfunc GL_ONE GL_ZERO
                rgbgen identity
       }
       {
                map models/weaphits/kamik02r.tga
                tcGen environment
                blendFunc add
                tcmod scale .5 .5
                tcmod rotate 166
                tcmod Scroll 1.3 .8
                
                rgbGen identity
       }

}
models/weaphits/kamikblu
{
	nopicmip
  cull disable
       {
	        map textures/effects/tinfx2d.tga
                tcGen environment
		blendfunc GL_ONE GL_ZERO
                rgbgen identity
       }
       {
                map models/weaphits/kamik02b.tga
                tcGen environment
                blendFunc add
                tcmod scale .5 .5
                tcmod rotate 166
                tcmod Scroll 1.3 .8
                
                rgbGen identity
        }
}


models/powerups/teleporter/tele_enter
{
	nopicmip
     
     cull disable

        {
                clampmap models/powerups/teleporter/tele_enter.tga
                alphaFunc GE128
		depthWrite
                rgbGen lightingdiffuse
        }
}
models/powerups/teleporter/tele_enter2
{
	nopicmip
     
     cull disable

        {
                clampmap models/powerups/teleporter/tele_enter2.tga
                blendfunc Add
                tcmod rotate 120
                rgbGen lightingdiffuse
        }
}
models/powerups/teleporter/tele_exit2
{
	nopicmip
     
     cull disable

        {
                clampmap models/powerups/teleporter/tele_exit2.tga
                blendfunc Add
                tcmod rotate 120
                rgbGen lightingdiffuse
        }
}
models/powerups/teleporter/tele_exit
{
	nopicmip
     
     cull disable

        {
                clampmap models/powerups/teleporter/tele_exit.tga
                alphaFunc GE128
		depthWrite
                rgbGen lightingdiffuse
        }
}

models/powerups/kamikazi1
{
	nopicmip
        {
	        map textures/effects/tinfx2d.tga
		tcGen environment
		rgbGen identity
        }
}

models/powerups/kamikazi2
{
	nopicmip
        {
	        map textures/effects/tinfx2d.tga
		tcGen environment
		blendfunc add
                rgbGen identity
        }
}

models/powerups/kamikazi_f
{
	nopicmip
   	
        {
	        map models/powerups/kamikazi_f.tga
		blendfunc Add
                tcmod Scroll 0 1
                rgbGen identity
        }

}

models/powerups/ammo1
{
	nopicmip
        {
	        map textures/effects/envmapmach.tga
		tcGen environment
		blendfunc GL_ONE GL_ZERO
                rgbGen lightingDiffuse
        }
}

models/powerups/ammo2
{
	nopicmip
    cull disable
        {
	        map models/powerups/ammo2.tga
		blendfunc Add
                tcmod Scroll 1.3 0
                rgbGen identity
        }
}

models/powerups/scout1
{
	nopicmip
        {
	        map textures/effects/envmapgreen.tga
		tcGen environment
		blendfunc GL_ONE GL_ZERO
                rgbGen lightingDiffuse
        }
}

models/powerups/scout2
{
	nopicmip
    cull disable
        {
	        map models/powerups/scout2.tga
		blendfunc Add
                tcmod Scroll .9 0
                rgbGen identity
        }
}

models/powerups/guard1
{
	nopicmip
        {
	        map textures/effects/envmapblue.tga
		tcGen environment
		blendfunc GL_ONE GL_ZERO
                rgbGen lightingDiffuse
        }
}
models/powerups/guard2
{
	nopicmip
    cull disable
        {
	        map models/powerups/guard2.tga
		blendfunc Add
                tcmod Scroll .9 0
                rgbGen identity
        }
}
models/powerups/doubler1
{
	nopicmip
        {
	        map textures/effects/envmaproc.tga
		tcGen environment
		blendfunc GL_ONE GL_ZERO
                rgbGen lightingDiffuse
        }
}
models/powerups/doubler2
{
	nopicmip
    cull disable
        {
	        map models/powerups/doubler2.tga
		blendfunc Add
                tcmod Scroll .9 0
                rgbGen identity
        }
}

models/powerups/obelisk/ob_trns
{
	nopicmip
     
     cull disable

        {
                map models/powerups/obelisk/ob_trns.tga
                alphaFunc GE128
		depthWrite
                rgbGen lightingdiffuse
        }
}

models/powerups/obelisk/ob_sft
{
	nopicmip
        {
	        map models/powerups/obelisk/ob_sft2.tga
		tcmod scroll 0 .05
		blendfunc GL_ONE GL_ZERO
                rgbGen identity
        }

        {
                map models/powerups/obelisk/ob_sft.tga
                blendfunc blend
                rgbGen lightingdiffuse
        }
       
}

models/powerups/obelisk/ob_twirl
{
	nopicmip
     cull disable
     nomipmaps
     deformVertexes move 0 0 2  sin 0 5 0 0.33
        {
                clampmap models/powerups/obelisk/ob_twirl.tga
                tcmod rotate 103
                Blendfunc Add
                rgbGen identity
        }
       
}
models/powerups/obelisk/ob_twirl2
{
	nopicmip
     cull disable
     nomipmaps
     deformVertexes move 0 0 3  sin 0 5 0 0.2
        {
                clampmap models/powerups/obelisk/ob_twirl2.tga
                tcmod rotate -73
                Blendfunc Add
                rgbGen identity
        }
       
}
models/powerups/obelisk/ob_flare
{
	nopicmip
     cull disable
     nomipmaps
      deformVertexes autoSprite2
        {
                map models/powerups/obelisk/ob_flare.tga
                Blendfunc Add
                rgbGen identity
        }
       
}

models/powerups/obelisk/ob_flare2
{
	nopicmip
     cull disable
     nomipmaps
      deformVertexes autoSprite
        {
                map models/powerups/obelisk/ob_flare2.tga
                Blendfunc Add
                rgbGen identity
        }
       
}
models/powerups/obelisk/ob_cyl
{
	nopicmip
     cull disable

        {
                map models/powerups/obelisk/ob_cyl.tga
                Blendfunc Add
                tcmod scroll .2 0
                rgbGen identity
        }
       
        {
                map models/powerups/obelisk/ob_cyl.tga
                Blendfunc Add
                tcmod scroll -.33 0
                rgbGen identity
        }
}

models/powerups/orb/red
{
	nopicmip
     cull disable

        {
                map models/powerups/orb/red.tga
                Blendfunc Add
                rgbGen identity
        }
        {
                map models/powerups/orb/redfx.tga
                //tcGen environment
                tcmod scroll 0 0.2
                Blendfunc Add
                rgbGen wave sin .5 .5 0 .5
        }
}
models/powerups/orb/blue
{
	nopicmip
     cull disable

        {
                map models/powerups/orb/blue.tga
                Blendfunc Add
                rgbGen identity
        }
        {
                map models/powerups/orb/bluefx.tga
                //tcGen environment
                tcmod scroll 0 0.2
                Blendfunc Add
                rgbGen wave sin .5 .5 0 .5
        }
}

models/weaphits/kamik01
{
	nopicmip
  cull disable
       {
	        map models/weaphits/kamik01.tga
                tcGen environment
                //blendfunc GL_ONE GL_ZERO
		//blendfunc   	blend
                //alphaGen	wave inversesawtooth 1 1 0 1
                rgbGen identity
                tcmod scale .75 .75
                tcmod rotate 0.5
                tcmod Scroll 0.5 .4
       }
       {
                map models/weaphits/kamik01.tga
                tcGen environment
                blendFunc blend
                tcmod scale .5 .5
                tcmod rotate 4
                tcmod Scroll 1.3 .8
                rgbGen lightingdiffuse
        }
       {
                map models/weaphits/kamik02.tga
                tcGen environment
                blendFunc add
                tcmod scale .5 .5
                tcmod rotate 66
                tcmod Scroll 1.3 .8
                rgbGen wave sin 0.5 0.5 0 2
        }
       {
                map models/weaphits/kam01.tga
                tcGen environment
                blendFunc add
                tcmod scale .5 .5
                tcmod rotate -116
                tcmod Scroll -1 .3
                rgbGen identity
        }
}

models/weaphits/kam01
{
	nopicmip
        cull disable  
        {
                map models/weaphits/kam01.tga
                blendFunc add
                tcmod Scroll 1.4 0
                rgbGen identity
        }
        {
                map models/weaphits/kam02.tga
                blendFunc add
                tcmod Scroll -1.9 0
                rgbGen identity
        }

}
models/weaphits/kam02
{
	nopicmip
        cull disable  
        {
                map models/weaphits/kam01.tga
                blendFunc add
                tcmod Scroll -2 0
                rgbGen identity
        }
        {
                map models/weaphits/kam02.tga
                blendFunc add
                tcmod Scroll 1 0
                rgbGen identity
        }

}
models/weaphits/kam03
{
	nopicmip
        cull disable  
        deformVertexes autoSprite
        {
                clampmap models/weaphits/kam03.tga
                blendFunc add
                tcmod rotate 133
                rgbGen identity
        }
        {
                clampmap models/weaphits/kam03b.tga
                blendFunc add
                tcmod rotate -113
                rgbGen identity
        }

}
models/weaphits/kam04
{
	nopicmip
        cull disable  
        deformVertexes autoSprite
        {
                clampmap models/weaphits/kam04.tga
                blendFunc add
                tcmod rotate 999
                rgbGen identity
        }


}

models/powerups/harvester/blue_h2
{
	nopicmip

	{
		map models/powerups/harvester/blue_h2.tga
                tcMod stretch sin .8 0.2 0 .3
                tcmod rotate 30
                rgbGen identity
	}
        {
		map models/powerups/harvester/harvester2.tga
                tcMod stretch sin .8 0.2 0 .2
                tcmod rotate 20
                blendfunc Blend
                rgbGen lightingdiffuse
	}
	{
		map models/powerups/harvester/harvester2.tga
		blendfunc Blend
                rgbGen lightingdiffuse
	}

}
models/powerups/harvester/harvester2
{
	nopicmip

	{
		map models/powerups/harvester/red_h2.tga
                tcMod stretch sin .8 0.2 0 .3
                tcmod rotate 30
                rgbGen identity
	}
        {
		map models/powerups/harvester/harvester2.tga
                tcMod stretch sin .8 0.2 0 .2
                tcmod rotate 20
                blendfunc Blend
                rgbGen lightingdiffuse
	}
	{
		map models/powerups/harvester/harvester2.tga
		blendfunc Blend
                rgbGen lightingdiffuse
	}

}

models/powerups/harvester/red_h
{
	nopicmip

   cull none
   nomipmaps


	{
		map models/powerups/harvester/red_h.tga
                tcmod scroll 3 0
                blendFunc Add
                rgbGen identity
	}
        {
		map models/powerups/harvester/red_hb.tga
                tcmod scroll 6 1
                tcmod scale 2 1
                blendFunc Add
                rgbGen wave inversesawtooth -.3 1.3 0 1
	}
        {
		map models/powerups/harvester/red_hb.tga
                tcmod scroll -4 1
                tcmod scale 2 1
                blendFunc Add
                rgbGen wave inversesawtooth -.3 1.3 0 1
	}



}


models/powerups/harvester/blue_h
{
	nopicmip

   cull none
   nomipmaps


	{
		map models/powerups/harvester/blue_h.tga
                tcmod scroll 3 0
                blendFunc Add
                rgbGen identity
	}
        {
		map models/powerups/harvester/red_hb.tga
                tcmod scroll 6 1
                tcmod scale 2 1
                blendFunc Add
                rgbGen wave inversesawtooth -.3 1.3 0 1
	}
        {
		map models/powerups/harvester/red_hb.tga
                tcmod scroll -4 1
                tcmod scale 2 1
                blendFunc Add
                rgbGen wave inversesawtooth -.3 1.3 0 1
	}



}

models/weaphits/rlboom/rlboom_1  
{
	nopicmip
	cull disable
        
	{
		animmap 8 models/weaphits/rlboom/rlboom_1.tga  models/weaphits/rlboom/rlboom_2.tga models/weaphits/rlboom/rlboom_3.tga models/weaphits/rlboom/rlboom_4.tga models/weaphits/rlboom/rlboom_5.tga models/weaphits/rlboom/rlboom_6.tga models/weaphits/rlboom/rlboom_7.tga models/weaphits/rlboom/rlboom_8.tga
                //tcmod rotate 30 
		rgbGen wave inversesawtooth 0 1 0 8
		blendfunc add
	}
	{
		animmap 8 models/weaphits/rlboom/rlboom_2.tga models/weaphits/rlboom/rlboom_3.tga models/weaphits/rlboom/rlboom_4.tga models/weaphits/rlboom/rlboom_5.tga models/weaphits/rlboom/rlboom_6.tga models/weaphits/rlboom/rlboom_7.tga models/weaphits/rlboom/rlboom_8.tga gfx/colors/black.tga
		//tcmod rotate 30
                rgbGen wave sawtooth 0 1 0 8
		blendfunc add
	}
}

models/powerups/shield/juicer
{
	nopicmip
 deformVertexes wave 80 sin 0 1 0 .6
	{
		map models/powerups/shield/juicer.tga
                tcmod scale 2 2 
                tcmod scroll 0 -.1
		blendfunc GL_one GL_ZERO
                rgbGen lightingdiffuse
	}
        {
		map textures/effects2/tinfx_scr.tga
		tcGen environment
		blendfunc Add
                rgbGen lightingdiffuse
	}
}

models/powerups/regen1
{
	nopicmip
 cull disable
	{
		clampmap models/powerups/regen1.tga
                tcmod rotate -420
		blendfunc Add
                rgbGen entity
	}
	{
		clampmap models/powerups/regen2.tga
                tcmod rotate -640
		blendfunc Add
                rgbGen entity
	}
}

models/powerups/pop
{
	nopicmip
 cull disable
	{
		map models/powerups/pop.tga
		tcGen environment
		tcMod turb 0 0.1 0 0.1
                tcmod rotate 311
                tcmod scroll 1 1
		blendfunc Add
                rgbGen entity
	}
}

models/powerups/pop2
{
	nopicmip
 cull disable
 deformVertexes autosprite
	{
		clampmap models/powerups/pop2.tga
                tcmod rotate 333
		blendfunc Add
                rgbGen entity
	}
	{
		clampmap models/powerups/pop2.tga
                tcmod rotate -433
		blendfunc Add
                rgbGen entity
	}
}





//*************************************************************************//
//      models/mapobjects/flagbase shader stanzas                          //
//      Source: pack-qu4kezer0.pk3  scripts/models2.shader                 //
//      Covers red_base.md3 / blue_base.md3 / ntrl_base.md3 surfaces       //
//*************************************************************************//

models/mapobjects/flagbase/base_s

{
	surfaceparm	nodraw
}

models/mapobjects/flagbase/beam_blue
{
	nopicmip
     surfaceparm	trans
     nomipmaps
     cull disable
    {
		map models/mapobjects/flagbase/beam_blue.tga
        blendFunc add
		tcmod scroll -.5 0
		rgbGen wave sin .5 .5 0.5 0.09
	}
}
models/mapobjects/flagbase/beam_ntrl
{
	nopicmip
     surfaceparm	trans
     nomipmaps
     cull disable
	{
		map models/mapobjects/flagbase/beam_ntrl.tga
		blendFunc add
		tcmod scroll -.5 0
		rgbGen wave sin .5 .5 0.5 0.09
	}
}
models/mapobjects/flagbase/beam_red
{
	nopicmip
     surfaceparm	trans
     nomipmaps
     cull disable
    {
		map models/mapobjects/flagbase/beam_red.tga
        blendFunc add
        tcmod scroll -.5 0
        rgbGen wave sin .5 .5 0.5 0.09
	}
}
models/mapobjects/flagbase/swirl_ntrl
{
	nopicmip
        {
	        map models/mapobjects/flagbase/swirl_ntrl.tga
            blendFunc GL_ONE GL_ZERO
            tcmod rotate 130
            tcMod stretch sin .8 0.2 0 .2
	        rgbGen identity
		}
        {
	        map models/mapobjects/flagbase/swirl_ntrl.tga
			blendFunc Add
            tcmod rotate 80
            tcMod stretch sin .8 0.2 0 .1
	        rgbGen identity
		}
		{
	        map models/mapobjects/flagbase/base_r.tga
			blendFunc blend
	        //rgbGen lightingdiffuse
		}

}
models/mapobjects/flagbase/swirl_red
{
	nopicmip
        {
	        map models/mapobjects/flagbase/swirl_red.tga
            blendFunc GL_ONE GL_ZERO
            tcmod rotate 130
            tcMod stretch sin .8 0.2 0 .2
	        rgbGen identity
		}
        {
	        map models/mapobjects/flagbase/swirl_red.tga
			blendFunc Add
            tcmod rotate 80
            tcMod stretch sin .8 0.2 0 .1
	        rgbGen identity
		}
		{
	        map models/mapobjects/flagbase/base_r.tga
			blendFunc blend
	        //rgbGen lightingdiffuse
		}

}
models/mapobjects/flagbase/swirl_blue
{
	nopicmip
        {
	        map models/mapobjects/flagbase/swirl_blue.tga
            blendFunc GL_ONE GL_ZERO
            tcmod rotate 130
            tcMod stretch sin .8 0.2 0 .2
	        rgbGen identity
		}
        {
	        map models/mapobjects/flagbase/swirl_blue.tga
			blendFunc Add
            tcmod rotate 80
            tcMod stretch sin .8 0.2 0 .1
	        rgbGen identity
		}
		{
	        map models/mapobjects/flagbase/base_r.tga
			blendFunc blend
			//rgbGen lightingdiffuse
		}

}
models/mapobjects/flagbase/env_red
{
	nopicmip
       {
	        map models/mapobjects/flagbase/env_red.tga
			tcGen environment
			blendfunc GL_ONE GL_ZERO
            rgbGen identity
       }
       {
	        map models/mapobjects/flagbase/base_e.tga
			blendfunc blend
            //rgbGen lightingdiffuse
       }
}
models/mapobjects/flagbase/env_ntrl
{
	nopicmip
       {
	        map models/mapobjects/flagbase/env_ntrl.tga
			tcGen environment
			blendfunc GL_ONE GL_ZERO
            rgbGen identity
       }
       {
	        map models/mapobjects/flagbase/base_e.tga
			blendfunc blend
            //rgbGen lightingdiffuse
       }
}
models/mapobjects/flagbase/env_blue
{
	nopicmip
		{
	        map models/mapobjects/flagbase/env_blue.tga
			tcGen environment
			blendfunc GL_ONE GL_ZERO
            rgbGen identity
       }
       {
	        map models/mapobjects/flagbase/base_e.tga
			blendfunc blend
            //rgbGen lightingdiffuse
       }
}
