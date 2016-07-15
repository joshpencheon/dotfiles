for file in ~/.shrc/prompt/*.sh; do
  source "$file"
done

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1

# Build the prompt of our dreams:
export PS1="\\[\\033[1m\\]\\[\\033[38;5;202m\\][\$(__rbenv_ps1)] \\[\\033[1;34m\\]\$(__conditional_host_ps1)\\[\\033[00m\\]\\[\\033[38;5;195m\\]\w\\[\\033[38;5;156m\\]\$(__git_ps1) \\[\\033[38;5;195m\\]\\$ \\[\\e[0m\\]\\[\\033[0m\\]"
