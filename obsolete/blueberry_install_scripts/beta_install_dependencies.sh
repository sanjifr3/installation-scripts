#!/bin/bash
## Install required programs
sudo apt-get install -y --force-yes \
                     libsdl1.2-dev \
                     libsdl-image1.2-dev \
                     libsdl-mixer1.2-dev \
                     libsdl-ttf2.0-dev \
                     ros-indigo-desktop-full \
                     ros-indigo-laser-scan-matcher \
                     ros-indigo-depthimage-to-laserscan \
                     ros-indigo-rtabmap \
                     ros-indigo-rtabmap-ros \
                     ros-indigo-tf2-bullet \
                     ros-indigo-freenect-launch \
                     ros-indigo-openni-launch \
                     ros-indigo-openni2-launch \
                     ros-indigo-move-base \
                     ros-indigo-dwa-local-planner \
                     ros-indigo-uvc-camera \
                     ros-indigo-libuvc-camera \
                     ros-indigo-map-server \
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
                     libtiff4-dev \
                     libjasper-dev \
                     libatlas-base-dev \
                     gfortran \
                     libdc1394-22-dev \
                     teamviewer \
                     cloud-utils \
                     nautilus-open-terminal \
                     xclip &&

## Download bunch of Python related files
sudo apt-get install -y --force-yes python2.7-dev python3.4-dev && 
sudo apt-get install -y --force-yes make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils &&
sudo apt-get install -y --force-yes libxml2-dev libxslt-dev python-dev python-setuptools python-pip &&
sudo apt-get install -y --force-yes libatlas-base-dev gfortran &&
sleep 10s &&

## Download pip
wget https://bootstrap.pypa.io/get-pip.py -O - | sudo python3 &&

## Download ez-setup
wget https://bootstrap.pypa.io/ez_setup.py -O - | sudo python3 &&

## Update pip2
pip2 install --upgrade pip &&
pip install --upgrade pip &&

## Update pip3
python3 -m pip install --upgrade pip &&

## Download Python 2 libraries
sudo pip2 install numpy --upgrade &&
sudo pip2 install -U pandas &&
sudo pip2 install -U lxml pygame twitter boto3 networkx watson-developer-cloud plotly cufflinks wolframalpha flask &&
sudo pip2 install -U matplotlib &&
sudo pip2 install -U seaborn scipy scikit-learn scikit-image && 

## Install dlib
sudo python ../../libraries/dlib-19.4/setup.py install --yes USE_AVX_INSTRUCTIONS &&
cd ~/blueberry/libraries/dlib-19.4/ &&
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
sudo pip3 install -U lxml pandas boto3 pygame twitter networkx matplotlib watson-developer-cloud plotly cufflinks wolframalpha flask jupyter &&
sudo pip3 install -U seaborn scipy scikit-learn scikit-image &&

## Install open_face
sudo apt-get install -y --force-yes docker &&
cd ~ &&
sudo curl -sSL https://get.docker.com/ | sh &&
sudo usermod -aG docker $USER &&
#sudo groupadd docker &&
sudo gpasswd -a $USER docker &&
sudo service docker restart &&
sudo docker pull bamos/openface &&
#sudo docker run -p 9000:9000 -p 8000:8000 -t -i bamos/openface /bin/bash &&
cd ~/blueberry/libraries/openface &&
sudo python2 setup.py install &&
sleep 10s &&

## Install torch
cd ~ &&
sudo rm -rf ~/torch &&
git clone https://github.com/torch/distro.git ~/torch --recursive &&
cd ~/torch &&
bash install-deps &&
./install.sh
