-- Declare visible width and height
_W = display.viewableContentWidth;
_H = display.viewableContentHeight;

display.setStatusBar( display.HiddenStatusBar );

local composer = require( "composer" )

RevMob = require("revmob")
local REVMOB_IDS = { ["Android"] = "561751deca4c31de6cf4feac ", ["iPhone OS"] = "561751b0ca4c31de6cf4fe9e" }

RevMob.setTestingMode()
RevMob.startSession(REVMOB_IDS)

composer.gotoScene( "menu" )

score = 0