timetravel.levelMap = {}
timetravel.levelMap.textureSizeX, timetravel.levelMap.textureSizeY = 32, 32
timetravel.levelMap.editor = {}
timetravel.levelMap.editor.currentTile = 0
timetravel.levelMap.editor.maxTileNumber = 25
timetravel.levelMap.editor.lastKeyPress = 0
timetravel.levelMap.editor.mousepressed = ""

class "LevelMap" {
	currentMapString = "";
	defaultMapString = "";
	mapSizeX, mapSizeY = 0, 0;
	mapImage = nil;
	mapBatch = nil;
	quad = nil;
}

local function getCharFromNumber(number)
	return string.char(number+97)
end

local function getTileFromChar(char)
	--print("got string"..char)
	if type(char) == "number" then--char:len() > 1 then -- we have a number
		return char%16,(char-(char%16))/16
	else
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
		-- TODO generate custom map string
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
			--print("drawing map from string")
			local textureX, textureY = getTileFromChar(mapString:sub(1+j+i*sizeX, 1+j+i*sizeX))
			--print(textureX..", "..textureY)
			loadQuad:setViewport(textureX*timetravel.levelMap.textureSizeX,textureY*timetravel.levelMap.textureSizeY,
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
	--print("button pressed at "..posX..", "..posY)
	local actualX, actualY = (posX-(posX%timetravel.levelMap.textureSizeX))/timetravel.levelMap.textureSizeX,
							 (posY-(posY%timetravel.levelMap.textureSizeY))/timetravel.levelMap.textureSizeY
	print("placing tile at "..actualX..", "..actualY)
	self.currentMapString = util.replaceChar(self.currentMapString,getCharFromNumber(timetravel.levelMap.editor.currentTile),
												1+actualY+actualX*self.mapSizeY)
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
	print("selected tile "..timetravel.levelMap.editor.currentTile)
end

function LevelMap:selectPrevTile()
	if timetravel.levelMap.editor.currentTile > 0 then
		timetravel.levelMap.editor.currentTile = timetravel.levelMap.editor.currentTile-1
	else
		timetravel.levelMap.editor.currentTile = timetravel.levelMap.editor.maxTileNumber
	end
	print("selected tile "..timetravel.levelMap.editor.currentTile)
end
