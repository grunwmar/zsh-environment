#!/usr/bin/zsh

# clone repo
git clone https://github.com/grunwmar/zsh-environment.git "$HOME/.zpkg"

# create user's custom directory
if ! [[ -d "$HOME/.zuser" ]]; then
  mkdir "$HOME/.zuser"
  mkdir "$HOME/.zuser/plugins"
  echo "#!/usr/bin/zsh" > "$HOME/.zuser/plugins/plugins.sh"
  echo "# load_plugin plugin-name-one" >> "$HOME/.zuser/plugins/plugins.sh"
  echo "# load_plugin plugin-name-two" >> "$HOME/.zuser/plugins/plugins.sh"
  echo "# load_plugin plugin-name-three" >> "$HOME/.zuser/plugins/plugins.sh"
  echo "# ..." >> "$HOME/.zuser/plugins/plugins.sh"
  echo "#!/usr/bin/zsh" > "$HOME/.zuser/aliases.sh"
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
ln -s "$HOME/.zpkg/zshrc.sh" "$HOME/.zshrc"
