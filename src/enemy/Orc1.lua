local anim8 = require 'libs.anim8'

Orc1 = {}
Orc1.__index = Orc1

function Orc1:load(x, y)

    self.scale = 2

    -- orc1 spritesheet
    local orc1SpriteSheets = {
        orcAttack = love.graphics.newImage('assets/orc/Orc1/orc1_attack.png'),
        orcDeath = love.graphics.newImage('assets/orc/Orc1/orc1_death.png'),
        orcHurt = love.graphics.newImage('assets/orc/Orc1/orc1_hurt.png'),
        orcIdle = love.graphics.newImage('assets/orc/Orc1/orc1_idle_.png'),
        orcWalk = love.graphics.newImage('assets/orc/Orc1/orc1_walk.png'),
    }

    -- orc1 grid
    local orc1Grids = {
        orcAttack = anim8.newGrid(64, 64, orc1SpriteSheets.orcAttack:getWidth(), orc1SpriteSheets.orcAttack:getHeight()),
        orcDeath = anim8.newGrid(64, 64, orc1SpriteSheets.orcDeath:getWidth(), orc1SpriteSheets.orcDeath:getHeight()),
        orcHurt = anim8.newGrid(64, 64, orc1SpriteSheets.orcHurt:getWidth(), orc1SpriteSheets.orcHurt:getHeight()),
        orcIdle = anim8.newGrid(64, 64, orc1SpriteSheets.orcIdle:getWidth(),orc1SpriteSheets.orcIdle:getHeight()),
        orcWalk = anim8.newGrid(64, 64, orc1SpriteSheets.orcWalk:getWidth(), orc1SpriteSheets.orcWalk:getHeight()),
    }

    -- orc1 coordinate
    self.x = x or 100
    self.y = y or 100

    -- orc1 speed
    self.speed = 200
    
    -- orc1 health
    self.maxHealth = 100
    self.currentHealth = 100

    -- orc1 basis
    self.isMoving = false
    self.isAttacking = false

    -- orc1 attacking cooldown
    self.attackCooldown = 0.5

    -- orc1 Spritesheets
    self.orc1SpriteSheets = orc1SpriteSheets

    -- orc1 direction
    self.dir = 'down'
    
    -- orc1 animations
    self.animation = {
        idleDown = anim8.newAnimation(orc1Grids.orcIdle('1-4', 1), 0.2),
        idleUp = anim8.newAnimation(orc1Grids.orcIdle('1-4', 2), 0.2),
        idleLeft = anim8.newAnimation(orc1Grids.orcIdle('1-4', 3), 0.2),
        idleRight = anim8.newAnimation(orc1Grids.orcIdle('1-4', 4), 0.2),
    }

    -- orc1 current spritesheet
    self.currentOrcSpriteSheet = self.orc1SpriteSheets.orcIdle

    -- orc1 current animation
    self.currentAnimation = self.animation.idleDown

    setmetatable(self, Orc1)
    return self
end

function Orc1:update(dt)
    self.isMoving = false
    
    -- -- movement and changing animation/spritesheet
    -- self:movement(dt)
    -- self:changeAnimationAndSpritesheet()

    -- -- handling sword attack and cooldown
    -- if self.isAttacking then
    --     self.attackCooldown = self.attackCooldown - dt
    --     if self.attackCooldown <= 0 then
    --         self.isAttacking = false
    --         self.attackCooldown = 0
    --     end
    -- end

    -- -- updating the animaton
    self.currentAnimation:update(dt)
end

-- function Orc1:movement(dt)
--     if love.keyboard.isDown('w') then
--         self.y = self.y - self.speed * dt
--         self.dir = 'up'
--         self.isMoving = true
--     elseif love.keyboard.isDown('s') then
--         self.y = self.y + self.speed * dt
--         self.dir = 'down'
--         self.isMoving = true
--     elseif love.keyboard.isDown('a') then
--         self.x = self.x - self.speed * dt
--         self.dir = 'left'
--         self.isMoving = true
--     elseif love.keyboard.isDown('d') then
--         self.x = self.x +  self.speed * dt
--         self.dir = 'right'
--         self.isMoving = true
--     end
-- end

-- function Orc1:changeAnimationAndSpritesheet()
--     if self.isMoving then
--         if self.dir == 'down' then
--             self.currentPlayerSpriteSheet = self.orc1SpriteSheets.runDown
--             self.currentAnimation = self.animation.runDown
--         elseif self.dir == 'up' then
--             self.currentPlayerSpriteSheet = self.orc1SpriteSheets.runUp
--             self.currentAnimation = self.animation.runUp
--         elseif self.dir == 'left' then
--             self.currentPlayerSpriteSheet = self.orc1SpriteSheets.runLeft
--             self.currentAnimation = self.animation.runLeft
--         elseif self.dir == 'right' then
--             self.currentPlayerSpriteSheet = self.orc1SpriteSheets.runRight
--             self.currentAnimation = self.animation.runRight
--         end
--     elseif not self.isMoving and not self.isAttacking then
--         if self.dir == 'down' then
--             self.currentPlayerSpriteSheet = self.orc1SpriteSheets.idleDown
--             self.currentAnimation = self.animation.idleDown
--         elseif self.dir == 'up' then
--             self.currentPlayerSpriteSheet = self.orc1SpriteSheets.idleUp
--             self.currentAnimation = self.animation.idleUp
--         elseif self.dir == 'left' then
--             self.currentPlayerSpriteSheet = self.orc1SpriteSheets.idleLeft
--             self.currentAnimation = self.animation.idleLeft
--         elseif self.dir == 'right' then
--             self.currentPlayerSpriteSheet = self.orc1SpriteSheets.idleRight
--             self.currentAnimation = self.animation.idleRight
--         end
--     end
-- end

-- function Orc1:swordAttack()
--     self.isAttacking = true
--     self.attackCooldown = 0.8
--     self:attackingAnimation()
-- end

-- function Orc1:attackingAnimation()
--     if self.isAttacking then
--         if self.dir == 'down' then
--             self.currentPlayerSpriteSheet = self.orc1SpriteSheets.attack1Down
--             self.currentAnimation = self.animation.attackDown
--         elseif self.dir == 'up' then
--             self.currentPlayerSpriteSheet = self.orc1SpriteSheets.attack1Up
--             self.currentAnimation = self.animation.attackUp
--         elseif self.dir == 'left' then
--             self.currentPlayerSpriteSheet = self.orc1SpriteSheets.attack1Left
--             self.currentAnimation = self.animation.attackLeft
--         elseif self.dir == 'right' then
--             self.currentPlayerSpriteSheet = self.orc1SpriteSheets.attack1Right
--             self.currentAnimation = self.animation.attackRight
--         end
--     end
-- end

function Orc1:draw()
    -- health bar
    orcHealthBar(self.maxHealth, self.currentHealth)

    -- orc1
    self.currentAnimation:draw(self.currentOrcSpriteSheet, self.x, self.y, 0 , self.scale)
end

function orcHealthBar(maxHealth, currentHealth)
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle('line', 500, 20, maxHealth * 2, 15)
    love.graphics.setColor(0.6,0.4,0)
    love.graphics.rectangle('fill', 500, 20, currentHealth * 2, 15)
    love.graphics.setColor(1,1,1)
end

return Orc1