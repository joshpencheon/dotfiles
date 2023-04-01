# ensure GitHub's CLI has autocompletion:
if command -v gh > /dev/null; then
  if [ -n "$ZSH_VERSION" ]; then
    eval "$(gh completion -s zsh)"
  elif [ -n "$BASH_VERSION" ]; then
    eval "$(gh completion -s bash)"
  fi
fi
