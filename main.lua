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
    -- Fix and set SUIT colors
    suit.theme.color = {
        normal   = {bg = { 0.258823529, 0.258823529, 0.258823529}, fg = {0.737254902,0.737254902,0.737254902}},
        hovered  = {bg = { 0.196078431,0.6,0.733333333}, fg = {1,1,1}},
        active   = {bg = {1,0.6,  0}, fg = {1,1,1}}
    }

    -- Player 1 options
    p1 = {}
    p1.sprite = love.graphics.newImage("img/slime01.png")
    p1.x = 200
    p1.y = 384

    -- Player 2 options


    -- Ball options
    ball = {}
    ball.size = 2
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

