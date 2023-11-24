# Don't pull in e.g. remote branch names when tab completing,
# without using a specific <<remote_name>>/ prefix:
export GIT_COMPLETION_CHECKOUT_NO_GUESS=1

# Adds '+' / '*' for staged and unstaged changes:
export GIT_PS1_SHOWDIRTYSTATE=1

# Adds '%' if there are untracked files:
export GIT_PS1_SHOWUNTRACKEDFILES=1
