#!/usr/bin/env bash

# Install suckless utilties

mkdir ~/gits/

cd ~/gits
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/dmenu
git clone https://git.suckless.org/st
git clone https://git.suckless.org/surf

cd ~/gits/dwm/
make clean
sudo make install

cd ~/gits/dmenu/
make clean
sudo make install

cd ~/gits/st/
make clean
sudo make install

cd ~/gits/surf/
make clean
sudo make install

