-- Load some default values for our rectangle.
function love.load()

    -- Requires
    cf = require "lib.colorfactory.colorFactory"
    suit = require "lib.suit"
    hc = require "lib.hc"

    -- Options
    -- Set pixel graphics filtering
    love.graphics.setDefaultFilter("nearest", "nearest")
    scaling = 6

    -- GLOBALS
    -- Scene options
    screen = {}
    screen.width = love.graphics.getWidth()
    screen.height = love.graphics.getHeight()

    -- Player 1 options
    p1 = {}
    p1.sprite = love.graphics.newImage("img/slime01.png")
    p1.x = 200
    p1.y = 384
    p1.xMid = p1.sprite:getWidth() / 2 * scaling
    p1.yMid = p1.sprite:getHeight() / 2 * scaling + 20
    p1.right = "d"
    p1.left = "a"

    -- Player 2 options


    -- Ball options
    ball = {}
    ball.size = 2
    ball.x = 90
    ball.y = 90
    ball.xMid = ball.size * scaling
    ball.yMid = ball.size * scaling
    ball.xSpeed = 0
    ball.ySpeed = 0
    ball.hitSpeed = 8
    ball.gravity = 0.1
    canvas = love.graphics.newCanvas(300, 300)
    love.graphics.setCanvas(canvas)
    love.graphics.circle("fill", ball.size, ball.size, ball.size)
    love.graphics.setCanvas()

    -- Create static colliders
    cFloor = hc.rectangle(
        0,screen.height,screen.width,50
    )
    cLeftWall = hc.rectangle(
        0,0,50,screen.height
    )
    cRightWall = hc.rectangle(
        screen.width,0,-50,screen.height
    )
end
 
-- Increase the size of the rectangle every frame.
function love.update(dt)
    -- Draw colliders
    updateColliders()
    collisionCheck()

    -- Handle player controls
    handleControls(p1)
    --handleControls(p2)

    -- Ball movement
    ball.ySpeed = ball.ySpeed + ball.gravity
    ball.y = ball.y + ball.ySpeed
    ball.x = ball.x + ball.xSpeed
end

function updateColliders()
    ball.collider = hc.circle(ball.x+12,ball.y+12,13,100)
    p1.collider = hc.polygon(
        p1.x,p1.y+58,
        p1.x,p1.y+30,
        p1.x+30,p1.y, 
        p1.x+65,p1.y,
        p1.x+95,p1.y+30,
        p1.x+95,p1.y+58
    )
end

function collisionCheck()
    -- Check player collision
    local cP1Check = ball.collider:collidesWith(p1.collider)
    if cP1Check then
        playerCollision(p1)
    end

    -- Check floor collision
    local cFloorCheck = ball.collider:collidesWith(cFloor)
    if cFloorCheck then
        ball.ySpeed = -ball.hitSpeed
    end

    -- Check wall collision
    local cLeftWallCheck = ball.collider:collidesWith(cLeftWall)
    local cRightWallCheck = ball.collider:collidesWith(cRightWall)
    if cLeftWallCheck or cRightWallCheck  then
        ball.xSpeed = -ball.xSpeed
    end
end

function playerCollision(p)
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
 
function handleControls(p)
    local right = love.keyboard.isDown(p.right)
    local left = love.keyboard.isDown(p.left)
    if right then
        p.x = p.x + 5
    end
    if left then
        p.x = p.x - 5
    end
end

-- Draw a coloured rectangle.
function love.draw()
    --Draw player
    love.graphics.setColor(cf.WHITE())
    love.graphics.draw(p1.sprite, p1.x, p1.y, 0, scaling)

    -- Draw ball
    love.graphics.setColor(cf.hex "c2c3c7")
    love.graphics.draw(canvas, ball.x, ball.y, 0, scaling)

    -- Helpers
    love.graphics.setColor(cf.GREEN())
    love.graphics.circle("fill", p1.x+p1.xMid, p1.y+p1.yMid, ball.size)
    love.graphics.circle("fill", ball.x+ball.xMid, ball.y+ball.yMid, ball.size)
    ball.collider:draw()
    p1.collider:draw()
    cFloor:draw()
    cLeftWall:draw()
    cRightWall:draw()
end

