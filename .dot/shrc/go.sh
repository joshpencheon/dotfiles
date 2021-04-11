# Adds Go binaries to the path, if Go is installed.
if command -v go > /dev/null; then
  export PATH=$(go env GOPATH)/bin:$PATH
fi
