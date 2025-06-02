#!/usr/bin/env bash

# Install suckless utilties

GIT_FOLDER=$HOME/gits    # Modify this to your needs

echo "cloning to $GIT_FOLDER"
mkdir -p $GIT_FOLDER

#TODO make my own git repositories for suckless tools
cd $GIT_FOLDER
echo "current location: `pwd`"

git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/dmenu
git clone https://git.suckless.org/st
#git clone https://git.suckless.org/surf

cd $GIT_FOLDER/dwm/
make clean
make
sudo make install

cd $GIT_FOLDER/dmenu/
make clean
make
sudo make install

cd $GIT_FOLDER/st/
make clean
make
sudo make install

#cd $GIT_FOLDER/surf/
#make clean
#make
#sudo make install



