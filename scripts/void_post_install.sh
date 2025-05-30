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

# X Display server
applist+=' xorg'      # x window server

# Keyboard Management
applist+=' sxhkd'            # keyboard shortcut daemon
                             # sxhkd is referenced in configs/xinitrc

# Text Editor
applist+=' vim'              # text editor

# Terminal Utilities
applist+=' acpi'             # battery information
applist+=' fastfetch'        # show computer info
applist+=' fzf'              # fuzzy finder used in tmux-sessionizer script
                             # fzf is referenced in local/scripts/tmux-sesionizer
applist+=' htop'             # system monitor
applist+=' tmux'             # terminal mulplexor
                             # tmux is referenced in local/scripts/tmux-sessionizer
applist+=' tree'             # view a directory structure
#applist+=' udisks2'          # usb disk mounting
applist+=' bashmount'        # tui disk mounting
#applist+=' figlet'           # large ascii fonts
#applist+=' toilet'           # large ascii fonts
#applist+=' viu'              # terminal image viewer

# Multimedia
#applist+=' gimp'             # image editor
#applist+=' mpv'              # video player

# Development
applist+=' git'                # version control
applist+=' base-devel'         # core build utilities
applist+=' libX11-devel'       # required to build dwm on Void
applist+=' libXft-devel'       # required to build dwm on Void
applist+=' libXinerama-devel'  # required to build dwm on Void
applist+=' freetype-devel'     # required to build dwm on Void
applist+=' fontconfig-devel'   # required to build dwm on Void

# Desktop Environment
applist+=' feh'              # desktop background
                              # feh is reverenced in configs/xinitrc
#applist+=' pamixer'           # volume control
#applist+=' brightnessctl'     # brightness control (ubuntu sway)

# Web
applist+=' qutebrowser'
#applist+=' firefox'          # heavy web browser
#applist+=' gtk3'             # required to build surf web browser
#applist+=' gcr'              # required to build surf web browser
#applist+=' webkit2gtk'       # required to build surf web browser
#applist+=' w3m'              # terminal web browser

# Documentation
#applist+=' mandoc'           # man pages
#applist+=' tldr'             # man page chreatsheets

# Extra applications
#applist+=' ctags'       # tagging tool, used with vim
#applist+=' doxygen'
#applist+=' graphviz'
#applist+=' iwd'         # WiFi control
applist+=' speedcrunch' # calculator

# Other
# lprng - gives 'lp' command for terminal printing
#seer - GUI for gdb
#lunar vim
#nvchad
#vimwiki
#nerd font - special characters in text (in termainl?)
#              atomotic if a character code is in the text?
#gnu parallel
#googler - cli google search tool (BROWSER=w3m)
#tldr - text summary tool (for googler?)
#ddgr - cli duckduckgo search tool(BROWSER=w3m)
#surfraw - cli internet search tool
#exa - enhanced 'ls' command
#bat - enhanced 'cat' command
#ripgrep - enhanced 'grep' command
#zoxide - enhanced 'cd' command
#entr - run commands when a file changes
#mc - "Midnight Commander" TUI file manager
#uxn - interesting stack machine thing
#screenkey - screencast keystrokes
#grim - screenshot tool
#slurp - screenshot tool region selector
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


## SC-IM stuff (vim-like spreadsheets)
# This is needed to build scim
#libzip-dev libxml2-dev bison  libncurses5-dev
#libncurses5 libncursesw5 libncursesw5-dev stow
#!/usr/bin/env bash

# Install suckless utilties

mkdir -p ~/gits/

#TODO make my own git repositories for suckless tools
cd ~/gits
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/dmenu
git clone https://git.suckless.org/st
#git clone https://git.suckless.org/surf

cd ~/gits/dwm/
make clean
sudo make install

cd ~/gits/dmenu/
make clean
sudo make install

cd ~/gits/st/
make clean
sudo make install

#cd ~/gits/surf/
#make clean
#sudo make install



