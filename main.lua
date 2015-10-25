require("lib/object_manager")
require("lib/quests")
require("lib/player")

function love.load()
	player = CreatePlayer(64, 128, 16, 32)
	objectManager = CreateObjectManager()
	objectManager:add(16, 16, 32, 32, "AddPart")
	objectManager:add(48, 64, 16, 16, "AddPart", true)
	
	for i=0,15 do
		objectManager:add(math.random(0,700), math.random(0,500), 16, 16, "AddPart", true)
	end
end

function love.draw()
	-- WORLD
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