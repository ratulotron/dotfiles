# OH MY ZSH settings
export ZSH="$HOME/.oh-my-zsh"

# Oh My ZSH Configuration
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="false"
DISABLE_UPDATE_PROMPT="false"
export UPDATE_ZSH_DAYS=13
DISABLE_MAGIC_FUNCTIONS="false"
DISABLE_LS_COLORS="false"
DISABLE_AUTO_TITLE="false"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="false"
HIST_STAMPS="yyyy-mm-dd"

# Oh My ZSH Plugins
plugins=(
    # Essential plugins
    git
    docker
    docker-compose
    
    # Language and frameworks
    node
    npm
    python
    rust
    golang
    
    # Tools and utilities
    terraform
    helm
    
    # Productivity
    history          # History shortcuts
    colored-man-pages
    
    # Enhanced shell features
    zsh-autosuggestions
    zsh-syntax-highlighting

    # Custom plugins
    eza
)

# ZSH_THEME is disabled - using Starship instead
# ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

# Custom
# shortcut to this dotfiles path is $DOTFILES
export DOTFILES=~/.dotfiles

# your project folder that we can `c [tab]` to
export PROJECTS=~/Code


# Stash your environment variables in ~/.localrc. This means they'll stay out
# of your main dotfiles repository (which may be public, like this one), but
# you'll have access to them in your scripts.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

# all of our zsh files
typeset -U config_files
config_files=($DOTFILES/**/*.zsh)

# Initialize Homebrew early so all path files can use it
if test "$(uname)" = "Darwin"; then
    eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null
elif test "$(expr substr $(uname -s) 1 5)" = "Linux"; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" 2>/dev/null
fi

# load the path files
for file in ${(M)config_files:#*/path.zsh}
do
  source $file
done

# load everything but the path and completion files
for file in ${${config_files:#*/path.zsh}:#*/completion.zsh}
do
  source $file
done

# Normalize Home/End keys across terminals
if [[ -n ${terminfo[khome]} ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line
  bindkey -M vicmd "${terminfo[khome]}" beginning-of-line 2>/dev/null
fi
if [[ -n ${terminfo[kend]} ]]; then
  bindkey "${terminfo[kend]}" end-of-line
  bindkey -M vicmd "${terminfo[kend]}" end-of-line 2>/dev/null
fi

# initialize autocomplete here, otherwise functions won't be loaded

# load every completion after autocomplete loads
for file in ${(M)config_files:#*/completion.zsh}
do
  source $file
done

unset config_files


if [ -f "$HOME/.local/bin/env" ]; then
  . "$HOME/.local/bin/env"
fi

if command -v terraform >/dev/null 2>&1; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C "$(command -v terraform)" terraform
fi

if [ -d "$HOME/.docker/completions" ]; then
  fpath=("$HOME/.docker/completions" $fpath)
fi

autoload -Uz compinit
compinit

if command -v uvx >/dev/null 2>&1; then
  eval "$(uvx --generate-shell-completion zsh)"
fi

if [ -d "$HOME/.antigravity/antigravity/bin" ]; then
  export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
fi
