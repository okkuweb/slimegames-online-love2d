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
        print("jump!")
        p.ySpeed = p.jumpSpeed
        p.jumpState = true
    end 
end

return controls
