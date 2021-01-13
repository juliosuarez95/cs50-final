bullet = {}
bullet.image = love.graphics.newImage('graphics/laser.png')
bullet.width = bullet.image:getWidth()
bullet.height = bullet.image:getHeight()
bullet.speed = 500
--
--
function bullet.spawn(x, y, dir)
    table.insert(bullet, {x = x, y = y, dir = dir, width = enemy.width, height = enemy.height})
end
--
--
function bullet.draw()
    for i,v in ipairs(bullet) do
        love.graphics.draw(bullet.image, v.x, v.y)
    end
end
--
--
function bullet.move(dt)
    for i,v in ipairs(bullet) do
        if v.dir == 'up' then
            v.y = v.y - bullet.speed * dt
        end
    end
end
--
-- PARENT FUNCTIONS
function DRAW_BULLET()
    bullet.draw()
end
--
--
function UPDATE_BULLET(dt)
    bullet.move(dt)
end
