HC = require("HC-master")
require("tank")
require("cannon")
require("enemy")
local gameOverImg = love.graphics.newImage("_img/gameOver.png")
local terreno = love.graphics.newImage("_terreno/terreno.jpg")
local tankDown = false
deBugMode = false


Height = love.graphics.getHeight()
Width = love.graphics.getWidth()

function love.load(arg)
 	Tank:load()
  Cannon:load()
end

function love.update(dt)
	if not gameOver then
  	Tank:update(dt)
  	Cannon:update(dt)
  	Enemy:update(dt)
  	Bullet:update(dt)
  end
  	Explosion:update(dt)

end

function love.draw()
	--Desenha o terreno
	love.graphics.draw(terreno)
	--Desenha as balas
  	Bullet:draw()
  	--Desenha o Tank
	if not gameOver then
		Tank:draw()
  	Cannon:draw()
	end
	--Desenha os Inimigos
	Enemy:draw()
	--Desenha as explosões
  Explosion:draw()
  --GAME OVER
  if gameOver then
  	--Explode o tank
  	if not tankDown then
  		tankDown = true
  		table.insert(Explosions, Explosion:create(Tank.x, Tank.y))
  	end
  	--Desenha o Game Over
  	love.graphics.draw(gameOverImg, Width / 2, Height / 2, 0, 1, 1, gameOverImg:getWidth()/2, gameOverImg:getHeight()/2)
  end
end

function love.keypressed(key, scancode, isrepeat)
	--Preciona ESC para sair do jogo
  if key == "escape" then
    love.event.quit("Bye Bye !!")
  end
  --Preciona F2 para aparecer os HC
  if key == "f2" then
  	if deBugMode then
  		deBugMode = false
  	else
  		deBugMode = true
  	end
  end
  -- Reinicia o GAME
  if key == "f1" and gameOver then
  	gameOver = false
  	tankDown = false
  	Tank.x = Width / 2
  	Tank.y = Height / 2
  	cdEnemy = 3

    for i, e in ipairs(Enemys) do
      HC.remove(e.body)
      table.insert(Explosions, Explosion:create(e.x, e.y))
      table.remove(Enemys, i)
    end
    for i, b in ipairs(Cannon.bullets) do
      HC.remove(b.body)
      table.remove(Cannon.bullets, i)
    end
	end
end
