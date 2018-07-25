#!/bin/bash
OS_V=${OS_VERSION:-16.04}

## Upgrade pip2
sudo pip2 install --upgrade pip

sudo pip2 install python-dateutil==2.7.0

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

sudo pip2 install -U ${PACKAGES[*]}
#for PKG in ${PACKAGES[*]}; do echo sudo pip2 install -U $PKG ; done

# Install face recognition
sudo pip2 install -U face_recognition
sudo pip2 install git+https://github.com/ageitgey/face_recognition_models

sudo pip2 install pyasn1==0.4.3
