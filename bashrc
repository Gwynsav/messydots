# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

######################################################
# just terminal startup stuff, I don't even use bash as root shell lol.
$HOME/.local/bin/bunnyfetch

eval "$(starship init bash)"
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
. "$HOME/.cargo/env"
