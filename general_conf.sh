#!/bin/bash

# Set to debug mode to view output when executing
set -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
 
ln -sf $DIR/dot.vimrc ~/.vimrc
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Fix for Vundle color installs.
mkdir -p ~/.vim/colors
cp  ~/.vim/bundle/vim-colors-solarized/colors/solarized.vim ~/.vim/colors
cp  ~/.vim/bundle/badwolf/colors/badwolf.vim ~/.vim/colors

mkdir -p ~/.vim/backup
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/undo

# Required installs for vim plugins
sudo apt-get install exuberant-ctags
sudo apt-get install silversearcher-ag

# Required vim package mods
~/.vim/bundle/vimproc.vim/make

#
# Git configuration
#
git config --global user.name "Steve Quinn"
git config --global user.email steve.m.quinn@gmail.com
git config --global core.editor vim

