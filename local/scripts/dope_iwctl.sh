#!/bin/env bash

# Notes #######################################################################
# DONE $ iwctl device list  # list devices
# $ iwctl device <device>  set-property Powered on  # power on device
# $ iwctl station <device> scan  # scan for networks
# DONE $ iwctl station <device> get-networks  # list available network ssids
# $ iwctl station <device> connect <ssid>  # connect to network
# $ iwctl station <device connect-hidden <ssid>  # connect to hidden network
# TODO manage device power (Powered on)
# TODO scan networks
# TODO connect to network
# TODO connect to hidden network
# TODO mechanism for password
#
# BUG script does not handle ssid's with spaces
# TODO handle ssid's with spaces
#      - find the location of the second column header
#      - ssid is everything up to that column
#      - trim leading and trailing whitespace

# Header Information ##########################################################
#
# Name: System Dope iwctl Wrapper
#
# Description: wrapper for iwctl to output clean lists for dmenu
#
# Version: ${SCRIPT_VERSION}
# License: ${SCRIPT_LICENSE}
# Author: Charles Edward Pax <charles@pax.net>

# Script Metadata and Constants ###############################################
SCRIPT_NAME="dope_iwdctl"
SCRIPT_VERSION="0.0.1"
SCRIPT_LICENSE="gplv3"
DOPE_VERSION="0.0.1"

# Global Variables ############################################################
COMMAND=""
DEVICE=""
PASSWORD=""

# Usage #######################################################################
USAGE="Usage: ${SCRIPT_NAME} [OPTION]... [COMMAND]...
Wrapper for iwctl to output clean lists for dmenu
Example: ${SCRIPT_NAME} networks

Commands:
  connect                  connect to a network
  dmenu                    use dmenu
  networks                 print list of available networks
  devices                  print list of devices
  debug

Flags:
  -d, --device=DEVICE      define DEVICE
  -h, --help               print this help message
      --license            print license information
  -n, --network=NETWORK    define NETWORK
  -p, --password=PASSWORD  define PASSWORD
  -v, --version            print this script's name and version"

# Argument Processing #########################################################
# NOTE Do the minimal (i.e. set variables, etc.)
while [[ $# -gt 0 ]]; do  # $# is the number of script arguments
	case "${1}" in
	# Flag Arguments
	# - flags that exit
	# - flags that set variables
		-d|--device)
			shift  # discard the -d flag
			DEVICE="${1}"  # DEVICE is the next parameter
			shift  # drop device parameter
			;;
		-h|--help)
			printf "${USAGE}\n"
			shift
			;;
		--license)
			printf "${SCRIPT_LICENSE}\n"
			exit
			;;
		-p|--password)
			shift  # discard the -p flag
			PASSWORD="${1}"  # PASSWORD is the next parameter
			shift  # drop password parameter
			;;
		-v|--version)
			printf "${SCRIPT_NAME} ${SCRIPT_VERSION}\n"
			exit
			;;
	# Non-flag Arguments
		dmenu|devices|connect|networks|debug)
			COMMAND="${1}"
			shift
			;;
		*)
			printf "Unknown command: ${1}\n"
			exit
			;;
	esac
done
# Exit if COMMAND is not set
if [[ "${COMMAND}" == "" ]]; then
	printf "no command set\n"
	exit
fi

# Function Declarations #######################################################

# function: clean_iwctl_output
# Clean the output of iwctl
# - remove header lines
# - remove leading white space on each line
# - remove ansi color codes
# - TODO explicitly remove blank footer line
function clean_iwctl_output {
	local STR="${1}"
	local HEADER=""
	local SPACE_COUNT=0
	STR="$(sed -e 's/\x1b\[[0-9;]*m//g' <<< "${STR}")" # remove ansi colors
	STR="$(sed '1,2d' <<< ${STR})"  # remove top two header lines 
	HEADER="$(head -n 1 <<< ${STR})"  # grag the top line
	HEADER="$(head -n 1 <<< ${STR})"  # grag the top line
	SPACE_COUNT="$(expr match "${HEADER}" " *")"  # count spaces in header
	STR="$(cut -c $((${SPACE_COUNT} + 1))- <<< "${STR}")"  # del left chars
	STR="$(sed '1,2d' <<< ${STR})" # select lies 1-2, delete
	printf "${STR}\n"
	return 0
}

# function: col1
# Get the first column from a block of text
# - input must be cleaned if necessary (e.g. clean_iwctl_output)
# - outputs the first word of each line
function col1 {
	local STR="${1}"
	STR="$(awk '{print $1}' <<< ${STR})" # select first column
	printf "${STR}\n"
	return 0
}

# function: list_devices
# List available devices
function list_devices {
	local STR=""
	STR="$(iwctl device list)"
	STR="$(clean_iwctl_output "${STR}")"
	STR="$(col1 "${STR}")"
	printf "${STR}\n"
	return 0
}

# function: list_networks
# Get a list of networks from a device
function list_networks {
	local STR=""  # working string
	# ensure DEVICE is defined
	if [[ "${DEVICE}" == "" ]]; then  # if -d is not set
		DEVICE="$(head -n 1 <<< "$(${0} devices)")"
	fi
	# process working string
	# TODO scan first
	STR="$(iwctl station ${DEVICE} get-networks)\n"
	STR="$(clean_iwctl_output "${STR}")"
	STR="$(col1 "${STR}")"
	printf "${STR}\n"
	return 0
}

# function: use_dmenu
# utilize dmenu
function use_dmenu {
	if [[ "${DEVICE}" == "" ]]; then  # select DEVICE if not set using -d
		DEVICE="$("${0}" devices | dmenu -p "Select device")"
	fi
	NETWORK="$(${0} networks -d ${DEVICE} | dmenu -p "Select network")"
	printf "Device: ${DEVICE}\n"
	printf "Network: ${NETWORK}\n"
	printf "Password: ${PASSWORD}\n"
	if command -v notify-send &> /dev/null; then  # notify if installed
		notify-send "iwctl status" \
			"Device: ${DEVICE}\nNetwork: ${NETWORK}"
	fi
	return 0
}

# function: connect_network
# Connect to a network
# - TODO use -d to select device
# - TODO use -n to select network
# - TODO use -p to set password
function connect_network {
	printf "TODO implement connect function.\n"
	return 0
}

# Main Logic ##################################################################

# TODO test for network connectivity
case ${COMMAND} in
	connect) connect_network ;;
	devices) list_devices ;;
	dmenu) use_dmenu ;;
	networks) list_networks ;;
	debug)
		printf "** clean_iwctl_output \"\$(iwctl device list)\" **\n"
		clean_iwctl_output "$(iwctl device list)"
		printf "\n"
		printf "** clean_iwctl_output \"\$(iwctl station wlp0s20f3 get-networks)\" **\n"
		clean_iwctl_output "$(iwctl station wlp0s20f3 get-networks)"
		;;
esac

