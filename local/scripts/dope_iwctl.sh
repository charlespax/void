#!/bin/env bash

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

# Usage #######################################################################
USAGE="Usage: ${SCRIPT_NAME} [OPTION]... [COMMAND]...
Wrapper for iwctl to output clean lists for dmenu
Example: ${SCRIPT_NAME} networks

Commands:
  dmenu                 use dmenu
  networks              print list of available networks
  devices               print list of devices

Flags:
  -d, --device=DEVICE   define device
  -h, --help            print this help message
      --license         print license information
  -v, --version         print this script's name and version"

# Argument Processing #########################################################
# NOTE Do the minimal (i.e. set variables, etc.)
while [[ $# -gt 0 ]]; do  # $# is the number of script arguments
	case "${1}" in
	# Flag Arguments
	# - flags that exit
	# - flags that set variables
		--license)
			printf "${SCRIPT_LICENSE}\n"
			exit
			;;
		-v|--version)
			printf "${SCRIPT_NAME} ${SCRIPT_VERSION}\n"
			exit
			;;
		-h|--help)
			printf "${USAGE}\n"
			shift
			;;
		-d|--device)
			shift  # discard the -d flag
			DEVICE="${1}"  # DEVICE is the next parameter
			shift  # drop device parameter
			;;
	# Non-flag Arguments
		dmenu|devices|networks)
			COMMAND="${1}"
			shift
			;;
		*)
			printf "Unknown command: ${1}\n"
			exit
			;;
	esac
done

# Function Declarations #######################################################

# function: clean_iwctl_output
# Clean the output of iwctl
# - remove header lines
# - remove leading white space on each line
# - remove ansi color codes
# - TODO explicitly remove blank footer line
function clean_iwctl_output {
	local STR="${1}"
	STR=$(sed '1,4d' <<< ${STR}) # select lies 1-4, delete
	STR=$(sed -e 's/\x1b\[[0-9;]*m//g' <<< ${STR}) # remove ansi colors
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
	if command -v notify-send &> /dev/null; then  # notify if installed
		notify-send "iwctl status" \
			"Device: ${DEVICE}\nNetwork: ${NETWORK}"
	fi
	return 0
}

# Main Logic ##################################################################

# TODO test for network connectivity
case ${COMMAND} in
	devices) list_devices ;;
	networks) list_networks ;;
	dmenu) use_dmenu ;;
esac

