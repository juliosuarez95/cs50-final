push = require "push"
require "player"
require "bullet"
require "enemy"

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 1280
VIRTUAL_HEIGHT = 720

function love.load()
    -- loading libraries
    player.load()
    --
    -- set fonts filter
    love.graphics.setDefaultFilter('nearest', 'nearest')
    --
    -- set fonts for title screen (and pause)
    title = love.graphics.newFont('fonts/Stars Fighters.ttf', 45)
    --
    -- set fonts for start screen
    start = love.graphics.newFont('fonts/robo.ttf', 30)
    --
    -- set fonts for meny screens
    menu = love.graphics.newFont('fonts/robo.ttf', 40)
    --    
    -- set background
    background = love.graphics.newImage('graphics/space.png')
    

    -- set screen settings
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resize = true
    })
    -- set gameState and pause
    gameState = 'start'
    gamePaused = false
end
-- 
-- 
function love.resize(w, h)
    push:resize(w, h)
end
--
-- 
function love.keypressed(key)
    -- quit game 
    if key == 'escape' then
        love.event.quit()
    end
    --
    -- menu state 
    if key == 'enter' or key == 'return' and gameState == 'start' then
        gameState = 'menu'
    end
    -- 
    -- states from the menu
    if key == 's' and gameState == 'menu' then
        gameState = 'play'
    elseif key == 'h' and gameState == 'menu' then
        gameState = 'help'
    elseif key == 'e' or key == 'escape' and gameState == 'menu' then
        love.event.quit()
    end
    -- 
    -- back to main menu from help menu
    if key == 'backspace' and gameState == 'help' then
        gameState = 'menu'
    end
    -- 
    -- pause the game
    if key == 'p' and gameState == 'play' then
        game_paused = true
        gameState = 'pause'
    elseif key == 'p' and gameState == 'pause' then
        game_paused = false
        gameState = 'play'
    end
    -- 
    -- player shoot function
    player.shoot(key)
end
-- 
-- 
function love.update(dt)
    if gameState == 'play' then
        UPDATE_ENEMY(dt)
        UPDATE_PLAYER(dt)
        UPDATE_BULLET(dt)
    end
end
-- 
-- 
function love.draw()
    push:apply('start')
    -- 
    -- draw the background
    for i = 0, love.graphics.getWidth() / background:getWidth() do
        for j = 0, love.graphics.getHeight() / background:getHeight() do
            love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
        end
    end
    -- 
    -- draw the start screen
    if gameState == 'start' then
        love.graphics.setFont(title)
        love.graphics.printf('Titania', 0, 30, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(start)
        love.graphics.printf("Press Enter", 0, 500, VIRTUAL_WIDTH, 'center')
    -- 
    -- draw the menu screen
    elseif gameState == 'menu' then
        love.graphics.setFont(title)
        love.graphics.printf('Titania', 0, 30, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(menu)
        love.graphics.printf("[S]TART    [H]ELP    [E]XIT", 0, 500, VIRTUAL_WIDTH, 'center')
    -- 
    -- draw the help screen
    elseif gameState == 'help' then
        DRAW_PLAYER()
        DRAW_BULLET()
        love.graphics.setFont(title)
        love.graphics.printf('Titania', 0, 30, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(menu)
        love.graphics.printf("Use the ARROW keys or WASD to move and SPACE to shoot", 0, 500, VIRTUAL_WIDTH, 'center')
    --
    -- draw the play screen
    elseif gameState == 'play' then
        DRAW_PLAYER()
        DRAW_BULLET()
        DRAW_ENEMY()
        love.graphics.setFont(title)
        love.graphics.printf('TEST WAVE 1', 0, 30, VIRTUAL_WIDTH, 'center')
    -- 
    -- draw the pause screen
    elseif gameState == 'pause' then
        DRAW_PLAYER()
        DRAW_ENEMY()
        love.graphics.setFont(title)
        love.graphics.printf('PAUSE', 0, 250, VIRTUAL_WIDTH, 'center')
    end

    push:apply('end')
end
