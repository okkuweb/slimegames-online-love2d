local ui = {}

function ui.main()
    -- Setup the main menu
    suit.layout:reset(game.width/2-70, 50, 20)

    game.startButton = suit.Button(
        "Start Game",
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

    if game.startButton.hit then
        game.mode = "lobby"
        game.nextState = "netplay"
        hub = netplay.init()
        hub:publish({
            message = {
                action = "ping",
                hash = game.hash,
            }
        })
    end
end

return ui
