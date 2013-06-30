module(..., package.seeall);

----------------------------------------------  vars
local speed = 500;
local direction = 1;
local h;

function init()

	
	
	---------------------------------------------- init sprite
	h = display.newImage( "Assets/Texture/Hind.png");
	h.hit = false;
	
	---------------------------------------------- adding physics & set velocity
	physics.addBody( h, "kinematic", {density = 0, bounce=0, friction = 0});
	
	h:setLinearVelocity( speed*direction, 0);

	return r;

end

function changeDirection()
	if ( direction == 1 ) then 
		direction = -1;
	else 
		direction = 1; 
	end
	h:setLinearVelocity( speed*direction, 0);
end