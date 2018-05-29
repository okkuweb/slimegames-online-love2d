-- Load some default values for our rectangle.
function love.load()

    -- External requires
    cf = require "lib.colorfactory.colorFactory"
    hc = require "lib.hc"
    suit = require "lib.suit"
    socket = require "socket"

    -- Internal requires
    require "src.init"
    require "src.init_players"
    require "src.init_ball"
    require "src.init_colliders"
end
 
-- Increase the size of the rectangle every frame.
function love.update(dt)
    -- Draw colliders
    updateColliders()

    -- Handle player controls
    handleControls(p1)
    handleControls(p2)
    
    -- Collision checks
    ballCollisionCheck()
    playerCollisionCheck(p1)
    playerCollisionCheck(p2)

    -- Ball movement
    ball.ySpeed = ball.ySpeed + ball.gravity
    ball.y = ball.y + ball.ySpeed
    ball.x = ball.x + ball.xSpeed
    -- Player movements
    movePlayer(p1)
    movePlayer(p2)
end

function updateColliders()
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

function ballCollisionCheck()
    -- Check player collision
    local cP1Check = ball.collider:collidesWith(p1.collider)
    if cP1Check then
        if p1.ballCollision ~= true then
            playerBallCollision(p1)
        end
        p1.ballCollision = true
    else
        p1.ballCollision = false
    end

    local cP2Check = ball.collider:collidesWith(p2.collider)
    if cP2Check then
        if p2.ballCollision ~= true then
            playerBallCollision(p2)
        end
        p2.ballCollision = true
    else
        p2.ballCollision = false
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
    print("Here's x speed: " .. -xSpeed)
    print("Here's y speed: " .. -ySpeed)
end

function playerCollisionCheck(p)
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
 
function handleControls(p)
    local right = love.keyboard.isDown(p.right)
    local left = love.keyboard.isDown(p.left)
    local up = love.keyboard.isDown(p.up)

    if right then
        p.xSpeed = 5
    end
    if left then
        p.xSpeed = -5
    end
    if not right and not left then
        p.xSpeed = 0
    end

    if up and p.jumpState == false then
        print("jump!")
        p.ySpeed = p.jumpSpeed
        p.jumpState = true
    end 
end

function movePlayer(p)
    p.x = p.x + p.xSpeed
    p.y = p.y - p.ySpeed
    p.ySpeed = p.ySpeed - p.gravity
end

-- Draw a coloured rectangle.
function love.draw()
    --Draw players
    love.graphics.setColor(cf.WHITE())
    love.graphics.draw(p1.sprite, p1.x, p1.y, 0, scaling)
    love.graphics.draw(p2.sprite, p2.x, p2.y, 0, scaling)

    -- Draw ball
    love.graphics.setColor(cf.hex "c2c3c7")
    love.graphics.draw(canvas, ball.x, ball.y, 0, scaling)

    -- Helpers
    love.graphics.setColor(cf.GREEN())
    love.graphics.circle("fill", p1.x+p1.xMid, p1.y+p1.yMid, ball.size)
    love.graphics.circle("fill", ball.x+ball.xMid, ball.y+ball.yMid, ball.size)
    ball.collider:draw()
    p1.collider:draw()
    p2.collider:draw()
    cFloor.collider:draw()
    cLeftWall:draw()
    cRightWall:draw()
end

