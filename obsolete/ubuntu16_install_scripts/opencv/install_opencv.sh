#!/bin/bash
VERSION=3.4.1
GPU=1

if [ "$#" -eq 1 ]; then
  VERSION=$1
elif [ "$#" -eq 2 ]; then
  VERSION=$1
  GPU=$2
fi

if [ $GPU -eq 1 ]; then 
  echo Installing OpenCV $VERSION w/ GPU support
else
  echo Installing OpenCV $VERSION w/o GPU support
fi

mkdir -p ~/programs/opencv
cd ~/programs/opencv

# Clone opencv repositories
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git

# Remove build folder
rm -rf opencv/release/

# Update opencv repos
cd opencv
git checkout master
git pull
git checkout -f tags/${VERSION}
cd ../opencv_contrib
git checkout master
git pull
git checkout -f tags/$VERSION

# Remake build folder
mkdir ../opencv/release
cd ../opencv/release

if [ $GPU -eq 1 ]; then
  cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D WITH_TBB=ON \
        -D BUILD_NEW_PYTHON_SUPPORT=ON \
        -D WITH_V4L=ON \
        -D INSTALL_C_EXAMPLES=ON \
        -D INSTALL_PYTHON_EXAMPLES=ON \
        -D OPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules \
        -D WITH_CUDA=ON \
        -D WITH_CUBLAS=ON \
        -D ENABLE_FAST_MATH=ON \
        -D CUDA_FAST_MATH=ON \
        -D ENABLE_NEON=ON \
        -D WITH_LIBV4L=ON \
        -D BUILD_TESTS=OFF \
        -D BUILD_PERF_TESTS=OFF \
        -D BUILD_EXAMPLES=OFF \
        -D WITH_QT=ON \
        -D WITH_OPENGL=ON \
        -D ENABLE_FAST_MATH=1 \
        -D CUDA_FAST_MATH=1 \
        -D BUILD_SHARED_LIB=ON ..
else
  cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D WITH_CUDA=ON \
        -D ENABLE_FAST_MATH=1 \
        -D CUDA_FAST_MATH=1 \
        -D WITH CUBLAS=1 \
        -D INSTALL_C_EXAMPLES=ON \
        -D INSTALL_PYTHON_EXAMPLES=ON \
        -D OPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules \
        -D BUILD_EXAMPLES=ON ..
fi

make -j8      
sudo make install
sudo ldconfig
sudo apt-get update
source ~/.bashrc
