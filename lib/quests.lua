GAME_PARTS = 0

function AddPart(self)
	GAME_PARTS = GAME_PARTS + 1
end

function GoToThePast(self)
	if GAME_PARTS >= 5 then
		GAME_PARTS = 0
		objectManager:load("data/objects_present.lua")
	end
end