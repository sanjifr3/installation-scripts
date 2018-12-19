#!/bin/bash
CUDNN=${CUDNN_VERSION:-7.1.4}
CUDA=${CUDA_VERSION:-9.0}
DIR=${PROGRAM_PATH:-$HOME/programs}
OS_V=${OS_VERSION:-16.04}
METHOD=${CUDNN_METHOD:-1}

echo "Installing CUDNN $CUDNN for CUDA $CUDA in $DIR..."

IFS='.' read -ra CUDNN_SPLIT <<< "$CUDNN"

## install cudnn 7

if [ $OS_V == "aarch" ]; then
  TO=/usr/local/cuda/lib64
  if [ $METHOD -eq 1 ]; then
    FROM=$DIR/cuda/jetson/cudnn/$CUDNN
    sudo cp $FROM/cudnn.h /usr/local/cuda/include/cudnn.h
    sudo cp $FROM/libcudnn.so.${CUDNN} $TO/libcudnn.so.${CUDNN}
    sudo cp $FROM/libcudnn_static.a $TO/libcudnn_static.a
    cd $TO
    sudo ln -s libcudnn.so.${CUDNN} libcudnn.so.${CUDNN_SPLIT[0]}
    sudo ln -s libcudnn.so.${CUDNN} libcudnn.so.${CUDNN_SPLIT[0]}.${CUDNN_SPLIT[1]}
    sudo ln -s libcudnn.so.${CUDNN} libcudnn.so
  else
    FROM=/usr/lib/aarch64-linux-gnu
    sudo ln -s /usr/include/cudnn.h /usr/local/cuda/include/cudnn.h
    sudo ln -s $FROM/libcudnn.so $TO/libcudnn.so
    sudo ln -s $FROM/libcudnn.so.${CUDNN_SPLIT[0]} $TO/libcudnn.so.${CUDNN_SPLIT[0]}
    sudo ln -s $FROM/libcudnn.so.${CUDNN} $TO/libcudnn.so.${CUDNN}
    sudo ln -s $FROM/libcudnn_static_v7.a $TO/libcudnn_static.a
  fi
else
  cd $DIR/cuda
  if [ $CUDNN == "7.0.5" ]; then
    tar xvzf cudnn-${CUDA}-linux-x64-v${CUDNN_SPLIT[0]}.tgz
  elif [ $CUDNN == "7.1.4" ]; then
    tar xvzf cudnn-${CUDA}-linux-x64-v${CUDNN_SPLIT[0]}.${CUDNN_SPLIT[1]}.tgz
  fi
  
  sudo cp cuda/include/cudnn.h /usr/local/cuda/include
  sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
  sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*
  #sudo apt-get install nvidia-384-dev 
fi

#cp /etc/ld.so.conf.d/cuda-9-0.conf $DIR/cuda
#SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
#if [ -d $SCRIPTPATH/cuda ]; then
#  cp $SCRIPTPATH/cuda/cuda-9-0.conf /etc/ld.so.conf.d
#elif [ -d $SCRIPTPATH/install/polly ]; then
#  cp $SCRIPTPATH/install/cuda/cuda-9-0.conf /etc/ld.so.conf.d
#fi
