timetravel = {}
require('levelMap')
require("lib/player")

function love.load()
	timetravel.levelMap:__init(64, 64, nil)--LevelMap:__init()
	player = CreatePlayer(64, 64)
end

function love.draw()
	timetravel.levelMap:draw()--LevelMap:draw()
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