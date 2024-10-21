#!/usr/bin/zsh

# Checks if is running in development mode (-d) or enter
# custom paths for ZSH_RC_DIR and ZSH_USER_DIR
if [[ $1 = -d ]]; then
    export ZSH_RC_DIR="./"
    export ZSH_USER_DIR="./zshuser"
    echo "[Development mode]"
elif [[ $1 = -c ]]; then
    export ZSH_RC_DIR="$2"
    export ZSH_USER_DIR="$3"
else
    export ZSH_RC_DIR="$HOME/.zshrc.d"
    export ZSH_USER_DIR="$HOME/.zshuser"
fi

if [[ -d "$ZSH_RC_DIR/commands" ]]; then
    path+=("$ZSH_RC_DIR/commands")
    export PATH
fi

# Directory for custom zshrc and plugins
if ! [[ -d "$ZSH_USER_DIR" ]]; then
    mkdir "$ZSH_USER_DIR"
fi

if ! [[ -d "$ZSH_USER_DIR/plugins" ]]; then
    mkdir "$ZSH_USER_DIR/plugins"
fi


# Sources user's custom commands
if [[ -d "$ZSH_USER_DIR/commands" ]]; then
    path+=("$ZSH_USER_DIR/commands")
    export PATH
fi

function read_var() {
    ZVAR="$ZSH_USER_DIR/var"
    if [[ -f "$ZVAR/$1" ]]; then
      cat "$ZVAR/$1"
    else
      echo "$2" # Default value
    fi
}

function set_var() {
    ZVAR="$ZSH_USER_DIR/var"
    echo "$2" > "$ZVAR/$1"
}

# =========================== Hístory settings ===========================
export HISTFILE="$ZSH_USER_DIR/history.log"
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

source "$ZSH_RC_DIR/aliases.sh"

if [[ -f "$ZSH_USER_DIR/aliases.sh" ]]; then
    source "$ZSH_USER_DIR/aliases.sh"
fi

# Update environment from git
function ze-update () {
  echo -n "Do you want to download zsh-environment from git? [y/N] "
  read ANSW
  if [[ $ANSW = "y" ]]; then
    PWDBK="$PWD"
    cd $ZSH_RC_DIR
    git pull -f
    cd "$PWDBK"
  fi
}

OPT_FANCY_PROMPT=$(read_var "prompt/fancy-prompt" "off")

if [[ $OPT_FANCY_PROMPT = on ]]; then
  source "$ZSH_RC_DIR/prompt1.sh"
else
  source "$ZSH_RC_DIR/prompt.sh"
fi

if [[ -f "$ZSH_USER_DIR/plugins/plugins.sh" ]]; then
    source "$ZSH_USER_DIR/plugins/plugins.sh"
fi

if [[ -f "$ZSH_USER_DIR/zshrc.sh" ]]; then
    source "$ZSH_USER_DIR/zshrc.sh"
fi

which zsh
echo ""