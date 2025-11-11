function love.load()
    local RWidth, RHeight = love.window.getDesktopDimensions()
    love.window.setMode(RWidth, RHeight - 60)
    love.window.setTitle("Rock Out")
    guitar = {
        sprite = love.graphics.newImage('sprites/RedElectricGuitar.png'),
        width = 0.5,
        height = 0.5,
        rotation = 0.25,
        reward = 1
    }
    guitar.ObjW = guitar.sprite:getWidth() * guitar.width * guitar.rotation
    guitar.ObjH = guitar.sprite:getHeight() * guitar.height
    local SWidth, SHeight = love.graphics.getWidth(), love.graphics.getHeight()
    local Xoffset = 200
    local Yoffset = 150
    guitar.x = (SWidth - guitar.ObjW - Xoffset) / 2
    guitar.y = (SHeight - guitar.ObjH - Yoffset) / 2
end
local fans = 0
function love.mousepressed(mx, my, button)
    if button == 1 then
        if mx >= guitar.x and mx <= guitar.x + guitar.ObjW and
        my >= guitar.y and my <= guitar.y + guitar.ObjH then
            fans = fans + guitar.reward
        end
    end
end

function love.update(dt)

end

function love.draw()
    love.graphics.draw(guitar.sprite, guitar.x, guitar.y, guitar.rotation, guitar.width, guitar.height)
    love.graphics.print(fans)
end