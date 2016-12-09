#!/bin/sh

cd /work_disk
git clone git://git.code.sf.net/p/emgucv/code emgucv 
cd emgucv
git submodule update --init --recursive
cd platforms/ubuntu/16.04
./apt_install_dependency
./cmake_configure
cd ../../..
make