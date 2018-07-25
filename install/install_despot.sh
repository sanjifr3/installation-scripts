#!/bin/bash
DIR=${PROGRAM_PATH:-$HOME/programs}

cd $DIR

rm -rf despot
git clone https://github.com/AdaCompNUS/despot.git
cd despot
mkdir release
cd release
cmake ..
make
sudo make install
