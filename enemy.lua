require("explosion")
Enemy = {}
Enemys = {}
cdEnemy = 3
dificulty = 0

gameOver = false

math.randomseed (os.time())
local img = love.graphics.newImage("_img/enemy.png")
function Enemy:create()
	enemy = {}
		
		enemy.img 		= img
		enemy.x 		= 0
		enemy.y 		= 0
		enemy.r 		= 0
		enemy.sx	 	= 2
		enemy.sy	 	= 2
		enemy.width 	= enemy.img:getWidth()
  		enemy.height 	= enemy.img:getHeight()
		enemy.ox 		= enemy.img:getWidth()/2 
		enemy.oy 		= enemy.img:getHeight()/2
		enemy.dir       = {x, y}
  		enemy.hip       = 0
		enemy.life 		= 20
		enemy.speed 	= 600
		
		-- Gera posição inicial aleatória
		if math.random(0, 10) % 2 == 0 then
			if math.random(0, 10) % 2 == 0 then
				enemy.x 	= math.random(-200, Width + 200)
				enemy.y 	= math.random(-100, -300)
			else
				enemy.x 	= math.random(-100, -300)
				enemy.y 	= math.random(-200, Height + 200)
			end
		else
			if math.random(0, 10) % 2 == 0 then
				enemy.x 	= math.random(-200, Width + 200)
				enemy.y 	= math.random(Height + 200, Height + 400)
			else
				enemy.x 	= math.random(Width + 200, Width + 400)
				enemy.y 	= math.random(-200, Height + 200)
			end
		end

		-- Define Alvo
		enemy.dir.x 	= Tank.x - enemy.x
		enemy.dir.y 	= Tank.y - enemy.y
		enemy.hip    	= (enemy.dir.x^2 + enemy.dir.y^2)^(1/2)
		enemy.dir.x 	= (Tank.x - enemy.x) / enemy.hip
		enemy.dir.y 	= (Tank.y - enemy.y) / enemy.hip

		enemy.body 		= HC.polygon(enemy.x - enemy.width/2, enemy.y - enemy.height / 2 - 10,
									enemy.x + enemy.width/2, enemy.y - enemy.height / 2 - 10,
									enemy.x + enemy.width/2, enemy.y + enemy.height / 2 + 10,
									enemy.x - enemy.width/2, enemy.y + enemy.height / 2 + 10)

		if  enemy.dir.y < 0 then
    		enemy.hip        = (enemy.dir.x^2 + enemy.dir.y^2)^(1/2)
    		enemy.r          = math.asin(enemy.dir.x / enemy.hip)
    		enemy.body:rotate(math.asin(enemy.dir.x / enemy.hip))
  		else
    		enemy.hip        = (enemy.dir.x^2 + enemy.dir.y^2)^(1/2)
    		enemy.r          = math.asin(-enemy.dir.x / enemy.hip) + math.pi
    		enemy.body:rotate(math.asin(-enemy.dir.x / enemy.hip) + math.pi)
  		end
		
  		enemy.body.enemy = enemy

	return enemy
end

function Enemy:update(dt)

	-- Tempo entre Rokets
	cdEnemy = cdEnemy - dt
	if cdEnemy <= 0 then
  		cdEnemy = 1.5 - dificulty
  		dificulty = dificulty + dt / 2
  		table.insert(Enemys, Enemy:create())
  	end

  	-- Atualiza movimentação
	for i, e in ipairs(Enemys) do
		e.x = e.x + e.speed * e.dir.x * dt
		e.y = e.y + e.speed * e.dir.y * dt
		e.life = e.life - dt
		e.body:move(e.speed * e.dir.x * dt, e.speed * e.dir.y * dt)
		if e.life <= 0 then
			table.remove(Enemys, i)
			HC.remove(e.body)
		end
		-- Explosão do Rocket
		for shape, delta in pairs(HC.collisions(e.body)) do
			table.insert(Explosions, Explosion:create(e.x, e.y))
			table.remove(Enemys, i)
			HC.remove(e.body)
			if shape == Tank.body then
				gameOver = true
			elseif shape.bullet then
				shape.bullet.life = 0
				score = score + 1
			end
		end
	end

end

function Enemy:draw()
	for i, e in ipairs(Enemys) do
		love.graphics.draw(e.img, e.x, e.y, e.r, e.sx, e.sy, e.ox, e.oy)
		if deBugMode then
			e.body:draw()
			love.graphics.print(#Enemys)
		end
	end
end