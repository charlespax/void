#!/usr/bin/env bash

# Install suckless utilties

GIT_FOLDER=$HOME/gits    # Modify this to your needs

echo "cloning to $GIT_FOLDER"
mkdir -p $GIT_FOLDER

#TODO make my own git repositories for suckless tools
cd $GIT_FOLDER

# dwm -- Window Manager
git clone https://git.suckless.org/dwm
cd $GIT_FOLDER/dwm/
make clean
make
sudo make install

# dmenu -- Application Launcher
git clone https://git.suckless.org/dmenu
cd $GIT_FOLDER/dmenu/
make clean
make
sudo make install

# slock -- Display Locker
git clone https://git.suckless.org/slock
cd $GIT_FOLDER/slock/
make clean
make
sudo make install

# wt -- Terminal Emulator
git clone https://git.suckless.org/st
cd $GIT_FOLDER/st/
make clean
make
sudo make install

# surf -- Web Browser
#git clone https://git.suckless.org/surf
#cd $GIT_FOLDER/surf/
#make clean
#make
#sudo make install



