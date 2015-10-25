CreatePlayer = function(x, y, width, height, v)
	local obj = {}
	
	obj.x = x or 0
	obj.y = y or 0
	obj.width = width or 0
	obj.height = height or 0
	obj.velocity = v or 0
	
	obj.draw = function(self)
		love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	end
	
	obj.moveLeft = function(self, dt)
		self.x = self.x - dt * 100
	end
	
	obj.moveRight = function(self, dt)
		self.x = self.x + dt * 100
	end
	
	obj.moveUp = function(self, dt)
		self.y = self.y - dt * 100
	end
	
	obj.moveDown = function(self, dt)
		self.y = self.y + dt * 100
	end
	
	return obj
end