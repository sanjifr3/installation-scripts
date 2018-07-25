#!/bin/bash
OS_V=${OS_VERSION:-16.04}

## Download pip
wget https://bootstrap.pypa.io/get-pip.py -O - | sudo python3 &&

## Download ez-setup
wget https://bootstrap.pypa.io/ez_setup.py -O - | sudo python3 &&

## Upgrade pip3 
sudo pip3 install --upgrade pip

sudo pip3 install python-dateutil==2.7.0

PACKAGES=''
if [ $OS_V != "aarch" ]; then
  PACKAGES=(
    numpy pandas testresources matplotlib seaborn
    scipy scikit-learn sklearn scikit-image lxml
    imutils pygame numexpr twitter nltk boto3 
    networkx watson-developer-cloud plotly 
    cufflinks wolframalpha flask imblearn xgboost 
    jupyter ipython spyder Cython h5py hyperas
  )
else
  PACKAGES=(
    numpy pandas testresources matplotlib seaborn
    scipy scikit-learn sklearn scikit-image lxml
    imutils boto3 watson-developer-cloud plotly 
    cufflinks imblearn xgboost h5py hyperas Cython
  )
fi

## Install Python3 packages
sudo pip2 install -U ${PACKAGES[*]}
#for PKG in ${PACKAGES[*]}; do echo sudo pip2 install -U $PKG ; done

# remove setuptool installation file
SCRIPTS_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
sudo rm $SCRIPTS_PATH/setuptools*
sudo rm $SCRIPTS_PATH/install/setuptools*

sudo pip3 install pyasn1==0.4.3
