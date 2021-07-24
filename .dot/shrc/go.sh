# Add Go default (linux) location to path:
export PATH=$PATH:/usr/local/go/bin

# Adds Go binaries to the path, if Go is installed.
if command -v go > /dev/null; then
  export PATH=$(go env GOPATH)/bin:$PATH
fi
