# Enable bash completion, if it has been installed:
if command -v brew > /dev/null; then
  bash_completion="$(brew --prefix)/etc/profile.d/bash_completion.sh"
  [[ -r $bash_completion ]] && . $bash_completion
fi
