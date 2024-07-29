package main

import (
	"flag"
	"fmt"

	"github.com/boopdotpng/go-services.git/internal/api"
)

func main() {
	api_port := flag.Int("apiport", 3000, "port number of the api service")
	// websocket_port := flag.Int("websocketport", 3001, "port for websocket")

	flag.Parse()

	fmt.Println("hello! starting service.")
	api.StartAPI(*api_port)
}
