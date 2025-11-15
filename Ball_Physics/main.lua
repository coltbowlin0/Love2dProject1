function love.load()
    local SWidth, SHeight = love.graphics.getWidth(), love.graphics.getHeight()

    ball = {
        radius = 100,
        speed = 400,
        gravity = 280,
        bounciness = 0.8
    }
    ball.x = (SWidth - ball.radius) / 2
    ball.y = (SHeight - ball.radius) / 2
end

function love.update(dt)
    local SWidth, SHeight = love.graphics.getWidth(), love.graphics.getHeight()
    ball.speed = ball.speed + ball.gravity * dt
    ball.y = ball.y + ball.speed * dt
    if ball.y < 0 then
        ball.y = 0
    elseif ball.y + ball.radius > SHeight then
        ball.y = SHeight - ball.radius
        ball.speed = -ball.speed * ball.bounciness
    end
end

function love.draw()
    love.graphics.circle("fill", ball.x, ball.y, ball.radius)
end