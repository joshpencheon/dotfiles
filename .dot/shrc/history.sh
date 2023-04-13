if [ -n "$ZSH_VERSION" ]; then
  export HISTFILE=~/.zsh_external_history
  export HISTSIZE=999999999
  export SAVEHIST=$HISTSIZE
  setopt HIST_IGNORE_SPACE
elif [ -n "$BASH_VERSION" ]; then
  export HISTCONTROL=ignoreboth
  export HISTFILESIZE=
  export HISTSIZE=
  export HISTTIMEFORMAT="[%F %T] "
  export HISTFILE=~/.bash_eternal_history
  export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
fi
