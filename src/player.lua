local anim8 = require 'libs.anim8'

Player = {}
Player.__index = Player

function Player:load(x, y, world)

    self.scale = 2

    -- MC spritesheet
    local playerSpriteSheets = {
        idleDown = love.graphics.newImage('assets/MC/IDLE/idle_down.png'),
        idleUp = love.graphics.newImage('assets/MC/IDLE/idle_up.png'),
        idleLeft = love.graphics.newImage('assets/MC/IDLE/idle_left.png'),
        idleRight = love.graphics.newImage('assets/MC/IDLE/idle_right.png'),
        runDown = love.graphics.newImage('assets/MC/RUN/run_down.png'),
        runUp = love.graphics.newImage('assets/MC/RUN/run_up.png'),
        runLeft = love.graphics.newImage('assets/MC/RUN/run_left.png'),
        runRight = love.graphics.newImage('assets/MC/RUN/run_right.png'),
        attack1Down = love.graphics.newImage('assets/MC/ATTACK 1/attack1_down.png'),
        attack1Up = love.graphics.newImage('assets/MC/ATTACK 1/attack1_up.png'),
        attack1Left = love.graphics.newImage('assets/MC/ATTACK 1/attack1_left.png'),
        attack1Right = love.graphics.newImage('assets/MC/ATTACK 1/attack1_right.png')
    }

    -- MC grid
    local playerGrids = {
        idleDown = anim8.newGrid(96, 80, playerSpriteSheets.idleDown:getWidth(), playerSpriteSheets.idleDown:getHeight()),
        idleUp = anim8.newGrid(96, 80, playerSpriteSheets.idleUp:getWidth(), playerSpriteSheets.idleUp:getHeight()),
        idleLeft = anim8.newGrid(96, 80, playerSpriteSheets.idleLeft:getWidth(), playerSpriteSheets.idleLeft:getHeight()),
        idleRight = anim8.newGrid(96, 80, playerSpriteSheets.idleRight:getWidth(),playerSpriteSheets.idleRight:getHeight()),
        runDown = anim8.newGrid(96, 80, playerSpriteSheets.runDown:getWidth(), playerSpriteSheets.runDown:getHeight()),
        runUp = anim8.newGrid(96, 80, playerSpriteSheets.runUp:getWidth(), playerSpriteSheets.runUp:getHeight()),
        runLeft = anim8.newGrid(96, 80, playerSpriteSheets.runLeft:getWidth(), playerSpriteSheets.runLeft:getHeight()),
        runRight = anim8.newGrid(96, 80, playerSpriteSheets.runRight:getWidth(), playerSpriteSheets.runRight:getHeight()),
        attackRight = anim8.newGrid(96, 80, playerSpriteSheets.attack1Right:getWidth(), playerSpriteSheets.attack1Right:getHeight()),
        attackUp = anim8.newGrid(96, 80, playerSpriteSheets.attack1Up:getWidth(), playerSpriteSheets.attack1Up:getHeight()),
        attackDown = anim8.newGrid(96, 80, playerSpriteSheets.attack1Down:getWidth(), playerSpriteSheets.attack1Down:getHeight()),
        attackLeft = anim8.newGrid(96, 80, playerSpriteSheets.attack1Left:getWidth(), playerSpriteSheets.attack1Left:getHeight()),
    }


    -- MC coordinate
    self.x = x or 100
    self.y = y or 100

    -- MC speed
    self.speed = 200
    
    -- MC health
    self.maxHealth = 100
    self.currentHealth = 100

    -- MC mana 
    self.maxMana = 100
    self.currentMana = 0

    -- MC basis
    self.isMoving = false
    self.isAttacking = false

    -- MC attacking cooldown
    self.attackCooldown = 0.5

    -- MC Spritesheets
    self.playerSpriteSheets = playerSpriteSheets

    -- MC direction
    self.dir = 'down'
    
    -- MC animations
    self.animation = {
        idleDown = anim8.newAnimation(playerGrids.idleDown('1-8', 1), 0.2),
        idleUp = anim8.newAnimation(playerGrids.idleUp('1-8', 1), 0.2),
        idleLeft = anim8.newAnimation(playerGrids.idleLeft('1-8', 1), 0.2),
        idleRight = anim8.newAnimation(playerGrids.idleRight('1-8', 1), 0.2),
        runDown = anim8.newAnimation(playerGrids.runDown('1-8', 1), 0.2),
        runUp = anim8.newAnimation(playerGrids.runUp('1-8', 1), 0.2),
        runLeft = anim8.newAnimation(playerGrids.runLeft('1-8', 1), 0.2),
        runRight = anim8.newAnimation(playerGrids.runRight('1-8', 1), 0.2),
        attackDown = anim8.newAnimation(playerGrids.attackDown('1-8',1), 0.1),
        attackUp = anim8.newAnimation(playerGrids.attackUp('1-8',1), 0.1),
        attackLeft = anim8.newAnimation(playerGrids.attackLeft('1-8',1), 0.1),
        attackRight = anim8.newAnimation(playerGrids.attackRight('1-8',1), 0.1),
    }

    -- MC current spritesheet
    self.currentPlayerSpriteSheet = self.playerSpriteSheets.idleDown

    -- MC current animation
    self.currentAnimation = self.animation.idleDown

    -- hurtbox
    local height, width, rounded = 40,30,10
    local hurtboxOffsetX, hurtboxOffsetY = 80,65
    self.hurtbox = world:newBSGRectangleCollider(self.x + hurtboxOffsetX, self.y + hurtboxOffsetY, width, height, rounded)
    self.hurtbox:setFixedRotation(true)
    self.hurtbox:setCollisionClass('PlayerHurtBox')
    self.hurtbox:setObject(this)

    setmetatable(self, Player)
    return self
