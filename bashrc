#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

#
# Get config options common to all (sh-like) shells
#

source ~/.config/profile

