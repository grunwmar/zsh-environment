#!/usr/bin/zsh
alias ls="ls --color=yes"
alias l="ls -lh"
alias ll="ls -lAh"
alias la="ls -A"
alias nn="nano -T3"
alias tx="tmux"

function cl () {
  cd $1
  if [[ $? = 0 ]]; then
     ls --color=auto .
  fi
}


