#!/usr/bin/env bash

# This script creates links for the dotfiles contained within this Github 
# repository.

mkdir -p ~/.config
mkdir -p ~/.local

PWD=`pwd`

# Directory Structure
ln -i -s $PWD/../local/scripts ~/.local/

# Bash
ln -i -s $PWD/../configs/bash_login ~/.bash_login
ln -i -s $PWD/../configs/bash_login ~/.bash_profile
ln -i -s $PWD/../configs/bash_logout ~/.bash_logout
ln -i -s $PWD/../configs/bashrc ~/.bashrc

# Terminal Utilities
ln -i -s $PWD/../configs/tmux.conf ~/.tmux.conf

# X Server
ln -i -s $PWD/../configs/xinitrc ~/.xinitrc
ln -i -s $PWD/../configs/xprofile ~/.xprofile
ln -i -s $PWD/../configs/sxhkd ~/.config/
ln -i -s $PWD/../local/wallpapers ~/.local/

# Text Editor
ln -i -s $PWD/../configs/vim ~/.config/

# Web/Internet
ln -i -s $PWD/../configs/qutebrowser ~/.config/
