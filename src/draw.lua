local draw = {}

function draw.menu()
    suit.draw()
end

function draw.netplay()
    -- Draw players
    love.graphics.setColor(cf.WHITE())
    love.graphics.draw(p1.sprite, p1.x, p1.y, 0, scaling)
    love.graphics.draw(p2.sprite, p2.x, p2.y, 0, scaling)

    -- Draw ball
    love.graphics.setColor(cf.hex "c2c3c7")
    love.graphics.draw(canvas, ball.x, ball.y, 0, scaling)

    -- Pause overlay
    if game.pause then
        love.graphics.setColor(0,0,0,0.3)
        love.graphics.rectangle("fill", 0, 0, game.width, game.height)
    end

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

return draw
