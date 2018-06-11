-- Player options and initialization

-- Player 1 options
p1 = {}
p1.id = "p1"
p1.sprite = love.graphics.newImage("img/slime01.png")
p1.x = 200
p1.y = 384
p1.xMid = p1.sprite:getWidth() / 2 * scaling
p1.yMid = p1.sprite:getHeight() * scaling
p1.jumpSpeed = 15
p1.jumpState = false
p1.collisionState = false
p1.gravity = 0.8
p1.ySpeed = 0
p1.xSpeed = 0
p1.right = "d"
p1.left = "a"
p1.up = "w"

-- Player 2 options
p2 = {}
p2.id = "p2"
p2.sprite = love.graphics.newImage("img/slime02.png")
p2.x = 400
p2.y = 384
p2.xMid = p2.sprite:getWidth() / 2 * scaling
p2.yMid = p2.sprite:getHeight() * scaling
p2.jumpSpeed = 15
p2.jumpState = false
p2.collisionState = false
p2.gravity = 0.8
p2.ySpeed = 0
p2.xSpeed = 0
p2.right = "l"
p2.left = "j"
p2.up = "i"

