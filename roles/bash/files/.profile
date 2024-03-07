
bindkey -s ^f "tmux-sessionizer\n"
bindkey -s ^g "lazygit\n"

if [ -n "$BASH_VERSION" -a -n "$PS1" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
      . "$HOME/.bashrc"
    fi
fi
