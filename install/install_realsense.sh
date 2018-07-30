#!/bin/bash
VERSION=${REALSENSE_VERSION:-2.12.0}
WRAPPER_VERSION=${REALSENSE_ROS_VERSION:-2.0.3}
DIR=${PROGRAM_PATH:-$HOME/programs}
OS_V=${OS_VERSION:-16.04}

#if [ $OS_V == "aarch" ]; then
#  RS_SCRIPTS_PATH="$( cd "$(dirname "$0")" ; pwd -P )"

#  if [ -d $RS_SCRIPTS_PATH/realsense ]; then
#    RS_SCRIPTS_PATH=$RS_SCRIPTS_PATH/realsense
#  elif [ -d $RS_SCRIPTS_PATH/install/realsense ]; then
#    RS_SCRIPTS_PATH=$RS_SCRIPTS_PATH/install/realsense
#  fi
  #
  #cd $RS_SCRIPTS_PATH
  
  # Install drivers
  #./installLibrealsense.sh
  #cd /usr/local/bin
  #./realsense-viewer
  
  # Install ROS RealSense Package
  #./installRealSenseROS casper-vision
  
  #exit 0
  
#fi
#elif [ $OS_V != "16.04" ]; then
  # Add intel server to list of repos
#  echo 'deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo xenial main' | sudo tee /etc/apt/sources.list.d/realsense-public.list

  # Register the server's public key
#  sudo apt-key adv --keyserver hkp://keys.gnupg.net:80 --recv-key 6F3EFCDE

  # Refresh list of available repos and packages
#  sudo apt-get update

  # Install demos
#  sudo apt-get install librealsense2-dkms
#  sudo apt-get install librealsense2-utils

  # Install additional packages
#  sudo apt-get install librealsense2-dev
#  sudo apt-get install librealsense2-dbg
  # With dev package installed, you can compile an application with librealsense 
  #    using g++ -std=c++11 filename.cpp -lrealsense2 or an IDE of your choice.

  # Verify that the kernel is updated
#  modinfo uvcvideo | grep "version:" #should include realsense string

#  exit 0
#fi

cd $DIR
sudo rm -rf librealsense

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade

sudo apt-get install -y git libssl-dev libusb-1.0-0-dev pkg-config libgtk-3-dev
sudo apt-get install -y libglfw3-dev cmake build-essential
sudo apt-get install -y qtcreator cmake-curses-gui

# Pull git and checkout version
git clone https://github.com/IntelRealSense/librealsense
cd librealsense
git checkout tags/v${VERSION}
  
# Set udev rules for camera
sudo cp config/99-realsense-libusb.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && udevadm trigger

sudo chmod +x scripts/*.sh

if [ $OS_V == "16.04" ]; then
  ./scripts/patch-realsense-ubuntu-xenial-joule.sh
elif [ $OS_V == "aarch" ]; then
  ./scripts/patch-utils.sh.sh
fi

echo "hid_sensor_custom" | sudo tee -a /etc/modules
  
gedit CMakeLists.txt
# Add the following at row 22 of CMakeList.txt
#find_package (OpenCV 3.4.0 EXACT REQUIRED
#  NO_MODULE
#  PATHS /usr/local
#  NO_DEFAULT_PATH
#)
  
mkdir -p build
cd build

# Uninstall previous installation
sudo make uninstall
make clean

if [ $OS_V == "16.04" ]; then 
  cmake \
    -D CMAKE_BUILD_TYPE=release \
    ../ \
    -DBUILD_EXAMPLES=true \
    -DBUILD_CV_EXAMPLES=bool:true \
    -DBUILD_PYTHON_BINDINGS=bool:true \
    -DPYTHON_EXECUTABLE=/usr/bin/python2.7 \
    -DPYTHON_LIBS=/usr/lib/x86_64-linux-gnu/libpython2.7.so
elif [ $OS_V == "aaarch" ]; then
  cmake ../ -DBUILD_EXAMPLES=true
fi

make -j $(($(nproc) + 1))
sudo make install

if [ $OS_V != "aarch" ]; then
  sudo pip3 install pyrealsense2

  cd $DIR/librealsense
  mkdir -p data
  cd data
  wget -N http://realsense-hw-public.s3.amazonaws.com/rs-tests/TestData/object_detection.bag
  wget -N https://raw.githubusercontent.com/chuanqi305/MobileNet-SSD/master/MobileNetSSD_deploy.prototxt
  wget -N http://realsense-hw-public.s3.amazonaws.com/rs-tests/TestData/MobileNetSSD_deploy.caffemodel
fi

if [ $OS_V == "aarch" ]; then
  sudo sed -i '$s/$/ usbcore.autosuspend=-1/'  /boot/extlinux/extlinux.conf
  # /bin/ required for echo to work correctly in /bin/sh file
  /bin/echo -e "\e[1;32mPlease reboot for changes to take effect.\e[0m"
fi

# Install for ROS
#sudo apt-get install -y ros-kinetic-realsense-camera

# Clone ROS wrapper
#cd $DIR
#rm -rf realsense
#git clone https://github.com/intel-ros/realsense.git
#cd realsense
#git checkout tags/${WRAPPER_VERSION}
#cd ..
#cp -r realsense $HOME/casper-vision/src
#cd ~/casper-vision
#catkin_make
