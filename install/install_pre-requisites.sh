#!/bin/bash
OS_V=${OS_VERSION:-16.04}

echo "Installing pre-requisites for Ubuntu $OS_V ..."

# Get sublime text
if [ $OS_V != "aarch" ]; then 
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
fi

sudo add-apt-repository ppa:gnome-terminator

sudo apt-get update

# Install ubuntu packages
for PKG in \
  libsdl1.2-dev \
  libsdl-image1.2-dev \
  libsdl-mixer1.2-dev \
  libsdl-ttf2.0-dev \
  build-essential \
  cmake \
  git \
  libgtk2.0-dev \
  pkg-config \
  openssh-server \
  openssh-client \
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
  cloud-utils \
  nautilus-open-terminal \
  libapache2-mod-dnssd \
  samba \
  xclip \
  python2.7-dev \
  libhdf5-serial-dev \
  libatlas-base-dev \
  gfortran \
  libavcodec-dev \
  libavformat-dev \
  libswscale-dev \
  libv4l-dev \
  libgtk2.0-dev \
  libjpeg8-dev \
  libtiff5-dev \
  libjasper-dev \
  libpng12-dev \
  make \
  build-essential \
  libssl-dev \
  zlib1g-dev \
  libbz2-dev \
  libreadline-dev \
  libsqlite3-dev \
  wget \
  curl \
  llvm \
  libncurses5-dev \
  libncursesw5-dev \
  xz-utils \
  libxml2-dev \
  pcl-tools \
  libxslt-dev \
  python-dev \
  gparted \
  python-setuptools \
  python-pip \
  python-wstool \
  terminator \
  libgflags-dev \
; do sudo apt-get install -y --upgrade $PKG ; done

# Install ubuntu packages w/o installation recommends
for PKG in \
  thunar \
; do sudo apt-get install -y --no-install-recommends $PKG ; done

if [ $OS_V == "16.04" ]; then 
  sudo apt-get install -y --upgrade python3.5-dev sublime-text nautilus-actions
elif [ $OS_V == "14.04" ]; then 
  sudo apt-get install -y --upgrade python3.4-dev nautilus-open-terminal sublime-text
elif [ $OS_V == "aarch" ]; then
  sudo apt-get install -y --upgrade python3.5-dev
fi

HOSTNAME=`cat /proc/sys/kernel/hostname`

git config --global user.email "$LOGNAME@$HOSTNAME"
git config --global user.name "$LOGNAME"
