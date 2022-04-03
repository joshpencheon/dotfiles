# Don't try to configure brew if we don't have it
command -v brew > /dev/null || return

brew_dir=$(brew --prefix)

export PATH="$brew_dir/sbin:$brew_dir/bin:$PATH"

# Only refresh brew once a day:
export HOMEBREW_AUTO_UPDATE_SECS=$((60*60*24))
