#!/bin/bash

location=`dirname $0`

zip -9 -r $location/../builds/slimegames.love\
    $location/../.\
    -x $location/../.git/**\*\
    $location/../builds/**\*\
    $location/../build_scripts/**\*\

