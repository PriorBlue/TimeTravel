GAME_PARTS = 0

function AddPart(self)
	GAME_PARTS = GAME_PARTS + 1
end

function GoToThePast(self)
	if GAME_PARTS >= 5 then
		GAME_PARTS = 0
		objectManager:load("data/objects_present.lua")
		
		if YEAR ~= 2015 then
			YEAR = 2015
		else
			YEAR = 1985
		end
	end
end