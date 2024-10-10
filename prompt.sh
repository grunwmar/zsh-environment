#!/usr/bin/zsh

function get_git_branch () {
   git branch --show-current 2>/dev/null
}

function precmd () {
  NEWLINE=$'\n'

  GIT=$(get_git_branch)
  if ! [[ -z $GIT ]]; then
    GIT="%F{11} $GIT%f"
  fi

  VENV=$(basename "$VIRTUAL_ENV")
  if ! [[ -z $VENV ]]; then
    VENV="%F{5}:$VENV%f "
  fi

  TOPROW="$VENV"

  PROMPT="$TOPROW$NEWLINE%F{10}%3~%f%b$GIT %B%%%b "
  RPROMPT="%F{14}%n%f%F{6}@%m%f %F{2}%T%f"

  if [[ $COLUMNS -lt 127 ]]; then
    RPROMPT="%F{14}%n%f %F{2}%T%f"
  fi

  if [[ $COLUMNS -lt 111 ]]; then
    PROMPT="$TOPROW$NEWLINE%F{10}%2~%f%b$GIT %B%%%b "
  fi

  if [[ $COLUMNS -lt 100 ]]; then
    PROMPT="$TOPROW$NEWLINE%F{10}%c%f%b$GIT %B%%%b "
  fi

  if [[ $COLUMNS -lt 70 ]]; then
    TOPROW="%F{14}%n%f "$TOPROW
    PROMPT="$TOPROW$NEWLINE%F{10}%c%f%b$GIT %B%%%b "
    RPROMPT="%F{2}%T%f"
  fi

  export PROMPT="$NEWLINE$PROMPT"
  export RPROMPT="$RPROMPT"
}

