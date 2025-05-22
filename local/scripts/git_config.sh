#!/usr/bin/env bash

# This script configures git.

# Get personal information from the user
echo "Enter your name: "
read NAME

echo "Enter your email: "
read EMAIL

# Configure user name and email
git config --global user.email "$NAME"
git config --global user.name "$EMAIL"

# Push only the current branch rather than all branches when using 'git push'
git config --global push.default simple

# Use vim as difftool
git config --global diff.tool vimdiff
git config --global difftool.prompt false
git config --global alias.d difftool
git config --global commit.gpgsign true

