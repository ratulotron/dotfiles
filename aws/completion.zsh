# AWS SSO CLI completions and helper functions
# Requires: aws-sso-cli (brew install aws-sso-cli)
# Must load AFTER compinit (hence completion.zsh, not init.zsh)

if ! command -v aws-sso >/dev/null 2>&1; then
    return
fi

# Locate the aws-sso binary once
_aws_sso_bin="$(command -v aws-sso)"

__aws_sso_profile_complete() {
    local _args=${AWS_SSO_HELPER_ARGS:- -L error}
    _multi_parts : "$(${_aws_sso_bin} ${=_args} list --csv Profile)"
}

aws-sso-profile() {
    local _args=${AWS_SSO_HELPER_ARGS:- -L error}
    local _sso=""
    local _profile=""

    if [ -n "$AWS_PROFILE" ]; then
        echo "Unable to assume a role while AWS_PROFILE is set"
        return 1
    fi

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

    if [ -n "$_sso" ]; then
        eval $(${_aws_sso_bin} ${=_args} -S "$_sso" eval -p "$_profile")
    else
        eval $(${_aws_sso_bin} ${=_args} eval -p "$_profile")
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
    eval $(${_aws_sso_bin} ${=_args} eval -c)
}

compdef __aws_sso_profile_complete aws-sso-profile
complete -C "${_aws_sso_bin}" aws-sso
