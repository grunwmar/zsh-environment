#!/usr/bin/zsh

function get_git_branch () {
   git branch --show-current 2>/dev/null
}

function precmd () {
  NEWLINE=$'\n'

  GIT=$(get_git_branch)
  if ! [[ -z $GIT ]]; then
    GIT=" %F{5} $GIT%f "
  fi

  VENV=$(basename "$VIRTUAL_ENV")
  if ! [[ -z $VENV ]]; then
    VENV=" %F{6} $VENV%f "
  fi

  PROMPT_SIGN="%F{15}%(!.#.)%f"
  PREV_CMD_STATUS_VALUE="%(?..%F{1} %!%f)"
  TIME=" %T"
  USER_NAME="%(!.%F{11}%B%f%F{5}%n%f%b.%F{10}%n%f)"
  MACHINE_NAME="%F{2}%m%f"
  CURRENT_DIR="%3~"

  if [[ $COLUMNS -lt 51 ]]; then
    CURRENT_DIR="%1~"
  fi

  CURRENT_DIR="%F{15}$CURRENT_DIR%f"

  OPT_USER_NAME=$(read_var "prompt/username" "on")
  OPT_MACHINE_NAME=$(read_var "prompt/hostname" "on")
  OPT_TIME=$(read_var "prompt/time" "on")
  OPT_VENV=$(read_var "prompt/venv" "on")
  OPT_CWD=$(read_var "prompt/cwd" "on")
  OPT_GIT=$(read_var "prompt/git" "on")
  OPT_NEWLINE=$(read_var "prompt/newline" "on")
  OPT_CMDSTAT=$(read_var "prompt/command-status" "on")

  PROMPT=""
  RPROMPT=""
  SEP1=""
  SEP2=""

  if [[ $OPT_NEWLINE = on ]]; then
    PROMPT+="$NEWLINE"
  fi

  if { [[ $OPT_USER_NAME = on ]] || [[ $OPT_MACHINE_NAME = on ]] } && [[ $OPT_CWD = on ]]; then
    SEP1=" "
  fi

  if [[ $OPT_USER_NAME = on ]] && [[ $OPT_MACHINE_NAME = on ]]; then
    SEP2="%F{2}@%f"
  fi

  if [[ $OPT_USER_NAME = on ]]; then
    PROMPT="$PROMPT$USER_NAME"
  fi

  if [[ $OPT_MACHINE_NAME = on ]]; then
    PROMPT+="$SEP2$MACHINE_NAME"
  fi

  if [[ $OPT_CWD = on ]]; then
    PROMPT+="$SEP1$CURRENT_DIR"
  fi

  if [[ $OPT_GIT = on ]]; then
    RPROMPT+="$GIT"
  fi

  if [[ $OPT_VENV = on ]]; then
    RPROMPT+="$VENV"
  fi

  if [[ $OPT_TIME = on ]]; then
    RPROMPT+="$TIME"
  fi

  if [[ $OPT_CMDSTAT = on ]]; then
    RPROMPT="$PREV_CMD_STATUS_VALUE $RPROMPT"
  fi

  export PROMPT="$PROMPT$PROMPT_SIGN "
  export RPROMPT="$RPROMPT"
}

function ze-prompt-set() {
  ZVAR="$ZUSER/var/prompt"
  if ! [[ -d "$ZVAR" ]]; then
      mkdir -p "$ZVAR"
  fi
  set_var "prompt/$1" "$2"
}