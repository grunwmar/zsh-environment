#!/usr/bin/zsh

function precmd () {
  export  PROMPT="[%n:%F{10}%3d%f]%% "
  export RPROMPT="[%F{10}%m%f|%F{10}%T%f]"

  if [[ $COLUMNS -lt 101 ]]; then
    export PROMPT="[%n:%F{10}%c%f]%% "
  fi

  if [[ $COLUMNS -lt 71 ]]; then
    export RPROMPT="[%F{10}%T%f]"
  fi
}

