#!/bin/bash

CUDA=9.0
PY=2.7
TORCH=0.3.1

if [ "$#" -eq 1 ]; then
  PY=$1
elif [ "$#" -eq 2 ]; then
  PY=$1
  CUDA=$2
fi

if [ $PY != "2.7" ] && [ $PY != "3.5" ]; then
  echo Invalid python version: $PY
  echo "  Only 2.7 and 3.5 accepted"
  exit
elif [ $CUDA != "8.0" ] && [ $CUDA != "9.0" ]; then
  echo Invalid cuda: $CUDA
  echo "  Only 8.0 and 9.0 accepted"
  exit
fi

echo "Installing PyTorch for python $PY and CUDA $CUDA"

# Remap names (strip dots)
CUDA=${CUDA%.*}${CUDA##*.}
PY=${PY%.*}${PY##*.}

# Get pytorch wheel path
PYTORCH=http://download.pytorch.org/whl/cu$CUDA/torch-$TORCH-cp${PY}-cp${PY}m

# Select pip to use and finish seting PYTORCH path
PIP=pip3
if [ $PY ==  "27" ]; then
  PIP=pip2
  PYTORCH=${PYTORCH}u
fi
PYTORCH=$PYTORCH-linux_x86_64.whl

echo Installing $PYTORCH

# Install pytorch
sudo $PIP install $PYTORCH
sudo $PIP install torchvision
