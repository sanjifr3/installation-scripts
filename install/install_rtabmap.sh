#!/bin/bash
ROS_V=${ROS_VERSION:-kinetic}
OS_V=${OS_VERSION:-16.04}
RTABMAP_V=${RTABMAP_VERSION:-0.17.6}
#RTABMAP_ROS_V=${RTABMAP_ROS_VERSION:-0.17.6}
DIR=${PROGRAM_PATH:-$HOME/programs}

cd $DIR
git clone https://github.com/introlab/rtabmap.git
cd rtabmap
git checkout tags/${RTABMAP_V}-${ROS_V}
cd build
cmake ..
make
sudo make install

#roscd
#cd src
#git clone https://github.com/introlab/rtabmap_ros.git
#cd rtabmap_ros
#git checkout tags/${RTABMAP_V}-${ROS_V}
#roscd
#catkin_make -j1
