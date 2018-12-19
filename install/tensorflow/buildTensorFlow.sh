#!/bin/bash
# TensorFlow Installation
# Export TensorFlow GPU environment variables
# WARNING This needs to match setTensorFlowEV.sh settings

DIR=${PROGRAM_PATH:-$HOME/programs}
OS_V=${OS_VERSION:-16.04}
CUDA=${CUDA_VERSION:-9.0}
CUDNN=${CUDNN_VERSION:-7.1.5}
TF_PATH=${MY_TF_PATH:-tensorflow}

IFS='.' read -ra CUDNN_SPLIT <<< "$CUDNN"

if [ $OS_V == "aarch" ]; then export TF_CUDA_COMPUTE_CAPABILITIES=6.2;
else export TF_CUDA_COMPUTE_CAPABILITIES='3.5,5.0,5.2,6.1'; fi

export TF_NEED_CUDA=1
export TF_CUDA_VERSION=$CUDA
export CUDA_TOOLKIT_PATH=/usr/local/cuda
export TF_CUDNN_VERSION=${CUDNN_SPLIT[0]}
export CUDNN_INSTALL_PATH=/usr/local/cuda

cd $DIR/${TF_PATH}

# Build Tensorflow

if [ $OS_V == "aarch" ]; then
  bazel build -c opt --local_resources 3072,4.0,1.0 --verbose_failures --config=cuda //tensorflow/tools/pip_package:build_pip_package
else
  bazel build --config=opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
fi
