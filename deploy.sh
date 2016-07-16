#!/bin/bash

rsync_flags=(
	--recursive --one-file-system
	--update --delete
	--times --perms --no-owner --no-group
	--progress --itemize-changes
)

# Copies from $1 to $2 (with extra rsync parameters following)
function sync() {
	rsync "${rsync_flags[@]}" "${@:3}" "$1" "$2"
}

# Installs the files in this repository to their proper locations

sync bashrc ~/.bashrc

sync vim/ ~/.config/nvim --exclude='/bundle' --include='/bundle/Vundle.vim'

[ -f ~/.vimrc ] || ln -s ./.config/nvim/init.vim ~/.vimrc
[ -d ~/.vim ] || ln -s ./.config/nvim ~/.vim

cat <<EOS

#### Deployment complete ####
To install Vim plugins, run the command :PluginInstall in Vim.
EOS

