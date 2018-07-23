#!/bin/bash
# Update using environment variables if they exist, else use default values
VERSION=${ROS_VERSION:-kinetic}
OS_V=${OS_VERSION:-16.04}

echo "Installing Arduino for ROS $VERSION for Ubuntu $OS_V..."

## Install ROS + specified packages
for PKG in \
  rosserial \
  rosserial-arduino \
; do sudo apt-get install -y --upgrade ros-$VERSION-$PKG ; done

# Install ros_lib into Arduino Environment
cd ~/Arduino/libraries
rm -rf ros_lib
rosrun rosserial_arduino make_libraries.py .
