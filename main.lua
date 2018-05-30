-- Slime Games Online
-- By Oskari

function love.load()
    -- External requires
    cf = require "lib.colorfactory.colorFactory"
    hc = require "lib.hc"
    suit = require "lib.suit"
    require "lib.noobhub.noobhub"

    -- Internal requires
    require "src.init"
    require "src.init_players"
    require "src.init_ball"
    require "src.init_colliders"
    require "src.netplay"
    controls = require "src.controls"
    colliders = require "src.colliders"
    move = require "src.move"
end
 
-- Increase the size of the rectangle every frame.
function love.update(dt)
    -- Handle player controls
    controls.handle(p1)
    controls.handle(p2)

    -- Draw colliders
    colliders.update()
    
    -- Collision checks
    colliders.ballCheck()
    colliders.playerCheck(p1)
    colliders.playerCheck(p2)

    -- Ball movement
    move.ball()
    -- Player movements
    move.player(p1)
    move.player(p2)
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

