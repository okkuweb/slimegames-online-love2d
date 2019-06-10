
# Slime Games Online
Yet another discontinued http://slimegames.eu/ recreation attempt.

## Discontinued
### This project is discontinued since löve2d doesn't run nicely on the browser

## Links
- https://github.com/love2d-community/awesome-love2d
- https://docs.bartbes.com/grease
- https://github.com/vrld/HC
- http://hc.readthedocs.io/en/latest/
- https://love2d.org/wiki/Canvas
- https://love2d.org/forums/viewtopic.php?t=2479
- https://github.com/bartbes/love-misc-libs
- https://gafferongames.com/tags/networking/
- https://github.com/vrld/hump

## Making an Appimage
- https://github.com/AppImage/AppImageKit/releases
- https://github.com/AppImage/AppImageKit/issues/629
- https://github.com/AppImage/AppImageKit/wiki/Creating-AppImages
- https://wiki.archlinux.org/index.php/desktop_entries
- https://github.com/AppImage/AppImageKit/releases

## To-Do
- Make it so that the ball doesn't start clipping underground and that it always bounces slightly upwards??? or something (Already did a horrible hack to somewhat remedy this)
- Currently the ball also starts losing height each bounce on the floor? (I would guess it gets slightly stuck on the ground so there should be a check that doesn't let it trigger collision when the ball is going the other direction.... Nope wasn't it... Checked it)
- Add copy (and paste if you can) functionality to ip address and port fields
- Perhaps slow the ball down or stop the ball completely with a speshul effect when waiting for a new action from the server
- Make the channel name changeable so that more than 2 player can make a server at a time
- Draw a filter overlay when game paused and sync games after unpause
- Add countdown to unpause
- Sometimes when the ball hits the ground, it doesn't bounce back up as much as it should and kinda just gets stuck on the ground. Might be because "the dirty hack"
- When game is paused don't listen to control inputs (there's a saved event for jumping when paused)
