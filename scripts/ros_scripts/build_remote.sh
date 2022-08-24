#!/bin/bash
if [ $# -eq 0 ]; then 
    echo "missing directory argument"
    exit -1
fi
if [ ! -d "$1" ]; then 
    echo "Build called on a non-existant directory"
    echo "$1"
    exit -2
fi

source /opt/ros/humble/setup.bash

if [ ! "$1" == *"dependencies"* ]; then
    echo "Sourcing riptide deps"
    source /home/ros/osu-uwrt/dependencies/install/setup.bash
fi

cd $1

if [[ $# -eq 2 && $2 == "--symlink-install" ]]; then
    echo "Running symlink build"
    colcon build --symlink-install
else
    echo "Running full build"
    colcon build
fi