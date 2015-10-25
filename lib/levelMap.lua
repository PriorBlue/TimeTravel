timetravel.levelMap = {}
timetravel.levelMap.textureSizeX, timetravel.levelMap.textureSizeY = 16, 16

local function getTileFromChar(char)
	--print("got string"..char)
	if char == "a" then
		return 0,0
	elseif char == "b" then
		return 0,1
	elseif char == "c" then
		return 0,2
	else
		return 1,0
	end
end

function timetravel.levelMap:__init(sizeX, sizeY, mapString) --LevelMap:__init
	mapImage = love.graphics.newImage("gfx/tileset.png")
	mapBatch = love.graphics.newSpriteBatch(mapImage,sizeX*sizeY)
	quad = love.graphics.newQuad(0,0,16,16,mapImage:getWidth(), mapImage:getHeight())
	m = {}
	if not(mapString == nil) and (string.len(mapString)==sizeX*sizeY) then
		for i=0,sizeX-1 do
			for j=0,sizeY-1 do
				--print("drawing map from string")
				local textureX, textureY = getTileFromChar(mapString:sub(1+j+i*sizeX, 1+j+i*sizeX))
				--print(textureX..", "..textureY)
				quad:setViewport(textureX,textureY,timetravel.levelMap.textureSizeX,timetravel.levelMap.textureSizeY)
				mapBatch:add(quad,i*timetravel.levelMap.textureSizeX,j*timetravel.levelMap.textureSizeY)
			end
		end
	else -- map string does not exist or has the wrong length, generate random map
		if not(string.len(mapString)==sizeX*sizeY) then
			print("WARNING: map string has the wrong length ("..string.len(mapString).."), should be "..sizeX*sizeY)
		end
		for i=0,sizeX-1 do
			for j=0,sizeY-1 do
				quad:setViewport(love.math.random(0,4)*16,0,timetravel.levelMap.textureSizeX,timetravel.levelMap.textureSizeY)
				mapBatch:add(quad,i*timetravel.levelMap.textureSizeX,j*timetravel.levelMap.textureSizeY)
			end
		end
	end
end

function timetravel.levelMap:draw()
	love.graphics.draw(mapBatch)
end
