#!/usr/bin/zsh

# Checks if is running in development mode (-d) or enter
# custom paths for ZDOT and ZUSERDIR
if [[ $1 = -d ]]; then
    export ZDOT="./"
    export ZUSERDIR="./zsh_user"
    echo "[Development mode]"
elif [[ $1 = -c ]]; then
    export ZDOT="$2"
    export ZUSERDIR="$3"
else
    export ZDOT="$HOME/.zshrc.d"
    export ZUSERDIR="$HOME/.zsh_user"
fi

export DOTFILES="$ZUSERDIR/dotfiles"

if [[ -d "$ZDOT/commands" ]]; then
    path+=("$ZDOT/commands")
    export PATH
fi

# Directory for custom zshrc and plugins
if ! [[ -d "$ZUSERDIR" ]]; then
    mkdir "$ZUSERDIR"
fi

# Sources user's custom commands
if [[ -d "$ZUSERDIR/commands" ]]; then
    path+=("$ZUSERDIR/commands")
    export PATH
fi

function read_var() {

    ZUSETVAR="$ZUSERDIR/var"

    if [[ -f "$ZUSETVAR/$1" ]]; then
      cat "$ZUSETVAR/$1"
    else
      echo "$2" # Default value
    fi
}

function set_var() {
    echo "$2" > "$1"
}


# hístory settings
export HISTFILE="$ZUSERDIR/history.log"
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

source "$ZDOT/aliases.sh"

if [[ -f "$ZUSERDIR/aliases.sh" ]]; then
    source "$ZUSERDIR/aliases.sh"
fi

# Update environment from git
function ze:update () {
  echo -n "Do you want to download zsh-environment from git? [y/N] "
  read ANSW
  if [[ $ANSW = "y" ]]; then
    PWDBK="$PWD"
    cd $ZDOT
    git pull -f
    cd "$PWDBK"
  fi
}

source "$ZDOT/prompt.sh"

if [[ -f "$ZUSERDIR/plugins/plugins.sh" ]]; then
    source "$ZUSERDIR/plugins/plugins.sh"
fi

if [[ -f "$ZUSERDIR/zshrc.sh" ]]; then
    source "$ZUSERDIR/zshrc.sh"
fi
