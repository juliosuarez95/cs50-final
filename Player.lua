player = {}
--
--
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
--
--
function player.load()
    -- load the image of the player ship
    player.image = love.graphics.newImage('graphics/Titan.png')

    -- get the dimensions and positions of player
    player.width = player.image:getWidth()
    player.height = player.image:getHeight()
    player.x = 600
    player.y = 600
    player.xvel = 0
    player.yvel = 0
    player.friction = 9.5
    player.speed = 2250
end
--
--
function player.draw()
    love.graphics.draw(player.image, player.x, player.y)
end
--
--
function player.physics(dt)
    player.x = player.x + player.xvel * dt
    player.y = player.y + player.yvel * dt
    player.xvel = player.xvel * (1 - math.min(dt * player.friction, 1))
    player.yvel = player.yvel * (1 - math.min(dt * player.friction, 1))
end
--
--
function player.boundary()
    if player.x < 0 then
        player.x = 0
        player.xvel = 0
    end
    if player.y < 0 then
        player.y = 0
        player.yvel = 0
    end
    if player.x + player.width > WINDOW_WIDTH then
        player.x = WINDOW_WIDTH - player.width
        player.xvel = 0
    end
    if player.y + player.height > WINDOW_HEIGHT then
        player.y = WINDOW_HEIGHT - player.height
        player.yvel = 0
    end
end
--
--
function player.move(dt)
    --X AXIS
    if love.keyboard.isDown('d', 'right') and player.xvel < player.speed then
        player.xvel = player.xvel + player.speed * dt
    end
    if love.keyboard.isDown('a', 'left') and player.xvel > -player.speed then
        player.xvel = player.xvel - player.speed * dt
    end
    -- Y AXIS
    if love.keyboard.isDown('w', 'up') and player.yvel > -player.speed then
        player.yvel = player.yvel - player.speed * dt
    end
    if love.keyboard.isDown('s', 'down') and player.yvel < player.speed then
        player.yvel = player.yvel + player.speed * dt
    end
end
--
--
function player.shoot(key)
    if key == 'space' then
        bullet.spawn(player.x + player.width / 2 - bullet.width / 2, player.y - bullet.height, 'up')        
    end
end

-- PARENT FUNCTIONS
function DRAW_PLAYER()
    player.draw()
end
--
--
function UPDATE_PLAYER(dt)
    player.physics(dt)
    player.boundary()
    player.move(dt)
end
