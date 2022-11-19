# Defer to the bashrc file:
[ -e ~/.bashrc ] && source ~/.bashrc

# Source local config, if present:
[ -e ~/.bash_profile.local ] && source ~/.bash_profile.local
