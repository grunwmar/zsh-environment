#!/usr/bin/zsh

export HISTFILE="$ZDOT/zsh_history.log"

if [[ -d  "$ZUSERDIR" ]]; then
  HISTFILE="$ZUSERDIR/zsh_history.log"
fi

export HISTSIZE=5000000
export SAVEHIST=$HISTSIZE

setopt EXTENDED_HISTORY
setopt inc_append_history