#!/bin/bash
VERSION=${ASTRA_VERSION:-5.0.0}
DIR=${PROGRAM_PATH:-$HOME/programs}
OS_V=${OS_VERSION:-16.04}

GITHUB=0

sudo apt-get install ros-kinetic-astra-launch ros-kinetic-astra-camera &
sudo apt-get install protobuf-compiler libprotobuf-dev libsfml-dev

if [ $OS_V != "aarch" ]; then 
  sudo apt-get install clisp-dev
fi

mkdir -p $DIR/astra
cd $DIR/astra

if [ $GITHUB -eq 1 ]; then
  git clone --recursive https://github.com/orbbec/astra
  cd astra
  git submodule update --init --recursive
  mkdir build
  cd build
  cmake ..
  make
else
  # Download Drivers and SDK
  wget http://dl.orbbec3d.com/dist/openni2/OpenNI_2.3.0.43.zip
  wget http://dl.orbbec3d.com/dist/astra/v2.0.9-beta3/AstraSDK-v2.0.9-beta3-427db81acc-20180402T220618Z-Ubuntu1604.tar.gz
  
  # Extract
  unzip OpenNI_2.3.0.43.zip
  tar -xvzf AstraSDK-v2.0.9-beta3-427db81acc-20180402T220618Z-Ubuntu1604.tar.gz 
  
  FILE=OpenNI-Linux-x86-2.3.zip
  FOLDER=linux-x86
  if [ $OS_V == "aarch" ]; then 
    FILE=OpenNI-Linux-Arm64-2.3
    FOLDER=linux-arm64
  fi
  
  mv Linux/$FILE .
  mv ExtendedAPI/OpenNI-Extension-2.3.0.43.zip .
  unzip $FILE
  unzip OpenNI-Extension-2.3.0.43.zip
   
  mv OpenNI-Extension-2.3.0.43/OpenNI-Extension/$FOLDER/ExtendedAPI OpenNI-Linux-x86-2.3/

  # Remove unnecessary folders
  rm -rf *.zip *.tar.gz
  rm -rf Windows Android Linux ExtendedAPI OpenNI-Extension-2.3.0.43

  # Rename
  mv AstraSDK-v2.0.9-beta3-427db81acc-20180402T220618Z-Linux AstraSDK
  
  sudo chmod +x OpenNI-Linux-x86-2.3/install.sh AstraSDK/install/install.sh
  
  # Install driver
  sudo ./OpenNI-Linux-x86-2.3/install.sh
  
  # install SDK
  sudo ./AstraSDK/install/install.sh
fi
