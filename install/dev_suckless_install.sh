#!/usr/bin/env bash

# Global Variables ############################################################
# List Suckless Repositories
REPO_LIST="dwm dmenu st"

# Function Declarations #######################################################
# Get GIT_HOME
function get_git {
	if [ -z "${GIT_HOME}" ]; then
		echo "Environment variable GIT_HOME is not set."
		read -r -p "Enter path to GIT_HOME: " GIT_HOME
		GIT_HOME="${GIT_HOME/#\~/$HOME}"
		echo "GIT_HOME= $GIT_HOME"
		#TODO check/create directory, confirm with user
	fi
}

# Functions
function git_clone {
	#TODO check if directories exist
	echo cloning $1 into $GIT_HOME/$1
	#echo cd $GIT_HOME
	git clone https://git.suckless.org/$1 "$GIT_HOME/$1"
	cd "$GIT_HOME/$1"
	make clean
	make
	sudo make install
}

function main {
	get_git
	echo ""
	echo GIT_HOME: $GIT_HOME
	echo "Cloning: $REPO_LIST"
	#TODO confirm with user
	echo ""

	for i in $REPO_LIST; do
		git_clone $i
		echo ""
	done
}

# Main Program Logic ##########################################################
# Execute the main function
main first second third

exit
