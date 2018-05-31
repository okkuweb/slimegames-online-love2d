local colliders = {}

function colliders.ballCheck()
    -- Check player collision
    if game.mode == "p1" then
        local cP1Check = ball.collider:collidesWith(p1.collider)
        if cP1Check then
            if p1.ballCollision ~= true then
                playerBallCollision(p1)
            end
            p1.ballCollision = true
        else
            p1.ballCollision = false
        end
    elseif game.mode == "p2" then
        local cP2Check = ball.collider:collidesWith(p2.collider)
        if cP2Check then
            if p2.ballCollision ~= true then
                playerBallCollision(p2)
            end
            p2.ballCollision = true
        else
            p2.ballCollision = false
        end
    end
 
    -- Check floor collision
    local cFloorCheck = ball.collider:collidesWith(cFloor.collider)
    if cFloorCheck then
        ball.ySpeed = -ball.ySpeed
        -- A dirty hack to stop the ball from getting stuck to the ground
        if ball.ySpeed > 0 then
            ball.ySpeed = -2
        end
    end

    -- Check wall collision
    local cLeftWallCheck = ball.collider:collidesWith(cLeftWall)
    local cRightWallCheck = ball.collider:collidesWith(cRightWall)
    if cLeftWallCheck or cRightWallCheck  then
        ball.xSpeed = -ball.xSpeed
    end
end

function playerBallCollision(p)
    ball.angle = math.atan2(
        (p.x+p.xMid)-(ball.x+ball.xMid),
        (p.y+p.yMid)-(ball.y+ball.yMid)
    )
    local ySpeed = math.cos(ball.angle)*ball.hitSpeed
    local xSpeed = math.sin(ball.angle)*ball.hitSpeed

    ball.xSpeed = -xSpeed
    ball.ySpeed = -ySpeed

    if game.mode == p.id then
        print("sent")
        hub:publish({
            message = {
                player = p.id,
                action = "hit",
                ballXSpeed = ball.xSpeed,
                ballYSpeed = ball.ySpeed,
                ballX = ball.x,
                ballY = ball.y,
                playerX = p.x,
                playerY = p.y,
                playerYSpeed = p.ySpeed
            }
        })
    end
end

function colliders.playerCheck(p)
    -- Check floor collision
    local cFloorCheck = p.collider:collidesWith(cFloor.collider)
    if cFloorCheck and p.ySpeed < 0 then
        p.ySpeed = 0
        p.y = cFloor.y - p.sprite:getHeight() * scaling + 2
        p.jumpState = false
    end

    -- Check wall collision
    local cLeftWallCheck = p.collider:collidesWith(cLeftWall)
    local cRightWallCheck = p.collider:collidesWith(cRightWall)
    if cLeftWallCheck and p.xSpeed < 0 then
        p.xSpeed = 0
    end
    if cRightWallCheck and p.xSpeed > 0 then
        p.xSpeed = 0
    end
end

function colliders.update()
    ball.collider = hc.circle(
        ball.x+ball.size*scaling,
        ball.y+ball.size*scaling,
        ball.size*scaling
    )
    p1.collider = hc.polygon(
        p1.x,p1.y+10*scaling,
        p1.x,p1.y+5*scaling,
        p1.x+5*scaling,p1.y, 
        p1.x+11*scaling,p1.y,
        p1.x+16*scaling,p1.y+6*scaling,
        p1.x+16*scaling,p1.y+10*scaling
    )
    p2.collider = hc.polygon(
        p2.x,p2.y+10*scaling,
        p2.x,p2.y+5*scaling,
        p2.x+5*scaling,p2.y, 
        p2.x+11*scaling,p2.y,
        p2.x+16*scaling,p2.y+6*scaling,
        p2.x+16*scaling,p2.y+10*scaling
    )
end

return colliders
