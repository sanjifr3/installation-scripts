#!/bin/bash
DIR=${PROGRAM_PATH:-$HOME/programs}
CHANNELS=${RESPEAKER_CHANNELS:-6}

# http://wiki.seeedstudio.com/ReSpeaker_Mic_Array_v2.0/

./install_nodejs.sh

cd $DIR
git clone https://github.com/respeaker/usb_4_mic_array.git respeaker
sudo apt-get update
sudo apt-get install -y portaudio19-dev swig
sudo apt-get install -y libfftw3-dev libconfig-dev libasound2-dev
sudo apt-get install -y nodejs-dev npm
sudo apt-get update
sudo apt-get upgrade
sudo pip2 install -U pyusb click pyaudio webrtcvad SpeechRecognition
sudo pip3 install -U pyusb click pyaudio webrtcvad SpeechRecognition
cd respeaker
if [ $CHANNELS -eq 6 ]; then
  sudo python2 dfu.py --download ${CHANNELS}_channels_firmware.bin
else
  sudo python2 dfu.py --dowwnload ${CHANNELS}_channel_firmware.bin
fi

git clone https://github.com/respeaker/pixel_ring.git
cd pixel_ring
sudo python setup.py install

roscd respeaker_ros
cd ../..
rosdep install --from-paths src -i -r -n -y
catkin_make
source devel/setup.bash

roscd respeaker_ros
sudo cp -f $(rospack find respeaker_ros)/config/60-respeaker.rules /etc/udev/rules.d/60-respeaker.rules
sudo systemctl restart udev

sudo pip install -r requirements.txt

sudo apt-get install ros-kinetic-ros-speech-recognition

cd $DIR

wget https://github.com/introlab/odas_web/releases/download/v0.1-alpha/Linux_x64.tar.gz
tar xvzf Linux_x64.tar.gz
mv ODAS\ Studio-linux-x64 odas_web_v1
rm Linux_x64.tar.gz

wget https://github.com/introlab/odas_web/archive/v0.2-alpha.tar.gz
tar xvzf v0.2-alpha.tar.gz 
mv odas_web-0.2-alpha odas_web_v2
rm v0.2-alpha.tar.gz
cd odas_web_v2
npm install

cd ..
git clone https://github.com/introlab/odas.git
mkdir odas/build
cd odas/build
cmake ..
make
#sudo make install

cd ../../odas_web_v2
npm start
