# Why?

Just need a simple proxy that supports unauthenticated or authenticated connections? Don't want to edit another squid config? Need simple pivoting in, out, or within a network? This may be the proxy for you!

# About

This project contains two forks:

- Occassio's Socks5 Proxy: https://github.com/ocassio/go-socks5-proxy (Thanks Ocassio!)
- Elazarl's HTTP Proxy: https://github.com/elazarl/goproxy/tree/master/examples/goproxy-basic

The primary additions are making configuration options controllable at runtime.

You can use the following environment variables to configure the socks5 server:

- SOCKS_USER
- SOCKS_PASSWORD
- SOCKS_PORT
- SOCKS_LISTEN

And the following variables to configure the HTTP server:

- HTTP_PROXY_PORT
- HTTP_PROXY_LISTEN

Authentication is not supported on the HTTP proxy.

You can also use command line arguments to control how the server listens and accepts connections:

```
Usage of ./socksprox:
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
$ ./bin/httpproxy
```

## Cross Compiling

Simply run:

```
$ make build-all
```
