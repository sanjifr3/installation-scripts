#!/bin/bash
DIR=${PROGRAM_PATH:-$HOME/programs}
RUN_PATH=$PWD

export TORCH_NVCC_FLAGS="-D__CUDA_NO_HALF_OPERATORS__"

## Install torch
cd $DIR
rm -rf torch
git clone https://github.com/torch/distro.git torch --recursive
cd torch
./clean.sh
bash install-deps
./install.sh
# TORCH_LUA_VERSION=LUA52 ./install.sh
git config --global url.https://github.com
source ~/.bashrc

# Install torch libraries
cd $RUN_PATH
`dirname "$0"`/install_th_libraries.sh
