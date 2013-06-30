-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

display.setStatusBar( display.HiddenStatusBar )

-- Constant vars
_W = display.contentWidth;
_H = display.contentHeight;

-- Cached math functions
m = {}
m.random = math.random;

-- Scene set-up
local director = require("director");
local mainGroup = display.newGroup();

local function main()

	mainGroup:insert(director.directorView);
	director:changeScene("menu");
	
	return true;
end

main();