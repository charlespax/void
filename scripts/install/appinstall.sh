#!/usr/bin/env bash

# Get OS information
. /etc/os-release
OS=$ID

if [ $OS == 'arch' ]; then
	echo Welcome to the app installer!!!
else
	echo ERROR: this scrip only works on arch
	exit
fi

# Applications in the 'applist' are installed on top of
# the Arch base install
applist=''

# watch YouTube videos at the terminal
applist+=' yt-dlp'           # youtube downloader (consider plasmatube?)
applist+=' mpv'              # video player
applist+=' ytfzf'            # find and watch youtube via terminal

# Network Control
applist+=' iwd'              # $ iwctl station wlan0 connect <ssid>

# X Display server
applist+=' xorg-server'      # x window server
applist+=' xorg-xinit'
applist+=' terminus-font'    # necessary to start x server ('startx')
applist+=' libx11'           # dwm dependency
applist+=' libxft'           # dwm dependency
applist+=' libxinerama'      # dwm dependency

# Keyboard Management
applist+=' sxhkd'            # keyboard shortcut daemon

# Fonts
applist+=' adobe-source-code-pro-fonts' # nice font from Adobe

# Desktop Environment
applist+=' feh'              # desktop background
applist+=' pamixer'           # volume control
#applist+=' brightnessctl'    # brightness control (ubuntu sway)
#applist+=' pavucontrol'      # (ubuntu sway)

# Web
applist+=' firefox'          # heavy web browser
applist+=' gtk3'             # required to build surf web browser
applist+=' gcr'              # required to build surf web browser
applist+=' webkit2gtk'       # required to build surf web browser
#applist+=' w3m'              # terminal web browser

# Documentation
applist+=' mandoc'           # man pages
applist+=' tldr'             # man page chreatsheets

# Terminal Utilities
applist+=' vim'              # text editor
applist+=' fastfetch'        # show computer info
applist+=' acpi'             # battery information
applist+=' htop'             # system monitor
applist+=' fzf'              # fuzzy finder used in tmux-sessionizer script
applist+=' tmux'             # terminal mulplexor
applist+=' less'             # enhanced version of more
applist+=' tree'             # view a directory structure
applist+=' udisks2'          # usb disk mounting

# Multimedia
applist+=' gimp'             # image editor


# Development
applist+=' git'              # version control
applist+=' base-devel'       # core build utilities
applist+=' android-tools'    # required to install grapheneos on phone

# Other
#applist+=' ttf-font-awesome' #
#applist+=' ttf-roboto-mono'  #


sudo pacman -S --needed $applist



# clipboard manager
# color picker
# document viewer
# email client
# file manager
# gamma and day/night adjustment
# image viewer
# login manager
# notification daemon
# power menu wlogout
# sc
