timetravel = {}

require('lib/32log')
require('lib/util')
require('lib/levelMap')
require("lib/object_manager")
require("lib/quests")
require("lib/player")
timetravel.currentMode = 2 -- 2=in game, 8=edit mode

function love.load()
	IMAGE_PLAYER = love.graphics.newImage("gfx/player.png")
	IMAGE_PART = love.graphics.newImage("gfx/part.png")
	IMAGE_TIMEMACHINE = love.graphics.newImage("gfx/timemachine.png")

	timetravel.currentMap = LevelMap:new(32, 32, nil)
	player = CreatePlayer(IMAGE_PLAYER, 64, 128)
	objectManager = CreateObjectManager()
	objectManager:add(IMAGE_TIMEMACHINE, 128, 128, "GoToThePast")
	
	for i=0,15 do
		objectManager:add(IMAGE_PART, math.random(0, 700), math.random(0, 500), "AddPart", true)
	end
	
	--objectManager:load("data/objects_present.lua")
end

function love.draw()
	-- WORLD
	timetravel.currentMap:draw()
	objectManager:draw()
	player:draw()
	
	-- HUD
	love.graphics.print(GAME_PARTS, 256, 16)
	if timetravel.currentMode == 8 then
		love.graphics.print("EDIT MODE")
	--else
		--love.graphics.print("hello world")
	end
end

function love.update(dt)
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

function love.mousepressed(x, y, button)
	if timetravel.currentMode == 8 then
		timetravel.levelMap.editor.mousepressed = button -- TODO quick fix for now
		if button == "l" then
			--timetravel.currentMap:changeTile(x, y)
		elseif button == "r" then
			-- change to object placement mode
		elseif button == "wu" then
			-- next tile
			timetravel.currentMap:selectNextTile()
		elseif button == "wd" then
			-- previous tile
			timetravel.currentMap:selectPrevTile()
		elseif button == "m" then
			-- grab tile
		end
	end
end

function love.mousereleased(x, y, button)
	if timetravel.currentMode == 8 then
		if button == "l" then
			timetravel.levelMap.editor.mousepressed = ""
		end
	end
end