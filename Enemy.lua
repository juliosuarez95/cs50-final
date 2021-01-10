Enemy = Object:extend()



function Enemy:new()
    self.image = love.graphics.newImage('graphics/blueship.png')

    -- table function??? 
    enemy = {}

    --[[
        this will likely be changed from "timer" to "wave" when I find the 
        proper way to implement the idea
    ]]

    self.timer = 0
    self.timerLim = 2 --math.random(1, 3)
    self.amount = 4 --math.random(2, 5)
    self.side = math.random(1, 4)


    self.x = 300
    self.y = 20
    self.speed = 300
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.xvel = 0
    self.yvel = 0
    self.friction = 10
    self.health = 1

end

function Enemy:update(dt)
    --self.x = self.x + self.speed * dt -- you commented this out to test stuff
    local window_width = love.graphics.getWidth()
    local window_height = love.graphics.getHeight()

    --[[
        this should assist with generating multiple enemies on the screen.
        hopefully we'll be able to make them "fly in" from the top of the screen...

        for now, they spawn from all over the place
    ]]
    self.timer = self.timer + dt
    if self.timer > self.timerLim then
        --spawn the enemy
        for i = 1,self.amount do
            if self.side == 1 then -- LEFT
                enemy:spawn(-self.height, window_height / 2 - (self.height / 2))
            end
            if self.side == 2 then -- TOP
                enemy:spawn(window_width / 2 - (self.width / 2), -self.height)
            end
            if self.side == 3 then -- RIGHT
                enemy:spawn(window_width, window_height / 2 - (self.height / 2))
            end
            if self.side == 4 then -- BOTTOM
                enemy:spawn(window_width / 2 - (self.width / 2), window_height)
            end
            self.side = math.random(1, 4)
        end
        self.timerLim = 2 --math.random(1, 3)
        self.timer = 0
        self.amount = 4 --math.random(2, 5)
    end
    --[[
        this whole setup here establishes the enemy tracking the player
        currently the enemy follows the player pretty aggressively
        we'll fix that later... 
    ]]
    for i,v in ipairs(enemy) do
        self.x = self.x + self.xvel * dt
        self.y = self.y + self.yvel * dt
        self.xvel = self.xvel * (1 - math.min(dt * self.friction, 1))
        self.yvel = self.yvel * (1 - math.min(dt * self.friction, 1))
    end

    for i,v in ipairs(enemy) do
        -- TRACK X AXIS
        if player.x + player.width / 2 < self.x + self.width / 2 then
            if self.xvel > -self.speed then
                self.xvel = self.xvel - self.speed * dt
            end
        elseif player.x + player.width / 2 > self.x + self.width / 2 then
            if self.xvel < self.speed then
                self.xvel = self.xvel + self.speed * dt
            end
        end
        -- TRACK THE Y AXIS
        if player.y + player.height / 2 < self.y + self.height / 2 then
            if self.yvel > -self.speed then
                self.yvel = self.yvel - self.speed * dt
            end
        elseif player.y + player.height / 2 > self.y + self.height / 2 then
            if self.yvel < self.speed then
                self.yvel = self.yvel + self.speed * dt
            end
        end
    end
end

function Enemy:spawn(x, y)
    table.insert(enemy, {x = x, y = y, self.xvel, self.yvel, self.health})
end

function Enemy:draw()
    for i,v in ipairs(enemy) do
        love.graphics.draw(self.image, self.x, self.y)
    end
end
