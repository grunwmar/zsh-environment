#!/usr/bin/zsh

export HISTFILE="$ZUSERDIR/zsh_history.log"

export HISTSIZE=5000000
export SAVEHIST=$HISTSIZE
export HISTDUP=erase
HISTTIMEFORMAT="%m-%s-%Y %H:%M> "

setopt EXTENDED_HISTORY
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_expire_dups_first
setopt completeinword
setopt hash_list_all
setopt share_history
setopt hist_ignore_space

zstyle ':completion:*' range 1000:100