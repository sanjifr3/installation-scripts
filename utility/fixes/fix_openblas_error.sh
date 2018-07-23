#!/bin/bash
# Fix openBlas error

sudo apt-get install libopenblas-dev liblapack3 liblapack-dev &&
sudo cp openblas.conf /etc/ld.so.conf.d/ &&
sudo ldconfig
