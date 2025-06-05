#!/usr/bin/env bash

# Install suckless utilties

# TODO in suckless_install.sh, use the GIT_DIRECTORY environment variable
# TODO in suckless_install.sh, prompt user for GIT_DIRECTORY is none is set
# TODO in suckless_install.sh, behave nicely if a git repo already exists

GIT_FOLDER=$HOME/gits    # Modify this to your needs

echo "cloning to $GIT_FOLDER"
mkdir -p $GIT_FOLDER

#TODO make my own git repositories for suckless tools
cd $GIT_FOLDER

# dwm -- Window Manager
cd $GIT_FOLDER
git clone https://git.suckless.org/dwm
make clean
make
sudo make install

# dmenu -- Application Launcher
cd $GIT_FOLDER
git clone https://git.suckless.org/dmenu
make clean
make
sudo make install

# slock -- Display Locker
cd $GIT_FOLDER
git clone https://git.suckless.org/slock
make clean
make
sudo make install

# wt -- Terminal Emulator
cd $GIT_FOLDER
git clone https://git.suckless.org/st
make clean
make
sudo make install

# surf -- Web Browser
cd $GIT_FOLDER
git clone https://git.suckless.org/surf
make clean
make
sudo make install



