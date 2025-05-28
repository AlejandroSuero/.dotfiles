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

alias gm="git merge --no-commit --no-ff"
# ======== Work Aliases ================
alias wnvim='NVIM_APPNAME="nvim.work" nvim'
alias knvim='NVIM_APPNAME="nvim.kickstart" nvim'
# ======================================

[[ ! -x "$(command -v fzf)" ]] || source <(fzf --zsh)
[[ ! -x "$(command -v thefuck)" ]] || eval "$(thefuck --alias)"
[[ ! -x "$(command -v zoxide)" ]] || eval "$(zoxide init zsh)"

# --- NVMRC Auto Check Start ---
# Automatically check for .nvmrc file on directory change and run nvm use.
INSTALL_MARKER="# NVMRC_AUTOCHECK_INSTALL_MARKER_V1" # Keep this marker for identification

# Define colors and symbols (only if not already defined or customize as needed)
if [ -z "$RED" ]; then export RED='[00;31m'; fi
if [ -z "$YELLOW" ]; then export YELLOW='[00;33m'; fi
if [ -z "$GREEN" ]; then export GREEN='[00;32m'; fi
if [ -z "$NC" ]; then export NC='[0m'; fi # No Color
WARNING="${RED}🚨${NC}"
CHECK_MARK="${GREEN}✔${NC}"

check_nvmrc() {
  # Check if nvm command exists
  if ! command -v nvm &> /dev/null; then
    # Only print warning if function is called interactively (e.g. not during shell startup)
    # Check for Zsh interactive shell: [[ -o INTERACTIVE ]]
    # Check for Bash interactive shell: [[ $- == *i* ]]
    if { [ -n "$ZSH_VERSION" ] && [[ -o INTERACTIVE ]]; } || { [ -n "$BASH_VERSION" ] && [[ $- == *i* ]]; }; then
        echo -e "${WARNING}${YELLOW} nvm command not found. Cannot check for .nvmrc.${NC}"
    fi
    return 1 # Indicate nvm is not available
  fi

  # Check if .nvmrc exists in the current directory
  # Using -e to check for file existence, including symlinks
  if [[ -e "$PWD"/.nvmrc ]]; then
    # Check if the current Node version matches .nvmrc already
    # nvm current prints the version, nvm version-remote reads .nvmrc
    local current_version=$(nvm current)
    local required_version=$(nvm which --silent) # Use --silent to avoid extra output

    # Compare versions only if nvm version-remote succeeded
    if [ -n "$required_version" ] && [ "$current_version" != "$required_version" ]; then
        echo -e "${CHECK_MARK}${GREEN} Found .nvmrc. Switching Node version...${NC}"
        # Run nvm use. Redirect output only if necessary.
        # Let nvm output its messages (e.g., version switching info, errors)
        nvm use --silent
    elif [ -n "$required_version" ]; then
        # Optional: uncomment the line below if you want confirmation even if version matches
        # echo -e "${CHECK_MARK}${GREEN}Found .nvmrc. Node version ($current_version) already matches.${NC}"
        : # Do nothing, version already matches
    else
        echo -e "${WARNING}${YELLOW} Found .nvmrc, but could not determine required version.${NC}"
    fi
  fi
}

# Store the original cd command if not already done
if [ -z "$__orig_cd_defined" ]; then
  # Check if 'cd' is already an alias or function to avoid potential issues
  if type cd | grep -q 'function' || type cd | grep -q 'alias'; then
      echo -e "${YELLOW} Warning: 'cd' is already a function or alias. Overriding might cause issues.${NC}"
      # Consider adding logic here to attempt to preserve existing overrides if necessary
  fi
  # For Bash/Zsh, 'builtin cd' ensures we call the actual cd command
  export __orig_cd_defined=1
fi
__orig_cd() { builtin cd "$@"; }


# Override the cd command
cd() {
  __orig_cd "$@" # Call the original cd command first
  local cd_exit_status=$? # Capture exit status of cd
  # Proceed only if cd was successful (exit status 0)
  if [ $cd_exit_status -eq 0 ]; then
      check_nvmrc # Then run the nvmrc check
  fi
  return $cd_exit_status # Return the original exit status of cd
}

# Add check_nvmrc to Zsh's chpwd_functions array if using Zsh
# This is an alternative/complement to overriding cd, runs whenever directory changes.
# It might be preferred in Zsh as it avoids potential conflicts with cd overrides.
# Uncomment the following lines if you prefer this Zsh-specific method instead of/alongside cd override.
# if [ -n "$ZSH_VERSION" ]; then
#   if [[ -z "${chpwd_functions[(r)check_nvmrc]}" ]]; then
#     chpwd_functions+=(check_nvmrc)
#   fi
# fi

# Optional: Run check_nvmrc once when the shell starts
check_nvmrc
# Optional: Add `cd` as a zoxide alias
# [[ ! -x "$(command -v zoxide)" ]] || eval "$(zoxide init --cmd cd zsh)"

# --- NVMRC Auto Check End ---
