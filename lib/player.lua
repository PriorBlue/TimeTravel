CreatePlayer = function(x, y)
	local obj = {}
	
	obj.x = x
	obj.y = y
	
	obj.draw = function(self)
		love.graphics.rectangle("fill", self.x, self.y, 16, 16)
	end
	
	obj.moveLeft = function(self, dt)
		self.x = self.x - dt * 100
	end
	
	obj.moveRight = function(self, dt)
		self.x = self.x + dt * 100
	end
	
	return obj
end