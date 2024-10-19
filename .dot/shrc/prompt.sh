if [ -n "$ZSH_VERSION" ]; then
   PROMPT="
%(?.%F{green}%*.%F{red}%*) %f%~
%(!.#.$) "
elif [ -n "$BASH_VERSION" ]; then
  for file in ~/.dot/shrc/prompt/*.sh; do
    source "$file"
  done

  # Build the prompt of our dreams:
  prompt="\n\\[\\033[1m\\]\$(__exit_status_ps1) "

  # Add AWS profile, if one is active:
  prompt="$prompt\$(__aws_vault_ps1)"

  # Add user@host, if this is a remote session:
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    prompt="$prompt\\[\\033[1;34m\\]\$(whoami)@\$(hostname -s) "
  fi

  # Add current working directory:
  prompt="$prompt\\[\\033[00m\\]\\[\\033[90m\\]\w"

  # Add git prompt:
  export GIT_PS1_SHOWDIRTYSTATE=1      # '+' / '*'
  export GIT_PS1_SHOWUNTRACKEDFILES=1  # '%'
  prompt="$prompt\\[\\033[92m\\]\$(__git_ps1 ' %s') "

  # Finish up:
  prompt="$prompt\n"
  prompt="$prompt\\[\\033[95m\\]$ \\[\\e[0m\\]\\[\\033[0m\\]"

  export PS1=$prompt
  export PS2="\\[\\033[95m\\]> \\[\\e[0m\\]\\[\\033[0m\\]"
fi
