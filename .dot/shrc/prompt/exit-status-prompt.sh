function __exit_status_ps1() {
  status=$?
  dot="•" && [[ $OSTYPE == "darwin"* ]] && dot=""

  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    # use blue / yellow for SSH sessions...
    colour=$([ $status == 0 ] && echo "81" || echo "227")
  else
    # ...otherwise, red / green:
    colour=$([ $status == 0 ] && echo "112" || echo "124")
  fi

  printf "\033[38;5;${colour}m$dot $(date +"%X")"
}

