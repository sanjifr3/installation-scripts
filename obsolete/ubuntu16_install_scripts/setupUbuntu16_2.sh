#!/bin/bash

## install jetpack - follow instructions below
#http://docs.nvidia.com/jetpack-l4t/index.html#developertools/mobile/jetpack/l4t/3.2rc/jetpack_l4t_install.htm
#	Deselect Jetson target specific entries if only installing on host machine

## Install cudnn7 for cuda 9
## https://developer.nvidia.com/rdp/cudnn-download
## store in programs/cuda

CUDA=9.0
CUDNN=7
PY=2.7

# OpenCV Parameters
OPENCV=3.4.1
GPU=1

REPOS=$HOME/repos
PROGRAMS=$HOME/programs
INSTALL_SCRIPTS=$HOME/casper-vision/scripts/ubuntu16

mkdir -p $REPOS
mkdir -p $PROGRAMS

## Install cuda 9 - installed with jetpack

## Install cudnn7












## install cudnn 7
cd $PROGRAMS/cuda
tar xvzf cudnn-${CUDA}-linux-x64-v7.tgz
sudo cp cuda/include/cudnn.h /usr/local/cuda/include
sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*	

## Install opencv - installed with jetpack
cd $INSTALL_SCRIPTS/install_scripts/opencv
./install_opencv.sh $OPENCV $GPU

## Install torch
cd $INSTALL_SCRIPTS/install_scripts/torch
./install_torch.sh

## Install yolo
cd $PROGRAMS
#	Clone repo
git clone https://github.com/pjreddie/darknet.git
#	Backup files
cd darknet
mv MakeFile MakeFile.back
mv python/darknet.py python/darknet.py.back
mv cfg/coco.data cfg/coco.data.back
#	Copy custom make file
cp $INSTALL_SCRIPTS/install_scripts/yolo/MakeFile .
#	Build library
make
#	Copy over fixed files
cp $INSTALL_SCRIPTS/install_scripts/yolo/darknet.py python/
cp $INSTALL_SCRIPTS/install_scripts/yolo/coco.data cfg/
#	Download weights
mkdir -p weights
cd weights
wget https://pjreddie.com/media/files/yolo.weights
wget https://pjreddie.com/media/files/alexnet.weights

## Install torch
cd $INSTALL_SCRIPTS/install_scripts/torch/
./install_torch.sh
source ~/.bashrc
./install_th_libraries.sh

## Install pyTorch
cd $INSTALL_SCRIPTS/install_scripts/pytorch/
sudo ./install_pytorch.sh $PY $CUDA
PY=3.5
sudo ./install_pytorch.sh $PY $CUDA

## Install tensorflow
cd $INSTALL_SCRIPTS/install_scripts/tensorflow/
./installPrerequisites.sh
./installPrerequisitesPy3.sh

cd $REPOS
rm -rf tensorflow
git clone https://github.com/tensorflow/tensorflow.git
cd $INSTALL_SCRIPTS/install_scripts/tensorflow/
./setTensorFlowEV.sh
#sudo pip install $HOME/repos/tensorflow-1.6.0rc0-cp27-cp27mu-linux_aarch64.whl  

cd $REPOS
rm -rf tensorflow
git clone https://github.com/tensorflow/tensorflow.git
cd $INSTALL_SCRIPTS/install_scripts/tensorflow/
./setTensorFlowEVPy3.sh
./buildTensorFlow.sh
./packageTensorFlow.sh
#sudo pip3 install $HOME/repos/tensorflow-1.6.0rc0-cp27-cp27mu-linux_aarch64.whl  
https://drive.google.com/uc?export=download&id=7I62GOSnZ8R3Jzd0ozdzlJUk0
https://drive.google.com/file/d//view

## Python 2.7 ##
#./installPrerequisites.sh
#./cloneTensorFlow.sh
#./setTensorFlowEV.sh
#./buildTensorFlow.sh
#./packageTensorFlow.sh
#sudo pip install $HOME/programs/tensorflow-1.6.0rc0-cp27-cp27mu-linux_aarch64.whl  
################

## Python 3.5 ##
#./installPrerequisitesPy3.sh
#./cloneTensorFlow.sh
#./setTensorFlowEV.sh
#./buildTensorFlowPy3.sh
#./packageTensorFlow.sh
#sudo pip3 install $HOME/programs/tensorflow-1.6.0rc0-cp35-cp35m-linux_aarch64.whl   
################

