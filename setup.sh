#!/bin/bash

# Update bashrc prior to running script

# Version sets in respective installation scripts inside ./scripts/

# install jetpack - follow instructions below
#   http://docs.nvidia.com/jetpack-l4t/index.html#developertools/mobile/jetpack/l4t/3.2rc/jetpack_l4t_install.htm
#	  Deselect Jetson target specific entries if only installing on host machine

# Install cudnn7 from  https://developer.nvidia.com/rdp/form/cudnn-download-survey
##       - save in ~/programs/cuda

######################################################################################

# Installation Control
PREREQ=${INSTALL_PREREQ:-0}
ROS=${INSTALL_ROS:-0}
PY2_LIBS=${INSTALL_PY2_LIBS:-0}
PY3_LIBS=${INSTALL_PY3_LIBS:-0}
CUDA=${INSTALL_CUDA:-0}
CUDNN=${INSTALL_CUDNN:-0}
OPENCV=${INSTALL_OPENCV:-0}
DLIB=${INSTALL_DLIB:-0}
TORCH=${INSTALL_TORCH:-0}
OPENFACE=${INSTALL_OPENFACE:-0}
PYTORCH=${INSTALL_PYTORCH:-0}
YOLO=${INSTALL_YOLO:-0}
TF=${INSTALL_TF:-0}
ASTRA=${INSTALL_ASTRA:-0}
REALSENSE=${INSTALL_REALSENSE:-0}
AWS=${INSTALL_AWS:-0}
ARDUINO=${INSTALL_ARDUINO:-0}
DESPOT=${INSTALL_DESPOT:-0}
SWAP=${CREATE_SWAP:-0}
RPLIDAR=${INSTALL_RPLIDAR:-0}
RESPEAKER=${INSTALL_RESPEAKER:-0}

# Override defaults for following install scripts
#export OS_VERSION=16.04 # 16.04 # aarch # 14.04
#export ROS_VERSION=kinetic # indigo # kinetic
#export USE_GPU=1 # 0
#export DLIB_VERSION=19.9
#export OPENFACE_VERSION=0.2.1
#export CUDA_VERSION=9.0
#export CUDNN_VERSION=7.1.5
export OPENCV_VERSION=3.4.0
#export PYTORCH_VERSION=0.3.1
#export TF_VERSION=1.6.0-rc1
#export BAZEL_VERSION=0.10.1
export REALSENSE_VERSION=2.12.0 # 2.10.4
export REALSENSE_ROS_VERSION=2.0.3
#export INSTALL_PY2=1
#export INSTALL_PY3=0

# Paths
export PROGRAM_PATH=$HOME/programs
EXT_NAME=sanjif32SD

######################################################################################

# Make target paths
mkdir -p $PROGRAM_PATH/cuda
mkdir -p $PROGRAM_PATH/nvidia-jetpack

DIR=$PWD

# Activate all cores
if [ $OS_VERSION == "aarch" ]; then
  # Activate all CPU cores for build
  sudo nvpmodel -m 0
  sudo bash ~/jetson_clocks.sh
	
  if [ $SWAP -eq 1 ]; then
    cd $PROGRAM_PATH
    git clone https://github.com/jetsonhacks/postFlashTX1
    cd postFlashTX1

    # Change 'sanjif32SD' to name of the SD card drive	
    sudo ./createSwapfile.sh -d /media/nvidia/$EXT_NAME/ -s 16 -a
    swapon
  fi
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
# -- otherwise need to install cuda9 separately
if [ $CUDA -eq 1 ]; then ./install/install_cuda.sh; fi

# Install CUDNN
if [ $CUDNN -eq 1 ]; then ./install/install_cudnn.sh; fi

# Install OpenCV
if [ $OPENCV -eq 1 ]; then 
  ./install/install_opencv.sh
  if [ $OS_VERSION == "aarch" ]; then rm -rf $PROGRAM_PATH/opencv$OPENCV_VERSION; fi
fi

# Install DLIB
if [ $DLIB -eq 1 ]; then
  ./install/install_dlib.sh
  if [ $OS_VERSION == "aarch" ]; then rm -rf $PROGRAM_PATH/dlib; fi
fi

# Install Torch
if [ $TORCH -eq 1 ]; then ./install/install_torch.sh; fi

# Install OpenFace
if [ $OPENFACE -eq 1 ]; then ./install/install_openface.sh; fi

# Install PyTorch
if [ $PYTORCH -eq 1 ]; then
  ./install/install_pytorch.sh 
  if [ $OS_VERSION == "aarch" ]; then rm -rf $PROGRAM_PATH/pytorch; fi
fi

# Install YOLO
if [ $YOLO -eq 1 ]; then ./install/install_yolo.sh; fi

# Install TensorFlow
if [ $TF -eq 1 ]; then
  ./install/install_tensorflow.sh
  if [ $OS_VERSION == "aarch" ]; then rm -rf $PROGRAM_PATH/tensorflow; fi
fi

# Install Astra
if [ $ASTRA -eq 1 ]; then ./install/install_astra.sh; fi

# Install RealSense
if [ $REALSENSE -eq 1 ]; then ./install/install_realsense.sh; fi

# Install AWS/Polly
if [ $AWS -eq 1 ]; then ./install/install_aws.sh; fi

# Install Arduino
if [ $ARDUINO -eq 1 ]; then ./install/install_arduino.sh; fi

# Install Despot
if [ $DESPOT -eq 1 ]; then
  ./install/install_despot.sh
  if [ $OS_VERSION == "aarch" ]; then rm -rf $PROGRAM_PATH/despot; fi
fi

# Make ROS workspace if it exists and is installed
if [ $ROS -eq 1 ]; then
  roscd
  catkin_make
fi

# Install Respeaker
if [ $RESPEAKER -eq 1 ]; then ./install/install_respeaker.sh; fi

# Install RPLidar
if [ $RPLIDAR -eq 1 ]; then ./install/install_rplidar.sh; fi

# Deactivate swap
if [ $OS_VERSION == "aarch" ] && [ $SWAP -eq 1 ]; then
  sudo swapoff --all
  sudo mv /etc/fstab /etc/fstab.back
  sudo cp `dirname "$0"`install/tensorflow/fstab /etc/ 
  #sudo gedit /etc/fstab # Delete contents of entire file
  sudo rm -rf /media/nvidia/$EXT_NAME/swapfile
  
  #sudo apt clean
  #sudo apt autoremove --purge
  #sudo rm /usr/src/*.tbz2
fi
