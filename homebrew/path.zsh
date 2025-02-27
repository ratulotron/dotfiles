# export PATH="/opt/homebrew/bin:$PATH"

# Add Homebrew to the path
if test "$(uname)" = "Darwin"
then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi