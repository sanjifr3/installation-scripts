#!/bin/bash
# NVIDIA Jetson TX2
# Install TensorFlow dependencies and prerequisites
# Install Java and other dependencies by apt-get
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer -y
# Install other dependencies
sudo apt-get install zip unzip autoconf automake libtool curl zlib1g-dev maven -y
#sudo apt-get install -y cuda-command-line-tools
# Install Python 2.x
sudo apt-get install python-numpy swig python-dev python-pip python-wheel -y
# Install Python 3.x
sudo apt-get install python3-numpy swig python3-dev python3-pip python3-wheel -y

#sudo apt-get install nvidia-384-dev
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/nvidia-384

# Install bazel
./`dirname "$0"`/installBazel.sh
