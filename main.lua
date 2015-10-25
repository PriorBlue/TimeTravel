timetravel = {}

require('lib/32log')
require('lib/util')
require('lib/levelMap')
require("lib/object_manager")
require("lib/quests")
require("lib/player")
require('lib/world')
require('lib/menu')
require('lib/credits')
require('lib/postshader')

timetravel.currentMode = 2 -- 2=in game, 8=edit mode

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest", 0)
	
	IMAGE_PLAYER = love.graphics.newImage("gfx/player.png")
	IMAGE_PART = love.graphics.newImage("gfx/part.png")
	IMAGE_TIMEMACHINE = love.graphics.newImage("gfx/timemachine.png")
	IMAGE_SCORE = love.graphics.newImage("gfx/score.png")
	
	FONT_MENU = love.graphics.newFont("font/font.ttf", 48)
	FONT_GAME = love.graphics.newFont("font/font.ttf", 16)
	love.graphics.setFont(FONT_MENU)

	if gWorld ~= nil then
		gWorld:clearAll()
	end

	gWorld = World:new(gScreenWidth, gScreenHeight)
	gMenu = Menu:new(gScreenWidth, gScreenHeight)
	gCredits = Credits:new(gScreenWidth, gScreenHeight)
	
	timetravel.currentMap = LevelMap:new(32, 32, nil)
	player = CreatePlayer(IMAGE_PLAYER, 64, 128)
	objectManager = CreateObjectManager()
	objectManager:add(IMAGE_TIMEMACHINE, 128, 128, "GoToThePast", false, 2)
	
	--objectManager:load("data/objects_present.lua")
	
	gState = "menu"
	
	YEAR = 2015
end

function love.draw()

	love.postshader.setBuffer("render")

	if gState == "menu" then
		gMenu:draw()
	elseif gState == "credits" then
		gCredits:draw()
	else
		love.graphics.scale( 2, 2 )
		gWorld:draw()
	end
	
	love.graphics.origin()
	love.postshader.addEffect("scanlines")
	
	if YEAR ~= 2015 then
		love.postshader.addEffect("monochrom")
	end
	
	love.postshader.draw()
end

function love.update(dt)
	if gState == "menu" then
		gMenu:update(dt)
	elseif gState == "credits" then
		gCredits:update(dt)
	else
		gWorld:update(dt)

		if timetravel.currentMode == 8 then
			if timetravel.levelMap.editor.leftmousepressed then
				timetravel.currentMap:changeTile(love.mouse.getX(), love.mouse.getY())
			end
		end
	end
end

function love.mousepressed(x, y, button)
	if timetravel.currentMode == 8 then
		if button == "l" then
			timetravel.levelMap.editor.leftmousepressed = true
		elseif button == "r" then
			-- change to object placement mode
		elseif button == "m" then
			-- grab tile
		end
		
		if button == "wu" then
			-- next tile
			timetravel.currentMap:selectNextTile()
		elseif button == "wd" then
			-- previous tile
			timetravel.currentMap:selectPrevTile()
		end
	end
	
	if gState == "menu" then
		gMenu:mouseHit(x, y, button)
	elseif gState == "credits" then
		gCredits:mouseHit(x, y, button)
	end
end

function love.mousereleased(x, y, button)
	if timetravel.currentMode == 8 then
		if button == "l" then
			timetravel.levelMap.editor.leftmousepressed = false
		end
	end
end

function love.mousemoved(x, y)
	if gState == "menu" then
		gMenu:mouseMoved(x, y)
	elseif gState == "credits" then
		gCredits:mouseMoved(x, y)
	end
end

function love.keyreleased(key)
	if key == 'escape' then
		gState = "menu"
	end
end