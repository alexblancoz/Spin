local composer = require( "composer" )
local scene = composer.newScene()
local showScore
local score = require( "score" )

function scene:create( event )
    local sceneGroup = self.view
    local background = display.newRect(_W/2, _H/2, _W, _H)
	
    -- Background
	background:setFillColor(0,0,1)
	background.x = _W/2;
	background.y = _H/2;
	sceneGroup:insert( background )

	--Play button
	local play = display.newImage("Icon-72.png")
	play.x = _W/2
	play.y = _H/2

	function play:tap(e)
		composer.gotoScene("game",{
			effect = "slideLeft",
			time = "250"
			})
	end	

	play:addEventListener("tap", play);

	sceneGroup:insert( play )

end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    if ( phase == "will" ) then
    	local highscore = score.load()
		if showScore ~= nil then
			showScore:removeSelf()
			showScore = nil
			showScore = display.newText("The high score is " .. highscore, _W/2, (_H/5)*4, "Helvetica", 35)
			sceneGroup:insert(showScore)
		else
			if highscore ~= nil then
				showScore = display.newText("The high score is " .. highscore, _W/2, (_H/5)*4, "Helvetica", 35)
				sceneGroup:insert(showScore)
			end
		end
    elseif ( phase == "did" ) then
    end
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
    elseif ( phase == "did" ) then
    end
end

function scene:destroy( event )
    local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene