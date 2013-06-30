module(..., package.seeall);

function new()
	---------------------------------------------------------------- display objects
	local Scene = display.newGroup();
	local GUI = display.newGroup();
	
	local bg_rect = display.newRect(0,0,_W,_H);
	bg_rect.x = _W *.5;
	bg_rect.y = _H *.5;
	bg_rect:setFillColor(0);
	
	local title = display.newImage("Assets/Texture/logo.png");
	title.width = _W*.75
	title.height = _H*.35
	title.x = _W*.5;
	title.y = (_H*.5)-120;
	
	local title2 = display.newText( "2013 k-lock estudios",0,0,"Stencil", 18);
	title2:setTextColor(100)
	title2.x = _W*.5;
	title2.y = _H-20;
	
	local play_btn = display.newText("START TO Play ",0,0,"Stencil", 55);
	play_btn:setTextColor(100)
	play_btn.x = _W*.5;
	play_btn.y = (_H*.5)+180;
	play_btn.scene = "game";
	
	---------------------------------------------------------------- scene event
	local function changeScene(e)
		if(e.phase == "ended" or e.phase =="cancelled") then
			director:changeScene(e.target.scene);
		end
	end
	-- add scene change event
	play_btn:addEventListener("touch", changeScene);
	
	---------------------------------------------------------------- adding display objects
	GUI:insert(bg_rect);
	GUI:insert(title);
	GUI:insert(title2);
	GUI:insert(play_btn);
	Scene:insert(GUI);
	
	return Scene;
end