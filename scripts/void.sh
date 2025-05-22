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
#!/usr/bin/env bash

# Install suckless utilties

mkdir ~/gits/

cd ~/gits
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/dmenu
git clone https://git.suckless.org/st
git clone https://git.suckless.org/surf

cd ~/gits/dwm/
make clean
sudo make install

cd ~/gits/dmenu/
make clean
sudo make install

cd ~/gits/st/
make clean
sudo make install

cd ~/gits/surf/
make clean
sudo make install

#
# LINUX
#

                   Linux System Notes
                ======================

Things to Install
-------------------
void - distribution
dwm - window manager
wayland - composter
tmux - terminal multiplexor
git - version control
vim - text editor
gdb - debugger
gdb-multiarch - debugger
lprng - gives 'lp' command for terminal printing
acpi - terminal battery information


Things to Consider
-------------------
viu - terminal image viewer
greetd - display manager
sddm - display manager
emptty - display manager
lamurs - display manager
lightdm - display manager
ly - display manager
tbsm - display manager
tmux-sessionizer - opens git repositories at tmux sessions
screenkey - screencast keystrokes

Things to  Research
-------------------
Find tools; search youtube for 'developer workflow'

seer - GUI for gdb
lunar vim
nvchad
vimwiki
nerd font - special characters in text (in termainl?)
              atomotic if a character code is in the text?
gnu parallel
googler - cli google search tool (BROWSER=w3m)
tldr - text summary tool (for googler?)
ddgr - cli duckduckgo search tool(BROWSER=w3m)
surfraw - cli internet search tool
exa - enhanced 'ls' command
bat - enhanced 'cat' command
ripgrep - enhanced 'grep' command
fzf - fuzzy finder
zoxide - enhanced 'cd' command
entr - run commands when a file changes
mc - "Midnight Commander" TUI file manager
uxn - interesting stack machine thing
