timetravel = {}
require('levelMap')

function love.load()
	timetravel.levelMap:__init(64, 64, nil)--LevelMap:__init()
	
end

function love.draw()
	timetravel.levelMap:draw()--LevelMap:draw()
	love.graphics.print("hello world")
	
end