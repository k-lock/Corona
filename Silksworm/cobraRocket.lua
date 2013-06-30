module(..., package.seeall);

function shoot( WEAPON_MODE )
	
	---------------------------------------------- rocket vars
	local rocketSpeed = 1500;
	---------------------------------------------- init rocket sprite
	local cobraRocketSprite = graphics.newImageSheet( "Assets/Texture/Cobra_Rockets.png", { width=334, height=251, numFrames=3 } );
	local r = display.newSprite( cobraRocketSprite, { name="cobraRocket", start=1, count=3 } );

	r:setFrame( WEAPON_MODE );
	r.hit = false;
	r.weaponMode = WEAPON_MODE;
	
	---------------------------------------------- adding physics & set velocity
	physics.addBody( r, "kinematic", {density = 0, bounce=0, friction = 0});
	r:setLinearVelocity( rocketSpeed, 0);

	return r;
end