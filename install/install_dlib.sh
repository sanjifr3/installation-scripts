#!/bin/bash
VERSION=${DLIB_VERSION:-19.9}
DIR=${PROGRAM_PATH:-$HOME/programs}
GPU=${USE_GPU:-1}
PY2=${INSTALL_PY2:-1}
PY3=${INSTALL_PY3:-1}

echo "Installing DLIB $VERSION in $DIR..."

# Change directory
cd $DIR

# Remove existing installation
sudo rm -rf dlib

# Clone repo
git clone https://github.com/davisking/dlib.git

cd dlib
git checkout master
git pull
git checkout tags/v$VERSION

# Install python libraries
if [ $PY2 -eq 1 ]; then sudo python2 setup.py install --force --yes USE_AVX_INSTRUCTIONS; fi
if [ $PY3 -eq 1 ]; then sudo python3 setup.py install --force --yes USE_AVX_INSTRUCTIONS; fi

# Install C++ libraries
mkdir -p release
cd release
if [ $GPU -eq 1 ]; then 
  cmake .. -DUSE_AVX_INSTRUCTIONS=1 -DDLIB_USE_CUDA=1
else 
  cmake .. -DUSE_AVX_INSTRUCTIONS=1
fi

cmake --build .
sudo make install

# Get models
cd $DIR/dlib
mkdir -p models
cd models

wget http://dlib.net/files/shape_predictor_5_face_landmarks.dat.bz2
wget http://dlib.net/files/shape_predictor_68_face_landmarks.dat.bz2
wget http://dlib.net/files/mmod_human_face_detector.dat.bz2
wget http://dlib.net/files/dlib_face_recognition_resnet_model_v1.dat.bz2
wget http://dlib.net/files/resnet34_1000_imagenet_classifier.dnn.bz2

bzip2 -d shape_predictor_5_face_landmarks.dat.bz2
bzip2 -d shape_predictor_68_face_landmarks.dat.bz2
bzip2 -d mmod_human_face_detector.dat.bz2
bzip2 -d dlib_face_recognition_resnet_model_v1.dat.bz2
bzip2 -d resnet34_1000_imagenet_classifier.dnn.bz2
