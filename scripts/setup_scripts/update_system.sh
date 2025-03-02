#!/bin/bash

if [[ $UID = 0 ]] ; then
  echo "Please dont use sudo with this script"
  exit
fi

if [[ $1 != '--nodownload' ]] ; then
  git pull
  ./update_system.sh --nodownload
  exit

elif [[ $REINSTALL == 1 ]] ; then
  echo "Forcing reinstall of ROS2"
fi


# TODO make sure the script fires for ros2

if [ -z "$ROS_DISTRO"] || [ -n "$REINSTALL" ] ; then
    if type lsb_release >/dev/null 2>&1; then
        VER=$(lsb_release -sr)
        if [ $VER == "20.04" ]; then
            ROS_DISTRO="galactic"
        else
            echo "Linux version not recognized"
            exit
        fi
        echo "Ros distribution $ROS_DISTRO selected"
        export ROS_DISTRO
    else
        echo "Linux distro not recognized"
        exit
    fi
fi

# Install ros
if [ ! -d "/opt/ros/$ROS_DISTRO" ] || [ -n "$REINSTALL" ]  ; then
    if [ $ROS_DISTRO == "galactic" ]; then
        ./install_galactic.sh
    else
        echo "Ubuntu version not supported"
        exit
    fi
fi

# Install all custom ros packages
./install_custom_ros_packages.sh

# Setup ~/.bashrc and vscode
./setup_bashrc.sh
./setup_vscode.sh
sudo ./setup_hosts.sh

# Add user to group 'uwrt' for sensor permissions
sudo hardware/add_rule

# setup uwrt packages
./install_uwrt_ros2.sh

echo "If no errors occurred during compilation, then everything was setup correctly"
echo "Please reboot your computer for final changes to take effect"