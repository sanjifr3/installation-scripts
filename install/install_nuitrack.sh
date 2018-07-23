#!/usr/bin/bash

cd $HOME/programs/nuitrack
sudo apt-get purge --auto-remove openni-utils
sudo dpkg -i nuitrack-ubuntu-amd64.deb
sudo apt-get install nuitrack ros-kinetic-dynamixel-msgs
