export GOPATH="$XDG_DATA_HOME/go"
export PATH="$GOPATH/bin:$PATH"
export GO111MODULE="on"
# export GOPRIVATE="*.company.com,github.com/company"
# export GOPROXY="https://company.com/repos/api/go/golang-virtual,direct"

got() {
    go test ${1:-./...} | grep --color=always -E "FAIL.*|$"
}

gotc() {
    go test -coverprofile /dev/null ${1:-./...} | grep --color=always -E "FAIL.*|$"
}
