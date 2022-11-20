# Defer to the bashrc file:
if [ -e ~/.bashrc ]; then
  source ~/.bashrc
fi

# Source local profile config, if present:
if [ -e ~/.bash_profile.local ]; then
  source ~/.bash_profile.local
fi
