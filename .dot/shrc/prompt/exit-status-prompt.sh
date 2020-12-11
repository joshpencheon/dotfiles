function __exit_status_ps1() {
  if [ $? != 0 ]; then
    printf "\033[38;5;124m• $(date +'%X')"
  else
    printf "\033[38;5;112m• $(date +'%X')"
  fi
}

