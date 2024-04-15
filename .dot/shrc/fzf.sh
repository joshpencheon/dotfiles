if command -v fzf > /dev/null; then
   if [ -n "$ZSH_VERSION" ]; then
      eval "$(fzf --zsh)"
   elif [ -n "$BASH_VERSION" ]; then
      eval "$(fzf --bash)"
   fi

   # By default, reset selection on further filtering:
   export FZF_DEFAULT_OPTS='--bind change:top'
fi
