timetravel = {}
require('lib/levelMap')
require("lib/player")

function love.load()
	timetravel.levelMap:__init(4, 4, nil) -- "blaclacalababbbb")
	player = CreatePlayer(64, 64)
end

function love.draw()
	timetravel.levelMap:draw()
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