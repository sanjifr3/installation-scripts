#!/bin/bash
# Removes opencv from your system

VERSION=3.3.1

DIR=opt/ros/kinetic/lib

mkdir -p ~/opencv${VERSION}/${DIR}/python2.7/dist-packages

#sudo mv /$DIR/libopencv* ~/opencv${VERSION}/${DIR}/
sudo mv /$DIR/python2.7/dist-packages/cv2.so ~/opencv${VERSION}/${DIR}/python2.7/dist-packages/


DIR=usr/lib
mkdir -p ~/opencv${VERSION}/${DIR}/python2.7/dist-packages

sudo mv /$DIR/libopencv* ~/opencv${VERSION}/${DIR}/
sudo mv /$DIR/python2.7/dist-packages/cv2.so ~/opencv${VERSION}/${DIR}/python2.7/dist-packages/
