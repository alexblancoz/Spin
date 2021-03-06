local composer = require( "composer" )
local scene = composer.newScene()
local showScore
local score = require( "score" )

function scene:create( event )
    local sceneGroup = self.view

	-- Background
	local background = display.newRect(_W/2, _H/2, _W, _H)
	sceneGroup:insert( background)

    -- Title
    local title = display.newImage("spin.png")
	title.x = _W/2;
	title.y = (_H/10)*2.5;
	sceneGroup:insert( title )

	--Play button
	local play = display.newImage("play.png")
	play.x = (_W/2)
	play.y = (_H/10)*5

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
	rate.y = (_H/10)*6

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
	scores.y = (_H/10)*7

	-- function scores:tap(e)
	-- 	composer.gotoScene("game",{
	-- 		effect = "slideLeft",
	-- 		time = "250"
	-- 		})
	-- end	

	play:addEventListener("tap", scores);

	sceneGroup:insert( scores )

	--Sound button
	local sound = display.newImage("nosound.png")
	sound.x = (_W/2)
	sound.y = (_H/10)*8

	-- function sound:tap(e)
	-- 	composer.gotoScene("game",{
	-- 		effect = "slideLeft",
	-- 		time = "250"
	-- 		})
	-- end	

	sound:addEventListener("tap", sound);

	sceneGroup:insert( sound )

end

function scene:show( event )
	local banner = RevMob.createBanner({ x = _W/2, y = _H-40, width = _W, height = 80 })
    local sceneGroup = self.view
    local phase = event.phase
    if ( phase == "will" ) then
  --   	local highscore = score.load()
		-- if showScore ~= nil then
		-- 	showScore:removeSelf()
		-- 	showScore = nil
		-- 	showScore = display.newText("The high score is " .. highscore, _W/2, (_H/5)*4, "Helvetica", 35)
		-- 	sceneGroup:insert(showScore)
		-- else
		-- 	if highscore ~= nil then
		-- 		showScore = display.newText("The high score is " .. highscore, _W/2, (_H/5)*4, "Helvetica", 35)
		-- 		sceneGroup:insert(showScore)
		-- 	end
		-- end
    elseif ( phase == "did" ) then
    	banner:show()
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