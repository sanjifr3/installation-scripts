#!/bin/bash
DIR=${PROGRAM_PATH:-$HOME/programs}

#FIXED_FILES_PATH=$PWD/`dirname "$0"`/yolo
FIXED_FILES_PATH=$HOME/casper-vision/scripts/install/yolo

echo "Installing YOLO in $DIR..."

cd $DIR

# Delete existing installation
#rm -rf darknet

# Clone repo
git clone https://github.com/pjreddie/darknet.git pj_darknet
git clone https://github.com/sanjifr3/darknet.git

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
wget https://pjreddie.com/media/files/yolo.weights
wget https://pjreddie.com/media/files/yolov3.weights
wget https://pjreddie.com/media/files/yolo-voc.weights
wget https://pjreddie.com/media/files/alexnet.weights
wget https://pjreddie.com/media/files/yolov2-tiny.weights
wget https://pjreddie.com/media/files/tiny-yolo.weights
wget https://pjreddie.com/media/files/tiny-yolo-voc.weights
wget https://pjreddie.com/media/files/yolo9000.weights

# Download conv
cd ../conv
wget https://pjreddie.com/media/files/darknet19_448.conv.23
wget https://pjreddie.com/media/files/tiny-yolo-voc.conv.13
wget https://pjreddie.com/media/files/darknet53.conv.74

cd $FIXED_FILES_PATH
cd ../..

# Add yolo to bashrc
#grep -q -F "export PYTHONPATH=$PYTHONPATH:$DIR/darknet/python" ~/.bashrc || echo "export PYTHONPATH=$PYTHONPATH:$DIR/darknet/python" >> ~/.bashrc
#source ~/.bashrc
