if [ -n "$ZSH_VERSION" ]; then
   source "$HOME/.fzf.zsh"
elif [ -n "$BASH_VERSION" ]; then
   source "$HOME/.fzf.bash"
fi

# By default, reset selection on further filtering:
export FZF_DEFAULT_OPTS='--bind change:top'
