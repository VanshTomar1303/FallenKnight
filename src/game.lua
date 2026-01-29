local Map = require 'src.map'
local MC = require 'src.player'

Game = {}
Game.__index = Game

function Game:load()
    self.MC = MC:load()
    self.Map = Map:load()

    setmetatable(self, Game)
    return self
end

function Game:update(dt)
    self.MC:update(dt)
    self.Map:update(dt)
end

function Game:draw()
    self.Map:draw()
    self.MC:draw()
end

function Game:keypressed(key)
    if key == 'x' then
        self.MC:swordAttack()
    end
end

return Game