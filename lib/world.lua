class "World" {

}

function World:__init()

end

function World:update(dt)
	if love.keyboard.isDown("a") then
		player:moveLeft(dt)
	elseif love.keyboard.isDown("d") then
		player:moveRight(dt)
	elseif love.keyboard.isDown("e") then --TODO only allow this in the main menu
		-- switch between editor mode and game mode
		if timetravel.levelMap.editor.lastKeyPress < os.time() then -- todo remove this once the update frequency is checked somewhere else
			if timetravel.currentMode == 2 then
				print("switching to edit mode")
				timetravel.currentMode = 8
			elseif timetravel.currentMode == 8 then
				timetravel.currentMode = 2 
			end
			timetravel.levelMap.editor.lastKeyPress = os.time()
		end
	elseif love.keyboard.isDown("x") then -- export map string, only on console for now
		timetravel.currentMap:printMapString()
	end
	
	if love.keyboard.isDown("w") then
		player:moveUp(dt)
	elseif love.keyboard.isDown("s") then
		player:moveDown(dt)
	end
	if timetravel.currentMode == 8 then
		if timetravel.levelMap.editor.mousepressed == "l" then -- TODO quick fix from below, part 2
			timetravel.currentMap:changeTile(love.mouse.getX(), love.mouse.getY())
		end
	end
	
	player:update(dt)
	objectManager:checkCollision(player)
end

function World:draw()
	-- WORLD
	timetravel.currentMap:draw()
	objectManager:draw()
	player:draw()
	
	-- HUD
	love.graphics.draw(IMAGE_SCORE, 0, 256)
	love.graphics.setFont(FONT_GAME)
	love.graphics.setColor(0, 255, 0)
	love.graphics.print("Parts: " .. GAME_PARTS, 8, 258)
	love.graphics.setColor(255, 255, 255)
	if timetravel.currentMode == 8 then
		love.graphics.print("EDIT MODE")
	end
	
	local f = 7
	local r = 127 + math.sin((love.timer.getTime() * 0.1) * 5 * f + 90) * 127
	local g = 127 + math.sin((love.timer.getTime() * 0.1) * 5 * f + 180) * 127
	local b = 127 + math.sin((love.timer.getTime() * 0.1) * 5 * f + 270) * 127

	love.graphics.setFont(FONT_MENU)
	love.graphics.setColor(0, 0, 0)
	love.graphics.print("2015", 280 + 2, 8 + 2)
	love.graphics.setColor(r, g, b)
	love.graphics.print("2015", 280, 8)
end