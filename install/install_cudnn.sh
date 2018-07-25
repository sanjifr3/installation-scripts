#!/bin/bash
CUDNN=${CUDNN_VERSION:-7}
CUDA=${CUDA_VERSION:-9.0}
DIR=${PROGRAM_PATH:-$HOME/programs}
OS_V=${OS_VERSION:-16.04}

echo "Installing CUDNN $CUDNN for CUDA $CUDA in $DIR..."

## install cudnn 7

if [ $OS_V == "aarch" ]; then
  FROM=$DIR/cuda/jetson/cudnn
  TO=/usr/local/cuda/lib64
  sudo cp $FROM/cudnn.h /usr/local/cuda/include/cudnn.h
  sudo cp $FROM/libcudnn.so.7.0.5 $TO/libcudnn.so.7.0.5
  sudo cp $FROM/libcudnn_static.a $TO/libcudnn_static.a
  cd $TO
  sudo ln -s libcudnn.so.7.0.5 libcudnn.so.7
  sudo ln -s libcudnn.so.7.0.5 libcudnn.so
  sudo ln -s libcudnn.so.7.0.5 libcudnn.so.7.0
  #sudo ln -s /usr/include/cudnn.h /usr/local/cuda/include/cudnn.h
  #sudo ln -s $FROM/libcudnn.so $TO/libcudnn.so
  #sudo ln -s $FROM/libcudnn.so.7 $TO/libcudnn.so.7
  #sudo ln -s $FROM/libcudnn.so.7.0.5 $TO/libcudnn.so.7.0.5
  #sudo ln -s $FROM/libcudnn_static_v7.a $TO/libcudnn_static.a
else
  cd $DIR/cuda
  tar xvzf cudnn-${CUDA}-linux-x64-v${CUDNN}.tgz
  sudo cp cuda/include/cudnn.h /usr/local/cuda/include
  sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
  sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*
  sudo apt-get install nvidia-384-dev 
fi

#cp /etc/ld.so.conf.d/cuda-9-0.conf $DIR/cuda
#sudo mv $HOME/mia-robot/installation-scripts/install/cuda/cuda-9-0.conf /etc/ld.so.conf.d
