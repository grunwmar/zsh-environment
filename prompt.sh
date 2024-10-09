#!/usr/bin/zsh

function get_git_branch () {
   git branch --show-current 2>/dev/null
}

function get_ip_address() {
    ifconfig |grep 'inet 192'|cut -d' ' -f10
}


function precmd () {

  GIT=$(get_git_branch)
  if ! [[ -z $GIT ]]; then
    GIT="%F{11}<$GIT>%f"
  fi

  VENV=$(basename "$VIRTUAL_ENV")
  if ! [[ -z $VENV ]]; then
    VENV="%F{13}$VENV%f|"
  fi

  export PROMPT="[$VENV%n:%F{10}%3~%f$GIT]%% "
  export RPROMPT="[%F{10}%m%f|%F{10}%T%f]"

  if [[ $COLUMNS -lt 101 ]]; then
    export PROMPT="[$VENV%n:%F{10}%c%f$GIT]%% "
    export RPROMPT="[%F{10}%m%f|%F{10}%T%f]"
  fi

  if [[ $COLUMNS -lt 71 ]]; then
    export RPROMPT="[%F{10}%T%f]"
  fi

  NEWLINE=$'\n'

  export PROMPT=$NEWLINE$PROMPT
}

