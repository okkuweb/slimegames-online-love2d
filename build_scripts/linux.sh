#!/bin/bash

location=`dirname $0`
cd $location/../src
zip -9 -r ../builds/slimegames.love .
