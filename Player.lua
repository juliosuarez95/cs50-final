Player = Object:extend()

function Player:new()
    self.image = love.graphics.newImage('graphics/Titan.png')

    self.x = 500
    self.y = 500
    self.speed = 500
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function Player:update(dt)
    if love.keyboard.isDown('left') then
        self.x = self.x - self.speed * dt
    elseif love.keyboard.isDown('right') then
        self.x = self.x + self.speed * dt
    end

    if love.keyboard.isDown('up') then
        self.y = self.y - self.speed * dt
    elseif love.keyboard.isDown('down') then
        self.y = self.y + self.speed * dt
    end

    local window_width = love.graphics.getWidth()
    local window_height = love.graphics.getHeight()

    if self.x < 0 then
        self.x = 0
    elseif self.x + self.width > window_width then
        self.x = window_width - self.width
    end

    if self.y < 0 then
        self.y = 0
    elseif self.y + self.height > window_height then
        self.y = window_height - self.height
    end
end

function Player:keypressed(key)
    if key == 'space' then
        table.insert(listofBullets, Bullet(self.x, self.y))
    end
end

function Player:draw()
    love.graphics.draw(self.image, self.x, self.y)
end