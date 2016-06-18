# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/Josh/.fzf/bin* ]]; then
  export PATH="$PATH:/Users/Josh/.fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */Users/Josh/.fzf/man* && -d "/Users/Josh/.fzf/man" ]]; then
  export MANPATH="$MANPATH:/Users/Josh/.fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/Josh/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/Users/Josh/.fzf/shell/key-bindings.bash"

