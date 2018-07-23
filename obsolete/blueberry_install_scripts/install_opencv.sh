#!/bin/sh

cd ~/blueberry

# Install OpenCV 2.4.9
mkdir opencv
# The cmake command fixes the issue with ROS not being able to find the ocl package and nonfree packages for opencv 2.4.9 and higher
(cd opencv && wget http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.4.9/opencv-2.4.9.zip && unzip opencv-2.4.9.zip && cd opencv-2.4.9 && mkdir build && cd build && cmake -D CMAKE_BUILD_TYPE=RELEASE -D WITH_OPENCL=OFF -D CMAKE_INSTALL_PREFIX=/usr/local .. && make && sudo make install)
sudo sh -c 'echo "/usr/local/lib \n /usr/local/include" > /etc/ld.so.conf.d/opencv.conf' 
sudo ldconfig
