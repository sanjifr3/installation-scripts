#!/bin/bash
# Requirements:
## 1. External storage inserted to act as swap
##     - Change name of EXT_NAME to match  
## 2. Download cudnn7 from:
##     https://developer.nvidia.com/rdp/form/cudnn-download-survey
##       - save in ~/programs/cudnn7

# External storage for swap

###

EXT_NAME=sanjif32SD
DLIB_VERSION=19.9

### Make directories ###
mkdir -p ~/repos
mkdir -p ~/programs
########################


### Updated Installation Files ###
#cd repos
#git clone https://github.com/jetsonhacks/buildOpenCVTX2.git
#git clone https://github.com/jetsonhacks/installROSTX2.git
#git clone https://github.com/jetsonhacks/postFlashTX1
#git clone https://github.com/jetsonhacks/installTensorFlowTX2.git
#cd installTensorFlowTX2/
#git checkout vL4T28.1TF1.3V3
##################################


### Activate All Cores ###
sudo nvpmodel -m 0
##########################


### Install OpenCV ###
./install_scripts/buildOpenCVTX2/buildOpenCV.sh
cd ~/programs/opencv/build
sudo make install
######################


### Install ROS ###
cd ~/casper-vision/scripts/jetson
./install_scripts/installROSTX2/installROS.sh
###################


### Install Tensorflow ###
cd ~/install_scripts/installTensorFlowTX2

# Create swap on SD card
sudo ./createSwapfile.sh -d /media/nvidia/$EXT_NAME/ -s 16 -a

# Install cuDNN v7
cd ~/programs/cudnn7
tar xvzf cudnn-9.0-linux-x64-v7.tgz
sudo cp cuda/include/cudnn.h /usr/local/cuda/include
sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*	


## Python 2.7 ##
cd ~/casper-vision/scripts/jetson/install_scripts/installTensorFlowTX2
./installPrerequisites.sh
./cloneTensorFlow.sh
./setTensorFlowEV.sh
./buildTensorFlow.sh
./packageTensorFlow.sh
sudo pip install $HOME/programs/tensorflow-1.6.0rc0-cp27-cp27mu-linux_aarch64.whl  
################

## Python 3.5 ##
./installPrerequisitesPy3.sh
./cloneTensorFlow.sh
./setTensorFlowEVPy3.sh
./buildTensorFlow.sh
./packageTensorFlow.sh
sudo pip3 install $HOME/programs/tensorflow-1.6.0rc0-cp35-cp35m-linux_aarch64.whl   
################

## Stop Swap ##
sudo mv /etc/fstab /etc/fstab.back
sudo cp ~/casper-vision/scripts/jetson/install_scripts/installTensorFlowTX2/fstab etc/
################

##########################


### Install DLIB ###
cd ~/casper-vision/libraries/dlib-${DLIB_VERSION}
sudo python setup.py install --yes USE_AVX_INSTRUCTIONS
mkdir -p build
cd build
cmake .. -DUSE_AVX_INSTRUCTIONS=1
cmake --build .
####################


### Install open_face ###
cd ~/casper-vision/libraries/openface &&
sudo python2 setup.py install
#########################


### Install YOLO ###
cd ~/programs
git clone https://github.com/pjreddie/darknet.git
cd darknet

# Backup files
mv MakeFile MakeFile.back
mv python/darknet.py python/darknet.py.back
mv cfg/coco.data cfg/coco.data.back

# Copy custom make file
cp ~/casper-vision/scripts/jetson/install_scripts/yolo/MakeFile .

# Build libraries
make

# Copy over fixed files
cp ~/casper-vision/scripts/jetson/install_scripts/yolo/darknet.py python/
cp ~/casper-vision/scripts/jetson/install_scripts/yolo/coco.data cfg/

# Download weights
mkdir -p weights
cd weights
wget https://pjreddie.com/media/files/yolo.weights
wget https://pjreddie.com/media/files/alexnet.weights
####################
