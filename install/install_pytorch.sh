#!/bin/bash
TORCH=${PYTORCH_VERSION:-0.3.1}
CUDA=${CUDA_VERSION:-9.0}
PY2=${INSTALL_PY2:-1}
PY3=${INSTALL_PY3:-1}

# Remap names (strip dots)
CUDA_=${CUDA%.*}${CUDA##*.}

if [ $PY2 -eq 1 ]; then
  echo "Installing PyTorch $TORCH for python 2.7 and CUDA $CUDA..."
  PYTORCH=http://download.pytorch.org/whl/cu$CUDA_/torch-$TORCH-cp27-cp27mu-linux_x86_64.whl
  sudo pip2 install $PYTORCH
  sudo pip2 install torchvision
fi

if [ $PY3 -eq 1 ]; then
  echo "Installing PyTorch $TORCH for python 3.5 and CUDA $CUDA..."
  PYTORCH=http://download.pytorch.org/whl/cu$CUDA_/torch-$TORCH-cp35-cp35m-linux_x86_64.whl
  sudo pip3 install $PYTORCH
  sudo pip3 install torchvision
fi