end

function Player:update(dt)
    self.isMoving = false
    
    -- movement and changing animation/spritesheet
    self:movement(dt)
    self:changeAnimationAndSpritesheet()

    if not self.isMoving and not self.isAttacking then
        self.hurtbox:setLinearVelocity(0, 0)
    end

    -- handling sword attack and cooldown
    if self.isAttacking then
        self.attackCooldown = self.attackCooldown - dt
        if self.attackCooldown <= 0 then
            self.isAttacking = false
            self.attackCooldown = 0
        end
    end

    -- updating the animaton
    self.currentAnimation:update(dt)
end

function Player:movement(dt)
    local vx, vy = 0,0
    if love.keyboard.isDown('w') then
        vy =  - self.speed
        self.dir = 'up'
        self.isMoving = true
    elseif love.keyboard.isDown('s') then
        vy = self.speed
        self.dir = 'down'
        self.isMoving = true
    elseif love.keyboard.isDown('a') then
        vx = - self.speed
        self.dir = 'left'
        self.isMoving = true
    elseif love.keyboard.isDown('d') then
        vx =  self.speed
        self.dir = 'right'
        self.isMoving = true
    end
    self.hurtbox:setLinearVelocity(vx, vy)
end

function Player:changeAnimationAndSpritesheet()
    if self.isMoving then
        if self.dir == 'down' then
            self.currentPlayerSpriteSheet = self.playerSpriteSheets.runDown
            self.currentAnimation = self.animation.runDown
        elseif self.dir == 'up' then
            self.currentPlayerSpriteSheet = self.playerSpriteSheets.runUp
            self.currentAnimation = self.animation.runUp
        elseif self.dir == 'left' then
            self.currentPlayerSpriteSheet = self.playerSpriteSheets.runLeft
            self.currentAnimation = self.animation.runLeft
        elseif self.dir == 'right' then
            self.currentPlayerSpriteSheet = self.playerSpriteSheets.runRight
            self.currentAnimation = self.animation.runRight
        end
    elseif not self.isMoving and not self.isAttacking then
        if self.dir == 'down' then
            self.currentPlayerSpriteSheet = self.playerSpriteSheets.idleDown
            self.currentAnimation = self.animation.idleDown
        elseif self.dir == 'up' then
            self.currentPlayerSpriteSheet = self.playerSpriteSheets.idleUp
            self.currentAnimation = self.animation.idleUp
        elseif self.dir == 'left' then
            self.currentPlayerSpriteSheet = self.playerSpriteSheets.idleLeft
            self.currentAnimation = self.animation.idleLeft
        elseif self.dir == 'right' then
            self.currentPlayerSpriteSheet = self.playerSpriteSheets.idleRight
            self.currentAnimation = self.animation.idleRight
        end
    end
end

function Player:swordAttack()
    self.isAttacking = true
    self.attackCooldown = 0.8
    self:attackingAnimation()
end

function Player:attackingAnimation()
    if self.isAttacking then
        if self.dir == 'down' then
            self.currentPlayerSpriteSheet = self.playerSpriteSheets.attack1Down
            self.currentAnimation = self.animation.attackDown
        elseif self.dir == 'up' then
            self.currentPlayerSpriteSheet = self.playerSpriteSheets.attack1Up
            self.currentAnimation = self.animation.attackUp
        elseif self.dir == 'left' then
            self.currentPlayerSpriteSheet = self.playerSpriteSheets.attack1Left
            self.currentAnimation = self.animation.attackLeft
        elseif self.dir == 'right' then
            self.currentPlayerSpriteSheet = self.playerSpriteSheets.attack1Right
            self.currentAnimation = self.animation.attackRight
        end
    end
end

function Player:draw()

    local playerX, playerY = self.hurtbox:getPosition()
    local offsetX, offsetY = 48, 48

    -- health bar
    healthBar(self.maxHealth, self.currentHealth)

    -- MC
    self.currentAnimation:draw(self.currentPlayerSpriteSheet, playerX, playerY, 0 , self.scale , nil, offsetX, offsetY)
end

function healthBar(maxHealth, currentHealth)
    local height = 15
    local scaleHealthBar = 2
    local x, y = 10, 20

    love.graphics.setColor(1,1,1)
    love.graphics.rectangle('line', x, y, maxHealth * scaleHealthBar, height)
    love.graphics.setColor(1,0,0)
    love.graphics.rectangle('fill', x, y, currentHealth * scaleHealthBar, height)
    love.graphics.setColor(1,1,1)
end

return Player