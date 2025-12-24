#
# ~/.config/zshrc.global
#

export XDG_DATA_HOME=~/.local/share

function in_path() {
    which "$1" > /dev/null 2>&1
}

#
# Prompt options
#

# Anonymous function to hide temporary variables from global scope
function {
    # TODO: show status of previous command (with color or symbol?)
    # The directory color
    local c_dir='%F{4}'
    # Only show hostname on SSH connections or in containers
    if [[ -z "$SSH_CLIENT" ]] && ! (in_path systemd-detect-virt && systemd-detect-virt --container > /dev/null); then
        local p_host=''
        local c_accent='%F{1}'
    else
        local p_host='@%m'
        local c_accent='%F{6}'
    fi
    local p_prefix="${c_accent}[%f"
    local p_user='%n'
    local p_dir="${c_dir}%~%f"
    local p_suffix="$c_accent]%(!.#.$)%f "

    PS1="${p_prefix}${p_user}${p_host} ${p_dir}${p_suffix}"
}

#
# Keyboard and editing options
#

unsetopt beep
# Vim keys
bindkey -v
# Let backspace work "normally" in insert mode.
bindkey -v '^?' backward-delete-char
# Faster mode switching
export KEYTIMEOUT=1

# Fix Home/End keys
# https://wiki.archlinux.org/title/Zsh#Key_bindings
function {
  typeset -g -A keys

  keys[Home]="${terminfo[khome]}"
  keys[End]="${terminfo[kend]}"

  [[ -n "${keys[Home]}" ]] && bindkey -- "${keys[Home]}" beginning-of-line
  [[ -n "${keys[End]}"  ]] && bindkey -- "${keys[End]}" end-of-line
}

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^O" edit-command-line

autoload -Uz compinit
compinit

compdef _gnu_generic start

#
# History options
#

HISTFILE=$XDG_DATA_HOME/zsh_history
HISTSIZE=1000
SAVEHIST=1000

setopt HIST_IGNORE_DUPS

#
# Skim/FZF
#

function {
    if in_path sk; then
        local skim_share_path=/usr/share/skim
        if in_path sk-share; then # Used on NixOS
            skim_share_path="$(sk-share)"
        fi
        if [ -d "$skim_share_path" ]; then
            source "${skim_share_path}/key-bindings.zsh"
        fi
    elif in_path fzf; then
        local fzf_share_path=/usr/share/doc/fzf/examples # Debian/Ubuntu
        if in_path fzf-share; then # Used on NixOS
            fzf_share_path="$(fzf-share)"
        fi
        if [ -d "$fzf_share_path" ]; then
            source "${fzf_share_path}/key-bindings.zsh"
        fi
    fi
}

if in_path atuin; then
    eval "$(atuin init zsh --disable-up-arrow)"
fi

# Used on Arch Linux with the zsh-syntax-highlighting package
function {
    local syntax_plugin=/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    if [ -f "$syntax_plugin" ]; then
        source "$syntax_plugin"
    fi
}

#
# Cleanup
#

unset -f in_path

#
# Get config options common to all (sh-like) shells
#

source ~/.config/profile.global
