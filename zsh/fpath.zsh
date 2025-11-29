# Add each topic folder to fpath so that they can add functions and completion scripts
for topic_folder ($DOTFILES/*) if [ -d $topic_folder ]; then  fpath=($topic_folder $fpath); fi;

# Add stowed completions directory to fpath
if [ -d "$HOME/.config/zsh/completions" ]; then
  fpath=("$HOME/.config/zsh/completions" $fpath)
fi
