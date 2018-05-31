local controls = {}

function controls.handle(p)
    local right = love.keyboard.isDown(p.right)
    local left = love.keyboard.isDown(p.left)
    local up = love.keyboard.isDown(p.up)

    if right then
        p.xSpeed = 5
    end
    if left then
        p.xSpeed = -5
    end
    if not right and not left then
        p.xSpeed = 0
    end

    if up and p.jumpState == false then
        p.ySpeed = p.jumpSpeed
        p.jumpState = true
    end 

    if p.rightDown ~= right or p.leftDown ~= left or p.upDown ~= up then
        hub:publish({
            message = {
                player = p.id,
                action = "move",
                playerX = p.x,
                playerY = p.y,
                right = right,
                left = left,
                up = up
            }
        })
    end

    p.rightDown = right
    p.leftDown = left
    p.upDown = up
end

function controls.onlineHandle(p)
    local right = p.rightDown
    local left = p.leftDown
    local up = p.upDown

    if right then
        p.xSpeed = 5
    end
    if left then
        p.xSpeed = -5
    end
    if not right and not left then
        p.xSpeed = 0
    end

    if up and p.jumpState == false then
        p.ySpeed = p.jumpSpeed
        p.jumpState = true
    end 
end

return controls