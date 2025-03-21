#!/usr/bin/env bash
# Installs the files in this repository to their proper locations

set -e

# TODO: support copying only specific files? (configured via command-line options)

rsync_flags=(
    --recursive --one-file-system
    --update --delete
    --times --omit-dir-times --perms --no-owner --no-group
    --progress --itemize-changes
)

# Copies from $1 to $2 (with extra rsync parameters following)
function sync() {
    mkdir -p $(dirname "$2")
    rsync "${rsync_flags[@]}" "${@:3}" "$1" "$2"
}

sync profile ~/.config/profile.global
sync bashrc ~/.config/bashrc.global
sync zshrc ~/.config/zshrc.global
sync nushell/config.nu ~/.config/nushell/config.local.nu
sync nushell/env.nu ~/.config/nushell/env.local.nu

sync git/ ~/.config/git/global/

sync vim/ ~/.config/nvim/
[ -f ~/.vimrc ] || ln -s ./.config/nvim/init.vim ~/.vimrc
[ -d ~/.vim ] || ln -s ./.config/nvim ~/.vim

sync tmux.conf ~/.tmux.conf

# Allows games that use OpenALsoft to be moved to a new audio sink. See https://unix.stackexchange.com/questions/452907/
# (Necessary to use alternate sinks for games like Baldur's Gate)
sync alsoftrc ~/.alsoftrc

cat <<EOS

#### Deployment complete ####
To install Vim plugins, run the command :PlugInstall in Vim.
EOS
