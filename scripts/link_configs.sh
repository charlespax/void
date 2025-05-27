#!/usr/bin/env bash

# This script creates links for the dotfiles contained within this
# Github repository.

mkdir -p ~/.config
mkdir -p ~/.local

PWD=`pwd`

# terminal
ln -i -s $PWD/../configs/bash_login ~/.bash_login
ln -i -s $PWD/../configs/bash_login ~/.bash_profile
ln -i -s $PWD/../configs/bash_logout ~/.bash_logout
ln -i -s $PWD/../configs/bashrc ~/.bashrc
ln -i -s $PWD/../configs/tmux.conf ~/.tmux.conf
ln -i -s $PWD/../local/scripts ~/.local/
ln -i -s $PWD/../local/wallpapers ~/.local/
ln -i -s $PWD/../configs/sxhkd ~/.config/
ln -i -s $PWD/../configs/vim ~/.config/

# x server
ln -i -s $PWD/../configs/xinitrc ~/.xinitrc

# text editor
#ln -i -s $PWD/../configs/vimrc ~/.vimrc
