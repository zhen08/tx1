#!/bin/sh

#Build Jetson Inference
export INFERENCE_ROOT=~/jetson-inference
rm -rf $INFERENCE_ROOT
git clone http://github.org/dusty-nv/jetson-inference $INFERENCE_ROOT
mkdir  $INFERENCE_ROOT/build
cd $INFERENCE_ROOT/build
cmake -DCUDA_USE_STATIC_CUDA_RUNTIME=OFF ../
cd $INFERENCE_ROOT/build
make -j4
