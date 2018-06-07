-- Networking controls and shit what am I doing :)

local netplay = {}

function netplay.init()
    hub = noobhub.new({ server = game.ip.text; port = game.port.text; })

    hub:subscribe({
        channel = "netplay",
        callback = function(message)
            -- Player and ball movement updates
            if game.mode == "p1" then
                if(message.player == "p2" and message.action == "hit") then
                    ball.xSpeed = message.ballXSpeed
                    ball.ySpeed = message.ballYSpeed
                    ball.x = message.ballX
                    ball.y = message.ballY
                    p2.x = message.playerX
                    p2.y = message.playerY
                    p1.YSpeed = message.playerYSpeed
                end

                if(message.player == "p2" and message.action == "move") then
                    p2.x = message.playerX
                    p2.y = message.playerY
                    p2.rightDown = message.right
                    p2.leftDown = message.left
                    p2.upDown = message.up
                end
            elseif game.mode == "p2" then
                if(message.player == "p1" and message.action == "hit") then
                    ball.xSpeed = message.ballXSpeed
                    ball.ySpeed = message.ballYSpeed
                    ball.x = message.ballX
                    ball.y = message.ballY
                    p1.x = message.playerX
                    p1.y = message.playerY
                    p1.YSpeed = message.playerYSpeed
                end

                if(message.player == "p1" and message.action == "move") then
                    p1.x = message.playerX
                    p1.y = message.playerY
                    p1.rightDown = message.right
                    p1.leftDown = message.left
                    p1.upDown = message.up
                end
            end

            -- Start game if both players are online
            if message.action == "start" then
                if message.player ~= game.mode then
                    hub:publish({
                        message = {
                            action = "pause",
                        }
                    })
                    game.pause = false
                end
            end

            print(1)
            if game.mode == "lobby" then
                if message.action == "ping"
                    and message.hash ~= game.hash
                    then
                    print("im in")

                    if message.player == "p1" then
                        game.mode = "p2"
                    else
                        game.mode = "p1"
                    end

                    hub:publish({
                        message = {
                            action = "ping",
                            hash = game.player,
                            player = game.mode
                        }
                    })
                    game.nextState = "netplay"

                    -- Start game if both players are online
                    hub:publish({
                        message = {
                            action = "start",
                            player = game.mode
                        }
                    })
                end
            end

            -- Toggle pause
            if message.action == "pause" then
                game.pause = message.pause
            end
        end;
    })


    return hub
end

return netplay
