# Ensure local bin directory is sourced:
PATH=~/.local/bin:$PATH

# Source all files in the symlinked directory:
for file in ~/.dot/shrc/*.sh; do
  source "$file"
done
unset file

# Source local config, if present:
if [ -e ~/.bash_profile.local ]; then
  source ~/.bash_profile.local
fi

# Remove any duplicates that have crept in:
export PATH="$(consolidate-path "$PATH")"

# Source iTerm2's integration only if we're acutally using iTerm. Allow it to
# re-source if it was previously successfully installed (the check script doesn't
# function correctly inside tmux).
if [ -n $ITERM_SHELL_INTEGRATION_INSTALLED ] || ${HOME}/.isiterm2.sh; then
  test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
fi
