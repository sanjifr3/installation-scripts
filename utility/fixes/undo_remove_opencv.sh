#!/bin/bash
# Removes opencv from your system

VERSION=3.3.1

DIR=opt/ros/kinetic/lib
#sudo mv ~/opencv${VERSION}/${DIR}/libopencv* /$DIR/
sudo mv ~/opencv${VERSION}/${DIR}/python2.7/dist-packages/cv2.so  /$DIR/python2.7/dist-packages/

DIR=usr/lib
sudo mv ~/opencv${VERSION}/${DIR}/libopencv*  /$DIR/
sudo mv ~/opencv${VERSION}/${DIR}/python2.7/dist-packages/cv2.so /$DIR/python2.7/dist-packages/
