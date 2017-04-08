HC = require("HC-master")
Bullet = {}
local img = love.graphics.newImage("_img/bullet.png")
function Bullet:create()
	local bullet = {}

	bullet.img 			= img
	bullet.x 			= Tank.x
	bullet.y 			= Tank.y
	bullet.r 			= Cannon.r
	bullet.sx 			= Tank.sx * 5
	bullet.sy 			= Tank.sx * 5
	bullet.width 		= bullet.img:getWidth()*bullet.sx
  	bullet.height 		= bullet.img:getHeight()*bullet.sy
	bullet.hip  		= Cannon.hip
	bullet.dir  		= {x = Cannon.dir.x / bullet.hip, y = Cannon.dir.y / bullet.hip}
	bullet.ox       	= Cannon.ox
	bullet.oy       	= Cannon.oy 
	bullet.life 		= 6
	bullet.speed		= 800
	bullet.body 		= HC.polygon(bullet.x - bullet.width / 120, bullet.y - bullet.height / 30, 
                                     bullet.x + bullet.width / 120, bullet.y - bullet.height / 30, 
                                     bullet.x + bullet.width / 120, bullet.y + bullet.height / 120,
                                     bullet.x - bullet.width / 120, bullet.y + bullet.height / 120)
	bullet.body:rotate(bullet.r)

	bullet.body.bullet = bullet

	return bullet
end

function Bullet:update(dt)
	-- Atualiza Posição
	for i, b in ipairs(Cannon.bullets) do
		b.x = b.x + b.speed * b.dir.x * dt
		b.y = b.y + b.speed * b.dir.y * dt
		b.life = b.life - dt
		b.body:moveTo(b.x + 22 * b.dir.x, b.y + 22 * b.dir.y)
		if b.life <= 0 then
			HC.remove(b.body)
			table.remove(Cannon.bullets, i)
		end
	end

	

end

function Bullet:draw()
	for i, b in ipairs(Cannon.bullets) do
		love.graphics.draw(b.img, b.x, b.y, b.r, b.sx, b.sy, b.ox, b.oy)
		if deBugMode then
			b.body:draw()
		end
	end
end