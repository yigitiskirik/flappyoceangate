
Ship = Class{}

local GRAVITY = 20

function Ship:init()
    anim8 = require 'anim8'
    self.spriteSheet = love.graphics.newImage('sprites/ship.png')
    self.grid = anim8.newGrid(38, 24, self.spriteSheet:getWidth(), self.spriteSheet:getHeight())
    self.x = VIRTUAL_WIDTH / 2 - 8
    self.y = VIRTUAL_HEIGHT / 2 - 8

    self.width = self.spriteSheet:getWidth()/5
    self.height = self.spriteSheet:getHeight()

    self.dy = 0


    self.animations = {}
    self.animations.idle = anim8.newAnimation(self.grid('1-5', 1), 0.2 )
end

function Ship:collides(pipe)
    if (self.x + 2) + (self.width - 4) >= pipe.x and self.x + 2 <= pipe.x + PIPE_WIDTH then
        if (self.y + 2) + (self.height - 4) >= pipe.y and self.y + 2 <= pipe.y + PIPE_HEIGHT then
            return true
        end
    end

    return false
end

function Ship:update(dt)
    self.dy = self.dy + GRAVITY * dt

    if love.keyboard.wasPressed('space') or love.mouse.wasPressed(1) then
        self.dy = -5
        sounds['jump']:play()
    end

    self.y = self.y + self.dy

    self.animations.idle:update(dt)
end

function Ship:render()
    self.animations.idle:draw(self.spriteSheet, self.x, self.y)
end