local love = require("love")
local Game = require("src.game")

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	game = Game:load()
end

function love.update(dt)
	game:update(dt)
end

function love.draw()
	game:draw()
end

function love.keypressed(key)
    game:keypressed(key)
end