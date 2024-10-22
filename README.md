# zsh-environment
**command to install**
```shell
zsh -c "$(curl -fsSL https://raw.githubusercontent.com/grunwmar/zsh-environment/refs/heads/main/setup.sh)"
```
Script creates two subdirectories and one symlink file in users `$HOME` directory
* directory `~/.zshrc.d` containing main code of environment
* directory `~/.zshuser` for user custom code, plugins ect. 
* symlink `~/.zshrc` referencing to `~/.zshrc.d/zshrc.sh`

**commands**

At this time there is just few commands implemented
* `ze-update` for downloading newer version of environment
* `ze-prompt-set` to quicky turn `on / off` items shown in prompt and has format `ze-prompt-set item {on|off}`     
