source ~/.dot/shrc/brew.sh

# Don't go any further if brew isn't configured
command -v brew > /dev/null || return

brew_dir=$(brew --prefix)

# Bash autocompletion, via homebrew
if [ -f $brew_dir/etc/bash_completion ]; then
  source $brew_dir/etc/bash_completion
fi

# For bash 4.0+ instead:
if [ -f $brew_dir/share/bash-completion/bash_completion ]; then
  source $brew_dir/share/bash-completion/bash_completion
fi
