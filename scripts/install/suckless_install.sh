#!/usr/bin/env bash

# Install suckless utilties

mkdir -p ~/gits/

#TODO make my own git repositories for suckless tools
cd ~/gits
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/dmenu
git clone https://git.suckless.org/st
#git clone https://git.suckless.org/surf

cd ~/gits/dwm/
make clean
make
sudo make install

cd ~/gits/dmenu/
make clean
make
sudo make install

cd ~/gits/st/
make clean
make
sudo make install

#cd ~/gits/surf/
#make clean
#make
#sudo make install



