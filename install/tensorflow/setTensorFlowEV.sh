#!/bin/bash
# TensorFlow Installation
# Build TensorFlow

DIR=${PROGRAM_PATH:-$HOME/programs}
OS_V=${OS_VERSION:-16.04}
CUDA=${CUDA_VERSION:-9.0}
CUDNN=${CUDNN_VERSION:-7.1.5}
PY=${USE_PY:-2.7}

IFS='.' read -ra CUDNN_SPLIT <<< "$CUDNN"

default_python_bin_path=$(which python)
default_cudnn_path=/usr/local/cuda

export TF_CUDA_COMPUTE_CAPABILITIES='3.5,5.0,5.2,6.1'

if [ $PY == 3.5 ]; then default_python_bin_path=$(which python3); fi
if [ $OS_V == "aarch" ]; then 
  #sudo mkdir -p /usr/lib/aarch64-linux-gnu/include/
  #sudo cp /usr/include/cudnn.h /usr/lib/aarch64-linux-gnu/include/cudnn.h
  #default_cudnn_path=/usr/lib/aarch64-linux-gnu
  export TF_CUDA_COMPUTE_CAPABILITIES=6.2
fi

cd $DIR/tensorflow
# TensorFlow couldn't find include file for some reason
# TensorFlow expects it in /usr/lib/aarch64-linux-gnu/include/cudnn.h
#sudo mkdir -p /usr/lib/aarch64-linux-gnu/include/
#sudo cp /usr/include/cudnn.h /usr/lib/aarch64-linux-gnu/include/cudnn.h
# Setup the environment variables for configuration
# PYTHON Path is the default
export PYTHON_BIN_PATH=$default_python_bin_path
export PYTHON_LIB_PATH=/usr/local/lib/python${PY}/dist-packages
# No Google Cloud Platform support
export TF_NEED_GCP=0
# No Hadoop file system support
export TF_NEED_HDFS=0
# Use CUDA
export TF_NEED_CUDA=1
# Setup gcc ; just use the default
default_gcc_host_compiler_path=$(which gcc)
export GCC_HOST_COMPILER_PATH=$default_gcc_host_compiler_path
# TF CUDA Version 
export TF_CUDA_VERSION=$CUDA
# CUDA path
export default_cuda_path=/usr/local/cuda
export CUDA_TOOLKIT_PATH=$default_cuda_path
# cuDNN
export TF_CUDNN_VERSION=${CUDNN_SPLIT[0]}
export CUDNN_INSTALL_PATH=$default_cudnn_path
# CUDA compute capability
export CC_OPT_FLAGS=-march=native
export TF_NEED_JEMALLOC=1
export TF_NEED_OPENCL=0
export TF_NEED_OPENCL_SYCL=0
export TF_ENABLE_XLA=0
# Added for TensorFlow 1.3
export TF_NEED_MKL=0
export TF_NEED_MPI=0
export TF_NEED_VERBS=0
# Use nvcc for CUDA compiler
export TF_CUDA_CLANG=0
# Added for TensorFlow 1.5
export TF_NEED_VERBS=0
export TF_NEED_GDR=0
export TF_NEED_S3=0
export TF_NEED_KAFKA=0
export TF_NEED_COMPUTECPP=0
export TF_NEED_TENSORRT=0
export TF_SET_ANDROID_WORKSPACE=0

source $DIR/tensorflow/configure

# If the above fails, try adding `#!/usr/bin/python` to top of configure.py
# try changing `configure` to `configure.py` above
