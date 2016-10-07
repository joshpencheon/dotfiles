for file in ~/.dot/shrc/prompt/*.sh; do
  source "$file"
done

# Build the prompt of our dreams:
prompt="\\[\\033[1m\\]"

# Add ruby version:
if command -v rbenv > /dev/null; then
  prompt="$prompt\\[\\033[38;5;202m\\][\$(rbenv version | sed -e 's/ .*//')] "
fi

# Add user@host, if this is a remote session:
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  prompt="$prompt\\[\\033[1;34m\\]\$(whoami)@\$(hostname -s) "
fi

# Add current working directory:
prompt="$prompt\\[\\033[00m\\]\\[\\033[38;5;195m\\]\w"

# Add git prompt:
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
prompt="$prompt\\[\\033[38;5;156m\\]\$(__git_ps1) "

# Finish up:
prompt="$prompt\\[\\033[38;5;195m\\]\\$ \\[\\e[0m\\]\\[\\033[0m\\]"

export PS1=$prompt
export PS2="\\[\\033[38;5;195m\\]> \\[\\e[0m\\]\\[\\033[0m\\]"

