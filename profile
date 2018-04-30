#
# ~.config/profile
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
# dtach/dvtm helpers
#

if in_path dtach; then
    function dtsession() {
        dtach_dir="$XDG_DATA_HOME/dtach"
        mkdir -p "$dtach_dir"
        sock_name=$(mktemp -p "$dtach_dir" session.XXXXXX)
        if [[ $? -ne 0 ]]; then
            echo "Unable to create session file"
            return 1
        fi
        rm "$sock_name"
        dtach -c "$sock_name" "${@:-dvtm}"
    }

    function dtls() {
        dtach_dir="$XDG_DATA_HOME/dtach"
        ls "$dtach_dir"
    }

    function dtattach() {
        dtach_dir="$XDG_DATA_HOME/dtach"
        session="${1:-$(ls "$dtach_dir" | head -n 1)}"
        dtach -a "$dtach_dir/$session"
    }
fi

#
# Cleanup
#

unset -f in_path

#
# Load "local" (machine-specific) profile
#

if [ -e ~/.profile ]; then
    . ~/.profile
fi

# vim:syntax=sh:sw=4:ts=4:et
