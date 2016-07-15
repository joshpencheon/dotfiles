source ~/.shrc/brew.sh

# Bash autocompletion, via homebrew
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  source $(brew --prefix)/etc/bash_completion
fi
