ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

BIN_DIR=bin
TARGET=socks/main.go
BINARY=socksprox
HTTP_TARGET=http/main.go
HTTP_BINARY=httpprox
VERSION=1.0.1
BUILD=`git rev-parse HEAD`
PLATFORMS=darwin linux windows
ARCHITECTURES=386 amd64

# Setup linker flags option for build that interoperate with variable names in src code
LDFLAGS=-ldflags "-X main.Version=${VERSION} -X main.Build=${BUILD}"

default: build

all: clean deps build-all install

build: build-socks

build-socks:
	go build ${LDFLAGS} -o ${BIN_DIR}/${BINARY} ${TARGET}

build-http:
	go build ${LDFLAGS} -o ${BIN_DIR}/${HTTP_BINARY} ${HTTP_TARGET}

build-all: build-socks-all build-http-all

build-socks-all:
	$(foreach GOOS, $(PLATFORMS),\
	$(foreach GOARCH, $(ARCHITECTURES),\
	$(shell export GOOS=$(GOOS); export GOARCH=$(GOARCH); go build -o $(BIN_DIR)/$(BINARY)-$(GOOS)-$(GOARCH) $(TARGET))))

build-http-all:
	$(foreach GOOS, $(PLATFORMS),\
	$(foreach GOARCH, $(ARCHITECTURES),\
	$(shell export GOOS=$(GOOS); export GOARCH=$(GOARCH); go build -o $(BIN_DIR)/$(HTTP_BINARY)-$(GOOS)-$(GOARCH) $(HTTP_TARGET))))

install:
	go install ${LDFLAGS}

deps:
	go get github.com/elazarl/goproxy
	go get github.com/armon/go-socks5

# Remove only what we've created
clean:
	rm -f "${ROOT_DIR}/${BIN_DIR}/*"

.PHONY: check clean install build-all all
