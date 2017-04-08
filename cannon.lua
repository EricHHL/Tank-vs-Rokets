require("bullet")

Cannon = {}
local cd = 0

function Cannon:load()

  self.imgCannon 		 = love.graphics.newImage("_img/cannon.png")
  self.r 					   = 0
	self.ox 				   = self.imgCannon:getWidth() / 2
	self.oy					   = self.imgCannon:getHeight() * 0.62
  self.dir           = {x = love.mouse.getX() - Tank.x, y = love.mouse.getY() - Tank.y}
  self.hip           = (self.dir.x^2 + self.dir.y^2)^(1/2)
  self.coultdown     = 0.08
  self.warm          = 3
  self.bullets       = {}

end

function Cannon:update(dt)
  -- ATUALIZA VETOR DE DIREÇÃO
  self.dir.x = love.mouse.getX() - Tank.x
  self.dir.y = love.mouse.getY() - Tank.y

  -- ROTACIONA O CANNON PARA APONTAR PRO MOUSE
  if  self.dir.y < 0 then
    self.hip = (self.dir.x^2 + self.dir.y^2)^(1/2)
    self.r = math.asin(self.dir.x / self.hip)
  else
    self.hip = (self.dir.x^2 + self.dir.y^2)^(1/2)
    self.r = math.asin(-self.dir.x / self.hip) + math.pi
  end

  -- FIRE
  cd = cd + dt
  if love.mouse.isDown(1) and self.coultdown < cd then
    self.coultdown = self.coultdown + dt/2
    cd = 0
    Cannon:fire()
  elseif self.coultdown > 0.08 then
    self.coultdown = self.coultdown - dt/30
  end
end

function Cannon:draw()
  love.graphics.draw(self.imgCannon, Tank.x, Tank.y, self.r, Tank.sx, Tank.sy, self.ox, self.oy)
end

function Cannon:fire()
  table.insert(self.bullets, Bullet:create())
end