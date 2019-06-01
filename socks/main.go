package main

import (
	"log"
	"os"
	"flag"
	"fmt"
	"github.com/armon/go-socks5"
)

func main() {

	envUser := os.Getenv("SOCKS_USER")
	if len(envUser) == 0 {
      envUser = ""
  }

	envPassword := os.Getenv("SOCKS_PASSWORD")
	if len(envPassword) == 0 {
      envPassword = ""
  }

	envPort := os.Getenv("SOCKS_PORT")
	if len(envPort) == 0 {
      envPort = "1080"
  }

	envListen := os.Getenv("SOCKS_LISTEN")
	if len(envListen) == 0 {
			envListen = "0.0.0.0"
	}


	user := flag.String("user", envUser, "Socks5 User")
	password := flag.String("password", envPassword, "Socks5 Password")
	port := flag.String("port", envPort, "Socks5 Port")
	listen := flag.String("listen", envListen, "Socks5 Listen")

	flag.Parse()

	creadentials := socks5.StaticCredentials{
		*user: *password,
	}

	authenticator := socks5.UserPassAuthenticator{Credentials: creadentials}

	// Create a SOCKS5 server
	config := &socks5.Config{
		AuthMethods: []socks5.Authenticator{authenticator},
		Logger:      log.New(os.Stdout, "", log.LstdFlags),
	}

	server, err := socks5.New(config)
	if err != nil {
		panic(err)
	}

	// Create SOCKS5 proxy on localhost port 1080
	listenOn := fmt.Sprintf("%s:%s", *listen, *port)
	fmt.Printf("Listening on: %s\n", listenOn)

	if len(*user) != 0 && len(*password) != 0 {
		fmt.Println("Authentication Enabled!")
	}
	if err := server.ListenAndServe("tcp", listenOn); err != nil {
		panic(err)
	}
}
