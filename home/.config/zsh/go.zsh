export GOPATH="$XDG_DATA_HOME/go"
export PATH="$GOPATH/bin:$PATH"
export GO111MODULE="on"
# export GOPRIVATE="*.company.com"
# export GOPROXY="direct"

got() {
    go test ${1:-./...} | grep --color=always -E "FAIL.*|$"
}

gotc() {
    go test -coverprofile /dev/null ${1:-./...} | grep --color=always -E "FAIL.*|$"
}
