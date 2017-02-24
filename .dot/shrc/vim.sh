# Use NeoVim instead of vim, if it's available:
if command -v nvim > /dev/null; then
  export EDITOR=nvim
  alias vi=nvim
  alias vim=nvim
else
  export EDITOR=vi
fi
