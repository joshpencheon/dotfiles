# Don't try to configure brew if we don't have it
command -v brew > /dev/null || return

brew_dir=$(brew --prefix)

export PATH="$brew_dir/sbin:$brew_dir/bin:$PATH"

# Bash autocompletion, via homebrew
if [ -f $brew_dir/etc/bash_completion ]; then
  source $brew_dir/etc/bash_completion
fi

# For bash 4.0+ instead:
if [ -f $brew_dir/share/bash-completion/bash_completion ]; then
  source $brew_dir/share/bash-completion/bash_completion
fi
