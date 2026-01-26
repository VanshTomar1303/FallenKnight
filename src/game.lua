local MC = require 'src.player'

Game = {}
Game.__index = Game

function Game:load()
    self.MC = MC:load()

    setmetatable(self, Game)
    return self
end

function Game:update(dt)
    self.MC:update(dt)

end

function Game:draw()
    self.MC:draw()
end

return Game