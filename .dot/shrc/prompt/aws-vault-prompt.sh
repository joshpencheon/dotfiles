function __aws_vault_ps1() {
  if [ -n "$AWS_VAULT" ]; then
    printf "\033[38;5;202m$AWS_VAULT "
  fi
}
