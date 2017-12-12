# Bash History:
export HISTCONTROL=ignoreboth
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE=~/.bash_eternal_history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
