# ensure GitHub's CLI has autocompletion:
if command -v gh > /dev/null; then
  eval "$(gh completion -s bash)"
fi
