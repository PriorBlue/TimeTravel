require("lib/player")

function love.load()
	player = CreatePlayer(64, 64)
end

function love.draw()
	love.graphics.print("hello world")
	player:draw()
end

function love.update(dt)
	if love.keyboard.isDown("a") then
		player:moveLeft(dt)
	elseif love.keyboard.isDown("d") then
		player:moveRight(dt)
	end
end