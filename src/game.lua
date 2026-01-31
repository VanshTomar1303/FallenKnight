local Map = require 'src.map'
local MC = require 'src.player'
local Orc1 = require 'src.enemy.Orc1'

Game = {}
Game.__index = Game

local game_state = {
    menu = "Menu",
    pause = "Pause",
    game_over = "DIE",
    running = "Running"
}

function Game:load(world)
    self.game_state = game_state.menu

    self.world = world

    self.playerX = 100
    self.playerY = 200

    self.MC = MC:load(playerX, playerY,world)
    self.Orc1 = Orc1:load(500,100)
    self.Map = Map:load()

    setmetatable(self, Game)
    return self
end

function Game:update(dt)
    if self.game_state == game_state.running then
        self.MC:update(dt)
        self.Orc1:update(dt)
        self.Map:update(dt)
        self.world:update(dt)
    end
end

function Game:draw()
    if self.game_state == game_state.menu then
        love.graphics.print("Menu", 100, 100)
    elseif self.game_state == game_state.running then
        self.Map:draw()
        self.MC:draw()
        self.Orc1:draw()
        self.world:draw()
    elseif self.game_state == game_state.game_over then
        love.graphics.print("DIE", 100, 100)
    elseif self.game_state == game_state.pause then
        love.graphics.print("Pause", 100, 100)
    end
end

function Game:keypressed(key)

    -- game state
    if key == 'p' then
        self.game_state = "Pause"
        print("hello")
    end
    if key == 'return' or self.game_state == 'Menu' and self. game_state == 'Pause' then 
        self.game_state = "Running"
    end

    -- Player sword attack
    if key == 'x' then
        self.MC:swordAttack()
    end
end

return Game