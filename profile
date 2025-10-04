#
# ~/.config/profile.global
# Common options for all my sh-like shells
#

#
# Paths
#

function in_path() {
    which "$1" > /dev/null 2>&1
}

if [ -d ~/.local/bin ]; then
    export PATH="$PATH:$HOME/.local/bin"
fi

# Add Ruby gem executables to PATH
if [ -d ~/.gem ]; then
    export GEM_HOME="$HOME/.gem"
    export PATH="$PATH:$GEM_HOME/ruby/2.3.0/bin:$GEM_HOME/bin"
fi

# Add Cargo-installed executables to PATH (unless Nix should be managing Cargo)
if [ -z "$NIX_PATH" -a -d ~/.cargo ]; then
    export PATH="$PATH:$HOME/.cargo/bin"
fi

#
# Editor
#

if in_path nvim; then
    export VISUAL=nvim
    alias vim=nvim
elif in_path vim; then
    export VISUAL=vim
else
    export VISUAL=vi
fi
export EDITOR="$VISUAL"
export FCEDIT="$EDITOR"

#
# Aliases
#

if in_path git; then
    alias g=git
fi

# Make ls use colors if it supports them.
if ls --color=auto ~/.config >/dev/null 2>&1; then
    alias ls='ls --color=auto'
fi

if in_path xdg-open; then
   function open() {
        for i in "$@"; do
            xdg-open "$i"
        done
   }
fi

#
# GPG agent
#

if in_path gpg && in_path tty; then
    export GPG_TTY="$(tty)"
fi

#
# SSH agent
#

if [ -e "$XDG_RUNTIME_DIR/ssh-agent.sock" ]; then
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.sock"
fi

# Adds all SSH keys in ~/.ssh to the agent cache
function ssh-add-all() {
    keys=()
    for pub in ~/.ssh/*.pub; do
        keys+=("${pub%.pub}")
    done
    ssh-add "${keys[@]}"
}

#
# FZF configuration
#

if in_path fzf && in_path rg; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden'
    export FZF_CTRL_T_COMMAND='rg --files --hidden'
fi

#
# Cleanup
#

unset -f in_path

# vim:syntax=sh:sw=4:ts=4:et
