#!/bin/bash
VERSION=${OPENCV_VERSION:-3.4.0}
DIR=${PROGRAM_PATH:-$HOME/programs}
GPU=${USE_GPU:-1}
OS_V=${OS_VERSION:-16.04}

if [ $GPU -eq 1 ]; then 
  echo "Installing OpenCV $VERSION w/ GPU support in $DIR..."
else
  echo "Installing OpenCV $VERSION w/o GPU support in $DIR..."
fi

sudo apt-get install -y \
    libglew-dev \
    libtiff5-dev \
    zlib1g-dev \
    libjpeg-dev \
    libpng12-dev \
    libjasper-dev \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libpostproc-dev \
    libswscale-dev \
    libeigen3-dev \
    libtbb-dev \
    libgtk2.0-dev \
    cmake \
    pkg-config
    
# Python 2.7
sudo apt-get install -y python-dev python-numpy python-py python-pytest -y
# GStreamer support
sudo apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev     

cd $DIR
rm -rf opencv$VERSION
mkdir -p opencv$VERSION
cd opencv$VERSION

# Clone opencv repositories
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git
#git clone https://github.com/opencv/opencv_extra.git

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

if [ $OS_V == "aarch" ]; then
  echo "Configuring OpenCV $VERSION w/ GPU support for the aarch architecture"
  sleep 2
  cmake \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D BUILD_PNG=OFF \
    -D BUILD_TIFF=OFF \
    -D BUILD_TBB=OFF \
    -D BUILD_JPEG=OFF \
    -D BUILD_JASPER=OFF \
    -D BUILD_ZLIB=OFF \
    -D BUILD_EXAMPLES=OFF \
    -D BUILD_opencv_java=OFF \
    -D BUILD_opencv_python2=ON \
    -D BUILD_opencv_python3=OFF \
    -D ENABLE_PRECOMPILED_HEADERS=OFF \
    -D WITH_OPENCL=OFF \
    -D WITH_OPENMP=OFF \
    -D WITH_FFMPEG=ON \
    -D WITH_GSTREAMER=ON \
    -D WITH_GSTREAMER_0_10=OFF \
    -D WITH_CUDA=ON \
    -D WITH_GTK=ON \
    -D WITH_VTK=OFF \
    -D WITH_TBB=ON \
    -D WITH_1394=OFF \
    -D WITH_OPENEXR=OFF \
    -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda \
    -D CUDA_ARCH_BIN=6.2 \
    -D CUDA_ARCH_PTX="" \
    -D INSTALL_C_EXAMPLES=OFF \
    -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
    ../
#    -D INSTALL_TESTS=ON \
#    -D OPENCV_TEST_DATA_PATH=../../opencv_extra/testdata \
elif [ $GPU -eq 1 ]; then
  echo "Configuring OpenCV $VERSION w/ GPU support for the x86_64 architecture"
  cmake \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D BUILD_PNG=OFF \
    -D BUILD_TIFF=OFF \
    -D BUILD_TBB=OFF \
    -D BUILD_JPEG=OFF \
    -D BUILD_JASPER=OFF \
    -D BUILD_ZLIB=OFF \
    -D BUILD_EXAMPLES=OFF \
    -D BUILD_opencv_java=OFF \
    -D BUILD_opencv_python2=ON \
    -D BUILD_opencv_python3=ON \
    -D ENABLE_PRECOMPILED_HEADERS=OFF \
    -D WITH_OPENCL=OFF \
    -D WITH_OPENMP=OFF \
    -D WITH_FFMPEG=ON \
    -D WITH_GSTREAMER=ON \
    -D WITH_GSTREAMER_0_10=OFF \
    -D WITH_CUDA=ON \
    -D WITH_GTK=ON \
    -D WITH_VTK=OFF \
    -D WITH_TBB=ON \
    -D WITH_1394=OFF \
    -D WITH_OPENEXR=OFF \
    -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda \
    -D INSTALL_C_EXAMPLES=OFF \
    -D INSTALL_TESTS=ON \
    -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
    -D WITH_TBB=ON \
    -D BUILD_NEW_PYTHON_SUPPORT=ON \
    -D WITH_V4L=ON \
    -D BUILD_EXAMPLES=OFF \
    -D INSTALL_C_EXAMPLES=OFF \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D BUILD_opencv_python2=ON \
    -D BUILD_opencv_python3=ON \
    -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
    -D WITH_QT=ON \
    -D WITH_CUBLAS=ON \
    -D WITH_OPENGL=ON \
    -D CUDA_FAST_MATH=ON \
    ../
#    -D CUDA_NVCC_FLAGS="-D_FORCE_INLINES --expt-relaxed-constexpr" \
#    -D OPENCV_TEST_DATA_PATH=../../opencv_extra/testdata \
else
  echo "Configuring OpenCV $VERSION w/o GPU support for the x86_64 architecture"
  cmake \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_C_EXAMPLES=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
    -D BUILD_EXAMPLES=ON \
    -D WITH_CUDA=OFF \
    -D WITH_CUBLAS=OFF \
    ../
#    -D OPENCV_TEST_DATA_PATH=../../opencv_extra/testdata \    
fi

#echo ADD cuda to following line: 'ocv_target_link_libraries(${tgt} ${OPENCV_LINKER_LIBS} ${OPENCV_CUDA_SAMPLES_REQUIRED_DEPS} cuda)'
#gedit ../samples/gpu/CMakeLists.txt
#read -p "Press enter to continue"

#make clean
make -j $(($(nproc) + 1))

sudo make install
sudo ldconfig
sudo apt-get update

source ~/.bashrc
