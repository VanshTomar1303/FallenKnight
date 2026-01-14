Game = {}
Game.__index = Game

function Game:load()
    
    setmetatable(self, Game)
    return self
end

function Game:update(dt)
    
end

function Game:draw()
    love.graphics.rectangle('fill', 100, 200, 50, 50)
end

return Game