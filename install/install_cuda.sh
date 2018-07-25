#!/bin/bash
CUDA=${CUDA_VERSION:-9.0}
DIR=${PROGRAM_PATH:-$HOME/programs}
OS_V=${OS_VERSION:-16.04}

echo "Installing CUDA $CUDA in $DIR..."

cd $DIR/cuda

if [ $OS_V != "aarch" ]; then 
  ## install cuda
  sudo dpkg -i cuda-repo-ubuntu1604-9-0-local_9.0.176-1_amd64.deb
  sudo apt-key add /var/cuda-repo-9-0-local/7fa2af80.pub
  sudo apt-get update
  sudo apt-get install -y cuda

  ## Apply patch 1
  sudo dpkg -i cuda-repo-ubuntu1604-9-0-local-cublas-performance-update_1.0-1_amd64.deb
  sudo apt-get update  
  sudo apt-get upgrade -y cuda  

  ## Apply patch 2
  sudo dpkg -i cuda-repo-ubuntu1604-9-0-local-cublas-performance-update-2_1.0-1_amd64.deb
  sudo apt-get update  
  sudo apt-get upgrade -y cuda
  
  ## Apply path 3
  sudo dpkg -i cuda-repo-ubuntu1604-9-0-local-cublas-performance-update-3_1.0-1_amd64.deb
  sudo apt-get update
  sudo apt-get upgrade -y cuda
fi
