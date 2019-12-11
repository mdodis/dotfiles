#!/bin/bash
# This script (which will be worked upon incrementally) will
# link the files in dotfiles to the appropriate paths.

# neovim
ln -s init.vim ~/.config/nvim/init.vim
# bash
ln -s .bashrc ~/.bashrc
# mpv
ln -s input.conf ~/.config/mpv/input.conf
# xinit
ln -s ~/dotfiles/.xinitrc ~/.xinitrc

# scripts directory
ln -s scripts ~/scripts

# applications directory
ln -s applications ~/.local/share/applications
