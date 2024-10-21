#!/usr/bin/zsh
alias ls="ls --color=auto"
alias l="ls -lh"
alias ll="ls -lAh"
alias la="ls -A"
alias nn="nano -T3"

function cl () {
  cd $1
  if [[ $? = 0 ]]; then
     ls --color=auto .
  fi
}

function venv () {
  typeset -a venv_names
  venv_names=(venv .venv .python)

  for name in $venv_names; do
     vpath=$PWD/$name/bin/activate
     if [[ -f $vpath ]]; then
        source $vpath
     fi
  done
}

# git aliases
alias gad="git add"
alias gaa="git add ."
alias gcm="git commit -m"
alias gca="git commit -m ""#$(date)"
alias gpu="git push"
alias gpf="git push -f"