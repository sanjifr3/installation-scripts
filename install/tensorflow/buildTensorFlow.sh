#!/bin/bash
# TensorFlow Installation
# Export TensorFlow GPU environment variables
# WARNING This needs to match setTensorFlowEV.sh settings

DIR=${PROGRAM_PATH:-$HOME/programs}
OS_V=${OS_VERSION:-16.04}
CUDA=${CUDA_VERSION:-9.0}
CUDNN=${CUDNN_VERSION:-7}

if [ $OS_V == "aarch" ]; then export TF_CUDA_COMPUTE_CAPABILITIES=6.2;
else export TF_CUDA_COMPUTE_CAPABILITIES='3.5,5.2'; fi

export TF_NEED_CUDA=1
export TF_CUDA_VERSION=$CUDA
export CUDA_TOOLKIT_PATH=/usr/local/cuda
export TF_CUDNN_VERSION=$CUDNN
export CUDNN_INSTALL_PATH=/usr/local/cuda

cd $DIR/tensorflow

# Build Tensorflow

if [ $OS_V == "aarch" ]; then
  bazel build -c opt --local_resources 3072,4.0,1.0 --verbose_failures --config=cuda //tensorflow/tools/pip_package:build_pip_package
else
  bazel build --config=opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
fi
