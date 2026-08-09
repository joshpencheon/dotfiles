function __exit_status_ps1() {
  status=$?
  dot="•" && [[ $OSTYPE == "darwin"* ]] && dot=""

  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    # use blue / yellow for SSH sessions...
    colour=$([ $status == 0 ] && echo "34" || echo "93")
  else
    # ...otherwise, red / green:
    colour=$([ $status == 0 ] && echo "92" || echo "31")
  fi

  printf "\033[${colour}m$dot $(date +"%X")"
}

