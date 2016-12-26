#!/bin/sh

cd /work_disk
get http://node-arm.herokuapp.com/node_latest_armhf.deb
sudo dpkg -i node_latest_armhf.deb
sudo apt-get install libx11-dev -y
sudo rm -rf vscode
git clone https://github.com/microsoft/vscode
cd vscode
./scripts/npm.sh install --arch=arm64
