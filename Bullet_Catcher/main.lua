function love.load()
    local RWidth, RHeight = love.window.getDesktopDimensions()
    love.window.setMode(RWidth, RHeight - 60)
    love.window.setTitle("Bullet Catcher")
    ammobox = {
        sprite = love.graphics.newImage('sprites/AmmoBox0.png'),
        rotation = 0,
        scaleF = 0.5,
        speed = 400
    }
    ammobox.sprites = {
        love.graphics.newImage('sprites/AmmoBox0.png'),
        love.graphics.newImage('sprites/AmmoBox1.png'),
        love.graphics.newImage('sprites/AmmoBox2.png'),
        love.graphics.newImage('sprites/AmmoBox3.png'),
        love.graphics.newImage('sprites/AmmoBox4.png')
    }
    ammobox.spriteIndex = 1
    ammobox.sprite = ammobox.sprites[ammobox.spriteIndex]
    bullets = {}
    local SWidth, SHeight = love.graphics.getWidth(), love.graphics.getHeight()
    ammobox.ObjW = ammobox.sprite:getWidth() * ammobox.scaleF
    ammobox.ObjH = ammobox.sprite:getHeight() * ammobox.scaleF
    ammobox.x = (SWidth - ammobox.ObjW) / 2
    ammobox.y = (SHeight - ammobox.ObjH)
    myFont = love.graphics.newFont(50)
    love.graphics.setFont(myFont)
end

function SBullet()
    bullet = {
        sprite = love.graphics.newImage('sprites/Ammo.png'),
        rotation = 22,
        scaleF = 0.5,
        speed = 300
    }
    bullet.ObjW = bullet.sprite:getWidth() * bullet.scaleF
    bullet.ObjH = bullet.sprite:getHeight() * bullet.scaleF
    bullet.x = love.math.random(0 + bullet.ObjW, 2500)
    bullet.y = 0
    table.insert(bullets, bullet)
end

local sleeptimer = 0
local score = 0
function love.update(dt)
    local SWidth, SHeight = love.graphics.getWidth(), love.graphics.getHeight()
    local yoffset = 120
    sleeptimer = sleeptimer + dt
    if sleeptimer >= 1 then
        SBullet()
        sleeptimer = 0
    end
    if love.keyboard.isDown("a") then
        ammobox.x = ammobox.x - ammobox.speed * dt
    elseif love.keyboard.isDown("d") then
        ammobox.x = ammobox.x + ammobox.speed * dt
    end
    for i = #bullets, 1, -1 do
        local b = bullets[i]
        b.y = b.y + b.speed * dt

        if b.x < ammobox.x + ammobox.ObjW and
        ammobox.x < b.x + b.ObjW and
        b.y < (ammobox.y + ammobox.ObjH) - yoffset and
        (ammobox.y + yoffset) < b.y + b.ObjH then
            table.remove(bullets, i)
            score = score + 1

            ammobox.spriteIndex = ammobox.spriteIndex + 1
            if ammobox.spriteIndex > #ammobox.sprites then
                ammobox.spriteIndex = 1
            end
            ammobox.sprite = ammobox.sprites[ammobox.spriteIndex]
        end

        if b.y > SHeight then
            table.remove(bullets, i)
        end
    end
end

function love.draw()
    local SWidth, SHeight = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.setBackgroundColor(1, 1, 1)
    love.graphics.draw(ammobox.sprite, ammobox.x, ammobox.y, ammobox.rotation, ammobox.scaleF, ammobox.scaleF)
    love.graphics.setColor(0,0,0)
    love.graphics.print(score, SWidth/2)
    love.graphics.setColor(1,1,1)
    for _, b in ipairs(bullets) do
        love.graphics.draw(b.sprite, b.x, b.y, b.rotation, b.scaleF, b.scaleF)
    end
end