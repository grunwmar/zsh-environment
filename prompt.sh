#!/usr/bin/zsh


function get_git_branch () {
   git branch --show-current 2>/dev/null
}

function precmd () {
  NEWLINE=$'\n'

  GIT=$(get_git_branch)
  if ! [[ -z $GIT ]]; then
    GIT="%F{11}:$GIT%f"
  fi

  VENV=$(basename "$VIRTUAL_ENV")
  if ! [[ -z $VENV ]]; then
    VENV="%F{13}$VENV%f"
  fi

  TIME="[%F{14}%T%f]"
  USER_NAME="%B%F{2}%n%f%b"
  MACHINE_NAME="%F{2}%m%f"
  CWD="%3~"

  if [[ $COLUMNS -lt 91 ]]; then
    CWD="%1~"
  fi

  CWD="%F{14}$CWD%f"
  OPT_USER_NAME=$(read_var "prompt/username" "on")
  OPT_MACHINE_NAME=$(read_var "prompt/hostname" "on")
  OPT_TIME=$(read_var "prompt/time" "on")
  OPT_VENV=$(read_var "prompt/venv" "on")
  OPT_CWD=$(read_var "prompt/cwd" "on")
  OPT_GIT=$(read_var "prompt/git" "on")
  OPT_NEWLINE=$(read_var "prompt/newline" "on")
  PROMPT=""
  RPROMPT=""
  SEP1=""
  SEP2=""
  SEP3=""

  if [[ $OPT_NEWLINE = on ]]; then
    PROMPT="$NEWLINE"
  fi

  if { [[ $OPT_USER_NAME = on ]] || [[ $OPT_MACHINE_NAME = on ]] } && [[ $OPT_CWD = on ]]; then
    SEP1=":"
  fi

  if [[ $OPT_USER_NAME = on ]] && [[ $OPT_MACHINE_NAME = on ]]; then
    SEP2="%F{2}@%f"
  fi

  if [[ $OPT_TIME = on ]] || [[ $OPT_MACHINE_NAME = on ]]; then
    SEP3=" "
  fi

  if [[ $OPT_USER_NAME = on ]]; then
    PROMPT="$PROMPT$USER_NAME"
  fi

  if [[ $OPT_MACHINE_NAME = on ]]; then
    PROMPT+="$SEP2$MACHINE_NAME"
  fi

  if [[ $OPT_CWD = on ]]; then
    PROMPT+="$SEP1$CWD"
  fi

  if [[ $OPT_GIT = on ]]; then
    PROMPT+="$GIT"
  fi

  if [[ $OPT_VENV = on ]]; then
    RPROMPT+="$VENV$SEP3"
  fi

  if [[ $OPT_TIME = on ]]; then
    RPROMPT+="$TIME"
  fi

  export PROMPT="$PROMPT%B%%%b "
  export RPROMPT="$RPROMPT"
}

function ze:prompt() {
  ZUSETVAR="$ZUSERDIR/var/prompt"
  if ! [[ -d "$ZUSETVAR" ]]; then
      mkdir -p "$ZUSETVAR"
  fi
  set_var "$ZUSETVAR/$1" "$2"
}
