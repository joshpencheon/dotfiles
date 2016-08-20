# brew install coreutils
# brew install findutils --with-default-names
# brew install gnu-indent --with-default-names
# brew install gnu-sed --with-default-names
# brew install gnutls
# brew install grep --with-default-names
# brew install gnu-tar --with-default-names
# brew install gawk

# On macOS, if coreutils have been installed, use them instead:
if [[ -d `brew --prefix`/opt/coreutils/libexec/gnubin ]]; then
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi
