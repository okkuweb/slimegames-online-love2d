-- Collider initialization

-- Create static colliders
cFloor = {}
cFloor.x = 0
cFloor.y = game.height
cFloor.width = game.width
cFloor.height = 50
cFloor.collider = hc.rectangle(
    cFloor.x,cFloor.y,cFloor.width,cFloor.height
)
cLeftWall = hc.rectangle(
    0,0,50,game.height
)
cRightWall = hc.rectangle(
    game.width,0,-50,game.height
)
