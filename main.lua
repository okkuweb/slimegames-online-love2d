-- Load some default values for our rectangle.
function love.load()
    -- Draw the character
    love.graphics.setDefaultFilter("nearest", "nearest")
    -- Player 1 options
    p1 = {}
    p1.sprite = love.graphics.newImage("img/slime01.png")
    p1.x = 200
    p1.y = 536
    p1.scaling = 4
    -- Player 2 options
end
 
-- Increase the size of the rectangle every frame.
function love.update(dt)
end
 
-- Draw a coloured rectangle.
function love.draw()
    --love.graphics.setColor(100, 100, 100)
    --love.graphics.arc("fill", 200, 200, 20, 0, -math.pi)
    love.graphics.draw(p1.sprite, p1.x, p1.y, 0, p1.scaling)
end

