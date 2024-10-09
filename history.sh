#!/usr/bin/zsh

export HISTFILE="$ZDOT/zsh_history.log"

export HISTSIZE=5000000
export SAVEHIST=$HISTSIZE

setopt EXTENDED_HISTORY
setopt inc_append_history