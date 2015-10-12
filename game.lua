local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
    local sceneGroup = self.view
    		-- Walls
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
    elseif ( phase == "did" ) then
    	math.randomseed(os.time()) 
    	local bg = display.newRect(_W/2, _H/2, _W,_H)
		bg:setFillColor(1,1,1)
		sceneGroup:insert(bg)
		local score = require( "score" )
		local scoreText = score.init({
		   fontSize = 180,
		   font = "Siple DemiBold",
		   x = (_W/2)-80,
		   y = (_H/2)-10,
		   maxDigits = 3,
		   leadingZeros = false,
		   filename = "scorefile.txt",
		})

		score.set(0)
		sceneGroup:insert(scoreText)

		local physics = require("physics")
		physics.start()
		physics.setGravity( 0, 0)
		--physics.setDrawMode("debug")

		local fullscreen = RevMob.createFullscreen()

		local physicsData = (require "spin&match").physicsData(1);
		local spin_match = display.newImage("spin&match.png")
		spin_match.x = _W/2; spin_match.y = _H/2
		spin_match.name="spin_match"

		local leftWall = display.newRect(-10, _H/2, 10, _H)
		local rightWall = display.newRect(_W+10, _H/2, 10, _H)
		local topWall = display.newRect(_W/2, -10, _W, 10)
		local bottomWall = display.newRect(_W/2, _H+10, _W, 10)

		leftWall.name= "wall"
		rightWall.name = "wall"
		topWall.name = "wall"
		bottomWall.name = "wall"

		physics.addBody(leftWall, "static")
		physics.addBody(rightWall, "static")
		physics.addBody(topWall, "static")
		physics.addBody(bottomWall, "static")

		sceneGroup:insert( leftWall)
		sceneGroup:insert( rightWall )
		sceneGroup:insert( topWall )
		sceneGroup:insert( bottomWall)

		-- "Ball features"
		local ballcont = 0
		local color = 1
		local ball
		colors = {}
		i=1
		while i<5 do
			colors[i] = {}
			i=i+1
		end
		colors[1][1] = 244/255
		colors[1][2] = 91/255
		colors[1][3] = 105/255
		colors[1][4] = "red"
		colors[2][1] = 38/255
		colors[2][2] = 84/255
		colors[2][3] = 124/255
		colors[2][4] = "blue"
		colors[3][1] = 255/255
		colors[3][2] = 209/255
		colors[3][3] = 102/255
		colors[3][4] = "yellow"
		colors[4][1] = 46/255
		colors[4][2] = 196/255
		colors[4][3] = 182/255 
		colors[4][4] = "aqua"

		ball = display.newCircle(_W/2, _H/2, 20)
		ball.name ="ball"
		ball:setFillColor(colors[1][1], colors[1][2], colors[1][3])
		physics.addBody( ball, "dynamic", {radius=20})
		ball:applyLinearImpulse( .1, .1 , ball.x , ball.y)
		sceneGroup:insert( ball )

		function onCollision(self, event)
			if event.phase == "began" then
					--print(event.self)
				if event.other.name == "wall" then
					if score.get() > score.load() then 
						score.save()
					end
					fullscreen:show()
					composer.gotoScene("gameover",{
					effect = "slideRight",
					time = "250"
					})
					composer.removeScene( "game" )
				else
					if physicsData:getFixtureId("spin&match", event.otherElement) == colors[color][4] then
						--print("I executed color change")
						color= math.random(1,4)
						--print("I just changed the color")
						ball:setFillColor(colors[color][1], colors[color][2], colors[color][3])
						score.add(1)
						if score.get() > 9 then
							scoreText.x = (_W/2)-50
						end
						if score.get() > 99 then
							scoreText.x = (_W/2)
						end
					else
						if score.load() ~= nil then
							if score.get() > score.load()then 
								score.save()
							end
						else
							score.save()
						end
						composer.gotoScene("gameover",{
						effect = "slideRight",
						time = "250"
						})
						composer.removeScene( "game" )
						--print("The color of the ball was " .. colors[color][4])
						--print("The color of the brick was " .. physicsData:getFixtureId("spin&match", event.otherElement))
					end
				end
			end
		end

		-- Adding physics to lines
		physics.addBody(spin_match, "static", physicsData:get("spin&match"))
		sceneGroup:insert( spin_match )


		-- Impulse to ball
		--ball:applyLinearImpulse( .1, .1 , ball.x , ball.y)
		--newBall()

		local beganX
		local beganY
		local centerX = _W/2
		local centerY = _H/2
		local beganDx
		local beganDy
		local beganAngle
		local lastAngle
		local wheelAngle
		local endedAngle = 0

		local function onScreenTouch( event )
				if (event.phase == "began") then
					beganX= event.x
					beganY= event.y
					beganDy = beganY - centerY
					beganDx = beganX - centerX
					beganAngle = -math.atan2(beganDy,beganDx)* 180 / math.pi
					lastAngle = beganAngle + endedAngle
					endedAngle = 0
					--print("I began again")
				end
				if (event.phase == "moved") then
					local actualDy = event.y - centerY
					local actualDx = event.x - centerX
					local actualAngle = -math.atan2(actualDy,actualDx)* 180 / math.pi
					wheelAngle = lastAngle-actualAngle
					--print("Cambio en el ángulo" .. wheelAngle)
					spin_match.rotation = wheelAngle

				end

				if (event.phase == "ended") then
					endedAngle = wheelAngle or 0
					lastAngle = lastAngle or 0
				end
			end

			
		Runtime:addEventListener( "touch", onScreenTouch );
		ball.collision = onCollision
		ball:addEventListener("collision", ball)
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
    --physics.stop()
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene