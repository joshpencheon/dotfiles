# Adds `config` as a wrapper around `git` configured with
# bare repository at ~/.cfg for managing dotfiles in home.
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

