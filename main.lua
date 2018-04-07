-- Load some default values for our rectangle.
function love.load()
    -- Requires
    cf = require "lib.colorFactory"
    -- Draw the character
    love.graphics.setDefaultFilter("nearest", "nearest")
    -- Options
    scaling = 4
    -- Player 1 options
    p1 = {}
    p1.sprite = love.graphics.newImage("img/slime01.png")
    p1.x = 200
    p1.y = 536
    -- Player 2 options
    -- Draw ball
    ball = {}
    ball.size = 4
    canvas = love.graphics.newCanvas(300, 300)
    love.graphics.setCanvas(canvas)
    love.graphics.circle("fill", ball.size, ball.size, ball.size)
    love.graphics.setCanvas()
end
 
-- Increase the size of the rectangle every frame.
function love.update(dt)
    local right = love.keyboard.isDown("d")
    local left = love.keyboard.isDown("a")
    if right then
        p1.x = p1.x + 5
    end
    if left then
        p1.x = p1.x - 5
    end
end
 
-- Draw a coloured rectangle.
function love.draw()
    --Draw player
    love.graphics.setColor(cf.WHITE())
    love.graphics.draw(p1.sprite, p1.x, p1.y, 0, scaling)
    -- Draw ball
    love.graphics.setColor(cf.hex "c2c3c7")
    love.graphics.draw(canvas, 0, 0, 0, scaling)
end

