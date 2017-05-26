#!/bin/sh

cd /home/ubuntu
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install libx11-dev -y
sudo rm -rf vscode
git clone https://github.com/microsoft/vscode
cd vscode
./scripts/npm.sh install --arch=arm64
