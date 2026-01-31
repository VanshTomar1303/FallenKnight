local love = require("love")
local Game = require("src.game")
local windfield = require 'libs.windfield'

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")

	local world = windfield.newWorld(0, 0)
    world:addCollisionClass('PlayerHurtBox')
    world:addCollisionClass('OrcHurtBox')

	game = Game:load(world)
end

function love.update(dt)
	game:update(dt)
end

function love.draw()
	game:draw()
end

function love.keypressed(key)
    game:keypressed(key)

	if key == '0' then
		love.event.quit()
	end 
end