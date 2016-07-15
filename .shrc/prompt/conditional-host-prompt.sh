# Returns host string if connected using SSH
__conditional_host_ps1 ()
{
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    printf "`whoami`@`hostname -s` "
  fi
}
