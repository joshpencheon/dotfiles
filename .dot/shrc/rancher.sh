# Rancher, if installed, provides `docker` / `kubectl` etc
rancher_dir="$HOME/.rd/bin"

if [[ -d $rancher_dir ]]; then
  PATH=$rancher_dir:$PATH
fi
