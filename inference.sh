#!/bin/sh

#Build Jetson Inference
export INFERENCE_ROOT=/home/ubuntu/jetson-inference
rm -rf $INFERENCE_ROOT
git clone https://github.com/dusty-nv/jetson-inference.git $INFERENCE_ROOT
mkdir  $INFERENCE_ROOT/build
cd $INFERENCE_ROOT/build
cmake -DCUDA_USE_STATIC_CUDA_RUNTIME=OFF ../
cd $INFERENCE_ROOT/build
make -j4
