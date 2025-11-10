function love.load()
    local RWidth, RHeight = love.window.getDesktopDimensions()
    love.window.setMode(RWidth, RHeight - 60)
    love.window.setTitle("Catch the Bullets")
    bullets = {}
    ammobox = {
        sprite = love.graphics.newImage('sprites/AmmoBox0.png'),
        width = 0.5,
        height = 0.5,
        rotation = 0,
        speed = 400
    }
    local SWidth, SHeight = love.graphics.getWidth(), love.graphics.getHeight()
    ammobox.ObjW = ammobox.sprite:getWidth()
    ammobox.ObjH = ammobox.sprite:getHeight()
    ammobox.x = (SWidth - ammobox.ObjW) / 2
    ammobox.y = (SHeight - ammobox.ObjH)
end

function SBullet()
    bullet = {
            sprite = love.graphics.newImage('sprites/Ammo.png'),
            width = 0.5,
            height = 0.5,
            rotation  = 6.135,
            speed = 400
        }
    table.insert(bullets, bullet)
end
sleeptimer = 0
function love.update(dt)
    sleeptimer = sleeptimer + dt
    if sleeptimer >= 1 then
        SBullet()
        sleeptimer = 0
    end
    for _, b in ipairs(bullets) do
        b.y = b.y + speed *dt
        if b.y >= SHeight then
            table.remove()
        end
    end
    if love.keyboard.isDown("a") then
        ammobox.x = ammobox.x - ammobox.speed * dt
    elseif love.keyboard.isDown("d") then
        ammobox.x = ammobox.x + ammobox.speed * dt
    end
    if ammobox.x < 0 then
        ammobox.x = 0
    elseif ammobox.x + ammobox.ObjW > SWidth then
        ammobox.x = Swidth - ammobox.ObjW
    end
end

function love.draw()
    love.graphics.draw(ammobox.sprite, ammobox.x, ammobox.y, ammobox.rotation, ammobox.width, ammobox.height)
    for _, b in ipairs(bullets) do
        love.graphics.draw(b.sprite, b.x, b.y, b.rotation, b.width, b.height)
    end
end
