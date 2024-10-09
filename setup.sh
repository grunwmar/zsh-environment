#!/usr/bin/zsh

# clone repo
git clone https://github.com/grunwmar/zsh-environment.git "$HOME/.local/zshrc.d"

# create user's custom directory
if ! [[ -d "$HOME/.zsh_user" ]]; then
  mkdir "$HOME/.zsh_user"
fi

# checks if .zshrc.sh file is present and asks to remove it
if [[ -f "$HOME/.zshrc" ]]; then
  echo -n "Remove original '.zshrc' file? [y/N]"
  read ANSW
  if [[ $ANSW = 'y' ]]; then
    rm $HOME/.zshrc
  fi
fi

# creates symbolic links to .zshrc
ln -s "$HOME/.local/zshrc.d/zshrc.sh" "$HOME/.zshrc"
