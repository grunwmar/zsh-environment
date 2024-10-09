#!/usr/bin/zsh

# Checks if is running in development mode (-d)
if [[ $1 = -d ]]; then
    export ZDOT="./zshrc.d"
    export ZUSERDIR="./zsh_user"
    echo "[Development mode]"
else
    export ZDOT="$HOME/.local/zshrc.d"
    export ZUSERDIR="$HOME/.zsh_user"
fi

export DOTFILES="$ZDOT/dotfiles"

if ! [[ -d "$ZDOT/commands" ]]; then
    export PATH="$PATH:$ZDOT/commands"
fi

if ! [[ -d "$ZUSERDIR" ]]; then
    mkdir "$ZUSERDIR"
fi

# Sources user's custom commands
if [[ -d "$ZUSERDIR/commands" ]]; then
    export PATH="$PATH:$ZUSERDIR/commands"
fi

source "$ZDOT/history.sh"
source "$ZDOT/prompt.sh"
source "$ZDOT/aliases.sh"

if [[ -f "$ZUSERDIR/zshrc.sh" ]]; then
    source "$ZUSERDIR/zshrc.sh"
fi

# Sources user's script containing some custom informations
# to show when terminal is open, e.g. ASCII art picture etc.
if [[ -f "$ZUSERDIR/logo.sh" ]]; then
    source "$ZUSERDIR/logo.sh"
fi
