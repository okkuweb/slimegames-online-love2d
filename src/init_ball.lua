-- Ball options and initialization

-- Ball options
ball = {}
ball.size = 2
ball.x = 90
ball.y = 90
ball.xMid = ball.size * scaling
ball.yMid = ball.size * scaling
ball.xSpeed = 0
ball.ySpeed = 0
ball.hitSpeed = 10
ball.gravity = 0.2
canvas = love.graphics.newCanvas(300, 300)
love.graphics.setCanvas(canvas)
love.graphics.circle("fill", ball.size, ball.size, ball.size)
love.graphics.setCanvas()
