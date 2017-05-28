#!/bin/sh

#Add the package repository
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/debian xenial main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
sudo apt-get update

sudo apt-get install -y mono-complete
sudo apt-get install -y referenceassemblies-pcl
sudo apt-get install -y ca-certificates-mono
