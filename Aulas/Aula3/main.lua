-- Bibliotecas
local anim = require'Bibliotecas/anim8'

--Variáveis
-- Usado para controlar o sentido
local direcaoN = true
local direcaoS = true
local direcaoL = true
local direcaoO = true
-- variáveis do soldad0
-- Definição do soldado e sua animação
local soldier, animSol

local posXsol = 50
local posYsol = 550
local tam = 0.3
-- variáveis da aranha
-- Definição da aranha e sua animação
local spider, animSpi

local posXspi = 150
local posYspi = -100
local angulo = 0
local tamSpi = 1
local origem = 100

local dirVer = true

function love.load()
	-- Definindo que o mouse não vai aparecer
	love.mouse.setVisible( false )
	plano = love.graphics.newImage( "Imagens/plano.jpg" )
	-- Chamando as imagens da pasta para dentro do projeto
	cursor = love.graphics.newImage( "Imagens/mira.png" )
	soldier = love.graphics.newImage( "Imagens/survivor.png" )
	spider = love.graphics.newImage( "Imagens/Spider.png" )
	-- Criando a gride da animação 
	-- anim8.newGrid(frameWidth, frameHeight, imageWidth, imageHeight, left, top, border):
	soldierGrid = anim.newGrid( 313, 210, soldier:getWidth(), soldier:getHeight() )
	animSol = anim.newAnimation( soldierGrid( '7-13', 2, '1-13', 3 ), 0.10)
	local spiderGrid = anim.newGrid( 200, 200, spider:getWidth(), spider:getHeight() )
	animSpi = anim.newAnimation( spiderGrid( '1-4', 1, '1-4', 2, '1-4', 3, '1-4', 4), 0.10 )
end

function love.update( dt )
	-- Movimentação soldado
	-- Movimentação Vertical
	if love.keyboard.isDown( 'up' ) then
		posYsol = posYsol - 100 * dt
		direcaoN = true
		direcaoS = false
		direcaoL = false
		direcaoO = false
		animSol:update( dt )
	elseif love.keyboard.isDown( 'down' ) then
		posYsol = posYsol + 100 * dt
		direcaoN = false
		direcaoS = true
		direcaoL = false
		direcaoO = false
		animSol:update( dt )
	-- Movimentação Horizontal
	elseif love.keyboard.isDown( 'right' ) then
		posXsol = posXsol + 100 * dt
		direcaoN = false
		direcaoS = false
		direcaoL = true
		direcaoO = false
		animSol:update( dt )
	elseif love.keyboard.isDown( 'left' ) then
		posXsol = posXsol - 100 * dt
		direcaoN = false
		direcaoS = false
		direcaoL = false
		direcaoO = true
		animSol:update( dt )		
	end

	-- Movimentação Spider
	-- Movimentação Vertical
	if dirVer then
		posYspi = posYspi + 100 * dt
		animSpi:update( dt )
	else
		posYspi = posYspi - 100 * dt
		animSpi:update( dt )
	end
	-- Sentido Aranha
	if posYspi >= 700 then
		dirVer = false
	elseif posYspi <= -100 then
		dirVer = true
	end
	
	--fechando o jogo com a tecla ESC
	if love.keyboard.isDown( 'escape' ) then
		love.event.quit()
	end
end

function love.draw()
	-- Variável para definir a rotação
	rot = angulo
	
	--Desenhando a reta Numérica
	love.graphics.draw( plano, 0, -10, 0, 1.7, 1.2 )
	--Definição do fundo em Branco
	love.graphics.setBackgroundColor( 255, 255, 255 )
	
	-- Desenhando o soldado na tela
	if direcaoN then
		--animation:draw(image, x, y, angle, sx, sy, ox, oy, kx, ky)
		animSol:draw( soldier, posXsol, posYsol, 143, tam, tam, 120, 120 )
	elseif direcaoS then
		animSol:draw( soldier, posXsol, posYsol, -143, tam, tam, 120, 120 )
	elseif direcaoL then
		animSol:draw( soldier, posXsol, posYsol, -144.5, tam, tam, 120, 120 )
	elseif direcaoO then
		animSol:draw( soldier, posXsol, posYsol, 141.4, tam, tam, 120, 120 )
	end

	-- Desenhando a spider na tela
	if dirVer then
		--animation:draw(image, x, y, angle, sx, sy, ox, oy, kx, ky)
		animSpi:draw( spider, posXspi, posYspi, rot, tamSpi, tamSpi, origem, 130)
	else
		animSpi:draw( spider, posXspi, posYspi, rot, tamSpi, -tamSpi, origem, origem)
	end
	
	--Desenhando o mouse com a nova imagem
	love.graphics.draw( cursor, love.mouse.getX(), love.mouse.getY(), 0, 0.02, 0.02 )
end
