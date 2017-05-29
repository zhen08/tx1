#!/bin/sh

cd ..
rm -rf emgucv
git clone https://github.com/emgucv/emgucv.git 
cd emgucv
git checkout tags/3.2.0
git submodule update --init --recursive
cd platforms/ubuntu/16.04
./apt_install_dependency.sh
./cmake_configure.sh
cd ../../..
make -j4
