local ui = {}

function ui.main()
    -- Setup the main menu
    suit.layout:reset(game.width/2-70, 50, 20)

    game.offlineButton = suit.Button(
        "Start Offline",
        {align="center", valign="center"},
        suit.layout:row(140,40)
    )
    game.onlineButton = suit.Button(
        "Start Online",
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

    if game.offlineButton.hit then
        game.mode = "local"
        game.nextState = "local"
        game.pause = false
    end

    if game.onlineButton.hit then
        game.mode = "lobby"
        game.nextState = "netplay"
        game.pause = true
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
