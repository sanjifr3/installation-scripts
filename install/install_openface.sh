#!/bin/bash
VERSION=${OPENFACE_VERSION:-0.2.1}
DIR=${PROGRAM_PATH:-$HOME/programs}
PY2=${INSTALL_PY2:-1}
PY3=${INSTALL_PY3:-1}

echo "Installing OpenFace $VERSION in $DIR..."

# Change directory
cd $DIR

# Remove existing installation path
#sudo rm -rf openface

# Pull from git
git clone https://github.com/cmusatyalab/openface.git
cd openface
git pull
#git checkout tags/${VERSION}

# Install openface python libraries
if [ $PY2 -eq 1 ]; then sudo python2 setup.py install; fi
if [ $PY3 -eq 1 ]; then sudo python3 setup.py install; fi
