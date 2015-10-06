-- Declare visible width and height
_W = display.viewableContentWidth;
_H = display.viewableContentHeight;

display.setStatusBar( display.HiddenStatusBar );

local composer = require( "composer" )
composer.gotoScene( "menu" )

score = 0