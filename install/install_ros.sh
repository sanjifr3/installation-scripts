#!/bin/bash
# Update using environment variables if they exist, else use default values
VERSION=${ROS_VERSION:-kinetic}
OS_V=${OS_VERSION:-16.04}

echo "Installing ROS $VERSION for Ubuntu $OS_V..."

## Get ROS source paths
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

## Add ROS key
if [ $OS_V == "aarch" ]; then
  sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 0xB01FA116
else
  sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
fi

## Update
sudo apt-get update
sudo apt-get -y upgrade

## Install ROS main
if [ $OS_V == "aarch" ]; then 
  sudo apt-get install -y --upgrade ros-$VERSION-ros-base python-rosdep
  sudo c_rehash /etc/ssl/certs
  
else
  sudo apt-get install -y --upgrade ros-$VERSION-desktop-full
fi
  
## Install ROS + specified packages
for PKG in \
  laser-scan-matcher \
  depthimage-to-laserscan \
  rtabmap \
  rtabmap-ros \
  tf2-bullet \
  rqt-image-view \
  freenect-launch \
  openni2-launch \
  openni-launch \
  uvc-camera \
  libuvc-camera \
  audio-common \
  pcl-ros \
  rqt-reconfigure \
; do sudo apt-get install -y --upgrade ros-$VERSION-$PKG ; done

## Install ROS main
if [ $VERSION != "aarch" ]; then 
  sudo apt-get install -y --upgrade ros-$VERSION-gmapping ros-$VERSION-move-base ros-$VERSION-dwa-local-planner ros-$VERSION-map-server ros-$VERSION-driver-base ros-$VERSION-pointcloud-to-laserscan
fi

## Add lines to bashrc
grep -q -F "source /opt/ros/$VERSION/setup.bash" ~/.bashrc || echo "source /opt/ros/$VERSION/setup.bash" >> ~/.bashrc
source ~/.bashrc

apt-cache search ros-$VERSION
sudo rosdep init
rosdep update

# Install rosinstall
sudo apt-get install -y python-rosinstall python-rosinstall-generator

# Bashrc Lines:
#source /opt/ros/kinetic/setup.bash
#source $HOME/casper-vision/devel/setup.bash

#export ROS_WORKSPACE=~/casper-vision
#export ROS_HOSTNAME=XPS16.local
#export ROSLAUNCH_SSH_UNKNOWN=1

#export ROBOT=master
#export ROS_NAMESPACE=sanjif
