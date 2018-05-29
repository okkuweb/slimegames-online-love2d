-- Collider initialization

-- Create static colliders
cFloor = {}
cFloor.x = 0
cFloor.y = screen.height
cFloor.width = screen.width
cFloor.height = 50
cFloor.collider = hc.rectangle(
    cFloor.x,cFloor.y,cFloor.width,cFloor.height
)
cLeftWall = hc.rectangle(
    0,0,50,screen.height
)
cRightWall = hc.rectangle(
    screen.width,0,-50,screen.height
)
