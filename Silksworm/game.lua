module(..., package.seeall);

function new()
	---------------------------------------------------------------- imports
	local cobraRocket = require( "cobraRocket" )
	local hind = require( "hind" )
	---------------------------------------------------------------- start physics
	local physics = require( "physics" )
	physics.start()
	---------------------------------------------------------------- display objects
	local Scene = display.newGroup();
	local background = display.newGroup();
	local background2 = display.newGroup();
	local ground = display.newGroup();
	---------------------------------------------------------------- vars
	local scrollSpeed1 = .2;
	local scrollSpeed2 = .15;
	local scrollSpeed3 = .1;
	
	local tPrevious = system.getTimer()
	local cobra_FLY = true;
	local cobra_WEAPON = 1;
	
	local rockets = {};
	local rockCount = 0;
	---------------------------------------------------------------- Background sky objects
	local sky1 = display.newImage("Assets/Texture/bg_frame.png");
	sky1:setReferencePoint( display.TopLeftReferencePoint );
	sky1.height = 500;
	sky1.width = 1600;
	sky1.y =130;
	
	local sky2 = display.newImage("Assets/Texture/bg_frame.png");
	sky2:setReferencePoint( display.TopLeftReferencePoint );
	sky2.height = 500;
	sky2.width = 1600;
	sky2.y =130;
	sky2.x = 1590;
	
	background:insert(sky1);
	background:insert(sky2);
	---------------------------------------------------------------- Background towers objects
	local tower1 = display.newImage("Assets/Texture/towers.png");
	tower1:setReferencePoint( display.CenterLeftReferencePoint );
	tower1.y =420;
	
	local tower2 = display.newImage("Assets/Texture/towers.png");
	tower2:setReferencePoint( display.CenterLeftReferencePoint );
	tower2.y =420;
	tower2.x = 1590;
	
	background2:insert(tower1);
	background2:insert(tower2);
		---------------------------------------------------------------- Background ground objects
	local ground1 = display.newImage("Assets/Texture/ground.png");
	ground1:setReferencePoint( display.CenterLeftReferencePoint );
	ground1.width = 1600;
	ground1.x = -10;
	ground1.y = 580
	ground1.height = 180;
	
	local ground2 = display.newImage("Assets/Texture/ground.png");
	ground2:setReferencePoint( display.CenterLeftReferencePoint );
	ground2.width = 1600;
	ground2.height = 180;
	ground2.y =580;
	ground2.y =580;
	ground2.x =1550;
	
	ground:insert(ground1);
	ground:insert(ground2);
	---------------------------------------------------------------- Cobra objects 
	local cobra =  display.newGroup();
	local cobraBody = display.newImage("Assets/Texture/Cobra_Main_Body.png");
	cobraBody:setReferencePoint( display.CenterReferencePoint );

	local cobraRotorSprite = graphics.newImageSheet( "Assets/Texture/Cobra_Main_Rotor.png", { width=1003, height=36, numFrames=2 } );
	local cobraMainRotor = display.newSprite( cobraRotorSprite, { name="mainRotor", start=1, count=2, time=100 } );
	cobraMainRotor.x = 671;
	cobraMainRotor.y = 20;
	cobraMainRotor:play();
	
	local cobraHeckRotor = display.newImage( "Assets/Texture/Cobra_Heck_Rotor.png" );
	cobraHeckRotor.y =90
	cobraHeckRotor.x =70
	
	local cobraRocketPoint = display.newGroup();

	cobra:insert(cobraBody);
	cobra:insert(cobraMainRotor);
	cobra:insert(cobraHeckRotor);
	
	--Scene:insert(cobraRocketPoint);
	
	
	cobra.x = 50
	cobra.y = 90
	cobra.xScale = .18;
	cobra.yScale = .19;
	
	--local r = cobraRocket.shoot( cobra_WEAPON );
	--	cobraRocketPoint:insert(r);
	
	---------------------------------------------------------------- cobra Rocket Shootin
	local function shootRocket (event)
		
		local r = cobraRocket.shoot(3);--cobra_WEAPON );
		r.x = cobra.x+100; 
		r.y = cobra.y+40; 
		r.xScale = .1;
		r.yScale = .09;
		cobraRocketPoint:insert(r);
		
		rockets[rockCount] = r;
		rockCount=rockCount+1;
		
	end
	-- Start cobra rocket launcher
	timer.performWithDelay(200, shootRocket, 0 )
	---------------------------------------------------------------- cobra Heck Rotor rotation
	local function heckRotation (event)
		cobraHeckRotor.rotation = cobraHeckRotor.rotation-45;
	end
	-- Start cobra Heck Rotor rotation
	timer.performWithDelay(20, heckRotation, 0 )
	---------------------------------------------------------------- cobra drag listener function
	function cobra:touch( event )
		if (cobra_FLY==false ) then 
			return false; 
		end
		if event.phase == "began" then
			self.markX = self.x; self.markY = self.y;
		elseif event.phase == "moved" then
		
			local x = (event.x - event.xStart) + self.markX;
			local y = (event.y - event.yStart) + self.markY;
			
			self.x, self.y = x, y;
		end
		return true;
	end
	-- Start cobra draggin
	cobra:addEventListener( "touch", cobra )
	---------------------------------------------------------------- add enemies
	
	local h = hind.init();
	
	
	---------------------------------------------------------------- game tick
	function sceneTick(event)
		-- print( "player X", cobra.x )
		-- check cobra drag bounds
		if(cobra.x < 0 or cobra.x > 800 or cobra.y < 80 or cobra.y > 520 ) then 
			
			cobra_FLY=false;
			
			if(cobra.x <  0  ) then cobra.x = 1;end
			if(cobra.x > 800 ) then cobra.x = 799;end
			if(cobra.y < 80  ) then cobra.y = 81;end
			if(cobra.y > 520 ) then cobra.y = 519;end
		else
			cobra_FLY=true;
		end
		-- move level graphics
		
		local tDelta = event.time - tPrevious
		tPrevious = event.time

		-- move sky
		local xOffset = ( scrollSpeed3 * tDelta )

		sky1.x = sky1.x - xOffset;
		sky2.x = sky2.x - xOffset;
		
		-- move towers
		xOffset = ( scrollSpeed2 * tDelta )
		
		tower1.x = tower1.x-xOffset;
		tower2.x = tower2.x-xOffset;
		
		-- move ground
		xOffset = ( scrollSpeed1 * tDelta )
		
		ground1.x = ground1.x-xOffset;
		ground2.x = ground2.x-xOffset;
		
		-- sky reset
		if (sky1.x + sky1.contentWidth) < 0 then
			sky1:translate( 1590 * 2, 0)
		end
		if (sky2.x + sky2.contentWidth) < 0 then
			sky2:translate( 1590 * 2, 0)
		end
		-- tower reset
		if (tower1.x + tower1.contentWidth) < 0 then
			tower1:translate( 1590 * 2, 0)
		end
		if (tower2.x + tower1.contentWidth) < 0 then
			tower2:translate( 1590 * 2, 0)
		end
		-- ground reset
		if (ground1.x + ground1.contentWidth) < 0 then
			ground1:translate( 1550 * 2, 0)
		end
		if (ground2.x + ground2.contentWidth) < 0 then
			ground2:translate( 1550 * 2, 0)
		end
	end
	-- Start game tick
	Runtime:addEventListener( "enterFrame", sceneTick );

	return Scene;
end