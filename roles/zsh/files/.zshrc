if [[ -f "$XDG_CONFIG_HOME/zsh/.zsh_private" ]]; then
  source "$XDG_CONFIG_HOME/zsh/.zsh_private"
fi

# Download `zinit` if doesn't exist
if [ ! -d "${ZINIT_HOME}" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}"
fi

source "${ZINIT_HOME}/zinit.zsh"

if [[ ! -x "$(command -v starship)" ]]; then
  zinit light romkatv/powerlevel10k
else
  eval "$(starship init zsh)"
fi

# Load zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add snippets
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

zinit cdreplay -q

# History
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
# ======================================

# ========== Functions ===========
# ======== fzf functions =========
# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}
# ======= misc functions ========
junk() {
  for item in $@; do
    _task "Moving '$item' to the trash"
    # mv "$item" "$HOME/.Trash/"
    # _task_done
    _cmd "mv $item $HOME/.Trash/"
  done;
}

validateYaml() {
    python3 -c 'import yaml,sys;yaml.safe_load(sys.stdin)' < $1
}

check_nvmrc() {
  if [[ "$(command -v nvm)" == "" ]]; then
    echo -e "${WARNING}${YELLOW}nvm command not found${NC}"
  else
    if [[ -f "$PWD"/.nvmrc ]]; then
      echo -e "${INFO}${GREEN}nvmrc found${NC}"
      nvm use > /dev/null
    fi
  fi
}

cd() {
  builtin cd "$@"
  check_nvmrc
}

# ======= OS specific functions ========
source "$XDG_CONFIG_HOME/zsh/os_functions.sh"
# ======================================

# Completion styling
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}" # Case insensitive
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completion:*" menu no
# zstyle ":fzf-tab:complete:cd:*" fzf-preview "ls --color $realpath"
# ======================================

# =========== Aliases ===========
alias zshc="$EDITOR ~/.zshrc"
[[ ! -x "$(command -v ranger)" ]] || alias rr="ranger"

# ===== Directory aliases =======
if [[ -x "$(command -v eza)" ]]; then
  alias ls="eza --icons --classify"
  alias ll="eza -l --icons"
  alias la="eza -la --icons --classify"
else
  alias ls="ls --color"
  alias ll="ls -l --color"
  alias la="ls -la --color"
fi

# ======== Git Aliases ==========
alias yolo="git push origin main --force --no-verify"

alias g="git"
alias ghp="git --help"
alias gs="git status"

alias gcane="git commit --amend --no-edit"
alias gcm="git commit -m"

alias gc="git checkout"
alias gcb="git checkout -b"

alias gb="git switch"
alias gbc="git switch -c"
alias gbd="git branch -d"
alias gbs="git branch -a"

alias ggl="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all"

alias gps="git push"
alias gpsf="git push --force-with-lease"

alias ga="git add"
alias gaa="git add ."
alias gaA="git add -A"

alias gf="git fetch"
alias gfa="git fetch --all --prune"

alias gpl="git pull"
# ======== Work Aliases ================
alias wnvim='NVIM_APPNAME="nvim.work" nvim'
alias knvim='NVIM_APPNAME="nvim.kickstart" nvim'
# ======================================

[[ ! -x "$(command -v fzf)" ]] || source <(fzf --zsh)
[[ ! -x "$(command -v zoxide)" ]] || eval "$(zoxide init --cmd cd zsh)"
[[ ! -x "$(command -v thefuck)" ]] || eval "$(thefuck --alias)"

[[ ! -f "$PWD/.nvmrc" ]] || check_nvmrc
