# Use NeoVim instead of vim, if it's available:
nvim="$(brew --prefix)/bin/nvim"

if [ -e $nvim ]; then
  export EDITOR=$nvim
  alias vi=nvim
  alias vim=nvim
fi
