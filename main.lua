timetravel = {}

require('lib/levelMap')
require("lib/object_manager")
require("lib/quests")
require("lib/player")

function love.load()
	IMAGE_PART = love.graphics.newImage("gfx/part.png")
	IMAGE_TIMEMACHINE = love.graphics.newImage("gfx/timemachine.png")

	timetravel.levelMap:__init(4, 4, "blaclacalababbbb")
	player = CreatePlayer(64, 128, 16, 32)
	objectManager = CreateObjectManager()
	objectManager:add(IMAGE_TIMEMACHINE, 128, 128, "GoToThePast")
	
	for i=0,15 do
		objectManager:add(IMAGE_PART, math.random(0, 700), math.random(0, 500), "AddPart", true)
	end
end

function love.draw()
	-- WORLD
	timetravel.levelMap:draw()
	objectManager:draw()
	player:draw()
	
	-- HUD
	love.graphics.print(GAME_PARTS, 256, 16)
end

function love.update(dt)
	if love.keyboard.isDown("a") then
		player:moveLeft(dt)
	elseif love.keyboard.isDown("d") then
		player:moveRight(dt)
	end
	
	if love.keyboard.isDown("w") then
		player:moveUp(dt)
	elseif love.keyboard.isDown("s") then
		player:moveDown(dt)
	end
	
	objectManager:checkCollision(player)
end