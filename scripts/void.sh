#!/usr/bin/env bash

# This is a post-installation script to create a functioning system built
# on top of a Void Linux base installation.


#############################################################################
#                                                                           #
#   Environment Verification Testing                                        #
#                                                                           #
#############################################################################

echo "Welcome to the Void Linux Post-Installation Script!"
echo ""

# Test if this is a live environment
if grep -q "VOID_LIVE" "/proc/cmdline"; then
	echo "ERROR: This script will not run in a VOID_LIVE environment"
	echo "exiting..."
	exit
else
	echo "SUCCESS: this is not a live environment"
fi

# Test if the system is a Void Linux installation
. /etc/os-release # Get OS information
OS=$ID

if [ $OS == 'void' ]; then
	echo "SUCCESS: this is the void"
else
	echo "ERROR: this script only works on Void"
	exit
fi


# This script requires an active internet connection. If your connection
# was not configured during installation, you can use the following commands
# to manually setup WiFi.
#
# $ wpa_cli
# > scan
# > scan_results
# > add_network
# > set_network [0 1 ...] ssid "<your ssid>"
# > set_network [0 1 ...] psk "<your password>"
# > enable_network [0 1 ...]
# > save config
# > quit

# Test for network connection
HOST="8.8.8.8" # Google's DSN server

if ping -c 1 -W 1 "$HOST" > /dev/null 2>&1; then
	echo "SUCCESS: Network is reachable"
else
	echo "ERROR: network is unreachable"
	echo "exiting..."
	exit
fi


#############################################################################
#                                                                           #
#   Application List Generation                                             #
#                                                                           #
#############################################################################

# Packages that appear on the applist will be installed using xbps.
applist=''

# X Display server
applist+=' xorg-server'      # x window server
applist+=' xorg-xinit'
applist+=' terminus-font'    # necessary to start x server ('startx')
applist+=' libx11'           # dwm dependency
applist+=' libxft'           # dwm dependency
applist+=' libxinerama'      # dwm dependency

# Keyboard Management
applist+=' sxhkd'            # keyboard shortcut daemon

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





# watch YouTube videos at the terminal
applist+=' yt-dlp'           # youtube downloader (consider plasmatube?)
applist+=' mpv'              # video player
applist+=' ytfzf'            # find and watch youtube via terminal

# Network Control
#applist+=' iwd'              # $ iwctl station wlan0 connect <ssid>

# Fonts
applist+=' adobe-source-code-pro-fonts' # nice font from Adobe
#applist+=' ttf-font-awesome' #
#applist+=' ttf-roboto-mono'  #

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









echo $applist

#############################################################################
#                                                                           #
#   Post-Script Actions                                                     #
#                                                                           #
#############################################################################

# Exit this script
echo "SUCCESS: script complete!"
echo "exiting..."
exit


#############################################################################
#                                                                           #
#   NOTHING BELOW THIS LINE WILL BE EXECUTED                                #
#                                                                           #
#############################################################################


