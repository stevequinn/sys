#!/bin/bash

# Set to debug mode to view output when executing
set -x
 
ln -sf ~/sys/dot.vimrc ~/.vimrc
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Fix for solarized color Vundle install.
mkdir ~/.vim/colors
cp  ~/.vim/bundle/vim-colors-solarized/colors/solarized.vim ~/.vim/colors

# Required installs for vim plugins
sudo apt-get install exuberant-ctags

# Required vim package mods
~/.vim/bundle/vimproc.vim/make

#
# Git configuration
#
git config --global user.name "Steve Quinn"
git config --global user.email steve.m.quinn@gmail.com
git config --global core.editor vim

