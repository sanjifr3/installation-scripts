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
CUDNN=0
OPENCV=0
DLIB=0
TORCH=0
OPENFACE=0
PYTORCH=0
YOLO=0
TF=0
ASTRA=0
REALSENSE=1
AWS=0

# Override defaults for following install scripts
export OS_VERSION=aarch
export ROS_VERSION=kinetic
export USE_GPU=1
#export DLIB_VERSION=19.9
#export OPENFACE_VERSION=0.2.1
#export CUDA_VERSION=9.0
#export CUDNN_VERSION=7
#export OPENCV_VERSION=3.3.1
#export PYTORCH_VERSION=0.3.1
#export TF_VERSION=1.6.0
#export BAZEL_VERSION=0.10.1
#export REALSENSE_VERSION=2.10.2
#export REALSENSE_ROS_VERSION:-2.0.3
#export INSTALL_PY2=1
export INSTALL_PY3=0
EXT_NAME=sanjif32SD

# Paths
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

# Install pre-requisites
if [ $PREREQ -eq 1 ]; then ./install/install_pre-requisites.sh; fi

# Install ROS
if [ $ROS -eq 1 ]; then ./install/install_ros.sh; fi

# Install Python 2 libraries
if [ $PY2_LIBS -eq 1 ]; then ./install/install_python2.sh; fi

# Install Python 3 libraries
if [ $PY3_LIBS -eq 1 ]; then ./install/install_python3.sh; fi

# Install CUDA 9
# -- installed via NVIDIA Jetpack

# Install CUDNN
if [ $CUDNN -eq 1 ]; then ./install/install_cudnn.sh; fi

# Install OpenCV
if [ $OPENCV -eq 1 ]; then ./install/install_opencv.sh; fi

# Install DLIB
if [ $DLIB -eq 1 ]; then ./install/install_dlib.sh; fi
 
# Install Torch
if [ $TORCH -eq 1 ]; then ./install/install_torch.sh; fi

# Install OpenFace
if [ $OPENFACE -eq 1 ]; then ./install/install_openface.sh; fi

# Install PyTorch
if [ $PYTORCH -eq 1 ]; then ./install/install_pytorch.sh; fi

# Install YOLO
if [ $YOLO -eq 1 ]; then ./install/install_yolo.sh; fi

# Install TensorFlow
if [ $TF -eq 1 ]; then ./install/install_tensorflow; fi

# Install Astra
if [ $ASTRA -eq 1 ]; then ./install/install_astra.sh; fi

# Install RealSense
if [ $REALSENSE -eq 1 ]; then ./install/install_realsense.sh; fi

# Install AWS/Polly
if [ $AWS -eq 1 ]; then ./install/install_aws.sh; fi

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