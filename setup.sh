#!/usr/bin/zsh

# clone repo
git clone https://github.com/grunwmar/zsh-environment.git "$HOME/.zsh-environment"

# create user's custom directory
if ! [[ -d "$HOME/.zsh_user" ]]; then
  mkdir "$HOME/.zsh_user"
fi

# check if .zshrc.d directory is present and asks to remove it
if [[ -d "$HOME/.zshrc.d" ]]; then
  echo -n "Remove original '.zshrc.d' directory? [y/N]"
  read ANSW
  if [[ $ANSW = 'y' ]]; then
    rm -rf $HOME/.zshrc.d
  fi
fi

# checks if .zshrc file is present and asks to remove it
if [[ -f "$HOME/.zshrc" ]]; then
  echo -n "Remove original '.zshrc' file? [y/N]"
  read ANSW
  if [[ $ANSW = 'y' ]]; then
    rm $HOME/.zshrc
  fi
fi

# creates symbolic links .zshrc.d and .zshrc
ln -s "$HOME/.zsh-environment/zshrc.d" "$HOME/.zshrc.d"
ln -s "$HOME/.zsh-environment/zshrc" "$HOME/.zshrc"
