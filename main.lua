function love.load()
    timer = 0
    love.window.setTitle("Project")
    balloons = {}
end

function love.update(dt)
    timer = timer + dt
    if timer >= 1 then
        SBallon()
        timer = 0
    end
    for _, B in ipairs(balloons) do
        B.y = B.y - 5
    end
end

function SBallon()
    local RBalloon = {
        sprite = love.graphics.newImage('sprites/PixelArtRedBalloon.png'),
        x = love.math.random(100, 500),
        y = 600,
        rotation = 0,
        width = 0.25,
        height = 0.25,
        speed = 10,
        points = 1
    }
    table.insert(balloons, RBalloon)
end

function love.draw()
    for _, RB in ipairs(balloons) do
        love.graphics.draw(RB.sprite, RB.x, RB.y, RB.rotation, RB.width, RB.height)
    end
end