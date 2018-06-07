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
    ui = require "src.ui"
    netplay = require "src.netplay"
    draw = require "src.draw"
end
 
-- Increase the size of the rectangle every frame.
function love.update(dt)
    -- Change game state if it has changed
    if game.state ~= game.nextState then
        game.state = game.nextState
    end

    if game.state == "menu" then
        ui.main()
        if hub then
            hub:enterFrame()
        end
    elseif game.state == "netplay" then
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

        if not game.pause then
            -- Ball movement
            move.ball()
            -- Player movements
            move.player(p1)
            move.player(p2)
        end
    end
end

-- Draw a coloured rectangle.
function love.draw()
    if game.state == "menu" then
        -- Draw the main menu
        draw.menu()
    elseif game.state == "netplay" then
        -- Draw the sprites
        draw.netplay()
    end
end

