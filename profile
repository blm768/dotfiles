#
# ~.config/profile
# Common options for all my sh-like shells
#

# Load "local" (machine-specific) profile
# (Useful for Macs)
if [ -e ~/.profile ]; then
    . ~/.profile
fi

#
# Paths
#

function in_path() {
    which "$1" > /dev/null 2>&1
}

# Add Ruby gem executables to PATH
if [ -d ~/.gem ]; then
    export GEM_HOME="$HOME/.gem"
    export PATH="$PATH:$HOME/.local/bin:$GEM_HOME/ruby/2.3.0/bin:$GEM_HOME/bin"
fi

# Add Cargo-installed executables to PATH
if [ -d ~/.cargo ]; then
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

alias ls='ls --color=auto'

if in_path xdg-open; then
   function open() {
        for i in "$@"; do
            xdg-open "$i"
        done
   }
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
# Cleanup
#

unset -f in_path

# vim:syntax=sh:sw=4:ts=4:et
