local RW, RH = love.window.getDesktopDimensions()
function love.load()
    love.window.setMode(RW, RH - 60)
    love.window.setTitle("DvD bouncer")
    local Sw, Sh = love.graphics.getWidth(), love.graphics.getHeight()
    bouncer = {
        sprite = love.graphics.newImage('sprites/dvdlogo.png'),
        scalefactor = 1,
        rotation = 0,
        xspeed = 200,
        yspeed = 200
    }
    bouncer.ObjW = bouncer.sprite:getWidth()
    bouncer.ObjH = bouncer.sprite:getHeight()
    bouncer.x = (Sw / 2 ) - (bouncer.ObjW / 2) * bouncer.scalefactor
    bouncer.y = (Sh / 2) - (bouncer.ObjH / 2) * bouncer.scalefactor
end

function love.update(dt)
    local Sw, Sh = love.graphics.getWidth(), love.graphics.getHeight()
    bouncer.x = bouncer.x + bouncer.xspeed * dt
    bouncer.y = bouncer.y + bouncer.yspeed * dt

    if bouncer.x < 0 then
        bouncer.x = 0
        bouncer.xspeed = -bouncer.xspeed
    elseif bouncer.x + bouncer.ObjW > Sw then
        bouncer.x = Sw - bouncer.ObjW
        bouncer.xspeed = -bouncer.xspeed
    end

    if bouncer.y < 0 then
        bouncer.y = 0
        bouncer.yspeed = -bouncer.yspeed
    elseif bouncer.y + bouncer.ObjH > Sh then
        bouncer.y = Sh - bouncer.ObjH
        bouncer.yspeed = -bouncer.yspeed
    end

end

function love.draw()
    love.graphics.draw(bouncer.sprite, bouncer.x, bouncer.y, bouncer.rotation, bouncer.scalefactor, bouncer.scalefactor)
end