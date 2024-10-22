#!/usr/bin/zsh

# Checks if is running in development mode (-d) or enter
# custom paths for ZPKG and ZUSER
if [[ $1 = -d ]]; then
    export ZPKG="./"
    export ZUSER="./zuser"
    echo "[Development mode]"
elif [[ $1 = -c ]]; then
    export ZPKG="$2"
    export ZUSER="$3"
else
    export ZPKG="$HOME/.zpkg"
    export ZUSER="$HOME/.zuser"
fi

if [[ -d "$ZPKG/commands" ]]; then
    path+=("$ZPKG/commands")
    export PATH
fi

# Directory for custom zshrc and plugins
if ! [[ -d "$ZUSER" ]]; then
    mkdir "$ZUSER"
fi

if ! [[ -d "$ZUSER/plugins" ]]; then
    mkdir "$ZUSER/plugins"
fi

ZPLUGINS="$ZUSER/plugins"

# Sources user's custom commands
if [[ -d "$ZUSER/commands" ]]; then
    path+=("$ZUSER/commands")
    export PATH
fi

function read_var() {
    ZVAR="$ZUSER/var"
    if [[ -f "$ZVAR/$1" ]]; then
      cat "$ZVAR/$1"
    else
      echo "$2" # Default value
    fi
}

function set_var() {
    ZVAR="$ZUSER/var"
    echo "$2" > "$ZVAR/$1"
}

# =========================== Hístory settings ===========================
export HISTFILE="$ZUSER/history.log"
export HISTSIZE=5000000
export SAVEHIST=$HISTSIZE
export HISTDUP=erase

setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt APPEND_HISTORY
setopt HIST_NO_STORE

zstyle ':completion:*' range 1000:100

# ========================================================================

source "$ZPKG/aliases.sh"

if [[ -f "$ZUSER/aliases.sh" ]]; then
    source "$ZUSER/aliases.sh"
fi

# Update environment from git
function ze-update () {
  echo -n "Do you want to download zsh-environment from git? [y/N] "
  read ANSW
  if [[ $ANSW = "y" ]]; then
    PWDBK="$PWD"
    cd $ZPKG
    git pull -f
    cd "$PWDBK"
  fi
}

OPT_FANCY_PROMPT=$(read_var "prompt/fancy-prompt" "off")

if [[ $OPT_FANCY_PROMPT = on ]]; then
  source "$ZPKG/prompts/prompt1.sh"
else
  source "$ZPKG/prompts/prompt.sh"
fi

function load_plugin () {
    NAME="$1"
    source "$ZPLUGINS/$NAME/$NAME.plugin.zsh"
}

if [[ -f "$ZUSER/plugins/plugins.sh" ]]; then
    source "$ZUSER/plugins/plugins.sh"
fi

clear
echo " $(which zsh) | $USER@$HOSTNAME "
echo ""

if [[ -f "$ZUSER/zshrc.sh" ]]; then
    source "$ZUSER/zshrc.sh"
fi

