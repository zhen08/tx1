#!/bin/sh
cd /home/ubuntu
rm -rf opencv
git clone https://github.com/opencv/opencv.git
cd opencv
git checkout tags/3.2.0
mkdir build
cd build
cmake -DWITH_CUDA=ON -DCUDA_ARCH_BIN="5.3" -DCUDA_ARCH_PTX="" -DBUILD_TESTS=OFF -DBUILD_PERF_TESTS=OFF ..
sudo make -j4 install
echo "# Use OpenCV and other custom-built libraries." >> ~/.bashrc
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/" >> ~/.bashrc
source ~/.bashrc
