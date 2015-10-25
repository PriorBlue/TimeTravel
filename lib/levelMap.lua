timetravel.levelMap = {}
timetravel.levelMap.textureSizeX, timetravel.levelMap.textureSizeY = 32, 32
timetravel.levelMap.editor = {}
timetravel.levelMap.editor.currentTile = 0
timetravel.levelMap.editor.maxTileNumber = 51
timetravel.levelMap.editor.lastKeyPress = 0
timetravel.levelMap.editor.leftmousepressed = false

class "LevelMap" {
	currentMapString = "";
	defaultMapString = "";
	mapSizeX, mapSizeY = 0, 0;
	mapImage = nil;
	mapBatch = nil;
	quad = nil;
}

local function getCharFromNumber(number)
	if number<=25 then
		return string.char(number+97)
	else
		return string.char(number+65-25)
	end
end

local function getTileFromChar(char)
	if string.byte(char)>96 then
		return string.byte(char) - 96
	else
		return string.byte(char) - 64
	end
end

function LevelMap:__init(mapSizeX, mapSizeY, mapString)
	self.mapSizeX, self.mapSizeY = mapSizeX, mapSizeY
	self.mapImage = love.graphics.newImage("gfx/tileset.png")
	self.mapBatch = love.graphics.newSpriteBatch(self.mapImage,self.mapSizeX*self.mapSizeY)
	self.quad = love.graphics.newQuad(0,0,timetravel.levelMap.textureSizeX,timetravel.levelMap.textureSizeY,
										self.mapImage:getWidth(), self.mapImage:getHeight())
	if (mapString == nil) or not(string.len(mapString)==mapSizeX*mapSizeY) then -- map string has the wrong size or does not exist
		if not(mapString == nil) and not(string.len(mapString)==mapSizeX*mapSizeY) then
			print("WARNING: map string has the wrong length ("..string.len(mapString).."), should be "..mapSizeX*mapSizeY)
		end
		local tempMapString = {}
		for i=0,mapSizeX*mapSizeY do
			tempMapString[i] = getCharFromNumber(love.math.random(0,4)) --TODO replace 4 with maximum number of tiles
		end
		mapString = table.concat(tempMapString)
		--print(mapString)
	end
	self.defaultMapString = mapString
	self.currentMapString = mapString
	LevelMap:load(mapString, mapSizeX, mapSizeY, self.quad, self.mapBatch)
end

-- load map from given string
function LevelMap:load(mapString, sizeX, sizeY, loadQuad, loadBatch)
	loadBatch:clear()
	for i=0,sizeX-1 do
		for j=0,sizeY-1 do
			local texturePos = getTileFromChar(mapString:sub(1+i+j*sizeX, 1+i+j*sizeX))
			loadQuad:setViewport((texturePos%16)*timetravel.levelMap.textureSizeX,(texturePos-(texturePos%16))/16*timetravel.levelMap.textureSizeY,
								timetravel.levelMap.textureSizeX,timetravel.levelMap.textureSizeY)
			loadBatch:add(loadQuad,i*timetravel.levelMap.textureSizeX,j*timetravel.levelMap.textureSizeY)
		end
	end
end

function LevelMap:reload()
	LevelMap:load(self.currentMapString, self.mapSizeX, self.mapSizeY, self.quad, self.mapBatch)
end

function LevelMap:draw()
	love.graphics.draw(self.mapBatch)
end

function LevelMap:changeTile(posX, posY) -- position is given in pixels
	local actualX, actualY = (posX-(posX%timetravel.levelMap.textureSizeX))/timetravel.levelMap.textureSizeX,
							 (posY-(posY%timetravel.levelMap.textureSizeY))/timetravel.levelMap.textureSizeY
	self.currentMapString = util.replaceChar(self.currentMapString,getCharFromNumber(timetravel.levelMap.editor.currentTile),
												1+actualX+actualY*self.mapSizeY)
	self:reload()
end

function LevelMap:printMapString()
	print(self.currentMapString)
end

function LevelMap:selectNextTile()
	if timetravel.levelMap.editor.currentTile < timetravel.levelMap.editor.maxTileNumber then
		timetravel.levelMap.editor.currentTile = timetravel.levelMap.editor.currentTile+1
	else
		timetravel.levelMap.editor.currentTile = 0
	end
	--print("selected tile "..timetravel.levelMap.editor.currentTile)
end

function LevelMap:selectPrevTile()
	if timetravel.levelMap.editor.currentTile > 0 then
		timetravel.levelMap.editor.currentTile = timetravel.levelMap.editor.currentTile-1
	else
		timetravel.levelMap.editor.currentTile = timetravel.levelMap.editor.maxTileNumber
	end
	--print("selected tile "..timetravel.levelMap.editor.currentTile)
end