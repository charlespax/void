#!/usr/bin/env bash

. /etc/os-release
OS=$ID

if [ $OS == 'void' ]; then
        echo Welecome to Void the app installer!!!
else
        echo ERROR: this script only works on Void
        exit
fi

# Applications in the APPLIST are installed on top of
# the Void base install
APPLIST=''

# Desktop Environment 
DE=''
#DE+=' brightnessctl' # brightness control
#DE+=' dmenu'   # application launcher for xorg
#DE+=' foot'     # terminal emulator
#DE+=' grim'     # screenshot tool
#DE+=' pavucontrol'
#DE+=' polkit'   # system-wide privilege manager
#DE+=' slurp'    # screenshot tool region selector
#DE+=' sway'     # sway desktop
#DE+=' swaybg'   # desktop background image tool
#DE+=' swayidle' # idle manager
#DE+=' swaylock' # screen lock
#DE+=' waybar'   # status bar
#DE+=' wofi'     # application launcher
#DE+=' xorg-xwayland'
# clipboard manager
# color picker
# document viewer
# email client
# file manager
# gamma and day/night adjustment
#DE+=' gimp'     # image editor
# image viewer
# login manager
# notification daemon
# power menu wlogout
# sc

echo ''
echo 'Desktop Environment apps: ' $DE
read -p 'Install apps? [y,n] ' choice
case $choice in
        y|Y)   APPLIST+=$DE ;;
        n|N|*) echo ' skiping apps' ;;
esac

# Fonts
FONTS=''
FONTS+=' adobe-source-code-pro-fonts'
FONTS+=' ttf-font-awesome'
FONTS+=' ttf-roboto-mono'

echo ''
echo 'Fonts: ' $FONTS
read -p "Install fonts? [y,n] " choice
case $choice in
        y|Y)   APPLIST+=$FONTS ;;
        n|N|*) echo ' skiping fonts' ;;
esac

# Development Tools
DEVTOOLS=''
DEVTOOLS+=' base-devel'  # base development tools
DEVTOOLS+=' git'         # version control
DEVTOOLS+=' tmux'        # terminal session multiplexer
DEVTOOLS+=' vim'         # text editor

echo ''
echo 'Dev tools: ' $DEVTOOLS
read -p "Install development tools? [y,n] " choice
case $choice in
        y|Y)  APPLIST+=$DEVTOOLS ;;
        n|N|*) echo 'skipping dev tools' ;;
esac

# Extra applications
EXTRAS=''
EXTRAS+=' acpi'        # battery information
EXTRAS+=' ctags'       # tagging tool, used with vim
EXTRAS+=' doxygen'
EXTRAS+=' firefox'     # web browser
EXTRAS+=' graphviz'
EXTRAS+=' iwd'         # WiFi control
EXTRAS+=' neofetch'
EXTRAS+=' speedcrunch' # calculator
EXTRAS+=' w3m'         # tui web browser

echo ''
echo 'Extras: ' $EXTRAS
read -p "Install extras? [y,n] " choice
case $choice in
        y|Y)   APPLIST+=$EXTRAS ;;
        n|N|*) echo 'Skipping extras' ;;
esac

# Confirm installation
echo ''
echo 'Applications to install: ' $APPLIST
read -p "Continue with installation? [y,n] " choice
case $choice in
        y|Y) sudo pacman -S --needed $APPLIST ;;
        n|N) echo 'Exiting installation...' ;;
esac

## SC-IM stuff (vim-like spreadsheets)
# This is needed to build scim
#libzip-dev libxml2-dev bison  libncurses5-dev
#libncurses5 libncursesw5 libncursesw5-dev stow
