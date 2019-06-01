ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

BIN_DIR=bin
TARGET=socksprox.go
BINARY=socksprox
HTTP_BINARY=httpprox
VERSION=1.0.1
BUILD=`git rev-parse HEAD`
PLATFORMS=darwin linux windows
ARCHITECTURES=386 amd64

# Setup linker flags option for build that interoperate with variable names in src code
LDFLAGS=-ldflags "-X main.Version=${VERSION} -X main.Build=${BUILD}"

default: build

all: clean build-all install

build:
	go build ${LDFLAGS} ${TARGET} -o ${BIN_DIR}/${BINARY}
	go build ${LDFLAGS} ${HTTP_TARGET} -o ${BIN_DIR}/${BINARY}

build-all:
	$(foreach GOOS, $(PLATFORMS),\
	$(foreach GOARCH, $(ARCHITECTURES), $(shell export GOOS=$(GOOS); export GOARCH=$(GOARCH); go build $(TARGET) -v -o $(BIN_DIR)/$(BINARY)-$(GOOS)-$(GOARCH))))
	$(foreach GOOS, $(PLATFORMS),\
	$(foreach GOARCH, $(ARCHITECTURES), $(shell export GOOS=$(GOOS); export GOARCH=$(GOARCH); go build $(HTTP_TARGET) -v -o $(BIN_DIR)/$(HTTP_BIN)-$(GOOS)-$(GOARCH))))

install:
	go install ${LDFLAGS}

# Remove only what we've created
clean:
	rm ${ROOT_DIR}/${BIN_DIR}/*

.PHONY: check clean install build_all all
