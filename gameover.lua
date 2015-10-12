local composer = require( "composer" )
local scene = composer.newScene()
local score = require( "score" )
local showLastScore
local showHighScore
local font = "SIPLE LIGHT"

function scene:create( event )
    local sceneGroup = self.view
    local background = display.newRect(_W/2, _H/2, _W, _H)
	
    -- Background
	background:setFillColor(1,1,1)
	sceneGroup:insert( background )

	-- Game over title
	local title = display.newImage("gameover.png")
	title.x = _W/2;
	title.y = (_H/10)*2.5;
	sceneGroup:insert( title )

	--Play button
	local play = display.newImage("restart.png")
	play.x = (_W/2)
	play.y = (_H/10)*5.5

	function play:tap(e)
		composer.gotoScene("game",{
			effect = "slideLeft",
			time = "250"
			})
	end	

	play:addEventListener("tap", play);

	sceneGroup:insert( play )

	--Rate button
	local rate = display.newImage("rate.png")
	rate.x = (_W/2)
	rate.y = (_H/10)*6.5

	-- function play:tap(e)
	-- 	composer.gotoScene("game",{
	-- 		effect = "slideLeft",
	-- 		time = "250"
	-- 		})
	-- end	

	rate:addEventListener("tap", rate);

	sceneGroup:insert( rate )

	--Scores button
	local scores = display.newImage("charts.png")
	scores.x = (_W/2)
	scores.y = (_H/10)*7.5

	-- function scores:tap(e)
	-- 	composer.gotoScene("game",{
	-- 		effect = "slideLeft",
	-- 		time = "250"
	-- 		})
	-- end	

	play:addEventListener("tap", scores);

	sceneGroup:insert( scores )
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
    	local lastscore = score.get()
    	local highscore = score.load()
		if showHighScore ~= nil then
			showHighScore:removeSelf()
			showHighScore = nil
			showHighScore = display.newText("Best: " .. highscore, (_W/2)*1.2, (_H/5)*2, font, 35)
			showHighScore:setFillColor(0,0,0)
			sceneGroup:insert(showHighScore)
		else
			if highscore ~= nil then
				showHighScore = display.newText("Best: " .. highscore, (_W/2)*1.2, (_H/5)*2, font, 35)
				showHighScore:setFillColor(0,0,0)
				sceneGroup:insert(showHighScore)
			end
		end
		if showLastScore ~= nil then
			showLastScore:removeSelf()
			showLastScore = nil
			showLastScore = display.newText("Score: " .. lastscore, (_W/2)*.8, (_H/5)*2, font, 35)
			showLastScore:setFillColor(0,0,0)			
			sceneGroup:insert(showLastScore)
		else
			if highscore ~= nil then
				showLastScore = display.newText("Score: " .. lastscore, (_W/2)*.8, (_H/5)*2, font, 35)
				showLastScore:setFillColor(0,0,0)			
				sceneGroup:insert(showLastScore)
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