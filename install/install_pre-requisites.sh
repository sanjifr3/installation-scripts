#!/bin/bash
OS_V=${OS_VERSION:-18.04}

echo "Installing pre-requisites for Ubuntu $OS_V ..."
NO_SSL=""
if [ $OS_V == "18.04" ]; then
  NO_SSL="--no-check-certificate"
fi

# Get sublime text
if [ $OS_V != "aarch" ] && [ $OS_V != "18.04" ]; then 
  wget $NO_SSL -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
fi

#sudo add-apt-repository ppa:gnome-terminator

sudo apt-get update

PACKAGES=''
if [ $OS_V != "aarch" ] && [ $OS_V != "18.04" ]; then
  PACKAGES=(
    libsdl1.2-dev libsdl-image1.2-dev libsdl-mixer1.2-dev libsdl-ttf2.0-dev build-essential
    cmake git libgtk2.0-dev pkg-config openssh-server openssh-client libavcodec-dev 
    libavformat-dev libswscale-dev python-dev python-numpy libtbb2 libv4l-dev libtbb-dev
    libjpeg8-dev libpng12-dev libtiff4-dev libjasper-dev libatlas-base-dev gfortran 
    libdc1394-22-dev cloud-utils nautilus-open-terminal libapache2-mod-dnssd samba xclip
    python2.7-dev libhdf5-serial-dev libavcodec-dev libavformat-dev libswscale-dev libtiff5-dev
    make libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm 
    libncurses5-dev libncursesw5-dev xz-utils libxml2-dev pcl-tools libxslt-dev gparted 
    python-setuptools python-pip python-wstool terminator ncdu libproj-dev
  )
elif [ $OS_V == "18.04" ]; then
  PACKAGES=(
    libsdl1.2-dev libsdl-image1.2-dev libsdl-mixer1.2-dev libsdl-ttf2.0-dev build-essential
    cmake git libgtk2.0-dev pkg-config openssh-server openssh-client libavcodec-dev 
    libavformat-dev libswscale-dev python-dev python-numpy libtbb2 libv4l-dev libtbb-dev
    libjpeg8-dev libpng-dev libtiff5-dev libatlas-base-dev gfortran 
    libdc1394-22-dev cloud-utils libapache2-mod-dnssd samba xclip
    python2.7-dev libhdf5-serial-dev libavcodec-dev libavformat-dev libswscale-dev libtiff5-dev
    make libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm 
    libncurses5-dev libncursesw5-dev xz-utils libxml2-dev pcl-tools libxslt-dev gparted 
    python-setuptools python-pip python-wstool terminator ncdu libproj-dev
  )
else
  PACKAGES=(
    build-essential
    cmake git libgtk2.0-dev pkg-config openssh-server openssh-client libavcodec-dev 
    libavformat-dev libswscale-dev python-dev python-numpy libtbb2 libv4l-dev libtbb-dev
    libjpeg8-dev libpng12-dev libtiff4-dev libjasper-dev libatlas-base-dev gfortran 
    libdc1394-22-dev cloud-utils libapache2-mod-dnssd samba xclip
    python2.7-dev libhdf5-serial-dev libavcodec-dev libavformat-dev libswscale-dev libtiff5-dev
    make libssl-dev zlib1g-dev libbz2-dev libreadline-dev wget curl llvm 
    xz-utils libxml2-dev pcl-tools libxslt-dev gparted 
    python-setuptools python-pip python-wstool terminator ncdu libproj-dev
  )
fi

sudo apt-get install -y --upgrade ${PACKAGES[*]}
#for PKG in ${PACKAGES[*]}; do sudo apt-get install -y --upgrade $PKG ; done

if [ $OS_V == "18.04" ]; then
  sudo apt-get install -y --upgrade python3.7-dev
  sudo apt-get install -y --no-install-recommends thunar
elif [ $OS_V == "16.04" ]; then 
  sudo apt-get install -y --upgrade python3.5-dev sublime-text nautilus-actions
  sudo apt-get install -y --no-install-recommends thunar
elif [ $OS_V == "14.04" ]; then 
  sudo apt-get install -y --upgrade python3.4-dev nautilus-open-terminal sublime-text
  sudo apt-get install -y --no-install-recommends thunar
elif [ $OS_V == "aarch" ]; then
  sudo apt-get install -y --upgrade python3.5-dev
fi

HOSTNAME=`cat /proc/sys/kernel/hostname`

git config --global user.email "$LOGNAME@$HOSTNAME"
git config --global user.name "$LOGNAME"
