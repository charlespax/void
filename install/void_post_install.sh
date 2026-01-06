#!/usr/bin/env bash

# TODO search youtube for 'suckless developer workflow'
# TODO add a keybinding for opening the keybindings and shortcuts help page
#      Add fzf to find the command from the list

# This is a Void Linux post-installation script intended to
# create a suckless system.

echo "
__     __    _     _   _     _
\ \   / /__ (_) __| | | |   (_)_ __  _   ___  __
 \ \ / / _ \| |/ _\` | | |   | | '_ \| | | \ \/ /
  \ V / (_) | | (_| | | |___| | | | | |_| |>  < 
   \_/ \___/|_|\__,_| |_____|_|_| |_|\__,_/_/\_\\

"

function exit_script () {
	printf "exiting...\n"
	exit
}

#############################################################################
#                                                                           #
#   Environment Verification Testing                                        #
#                                                                           #
#############################################################################


# Test if the system is a Void Linux
OS=""
OS=$(. /etc/os-release ; printf "${ID}")
printf "Operating system: "
if [[ ${OS} == 'void' ]]; then
	printf "${OS}\n"
else
	printf "${OS}\n"
	printf "ERROR this script only works on Void\n"
	exit_script
fi

# Test if this is a live environment
# TODO explicitly confirm which non-live environment we have.
#      Can we detect explicitly if the environment is installed?
OS_ENV=""
OS_ENV=$(grep -q "VOID_LIVE" "/proc/cmdline")
printf "OS environment: "
if [[ ${OS_ENV} == 'VOID_LIVE' ]]; then
	printf "${OS_ENV}\n"
else
	printf "non-live\n"
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
	echo "Network:  connected"
else
	echo "Network:  ERROR: network is disconnected"
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

# CODOC Display Manager
# CODOC ** There is no display manager

# CODOC X Display Server
applist+=' xorg'             # CODOC xorg       x window server
applist+=' arandr'           # CODOC arandr     gui monitor management tool for randr
applist+=' autorandr'        # CODOC autorandr  command line monitor utility for randr

# CODOC X Keyboard Management
applist+=' sxhkd'            # CODOC sxhkd      keyboard shortcut daemon
                             # CODOC            sxhkd is referenced in configs/xinitrc

# CODOC Terminal Utilities
applist+=' acpi'             # CODOC acpi       battery information
applist+=' fastfetch'        # CODOC fastfetch  show computer info
applist+=' htop'             # CODOC htop       system monitor
applist+=' tree'             # CODOC tree       view a directory structure
# fzf is used in the terminal and pressing ctrl-f, tmux sessionizer
# fzf can also be used in dmenu scripts.
# IDEA scripts can be dmenu-aware. Output types: terminal with opt flags, dmenu
applist+=' fzf'              # CODOC fzf        fuzzy finder used in tmux-sessionizer script
                             #                  fzf is referenced in local/scripts/tmux-sesionizer
applist+=' tmux'             # CODOC tmux       terminal mulplexor
                             #                  tmux is referenced in local/scripts/tmux-sessionizer
#applist+=' udisks2'         # codoc udisks2    usb disk mounting
#applist+=' mc'              # codoc mc         Midnight Commander tui file manager
applist+=' ranger'           # CODOC ranger     tui file manager (vim keybindings)
applist+=' bashmount'        # CODOC bashmount  tui disk mounting
applist+=' viu'              # CODOC viu        terminal image viewer

# CODOC Terminal Fun and Games
applist+=' asciiquarium'     # CODOC asciiquarium  terminal aquarium

# CODOC Text Editor
applist+=' vim-huge'         # CODOC vim        text editor
#TODO investigate vimwiki

# CODOC Multimedia
applist+=' farbfeld'         # CODOC farbfeld   image format required for sent
applist+=' mpv'              # CODOC mpv        video player
#applist+=' gimp'            # codoc gimp       image editor

# CODOC Printing system
#lprng                       # CODOC lprng      'lp' terminal print command

# CODOC Development
applist+=' git'                   # CODOC git   version control
applist+=' base-devel'            # CODOC base-devel core build utilities
applist+=' ctags'                # source code tagging tool, used with vim
#applist+=' doxygen'              # documentation generation

# CODOC Build Dependencies: dwm
applist+=' libX11-devel'          # required to build dwm window manager
applist+=' libXft-devel'          # required to build dwm window manager
applist+=' libXinerama-devel'     # required to build dwm window manager
applist+=' freetype-devel'        # required to build dwm window manager
applist+=' fontconfig-devel'      # required to build dwm window manager

# CODOC Build Dependencies: sent
#applist+=' farbfeld-devel'       # required to build sent presentation tool

# CODOC Build Dependencies: slock
applist+=' libXrandr-devel'       # required to build slock screen locker

# CODOC Build Dependencies: surf
applist+=' gtk+3-devel'           # required to build surf web browser
applist+=' gcr-devel'             # required to build surf web browser
applist+=' libwebkit2gtk41-devel' # required to build surf web browser

#applist+=' graphviz'          # 
#gnu-parallel        # parallelization
#seer                # GUI for gdb

# CODOC Build Dependencies: scim
#libzip-dev          # required to build scim
#libxml2-dev         # required to build scim
#bison               # required to build scim
#libncurses5-dev     # required to build scim
#libncurses5         # required to build scim
#libncursesw5        # required to build scim
#libncursesw5-dev    # required to build scim
#stow                # required to build scim


# CODOC Desktop Environment
applist+=' feh'          # CODOC feh        desktop background setter
applist+=' slock'        # CODOC slock      screen locker
#applist+=' screenkey'   # CODOC screenkey  screencast keystrokes
#applist+=' entr'        # CODOC entr       run commands when a file changes
# clipboard manager
# color picker
# document viewer
# email client
# file manager
# gamma and day/night adjustment
# notification daemon
applist+=' dunst'             # provides notify-send for notifications
# power menu wlogout
                              # feh is reverenced in configs/xinitrc
applist+=' pamixer'           # volume control
applist+=' brightnessctl'     # brightness control


# Network Control
# TODO replace wpa_supplicant with iwd
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
applist+=' nerd-fonts'         #special characters in text
applist+=' dejavu-fonts-ttf'
applist+=' noto-fonts-ttf'
applist+=' noto-fonts-emoji'
#              atomotic if a character code is in the text?

# Bluetooth
# https://docs.voidlinux.org/config/bluetooth.html
applist+=' bluez'   # bluetooth packages
# ln -s /etc/sv/bluetoothd /var/service/
# ln -s /etc/sv/dbus /var/service/
#


#############################################################################
#                                                                           #
#   Install Packages                                                        #
#                                                                           #
#############################################################################
#my_list=("apple" "banana" "cherry")
#my_list=( ${applist} )

# Iterate over the array elements
#for item in "${my_list[@]}"; do
	#printf "$(xbps-query -p pkgver ${item})\n"
#done
printf "\n"

PACK=$(echo "${applist}" | sed 's/ /\n/g' | dmenu -l 8 -nb red -nf blue -p "Select package: ")
#echo Selected package: $PACK
printf "$(xbps-query -p pkgver ${PACK})\n"

exit

#printf "Applist: $applist"
#sudo xbps-install -S $applist


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


# * investigate dunst as a notification manager
# * investigate notify-send as a notificationn tool connected to dunst or other
# notificationn manager
# * consider asciidoc
# * consider tty-solitaire
# * consider cataslysm-dda
# * consider nethack
# * consider angband
# * consider gnu octave
# * consider Solaar Logitech unifying receiver device manager
#   Solaar must be run as root
# * consider fontmanager
# * consider ttf-ubuntu-font-family
# * consider console-setup
# * consider sacc gopher browser
# * consider typespeed typing speed tester
#
# Printing
# suod xbps-install void-repo-nonfree
# sudo xbps-install cups cups-filters foomatic-db foomatic-db-nonfree \
#                   gutenprint brother-brlaser
# sudo ln -s /etc/sv/cupsd /var/service/
# sudo usermod -a -G lpadmin <username>
# # https://localhost:631    then select MFC-L*
# install curl
