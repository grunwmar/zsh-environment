#!/usr/bin/zsh

# clone repo
git clone https://github.com/grunwmar/zsh-environment.git "$HOME/.zshrc.d"

# create user's custom directory
if ! [[ -d "$HOME/.zsh_user" ]]; then
  mkdir "$HOME/.zsh_user"
  mkdir "$HOME/.zsh_user/plugins"
  echo "#!/usr/bin/zsh" > "$HOME/.zsh_user/plugins/plugins.sh"
  echo "#!/usr/bin/zsh" > "$HOME/.zsh_user/aliases.sh"
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
ln -s "$HOME/.zshrc.d/zshrc.sh" "$HOME/.zshrc"
