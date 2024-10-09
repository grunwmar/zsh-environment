#!/usr/bin/zsh
alias ls="ls --color=yes"
alias l="ls -lh"
alias ll="ls -lAh"

alias nn="nano -T3"
alias tx="tmux"

# Update environment from git
function update-ze () {
  echo -n "Do you want to download zsh-environment from git? [y/N] "
  read ANSW
  if [[ $ANSW = "y" ]]; then
    PWDBK="$PWD"
    cd $HOME/.local/zshrc.d
    git pull -f
    cd "$PWDBK"
  fi
}