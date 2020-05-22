local anim = require'Bibliotecas/anim8'

--Usando para controlar o sentido
local dirN = true
local dirS = true
local dirL = true
local dirO = true

--variáveis do soldado
local soldier, animSol

local posXsol = 100
local posYsol = 100
local tam = 0.3

function love.load()
	plano = love.graphics.newImage( "Imagens/plano.jpg" )
	soldier = love.graphics.newImage( "Imagens/survivor.png" )
	--Criando a gride de animacao
	soldierGrid = anim.newGrid( 313, 210, soldier:getWidth(), soldier:getHeight() )
	animSol = anim.newAnimation( soldierGrid( '7-13',2, '1-13', 3 ), 0.10 )
end

function love.update( dt )
	--Movimentacao soldado
	--Movimentacao Vertical
	if love.keyboard.isDown('up')then
		posYsol = posYsol - 100 * dt
		dirN = true
		dirS = false
		dirL = false
		dirO = false
		animSol:update( dt )
	elseif love.keyboard.isDown('down')then
		posYsol = posYsol + 100 * dt
		dirS = true
		dirN = false
		dirL = false
		dirO = false
		animSol:update( dt )
	elseif love.keyboard.isDown('right')then
		posXsol = posXsol + 100 * dt
		dirL = true
		dirS = false
		dirN = false
		dirO = false
		animSol:update( dt )
	elseif love.keyboard.isDown('left')then
		posXsol = posXsol - 100 * dt
		dirO = true
		dirN = false
		dirL = false
		dirS = false
		animSol:update( dt )
	end
	
	if love.keyboard.isDown('escape') then
		love.event.quit()
	end
	
end

function love.draw()
	rot = angulo
	--love.graphics.draw( drawable, x, y, r, sx, sy, ox, oy, kx, ky )
	love.graphics.draw( plano, 0, -10, 0, 1.7, 1.2)
	
	--Desenha o soldado na tela
	if dirN then
		animSol:draw( soldier, posXsol, posYsol, 143, tam, tam, 120, 120)
	elseif dirS then
		animSol:draw( soldier, posXsol, posYsol, -143, tam, tam, 120, 120)
	elseif dirL then
		animSol:draw( soldier, posXsol, posYsol, -144.5, tam, tam, 120, 120)
	elseif dirO then
		animSol:draw( soldier, posXsol, posYsol, 141.4, tam, tam, 120, 120)
	end
	
end