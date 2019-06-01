# Why?

Just need a simple proxy that supports unauthenticated or authenticated connections? Don't want to edit another squid config? Need simple pivoting in, out, or within a network? This may be the proxy for you!

# About

This is a fork of Ocassio's project: https://github.com/ocassio/go-socks5-proxy (Thanks Ocassio!). The primary additions are making configuration options controllable at runtime.

You can use the following environment variables to configure the server:

- SOCKS_USER
- SOCKS_PASSWORD
- SOCKS_PORT
- SOCKS_LISTEN

You can also use command line arguments to control how the server listens and accepts connections:

```
Usage of ./server:
  -listen string
    	Socks5 Listen (default "0.0.0.0")
  -password string
    	Socks5 Password
  -port string
    	Socks5 Port (default "1080")
  -user string
    	Socks5 User
```

# Limitations

The base socks5 library by armon does not support the following commands:

- BIND
- ASSOCIATE

# Building

Simply run:

```
$ make build
$ ./bin/socksprox
```

## Cross Compiling

Simply run:

```
$ make build-all
```

# Original README

[![Docker Pulls](https://img.shields.io/docker/pulls/ocassio/go-socks5-proxy.svg)](https://hub.docker.com/r/ocassio/go-socks5-proxy/)

# Docker image usage

You can start Docker container with the following command (make sure to replace `<USER>` and `<PASSWORD>` placeholders with your own credentials).

```bash
docker run -d --name socks5-proxy -p 1080:1080 -e USER=<USER> -e PASSWORD=<PASSWORD> ocassio/go-socks5-proxy
```

# Build

The following command will perform a build of a static binary for Linux.
The result of this build can be used by a scratch Docker image. This reduces container size drastically.

```bash
CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o server .
```

# Special thanks

- The original idea. Actually, this project is just a very lightweight variation of the serj's one:
  https://github.com/serjs/socks5-server
- SOCKS5 server implementation for Go:
  https://github.com/armon/go-socks5
- Article about building minimal Go containers with Docker by Nick Gauthier:
  https://blog.codeship.com/building-minimal-docker-containers-for-go-applications/
