#!/bin/bash
DIR=${PROGRAM_PATH:-$HOME/programs}
TF=${TF_VERSION:-1.6.0-rc0}
CUDA=${CUDA_VERSION:-9.0}
OS_V=${OS_VERSION:-16.04}
PY2=${INSTALL_PY2:-1}
PY3=${INSTALL_PY3:-1}

# Remap names (strip dots)
CUDA_=${CUDA%.*}${CUDA##*.}

if echo $TF | grep -q "rc"; then TF_=${TF%-*}${TF##*-}
else TF_=$TF; fi

#TF_SCRIPTS_PATH=$PWD/`dirname "$0"`/tensorflow
TF_SCRIPTS_PATH=$HOME/casper-vision/scripts/install/tensorflow

cd $DIR
#rm -rf tensorflow
git clone https://github.com/tensorflow/tensorflow.git

cd tensorflow
#git pull
git checkout tags/v${TF}

cd $TF_SCRIPTS_PATH

# Install pre-requisities
cd $TF_SCRIPTS_PATH
./installPrerequisites.sh

if [ $PY2 -eq 1 ]; then
  export USE_PY=2.7

  TF_WHL=tensorflow-${TF_}-cp27-cp27mu-linux_
  if [ $OS_V == 'aarch' ]; then TF_WHL=${TF_WHL}aarch64.whl;
  else TF_WHL=${TF_WHL}x86_64.whl; fi

  if [ ! -f $DIR/$TF_WHL ]; then
    ./setTensorFlowEV.sh
    ./buildTensorFlow.sh
    ./packageTensorFlow.sh
  fi
  
  sudo pip2 install $DIR/$TF_WHL
  sudo pip2 install keras
fi

if [ $PY3 -eq 1 ]; then
  export USE_PY=3.5
  
  TF_WHL=tensorflow-${TF_}-cp35-cp35m-linux_
  if [ $OS_V == 'aarch' ]; then TF_WHL=${TF_WHL}aarch64.whl;
  else TF_WHL=${TF_WHL}x86_64.whl; fi
  
  if [ ! -f $DIR/$TF_WHL ]; then
    ./setTensorFlowEV.sh
    ./buildTensorFlow.sh
    ./packageTensorFlow.sh
  fi
   
  sudo pip3 install $DIR/$TF_WHL
  sudo pip3 install keras
fi
