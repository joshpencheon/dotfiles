# Ensure local bin directory is sourced:
PATH=~/.bin:$PATH

# Source all files in the symlinked directory:
for file in ~/.shrc/*.sh; do
  source "$file"
done

# Remove any duplicates that have crept in:
#export PATH="$(consolidate-path "$PATH")"
export PATH="$(consolidate-path "$PATH")"

# Source local config, if present:
if [ -e ~/.bash_profile.local ]; then
  source ~/.bash_profile.local
fi
