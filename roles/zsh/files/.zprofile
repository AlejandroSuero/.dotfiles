[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[[ ! -d "$HOME/fzf-git.sh" ]] || source ~/fzf-git.sh/fzf-git.sh

# Load `zsh` configuration files
for file in $XDG_CONFIG_HOME/zsh/*.sh; do
  source $file
done
