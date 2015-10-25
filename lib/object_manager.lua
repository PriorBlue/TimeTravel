CreateObjectManager = function()
	local obj = {}

	obj.objects = {}

	obj.draw = function(self)
		for k, o in pairs(self.objects) do
			love.graphics.draw(o.img, o.x, o.y)
		end
	end

	obj.add = function(self, img, x, y, func, del)
		local o = {}

		o.img = img
		o.x = x
		o.y = y
		o.width = img:getWidth()
		o.height = img:getHeight()
		o.func = func
		o.del = del

		table.insert(self.objects, o)
	end
	
	obj.checkCollision = function(self, target)
		for k, o in pairs(self.objects) do
			if o.func ~= nil then
				if target.x + target.width >= o.x and target.x <= o.x + o.width and target.y + target.height >= o.y and target.y <= o.y + o.height then
					if target.coll ~= o then
						_G[o.func](self, target)
						if o.del then
							table.remove(self.objects, k)
						else
							target.coll = o
						end
					end

					return
				end
			end
		end
		
		target.coll = nil
	end

	return obj
end