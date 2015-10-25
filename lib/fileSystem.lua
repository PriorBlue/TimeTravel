timetravel.fileSystem = {}
timetravel.fileSystem.savesList = {}

function timetravel.fileSystem.initGameFileSystem()
	--check if the game directory is already there
	if not love.filesystem.exists("saves") then
		love.filesystem.createDirectory("saves")
	end
	love.filesystem.getDirectoryItems("saves")
end

function timetravel.fileSystem.saveMap(mapInfo)
	if not love.filesystem.exists("saves/"..mapInfo.levelName..".ttmap") then
		--TODO save
		local mapInfoString = table.concat{mapInfo.levelName,",\n",mapInfo.mapString,"\n", mapInfo.objects}
		local saveName = os.date("%Y-%d-%m-%H.%M") --..mapInfo.levelName
		_, err = love.filesystem.write("saves/"..saveName..".ttmap",mapInfoString)
		print("saved to "..saveName)
		if not (err==nil) then
			print("error: "..err)
		end
	else
		--TODO overwrite
	end
	
	--levelName",\n",self.defaultMapString,",\n","OBJECTS:"
end

function timetravel.fileSystem.loadMap(index)
	--local 
end
