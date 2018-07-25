#!/bin/bash

# Version sets in respective installation scripts inside ./scripts/

# install jetpack - follow instructions below
#   http://docs.nvidia.com/jetpack-l4t/index.html#developertools/mobile/jetpack/l4t/3.2rc/jetpack_l4t_install.htm
#	  Deselect Jetson target specific entries if only installing on host machine

# Install cudnn7 from  https://developer.nvidia.com/rdp/form/cudnn-download-survey
##       - save in ~/programs/cuda

######################################################################################

# Installation Control
PREREQ=0
ROS=0
PY2_LIBS=0
PY3_LIBS=0
CUDA=0
CUDNN=1
OPENCV=0
DLIB=0
TORCH=0
OPENFACE=1
YOLO=1
PYTORCH=1
TF=1
ASTRA=1
REALSENSE=1
AWS=1
ARDUINO=0
DESPOT=0

export OS_VERSION=aarch
export ROS_VERSION=kinetic
export USE_GPU=1
export INSTALL_PY2=1
export INSTALL_PY3=0

EXT_NAME=sanjif32SD
export PROGRAM_PATH=$HOME/programs

######################################################################################

# Make target paths
mkdir -p $PROGRAM_PATH/cuda

DIR=$PWD

# Activate all cores
if [ $OS_VERSION == "aarch" ]; then
  # Activate all CPU cores for build
	sudo nvpmodel -m 0
	sudo bash ~/jetson_clocks.sh
	
	cd $PROGRAM_PATH
	git clone https://github.com/jetsonhacks/postFlashTX1
	cd postFlashTX1

	# Change 'sanjif32SD' to name of the SD card drive	
	sudo ./createSwapfile.sh -d /media/nvidia/$EXT_NAME/ -s 16 -a
	swapon
fi

cd $DIR

export INSTALL_PREREQ=$PREREQ
export INSTALL_ROS=$ROS
export INSTALL_PY2_LIBS=$PY2_LIBS
export INSTALL_PY3_LIBS=$PY3_LIBS
export INSTALL_CUDA=$CUDA
export INSTALL_CUDNN=$CUDNN
export INSTALL_OPENCV=$OPENCV
export INSTALL_DLIB=$DLIB
export INSTALL_TORCH=$TORCH
export INSTALL_OPENFACE=$OPENFACE
export INSTALL_PYTORCH=$PYTORCH
export INSTALL_YOLO=$YOLO
export INSTALL_TF=$TF
export INSTALL_ASTRA=$ASTRA
export INSTALL_REALSENSE=$REALSENSE
export INSTALL_AWS=$AWS
export INSTALL_ARDUINO=$ARDUINO
export INSTALL_DESPOT=$DESPOT

./setup.sh

# Deactivate swap
if [ $OS_VERSION == "aarch" ]; then
  sudo swapoff --all
  sudo mv /etc/fstab /etc/fstab.back
  sudo cp `dirname "$0"`/tensorflow/fstab /etc/ 
  #sudo gedit /etc/fstab # Delete contents of entire file
  rm -rf /media/nvidia/$EXT_NAME/swapfile
  
  sudo apt clean
  sudo apt autoremove --purge
  sudo rm /usr/src/*.tbz2
fi
