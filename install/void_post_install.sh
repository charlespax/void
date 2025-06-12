#!/usr/bin/env bash

# TODO search youtube for 'suckless developer workflow'

# This is a Void Linux post-installation script intended to
# create a suckless system.

echo "
__     __    _     _   _     _
\ \   / /__ (_) __| | | |   (_)_ __  _   ___  __
 \ \ / / _ \| |/ _\` | | |   | | '_ \| | | \ \/ /
  \ V / (_) | | (_| | | |___| | | | | |_| |>  < 
   \_/ \___/|_|\__,_| |_____|_|_| |_|\__,_/_/\_\\

"


#############################################################################
#                                                                           #
#   Environment Verification Testing                                        #
#                                                                           #
#############################################################################


# Test if the system is a Void Linux
. /etc/os-release # Get OS information
OS=$ID

if [ $OS == 'void' ]; then
	echo "Operating System...  void"
else
	echo "Operating System...  ERROR: this script only works on Void"
	echo "exiting..."
	exit
fi

# Test if this is a live environment
if grep -q "VOID_LIVE" "/proc/cmdline"; then
	echo "Environment...  VOID_LIVE"
else
	echo "Environment...  not VOID_LIVE"
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
	echo "Network...  connected"
else
	echo "Network...  ERROR: network is disconnected"
	echo "
This script requires an active internet connection. If your connection
was not configured during installation, you can use the following commands
to manually setup WiFi.

  $ wpa_cli
  > scan
  > scan_results
  > add_network
  > set_network [0 1 ...] ssid "<your ssid>"
  > set_network [0 1 ...] psk "<your password>"
  > enable_network [0 1 ...]
  > save config
  > quit
  "
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

# Display Manager

# X Display Server
applist+=' xorg'      # x window server

# X Keyboard Management
applist+=' sxhkd'            # keyboard shortcut daemon
                             # sxhkd is referenced in configs/xinitrc

# Terminal Utilities
applist+=' acpi'             # battery information
applist+=' fastfetch'        # show computer info
applist+=' htop'             # system monitor
applist+=' tree'             # view a directory structure
applist+=' fzf'              # fuzzy finder used in tmux-sessionizer script
                             # fzf is referenced in local/scripts/tmux-sesionizer
applist+=' tmux'             # terminal mulplexor
                             # tmux is referenced in local/scripts/tmux-sessionizer
#applist+=' udisks2'          # usb disk mounting
#applist+=' mc'           # "Midnight Commander" tui file manager
applist+=' bashmount'        # tui disk mounting
#applist+=' viu'              # terminal image viewer

# Text Editor
applist+=' vim'              # text editor
#TODO investigate vimwiki

# Multimedia
applist+=' farbfeld'          # image format required for sent
#applist+=' gimp'             # image editor
#applist+=' mpv'              # video player

# Printing system
#lprng        # gives 'lp' command for terminal printing


# Development
applist+=' git'                   # version control
applist+=' base-devel'            # core build utilities
applist+=' libX11-devel'          # required to build dwm window manager
applist+=' libXft-devel'          # required to build dwm window manager
applist+=' libXinerama-devel'     # required to build dwm window manager
applist+=' freetype-devel'        # required to build dwm window manager
applist+=' fontconfig-devel'      # required to build dwm window manager
#applist+=' farbfeld-devel'       # required to build sent presentation tool
applist+=' libXrandr-devel'       # required to build slock screen locker
applist+=' gtk+3-devel'           # required to build surf web browser
applist+=' gcr-devel'             # required to build surf web browser
applist+=' libwebkit2gtk41-devel' # required to build surf web browser
#applist+=' ctags'                # source code tagging tool, used with vim
#applist+=' doxygen'              # documentation generation
#applist+=' graphviz'          # 
#gnu-parallel        # parallelization
#seer                # GUI for gdb
#libzip-dev          # required to build scim
#libxml2-dev         # required to build scim
#bison               # required to build scim
#libncurses5-dev     # required to build scim
#libncurses5         # required to build scim
#libncursesw5        # required to build scim
#libncursesw5-dev    # required to build scim
#stow                # required to build scim


# Desktop Environment
applist+=' feh'          # desktop background setter
#applist+=' screenkey'   # screencast keystrokes
#applist+=' entr'        # run commands when a file changes
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
                              # feh is reverenced in configs/xinitrc
applist+=' pamixer'           # volume control
applist+=' brightnessctl'     # brightness control


# Network Control
applist+=' wpa_gui'           # gui network manager


# Web
applist+=' qutebrowser'       # gui web browser, tiling wm focused
applist+=' firefox'           # gui web browser
applist+=' w3m'               # tui web browser
#googler - cli google search tool (BROWSER=w3m)
#ddgr - cli duckduckgo search tool(BROWSER=w3m)


# Office
applist+=' sent'              # presentation tool
applist+=' zathura'           # document viewer
applist+=' zathura-cb'        # zathura comic book support
applist+=' zathura-djvu'      # zathura djvu support
applist+=' zathura-pdf-mupdf' # zathura pdf support
applist+=' zathura-ps'        # zathura postscript support

# Documentation
applist+=' tldr'              # man page chreatsheets


# Extra applications
applist+=' speedcrunch'       # gui calculator
#applist+=' sc'               # tui spreadsheet
#applist+=' sc-im'            # tui spreadsheet, based on sc


# Fonts
#applist+=' font-adobe-source-code-pro'  # not that great in terminal
applist+=' liberation-fonts-ttf'  # default st font
#applist+=' ttf-font-awesome'  # (probably icont fonts)
#applist+=' ttf-roboto-mono'  # (not sure)
#nerd font - special characters in text (in termainl?)
#              atomotic if a character code is in the text?


#############################################################################
#                                                                           #
#   Install Packages                                                        #
#                                                                           #
#############################################################################
echo $applist
sudo xbps-install -S $applist


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



