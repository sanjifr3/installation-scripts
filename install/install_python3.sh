#!/bin/bash
OS_V=${OS_VERSION:-18.04}

NO_SSL=""
PIP_NO_SSL=""
PIP_NO_SSL_SUF=""
if [ $OS_V == "18.04" ]; then
  NO_SSL="--no-check-certificate"
  PIP_NO_SSL="--trusted-host files.pythonhosted.org --trusted-host pypi.org --trusted-host pypi.python.org"
  PIP_NO_SSL_SUF="-vvv"
fi

## Download pip
if [ $OS_V != "18.04" ]; then
  ## Download pip  
  wget $NO_SSL https://bootstrap.pypa.io/get-pip.py -O - | sudo python3 &&
  ## Download ez-setup
  wget $NO_SSL https://bootstrap.pypa.io/ez_setup.py -O - | sudo python3 &&

  sudo pip3 install --upgrade pip
  sudo pip3 install virtualenv
else # 18.04
  sudo apt-get install python3-pip python3-virtualenv python3-venv
fi

if [ $OS_V != "18.04" ]; then 
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
  sudo pip3 install -U ${PACKAGES[*]}
  #for PKG in ${PACKAGES[*]}; do echo sudo pip2 install -U $PKG ; done

  # remove setuptool installation file
  SCRIPTS_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
  sudo rm $SCRIPTS_PATH/setuptools*
  sudo rm $SCRIPTS_PATH/install/setuptools*

  sudo pip3 install pyasn1==0.4.3
fi
