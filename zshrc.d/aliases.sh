#!/usr/bin/zsh
alias ls="ls --color=yes"
alias l="ls -lh"
alias ll="ls -lAh"

alias nn="nano -T3"
alias tx="termux"

# Update environment from git
function zeup () {
  PWDBK="$PWD"
  cd $HOME/.zsh-environment
  git pull -f
  cd "$PWDBK"
}