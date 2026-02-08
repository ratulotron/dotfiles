# OH MY ZSH settings
export ZSH="$HOME/.oh-my-zsh"

# Dotfiles root (must be set before globbing for topic files)
export DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

# Load OMZ configuration from topic file (must be before sourcing OMZ)
if [[ -f "$HOME/.dotfiles/zsh/omz-config.zsh" ]]; then
  source "$HOME/.dotfiles/zsh/omz-config.zsh"
fi

# Load Oh My ZSH
source $ZSH/oh-my-zsh.sh


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

# Load completions
autoload -Uz compinit
compinit

# Completions for terraform
if command -v terraform >/dev/null 2>&1; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C "$(command -v terraform)" terraform
fi

# Docker completions
if [ -d "$HOME/.docker/completions" ]; then
  fpath=("$HOME/.docker/completions" $fpath)
fi

# UV completions
if command -v uvx >/dev/null 2>&1; then
  eval "$(uvx --generate-shell-completion zsh)"
fi
