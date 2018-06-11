#!/bin/bash

dir=`pwd`
cd $dir/src
zip -9 -r ../builds/slimegames.love .
cd $dir/builds

# Linux build
cp -fv slimegames.love linux/slimegames-linux.love
cp -fv slimegames.love linux/appimage/Slimegames.AppDir/slimegames.love
./linux/appimage/appimagetool-x86_64.AppImage linux/appimage/Slimegames.AppDir/ linux/slimegames-linux.AppImage

# Windows build
cp -fv slimegames.love windows/slimegames-windows.love
cat windows/love.exe windows/slimegames-windows.love > windows/slimegames.exe
echo "Created an executable file for windows"

#MacOS build
cp -fv slimegames.love macos/slimegames-macos.love
cp -fv slimegames.love macos/slimegames-macos.app/Contents/Resources

echo "Done!"
