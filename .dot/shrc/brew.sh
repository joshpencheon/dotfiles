# Don't modify PATH again if we have `brew` already
command -v brew > /dev/null && return

if [[ "$OSTYPE" =~ ^linux  ]]; then
  export PATH="$HOME/.linuxbrew/bin:$PATH"
else
  export PATH="/usr/local/bin:$PATH"
fi
