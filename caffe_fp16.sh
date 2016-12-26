#!/bin/sh

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
