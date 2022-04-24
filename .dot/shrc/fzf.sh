if test -d /opt/homebrew/opt/fzf; then
  # Setup fzf
  # ---------
  if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
    export PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
  fi

  # Auto-completion
  # ---------------
  [[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.bash" 2> /dev/null

  # Key bindings
  # ------------
  source "/opt/homebrew/opt/fzf/shell/key-bindings.bash"
else
  # Setup fzf
  # ---------
  if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
    export PATH="$PATH:$HOME/.fzf/bin"
  fi

  # Man path
  # --------
  if [[ ! "$MANPATH" == *$HOME/.fzf/man* && -d "$HOME/.fzf/man" ]]; then
    export MANPATH="$MANPATH:$HOME/.fzf/man"
  fi

  # Auto-completion
  # ---------------
  [[ $- == *i* ]] && source "$HOME/.fzf/shell/completion.bash" 2> /dev/null

  # Key bindings
  # ------------
  source "$HOME/.fzf/shell/key-bindings.bash"
fi


# By default, reset selection on further filtering:
export FZF_DEFAULT_OPTS='--bind change:top'
