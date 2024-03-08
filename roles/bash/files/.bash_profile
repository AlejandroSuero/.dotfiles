if [[ "$OSTYPE" == "darwin"* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

bindkey -s ^f "tmux-sessionizer\n"
bindkey -s ^g "lazygit\n"

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

if [ -n "$BASH_VERSION" -a -n "$PS1" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
      . "$HOME/.bashrc"
    fi
fi
