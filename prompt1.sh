#!/usr/bin/zsh

function get_git_branch () {
   git branch --show-current 2>/dev/null
}

function precmd () {
  NEWLINE=$'\n'

  GIT=$(get_git_branch)
  if ! [[ -z $GIT ]]; then
    GIT="%S  $GIT %s"
  fi

  VENV=$(basename "$VIRTUAL_ENV")
  if ! [[ -z $VENV ]]; then
    VENV="%S  $VENV %s"
  fi

  PROMPT_SIGN=" %F{15}%B%(!.#.%%)%b%f"
  PREV_CMD_STATUS_VALUE="%(?.%F{10}%f.%F{9}%S %! %s%f)"
  TIME="%S %T %s"
  USER_NAME=" 󰀓 %n"
  MACHINE_NAME="  %m "
  CURRENT_DIR="%3~"

  if [[ $COLUMNS -lt 51 ]]; then
    CURRENT_DIR="%1~"
  fi

  CURRENT_DIR="$CURRENT_DIR"

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

  if { [[ $OPT_USER_NAME = on ]] || [[ $OPT_MACHINE_NAME = on ]] } && [[ $OPT_CWD = on ]]; then
    SEP1=" "
  fi

  if [[ $OPT_USER_NAME = on ]] && [[ $OPT_MACHINE_NAME = on ]]; then
    SEP2=" "
  fi

  if [[ $OPT_USER_NAME = on ]]; then
    PROMPT="$PROMPT$USER_NAME"
  fi

  if [[ $OPT_MACHINE_NAME = on ]]; then
    PROMPT+="$SEP2$MACHINE_NAME"
  fi

  if [[ $OPT_CWD = on ]]; then
    PROMPT="%S$PROMPT%s $CURRENT_DIR"
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
    RPROMPT="$PREV_CMD_STATUS_VALUE$RPROMPT"
  fi

  export PROMPT="$NEWLINE$PROMPT  "
  export RPROMPT="$RPROMPT"
}

function ze-prompt-set() {
  ZVAR="$ZSH_USER_DIR/var/prompt"
  if ! [[ -d "$ZVAR" ]]; then
      mkdir -p "$ZVAR"
  fi
  set_var "prompt/$1" "$2"
}
