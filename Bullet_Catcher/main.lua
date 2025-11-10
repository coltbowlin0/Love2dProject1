function love.load()
    local RWidth, RHeight = love.window.getDesktopDimensions()
    love.window.setMode(RWidth, RHeight - 60)
    love.window.setTitle("Catch the Bullets")
    bullet = {
        sprite = love.graphics.newImage('sprites/Ammo.png'),
        width = 1,
        height = 1,
        rotation  = 180
    }
    ammobox = {
        sprite = love.graphics.newImage('sprites/AmmoBox0.png'),
        width = 1,
        height = 1,
        rotation = 0
    }
end

function love.update(dt)
    
end

function love.draw()

end