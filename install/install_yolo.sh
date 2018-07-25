#!/bin/bash
DIR=${PROGRAM_PATH:-$HOME/programs}
OS_V=${OS_VERSION:-16.04}

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
if [ -d $SCRIPTPATH/yolo ]; then
  SCRIPTPATH=$SCRIPTPATH/yolo
elif [ -d $SCRIPTPATH/install/yolo ]; then
  SCRIPTPATH=$SCRIPTPATH/install/yolo
fi

echo "Installing YOLO in $DIR..."

cd $DIR

# Delete existing installation
#rm -rf darknet

# Clone repo
git clone https://github.com/sanjifr3/darknet.git

if [ $OS_V != "aarch" ]; then
  git clone https://github.com/pjreddie/darknet.git pj_darknet
fi

cd darknet
git pull

# Build library
make

# Make tools
cd tools/coco/PythonAPI
make

cd $DIR/darknet

# Make directories to store files
#mkdir -p weights/ conv/ backup/

# Download weights
cd weights
wget https://pjreddie.com/media/files/yolov3.weights
wget https://pjreddie.com/media/files/yolov3-tiny.weights
wget https://pjreddie.com/media/files/yolo9000.weights

if [ $OS_V != "aarch" ]; then
  wget https://pjreddie.com/media/files/yolo.weights
  wget https://pjreddie.com/media/files/yolo-voc.weights
  wget https://pjreddie.com/media/files/alexnet.weights
  wget https://pjreddie.com/media/files/yolov2-tiny.weights
  wget https://pjreddie.com/media/files/tiny-yolo.weights
  wget https://pjreddie.com/media/files/tiny-yolo-voc.weights

  cd ../conv
  wget https://pjreddie.com/media/files/darknet19_448.conv.23
  wget https://pjreddie.com/media/files/tiny-yolo-voc.conv.13
  wget https://pjreddie.com/media/files/darknet53.conv.74
fi

cd $SCRIPTPATH
cd ../..

# Add yolo to bashrc
#grep -q -F "export PYTHONPATH=$PYTHONPATH:$DIR/darknet/python" ~/.bashrc || echo "export PYTHONPATH=$PYTHONPATH:$DIR/darknet/python" >> ~/.bashrc
#source ~/.bashrc
