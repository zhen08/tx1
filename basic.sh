#!/bin/sh

#General dependencies
sudo add-apt-repository universe
sudo apt-get update -y

#remove libreoffice
sudo apt-get purge libreoffice*
sudo apt autoremove

#Install Chromium
sudo apt-get install chromium-browser -y

#Install cmake
sudo apt-get install cmake -y

sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev \
libhdf5-serial-dev protobuf-compiler -y
sudo apt-get install --no-install-recommends libboost-all-dev -y

#BLAS
sudo apt-get install libatlas-base-dev -y

sudo apt-get install libgflags-dev libgoogle-glog-dev liblmdb-dev -y
sudo apt-get install python-dev python-numpy -y
sudo apt-get install libqt4-dev qt4-dev-tools libglew-dev glew-utils \
libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libglib2.0-dev -y

sudo apt-get install libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev -y
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev -y
sudo apt-get install libxvidcore-dev libx264-dev -y
sudo apt-get install libgtk-3-dev -y
sudo apt-get install libopencv4tegra-python

sudo usermod -a -G video $USER

sudo apt-get install python-pip -y
sudo pip install --upgrade pip