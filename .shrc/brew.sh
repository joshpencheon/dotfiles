if [[ "$OSTYPE" =~ ^linux  ]]; then
  export PATH="$HOME/.linuxbrew/bin:$PATH"
else
  export PATH="/usr/local/bin:$PATH"
fi
