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
    controls = require "src.controls"
    colliders = require "src.colliders"
    move = require "src.move"
end
 
-- Increase the size of the rectangle every frame.
function love.update(dt)
    if game.state ~= game.nextState then
        game.state = game.nextState
    end
    if game.state == "menu" then
        suit.layout:reset(game.width/2-70, 50, 20)
        p1.button = suit.Button("Player 1", {align="center", valign="center"}, suit.layout:row(140,40))
        p2.button = suit.Button("Player 2", {align="center", valign="center"}, suit.layout:row(140,40))
        if p1.button.hit then
            game.nextState = "online"
            game.mode = "p1"
            hub = require "src.netplay"
        end
        if p2.button.hit then
            game.nextState = "online"
            game.mode = "p2"
            hub = require "src.netplay"
        end
    elseif game.state == "online" then
        -- Update online state
        hub:enterFrame()

        -- Handle player controls
        if game.mode == "p1" then
            controls.handle(p1)
            controls.onlineHandle(p2)
        elseif game.mode == "p2" then
            controls.handle(p2)
            controls.onlineHandle(p1)
        elseif game.mode == "local" then
            controls.handle(p1)
            controls.handle(p2)
        end

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
end

-- Draw a coloured rectangle.
function love.draw()
    if game.state == "menu" then
        suit.draw()
    elseif game.state == "online" then
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
        if game.mode == "p1" then
            p1.collider:draw()
        elseif game.mode == "p2" then
            p2.collider:draw()
        end
        cFloor.collider:draw()
        cLeftWall:draw()
        cRightWall:draw()
    end
end

