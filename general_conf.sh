#!/bin/bash

# Set to debug mode to view output when executing
set -x
 
ln -s dot.vimrc ~/.vimrc

#
# Git configuration
#
git config --global user.name "Steve Quinn"
git config --global user.email steve.m.quinn@gmail.com
git config --global core.editor vim

