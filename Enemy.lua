enemy = {}
enemy.timer = 0
enemy.timerLim = math.random(1,3)
enemy.amount = math.random(1,3)
enemy.side = math.random(1,4)

function enemy.generate(dt)
    enemy.timer = enemy.timer + dt
    if enemy.timer > enemy.timerLim then
        enemy.spawn(math.random(0, WINDOW_WIDTH), -50)
        enemy.amount = math.random(1,3)
        enemy.timerLim = math.random(3,5)
        enemy.timer = 0
    end
end


-- enemy specifications
enemy.image = love.graphics.newImage('graphics/blueship.png')
enemy.width = enemy.image:getWidth()
enemy.height = enemy.image:getHeight()
enemy.speed = 1000
enemy.friction = 10
-- 
-- 


function enemy.spawn(x,y)
    table.insert(enemy, {x = x, y = y, xvel = 0, yvel = 0, width = enemy.width, height = enemy.height})
end
-- 
-- 
function enemy.draw()
    for i,v in ipairs(enemy) do
        love.graphics.draw(enemy.image, v.x, v.y)
    end
end
-- 
-- 
function enemy.physics(dt)
    for i,v in ipairs(enemy) do
        v.x = v.x + v.xvel * dt
        v.y = v.y + v.yvel * dt
        v.xvel = v.xvel * (1 - math.min(dt * enemy.friction, 1))
        v.yvel = v.yvel * (1 - math.min(dt * enemy.friction, 1))
    end
end
-- 
-- 
function enemy.AI(dt)
    for i,v in ipairs(enemy) do
        --X AXIS
        if player.x + player.width / 2 < v.x + v.width / 2 then
            if v.xvel > -enemy.speed then
                v.xvel = v.xvel - enemy.speed * dt
            end
        end
        if player.x + player.width / 2 > v.x + v.width / 2 then
            if v.xvel < enemy.speed then
                v.xvel = v.xvel + enemy.speed * dt
            end
        end
        --Y AXIS
        if player.y + player.height /2 < v.y + v.height / 2 then
            if v.yvel > -enemy.speed then
                v.yvel = v.yvel - enemy.speed * dt
            end
        end
        if player.y + player.height /2 > v.y + v.height / 2 then
            if v.yvel < enemy.speed then
                v.yvel = v.yvel + enemy.speed * dt
            end
        end
    end
end
-- 
-- 
function enemy.bullet_collide()
    for i,v in ipairs(enemy) do
        for ia,va in ipairs(bullet) do
            if va.x + va.width > v.x and
            va.x < v.x + v.width and
            va.y + va.height > v.y and
            va.y < v.y + v.height then
                table.remove(enemy, i)
                table.remove(bullet, ia)
            end
        end
    end
end
-- 
-- PARENT FUNCTIONS
function DRAW_ENEMY()
    enemy.draw()
end
--
-- 
function UPDATE_ENEMY(dt)
    enemy.physics(dt)
    enemy.AI(dt)
    enemy.generate(dt)
    enemy.bullet_collide()
end
