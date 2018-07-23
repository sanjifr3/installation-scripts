#!/bin/bash

DLIB_VERSION=19.9

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install -y \
                     libsdl1.2-dev \
                     libsdl-image1.2-dev \
                     libsdl-mixer1.2-dev \
                     libsdl-ttf2.0-dev \
                     ros-kinetic-rqt-image-view \
                     ros-kinetic-laser-scan-matcher \
                     ros-kinetic-depthimage-to-laserscan \
                     ros-kinetic-rtabmap \
                     ros-kinetic-rtabmap-ros \
                     ros-kinetic-tf2-bullet \
                     ros-kinetic-freenect-launch \
                     ros-kinetic-openni-launch \
                     ros-kinetic-openni2-launch \
                     ros-kinetic-move-base \
                     ros-kinetic-dwa-local-planner \
                     ros-kinetic-uvc-camera \
                     ros-kinetic-libuvc-camera \
                     ros-kinetic-map-server \
                     build-essential \
                     cmake \
                     git \
                     libgtk2.0-dev \
                     pkg-config \
                     libavcodec-dev \
                     libavformat-dev \
                     libswscale-dev \
                     python-dev \
                     python-numpy \
                     libtbb2 \
                     libv4l-dev \
                     libtbb-dev \
                     libjpeg8-dev \
                     libpng12-dev \
                     libtiff5-dev \
                     libjasper-dev \
                     libatlas-base-dev \
                     gfortran \
                     libdc1394-22-dev \
                     cloud-utils \
                     libapache2-mod-dnssd \
                     samba \
                     xclip &&
sudo apt-get install --no-install-recommends thunar &&
sudo apt-get install -y python2.7-dev libhdf5-serial-dev libatlas-base-dev gfortran libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libgtk2.0-dev libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev &&

sudo apt-get install python-rosinstall python-rosinstall-generator python-wstool build-essential

# echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc

## Download bunch of Python related files
sudo apt-get install -y python2.7-dev python3.5-dev && 
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils &&
sudo apt-get install -y libxml2-dev libxslt-dev python-dev python-setuptools python-pip &&
sudo apt-get install -y libatlas-base-dev gfortran python3-pip &&
sleep 10s &&

## Download pip
wget https://bootstrap.pypa.io/get-pip.py -O - | sudo python3 &&

## Download ez-setup
wget https://bootstrap.pypa.io/ez_setup.py -O - | sudo python3 &&

## Update pip2
sudo pip2 install --upgrade pip &&
sudo pip3 install --upgrade pip &&

## Update pip3
sudo python3 -m pip install --upgrade pip &&

## Download Python 2 libraries
sudo pip2 install numpy --upgrade &&
sudo pip2 install -U pandas &&
sudo pip2 install -U lxml imutils numexpr twitter nltk boto3 networkx watson-developer-cloud plotly cufflinks wolframalpha flask &&
sudo pip2 install -U matplotlib keras &&
sudo pip2 install -U seaborn scipy scikit-learn scikit-image sklearn imblearn && 
sudo pip2 install jupyter ipython spyder &&
# sudo pip2 install -U pygame xgboost

# pip install numpy pandas lxml imutils pygame numexpr twitter nltk boto3 networkx watson-developer-cloud plotly cufflinks wolframalpha flask matplotlib seaborn scipy scikit-learn scikit-image jupyter ipython spyder sklearn imblearn --upgrade
# python3 -m pip install numpy pandas lxml imutils pygame numexpr twitter nltk boto3 networkx watson-developer-cloud plotly cufflinks wolframalpha flask matplotlib seaborn scipy scikit-learn sklearn jupyter ipython spyder imblearn --upgrade

## Install dlib
sudo python ../../libraries/dlib-${DLIB_VERSION}/setup.py install --yes USE_AVX_INSTRUCTIONS &&
cd ../../libraries/dlib-${DLIB_VERSION}/ &&
mkdir -p build &&
cd build &&
cmake .. -DUSE_AVX_INSTRUCTIONS=1 &&
cmake --build . &&
sleep 30s &&

## Install face_recognition
sudo pip2 install face_recognition &&
sudo pip2 install git+https://github.com/ageitgey/face_recognition_models &&
sleep 10s &&

## Download Python 3 libraries
sudo pip3 install numpy --upgrade &&
sudo pip3 install -U lxml imutils pandas numexpr boto3 nltk twitter networkx matplotlib watson-developer-cloud plotly cufflinks wolframalpha flask jupyter &&
sudo pip3 install -U seaborn scipy keras 
sudo pip3 install -U scikit-learn scikit-image sklearn imblearn &&
sudo pip3 install jupyter ipython spyder &&
# sudo pip3 install -U pygame xgboost

## Install open_face
## sudo apt-get install docker &&
## cd ~ &&
## sudo curl -sSL https://get.docker.com/ | sh &&
## sudo usermod -aG docker $USER &&
#sudo groupadd docker &&
## sudo gpasswd -a $USER docker &&
## sudo service docker restart &&
## sudo docker pull bamos/openface &&
#sudo docker run -p 9000:9000 -p 8000:8000 -t -i bamos/openface /bin/bash &&
cd ~/casper-vision/libraries/openface &&
sudo python2 setup.py install

# Install sublime
#wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
#sudo apt-get install apt-transport-https
#echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
#sudo apt-get update
#sudo apt-get install sublime-text

