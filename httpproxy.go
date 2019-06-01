
package main

import (
	"github.com/elazarl/goproxy"
  "os"
	"log"
	"flag"
	"net/http"
)

func main() {
  envPort := os.Getenv("HTTP_PROXY_PORT")
  if len(envPort) == 0 {
      envPort = "8080"
  }

  envListen := os.Getenv("HTTP_PROXY_LISTEN")
  if len(envListen) == 0 {
      envListen = "0.0.0.0"
  }

  verbose := flag.Bool("v", false, "should every proxy request be logged to stdout")

  port := flag.String("port", envPort, "HTTP Port")
  listen := flag.String("listen", envListen, "HTTP Listen")
	flag.Parse()

	proxy := goproxy.NewProxyHttpServer()
	proxy.Verbose = *verbose

  listenOn := fmt.Sprintf("%s:%s", *listen, *port)
  fmt.Printf("Listening on: %s\n", listenOn)

  if len(*user) != 0 && len(*password) != 0 {
    fmt.Println("Authentication Enabled!")
  }
  
	log.Fatal(http.ListenAndServe(listenOn, proxy))
}
