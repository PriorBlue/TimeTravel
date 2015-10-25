CreatePlayer = function(img, x, y, v)
	local obj = {}
	
	obj.img = img
	obj.x = x or 0
	obj.y = y or 0
	obj.width = img:getWidth() / 4
	obj.height = img:getHeight() / 4
	obj.velocity = v or 0
	obj.direction = 0
	obj.timer = 0
	obj.isMoving = false
	obj.quad = love.graphics.newQuad(0, 0, obj.width, obj.height, img:getWidth(), img:getHeight())
	
	obj.update = function(self, dt)
		if self.isMoving then
			self.timer = self.timer + dt * 10
		end
		
		self.isMoving = false
	end
	
	obj.draw = function(self)
		self.quad:setViewport((math.floor(self.timer) % 4) * self.width, self.direction * self.height, self.width, self.height)
		love.graphics.draw(self.img, obj.quad, self.x, self.y)
	end
	
	obj.moveLeft = function(self, dt)
		self.x = self.x - dt * 100
		self.direction = 1
		self.isMoving = true
	end
	
	obj.moveRight = function(self, dt)
		self.x = self.x + dt * 100
		self.direction = 2
		self.isMoving = true
	end
	
	obj.moveUp = function(self, dt)
		self.y = self.y - dt * 100
		self.direction = 3
		self.isMoving = true
	end
	
	obj.moveDown = function(self, dt)
		self.y = self.y + dt * 100
		self.direction = 0
		self.isMoving = true
	end
	
	return obj
end