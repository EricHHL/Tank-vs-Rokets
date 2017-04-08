local anim = require("anim8-master/anim8")

Explosion = {}
Explosions = {}

local img = love.graphics.newImage("_img/explosion_sp.png")
local g = anim.newGrid(95, 94, img:getWidth(), img:getHeight())

function Explosion:create(x, y)
	local explosion = {}
	explosion.animation 	= anim.newAnimation(g('1-7', 1), 0.1)
	explosion.img 			= img
	explosion.x 			= x + img:getWidth()/2 - 40
	explosion.y 			= y
	explosion.r 			= 0
	explosion.sx 			= 1
	explosion.sy 			= 1
	explosion.width 		= img:getWidth()*explosion.sx
  	explosion.height 		= img:getHeight()*explosion.sy
	explosion.ox       		= explosion.width / 2
	explosion.oy       		= explosion.height / 2
	explosion.life 			= 0.7
	return explosion
end

function Explosion:update(dt)
	for i, e in ipairs(Explosions) do
		e.animation:update(dt)
		e.life = e.life - dt
		if e.life <= 0 then
			table.remove(Explosions, i)
		end
	end
end

function Explosion:draw()
	for i, e in ipairs(Explosions) do
		e.animation:draw(e.img, e.x, e.y, e.r, e.sx, e.sy, e.ox, e.oy)
	end
end