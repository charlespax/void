#!/usr/bin/env bash

# TODO test if this script is being run in the live edition of
# void or on an installed system. Throw an error if live.
# Try  'cat /proc/cmdline | grep VOID_LIVE'. The live image will
# return a line while an installed system will not.

if grep -q "VOID_LIVE" "/proc/cmdline"; then
	echo "we are live!"
else
	echo "this is not live"
fi

# Exit this script
echo "exiting..."
exit              # nothing below this line will be executed




# Void Linux System Setup Notes
# 
# Assumptions:
#       - new minimal installation of Void Linux
#       - active internet connection
#
# Execution: run this script after Void Linux installation

## Install window manager

