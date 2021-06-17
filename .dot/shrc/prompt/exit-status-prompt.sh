function __exit_status_ps1() {
  status=$?
  dot="•" && [[ $OSTYPE == "darwin"* ]] && dot=""

  if [ $status != 0 ]; then
    printf "\033[38;5;124m$dot $(date +'%X')"
  else
    printf "\033[38;5;112m$dot $(date +'%X')"
  fi
}

