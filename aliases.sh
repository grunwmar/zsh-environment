#!/usr/bin/zsh
alias ls="ls --color=yes"
alias l="ls -lh"
alias ll="ls -lAh"

alias nn="nano -T3"
alias tx="tmux"

# Update environment from git
function zeup () {
  PWDBK="$PWD"
  cd $HOME/.local/zshrc.d
  git pull -f
  cd "$PWDBK"
}