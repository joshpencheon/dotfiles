# Ensure local bin directory is sourced:
PATH=~/.local/bin:/opt/homebrew/bin:$PATH

if command -v brew > /dev/null; then
  eval "$(brew shellenv)"
fi

# Source all files in the symlinked directory:
for file in ~/.dot/shrc/*.sh; do
  source "$file"
done
unset file

# Source local config, if present:
if [ -e ~/.bashrc.local ]; then
  source ~/.bashrc.local
fi

# Remove any duplicates that have crept in:
export PATH="$(consolidate-path "$PATH")"

