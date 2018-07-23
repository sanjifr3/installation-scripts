#!/bin/bash

## Upgrade pip2
sudo pip2 install --upgrade pip

sudo pip2 install python-dateutil==2.7.0

## Install Python2 packages
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
; do sudo pip2 install -U $PKG ; done

# Install face recognition
sudo pip2 install -U face_recognition
sudo pip2 install git+https://github.com/ageitgey/face_recognition_models

sudo pip2 install pyasn1==0.4.3
