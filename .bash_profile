# Ensure local bin directory is sourced:
PATH=~/.bin:$PATH

# Source all files in the symlinked directory:
for file in ~/.shrc/*.sh; do
  source "$file"
done

# Remove any duplicates that have crept in:
#export PATH="$(consolidate-path "$PATH")"
export PATH="$(consolidate-path "$PATH")"

# Build the prompt of our dreams:
export PS1="\\[\\033[1m\\]\\[\\033[38;5;202m\\][\$(__rbenv_ps1)] \\[\\033[38;5;195m\\]\w\\[\\033[38;5;156m\\]\$(__git_ps1) \\[\\033[38;5;195m\\]\\$ \\[\\e[0m\\]\\[\\033[0m\\]"

# Source local config, if present:
if [ -e ~/.bash_profile.local ]; then
  source ~/.bash_profile.local
fi
