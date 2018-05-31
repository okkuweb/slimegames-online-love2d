-- Options

-- Set pixel graphics filtering
love.graphics.setDefaultFilter("nearest", "nearest")
-- Set sprite size scaling
scaling = 6

-- Scene options
game = {}
game.width = love.graphics.getWidth()
game.height = love.graphics.getHeight()
game.state = "menu"
game.nextState = "menu"
game.mode = ""
game.ip = {text = "127.0.0.1"}
game.port = {text = "1337"}
