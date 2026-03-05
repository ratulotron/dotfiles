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
# BEGIN_AWS_SSO_CLI

# AWS SSO requires `bashcompinit` which needs to be enabled once and
# only once in your shell.  Hence we do not include the two lines:
#
# autoload -Uz +X compinit && compinit
# autoload -Uz +X bashcompinit && bashcompinit
#
# If you do not already have these lines, you must COPY the lines 
# above, place it OUTSIDE of the BEGIN/END_AWS_SSO_CLI markers
# and of course uncomment it

__aws_sso_profile_complete() {
     local _args=${AWS_SSO_HELPER_ARGS:- -L error}
    _multi_parts : "($(/opt/homebrew/bin/aws-sso ${=_args} list --csv Profile))"
}

aws-sso-profile() {
    local _args=${AWS_SSO_HELPER_ARGS:- -L error}
    local _sso=""
    local _profile=""
    
    if [ -n "$AWS_PROFILE" ]; then
        echo "Unable to assume a role while AWS_PROFILE is set"
        return 1
    fi

    # Parse arguments
    while [ $# -gt 0 ]; do
        case "$1" in
            -S|--sso)
                shift
                if [ -z "$1" ]; then
                    echo "Error: -S/--sso requires an argument"
                    return 1
                fi
                _sso="$1"
                shift
                ;;
            -*)
                echo "Unknown option: $1"
                echo "Usage: aws-sso-profile [-S|--sso <sso-instance>] <profile>"
                return 1
                ;;
            *)
                if [ -z "$_profile" ]; then
                    _profile="$1"
                else
                    echo "Error: Multiple profiles specified"
                    return 1
                fi
                shift
                ;;
        esac
    done

    if [ -z "$_profile" ]; then
        echo "Usage: aws-sso-profile [-S|--sso <sso-instance>] <profile>"
        return 1
    fi

    # Build and execute the eval command with optional SSO flag
    if [ -n "$_sso" ]; then
        eval $(/opt/homebrew/bin/aws-sso ${=_args} -S "$_sso" eval -p "$_profile")
    else
        eval $(/opt/homebrew/bin/aws-sso ${=_args} eval -p "$_profile")
    fi
    
    if [ "$AWS_SSO_PROFILE" != "$_profile" ]; then
        return 1
    fi
}

aws-sso-clear() {
    local _args=${AWS_SSO_HELPER_ARGS:- -L error}
    if [ -z "$AWS_SSO_PROFILE" ]; then
        echo "AWS_SSO_PROFILE is not set"
        return 1
    fi
    eval $(/opt/homebrew/bin/aws-sso ${=_args} eval -c)
}

compdef __aws_sso_profile_complete aws-sso-profile
complete -C /opt/homebrew/bin/aws-sso aws-sso

# END_AWS_SSO_CLI
