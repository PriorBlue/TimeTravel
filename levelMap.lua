timetravel.levelMap = {}

function timetravel.levelMap:__init(sizeX, sizeY, mapString) --LevelMap:__init
	mapImage = love.graphics.newImage("gfx/tileset.png")
	mapBatch = love.graphics.newSpriteBatch(mapImage,sizeX*sizeY)
	quad = love.graphics.newQuad(0,0,16,16,mapImage:getWidth(), mapImage:getHeight())
	m = {}
	for i=0,sizeX-1 do
		for j=0,sizeY-1 do
			quad:setViewport(love.math.random(0,4)*16,0,16,16)
			mapBatch:add(quad,i*16,j*16)
		end
	end
end

function timetravel.levelMap:draw() --LevelMap:draw
	love.graphics.draw(mapBatch)
end
