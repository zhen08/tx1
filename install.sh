#!/bin/sh

#General dependencies
sudo add-apt-repository universe
sudo apt-get update -y
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

#Link for caffe FP16 compilation
sudo ln -s /usr/lib/libsnappy.so.1 /usr/lib/libsnappy.so
sudo ldconfig

cd /usr/lib/aarch64-linux-gnu
sudo ln -s libhdf5_serial.so.10 libhdf5.so
sudo ln -s libhdf5_serial_hl.so.10 libhdf5_hl.so

#Build caffe FP16
export CAFFE_ROOT=/work_disk/caffe
rm -rf $CAFFE_ROOT
git clone -b experimental/fp16 https://github.com/NVIDIA/caffe $CAFFE_ROOT
cat $CAFFE_ROOT/python/requirements.txt | xargs -n1 sudo pip install

cd $CAFFE_ROOT
cp Makefile.config.example Makefile.config
sed -i 's/# NATIVE_FP16/NATIVE_FP16/g' Makefile.config
sed -i 's/# USE_CUDNN/USE_CUDNN/g' Makefile.config
sed -i 's/-gencode arch=compute_50,code=compute_50/-gencode arch=compute_53,code=sm_53 -gencode arch=compute_53,code=compute_53/g' Makefile.config
# Include the hdf5 directory for the includes; 16.04 has issues for some reason
echo "INCLUDE_DIRS += /usr/include/hdf5/serial/" >> Makefile.config
make -j4 all
make -j4 test
make -j4 runtest
make -j4 pycaffe

export PYTHONPATH=$CAFFE_ROOT/python:$PYTHONPATH

#Build Jetson Inference
export INFERENCE_ROOT=/work_disk/jetson-inference
rm -rf $INFERENCE_ROOT
git clone http://github.org/dusty-nv/jetson-inference $INFERENCE_ROOT
mkdir  $INFERENCE_ROOT/build
cd $INFERENCE_ROOT/build
cmake -DCUDA_USE_STATIC_CUDA_RUNTIME=OFF ../
cd $INFERENCE_ROOT/build
make -j4
