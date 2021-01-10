push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 1280
VIRTUAL_HEIGHT = 720

function love.load()
    Object = require "Classic"
    require 'player'
    require 'enemy'
    require 'bullet'

    player = Player()
    enemy = Enemy()
    listofBullets = {}


    love.graphics.setDefaultFilter('nearest', 'nearest')

    title = love.graphics.newFont('fonts/Stars Fighters.ttf', 45)
    start = love.graphics.newFont('fonts/robo.ttf', 30)
    menu = love.graphics.newFont('fonts/robo.ttf', 40)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resize = true
    })

    love.window.setTitle('Titania')

    background = love.graphics.newImage('graphics/space.png')

    gameState = 'start'

    game_paused = false
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    if game_paused == false then
        player:update(dt)

        for i,v in ipairs(listofBullets) do
            v:update(dt)

            v:checkCollision(enemy)

            if v.dead then
                table.remove(listofBullets, i)
            end
        end
    end

    if gameState == 'play' then
        enemy:update(dt)
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'enter' or key == 'return' and gameState == 'start' then
        gameState = 'menu'
    end

    if key == 's' and gameState == 'menu' then
        gameState = 'play'
    elseif key == 'h' and gameState == 'menu' then
        gameState = 'help'
    elseif key == 'e' or key == 'escape' and gameState == 'menu' then
        love.event.quit()
    end

    if key == 'backspace' and gameState == 'help' then
        gameState = 'menu'
    end

    if key == 'p' and gameState == 'play' then
        game_paused = true
        gameState = 'pause'
    elseif key == 'p' and gameState == 'pause' then
        game_paused = false
        gameState = 'play'
    end

    player:keypressed(key)
end

function love.draw()
    push:apply('start')

    -- supposed to keep the background scroling??????
    for i = 0, love.graphics.getWidth() / background:getWidth() do
        for j = 0, love.graphics.getHeight() / background:getHeight() do
            love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
        end
    end

    if gameState == 'start' then
        love.graphics.setFont(title)
        love.graphics.printf('Titania', 0, 30, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(start)
        love.graphics.printf("Press Enter", 0, 500, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'menu' then
        love.graphics.setFont(title)
        love.graphics.printf('Titania', 0, 30, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(menu)
        love.graphics.printf("[S]TART    [H]ELP    [E]XIT", 0, 500, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'help' then
        -- draw the player
        player:draw()
        love.graphics.setFont(title)
        love.graphics.printf('Titania', 0, 30, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(menu)
        love.graphics.printf("Use the ARROW keys or WASD to move and SPACE to shoot", 0, 500, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'play' then
        -- draw the player
        player:draw()
        -- draw the enemy
        enemy:draw()
        -- text
        love.graphics.setFont(title)
        love.graphics.printf('TEST WAVE 1', 0, 30, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'pause' then
        player:draw()
        enemy:draw()
        love.graphics.setFont(title)
        love.graphics.printf('PAUSE', 0, 250, VIRTUAL_WIDTH, 'center')
    end

    for i,v in ipairs(listofBullets) do
        v:draw()
    end

    push:apply('end')
end

function gameUpdate()

end
