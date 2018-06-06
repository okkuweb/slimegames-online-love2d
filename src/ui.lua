local ui = {}

function ui.main()
    -- Setup the main menu
    suit.layout:reset(game.width/2-70, 50, 20)
    p1.button = suit.Button(
        "Player 1",
        {align="center", valign="center"},
        suit.layout:row(140,40)
    )
    p2.button = suit.Button(
        "Player 2",
        {align="center", valign="center"},
        suit.layout:row(140,40)
    )
    game.ipField = suit.Input(
        game.ip,
        {align="center", valign="center"},
        suit.layout:row(140,40)
    )
    game.portField = suit.Input(
        game.port,
        {align="center", valign="center"},
        suit.layout:row(140,40)
    )

    if p1.button.hit then
        game.nextState = "netplay"
        game.mode = "p1"
        hub = netplay.init()
    end
    if p2.button.hit then
        game.nextState = "netplay"
        game.mode = "p2"
        hub = netplay.init()
    end
end

return ui
