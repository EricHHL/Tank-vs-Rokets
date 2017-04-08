Tank = {}

function Tank:load()

  self.img 		           = love.graphics.newImage("_img/tank.png")
  self.sx 				       = 0.12
  self.sy 				       = 0.12
  self.width 			       = self.img:getWidth()*self.sx
  self.height 		       = self.img:getHeight()*self.sy
	self.x 					       = Width / 2
	self.y 					       = Height / 2
	self.r 					       = 0
	self.ox 				       = self.img:getWidth() / 2
	self.oy					       = self.img:getHeight() / 2
	self.speed	 		       = 180
  self.speedX            = self.speed * math.cos(math.pi / 4)
  self.speedY            = self.speed * math.sin(math.pi / 4)
  self.body              = HC.polygon(self.x - self.width / 2 + 10, self.y - self.height / 2 + 10, 
                                      self.x + self.width / 2 - 10, self.y - self.height / 2 + 10, 
                                      self.x + self.width / 2 - 10, self.y + self.height / 2 - 10,
                                      self.x - self.width / 2 + 10, self.y + self.height / 2 - 10)

end

function Tank:update(dt)

  

  -- MOVIMENTÇÃO
  if love.keyboard.isDown("w") and love.keyboard.isDown("a") then
    self.y = self.y - self.speedY * dt
    self.x = self.x - self.speedX * dt
    self.r = math.pi*7/4
  elseif love.keyboard.isDown("a") and love.keyboard.isDown("s") then
    self.y = self.y + self.speedY * dt
    self.x = self.x - self.speedX * dt
    self.r = math.pi*5/4
  elseif love.keyboard.isDown("s") and love.keyboard.isDown("d") then
    self.y = self.y + self.speedY * dt
    self.x = self.x + self.speedX * dt
    self.r = math.pi*3/4
  elseif love.keyboard.isDown("d") and love.keyboard.isDown("w") then
    self.y = self.y - self.speedY * dt
    self.x = self.x + self.speedX * dt
    self.r = math.pi*1/4
  elseif love.keyboard.isDown("w") then
    self.y = self.y - self.speed * dt
    self.r = 0
  elseif love.keyboard.isDown("a") then
    self.x = self.x - self.speed * dt
    self.r = math.pi*3/2
  elseif love.keyboard.isDown("s") then
    self.y = self.y + self.speed * dt
    self.r = math.pi
  elseif love.keyboard.isDown("d") then
    self.x = self.x + self.speed * dt
    self.r = math.pi*1/2
  end


  -- IMPEDIR QUE SAIA DA TELA
  if self.y < self.height / 2 then
    self.y = self.height / 2
  end
  if self.x < self.width / 2 then
    self.x = self.width / 2
  end
  if self.y > Height - self.height / 2 then
    self.y = Height - self.height / 2
  end
  if self.x > Width - self.width / 2 then
    self.x = Width - self.width / 2
  end

  -- HC
  self.body:moveTo(self.x, self.y)
  self.body:rotate(self.r)
  
end

function Tank:draw()
  love.graphics.draw(self.img, self.x, self.y, self.r, self.sx, self.sy, self.ox, self.oy)
  if deBugMode then
    self.body:draw()
  end
end
