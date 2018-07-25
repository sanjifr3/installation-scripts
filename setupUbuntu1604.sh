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
CUDA=1
CUDNN=1
OPENCV=1
DLIB=1
TORCH=1
OPENFACE=1
YOLO=1
PYTORCH=1
TF=1
ASTRA=0
REALSENSE=1
AWS=1
ARDUINO=1
DESPOT=1

export OS_VERSION=16.04
export ROS_VERSION=kinetic
export USE_GPU=1
export INSTALL_PY2=1
export INSTALL_PY3=0

######################################################################################

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

