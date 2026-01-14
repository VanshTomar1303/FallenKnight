local Game = require 'src.game'

function love.load()
    game = Game:load()
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:draw()
end