#!/bin/bash
CUDA=9.0


PATH=$HOME/programs

if [ "$#" -eq 1 ]; then
  PATH=$1
fi

echo 'Install cudnn 7 for cuda 9'

cd $PATH
tar xvzf cudnn-9.0-linux-x64-v7.tgz
sudo cp cuda/include/cudnn.h /usr/local/cuda/include
sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*	
