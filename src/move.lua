local move = {}

function move.ball()
    -- Ball movement
    ball.ySpeed = ball.ySpeed + ball.gravity
    ball.y = ball.y + ball.ySpeed
    ball.x = ball.x + ball.xSpeed
end

function move.player(p)
    p.x = p.x + p.xSpeed
    p.y = p.y - p.ySpeed
    p.ySpeed = p.ySpeed - p.gravity
end

return move
