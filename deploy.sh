#!/bin/bash
# Installs the files in this repository to their proper locations

# TODO: support copying only specific files? (configured via command-line options)

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


sync profile ~/.profile
sync bashrc ~/.bashrc
sync zshrc ~/.zshrc

# TODO: figure out how to include the .git directory for Vundle.
# (Since we have the Vundle repo as a submodule, it doesn't have its own .git directory,
# and it doesn't really like that.)
sync vim/ ~/.config/nvim --include='/bundle/Vundle.vim/' --exclude='/bundle/*'

[ -f ~/.vimrc ] || ln -s ./.config/nvim/init.vim ~/.vimrc
[ -d ~/.vim ] || ln -s ./.config/nvim ~/.vim

cat <<EOS

#### Deployment complete ####
To install Vim plugins, run the command :PluginInstall in Vim.
EOS

