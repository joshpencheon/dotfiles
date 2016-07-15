# Adds `config` as a wrapper around `git` configured with
# bare repository at ~/.cfg for managing dotfiles in home.
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# ensure `config` gets git auto-completion:
if command -v __git_complete > /dev/null; then
  __git_complete config __git_main
fi
