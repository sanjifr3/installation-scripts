#!/bin/bash

export TORCH_NVCC_FLAGS="-D__CUDA_NO_HALF_OPERATORS__"

## Install torch
cd ~
rm -rf ~/programs/torch
git clone https://github.com/torch/distro.git ~/programs/torch --recursive
cd ~/programs/torch
./clean.sh
bash install-deps
./install.sh
source ~/.bashrc
git clone git@github.com:Yonaba/Moses.git
cd Moses/ 
luarocks make rockspec/moses-1.6.0-1.rockspec
cd ..
git clone git@github.com:nicholas-leonard/torchx.git
cd torchx/
luarocks make torchx-scm-1.rockspec
cd ..
git clone git@github.com:Element-Research/dpnn.git
cd dpnn/
luarocks make rocks/dpnn-scm-1.rockspec
cd ..

# TORCH_LUA_VERSION=LUA52 ./install.sh

source ~/.bashrc
git config --global url.https://github.com
#sudo rm -rf ~/.cache/luarocks &&
luarocks install image
luarocks install list
# Install luarocks libraries for torch
#for NAME in image list csvigo torch dpnn optim nn torchx optnet tds cutorch cunn fblualib; do luarocks install $NAME; done &&
for NAME in csvigo torch dpnn optim nn torchx optnet tds; do luarocks install $NAME; done
