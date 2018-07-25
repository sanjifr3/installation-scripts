#!/bin/bash

## Download pip
wget https://bootstrap.pypa.io/get-pip.py -O - | sudo python3 &&

## Download ez-setup
wget https://bootstrap.pypa.io/ez_setup.py -O - | sudo python3 &&

## Upgrade pip3 
sudo pip3 install --upgrade pip

sudo pip3 install python-dateutil==2.7.0

## Install Python3 packages
for PKG in \
  numpy \
  pandas \
  testresources \
  matplotlib \
  seaborn \
  scipy \
  scikit-learn \
  sklearn \
  scikit-image \
  lxml \
  imutils \
  pygame \
  numexpr \
  twitter \
  nltk \
  boto3 \
  networkx \
  watson-developer-cloud \
  plotly \
  cufflinks \
  wolframalpha \
  flask \
  imblearn \
  xgboost \
  jupyter \
  ipython \
  spyder \
  Cython \
  h5py \
  hyperas \
; do sudo pip3 install -U $PKG ; done

# remove setuptool installation file
sudo rm `dirname "$0"`/../setuptools*
sudo rm setuptools*

sudo pip3 install pyasn1==0.4.3
