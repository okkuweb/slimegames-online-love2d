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
    p1.right = "d"
    p1.left = "a"

    -- Player 2 options


    -- Ball options
    ball = {}
    ball.size = 2
    ball.x = 90
    ball.y = 90
    ball.speed = 0
    canvas = love.graphics.newCanvas(300, 300)
    love.graphics.setCanvas(canvas)
    love.graphics.circle("fill", ball.size, ball.size, ball.size)
    love.graphics.setCanvas()

    -- Setup colliders
    collisionText = {}
    collider = hc.new()
end
 
-- Increase the size of the rectangle every frame.
function love.update(dt)
    -- Handle player controls
    handleControls(p1)
    --handleControls(p2)

    -- Handle ball movement
    ball.speed = ball.speed + 0.05
    ball.y = ball.y + ball.speed
    print(ball.speed)

    -- Draw colliders
    drawColliders()
    -- Handle ball collider position
    ballCollision()
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

function drawColliders()
    ballCollider = collider:circle(ball.x+12,ball.y+12,13,100)
    floorCollider = collider:rectangle(
        0,screen.height,screen.width,50
    )
end

function ballCollision()
    local floorCollision
    for shape, delta in pairs(collider:collisions(ballCollider)) do
        local floor, dx, dy = shape:collidesWith(floorCollider)
        if floor then
            floorCollision = 1
        end
    end
    if floorCollision then
        print("Collided with floor")
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

    -- Draw colliders
    love.graphics.setColor(cf.RED())
    ballCollider:draw()
    floorCollider:draw()
end

