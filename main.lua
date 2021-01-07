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
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    player:update(dt)
    enemy:update(dt)

    for i,v in ipairs(listofBullets) do
        v:update(dt)

        v:checkCollision(enemy)

        if v.dead then
            table.remove(listofBullets, i)
        end
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'enter' or key == 'return' then
        gameState = 'play'
    end

    player:keypressed(key)
end

function love.draw()
    push:apply('start')

    for i = 0, love.graphics.getWidth() / background:getWidth() do
        for j = 0, love.graphics.getHeight() / background:getHeight() do
            love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
        end
    end

    player:draw()
    enemy:draw()

    for i,v in ipairs(listofBullets) do
        v:draw()
    end

    push:apply('end')
end