package main

import (
	"log"
	"net/http"
	"time"
)

func main() {
	// give redis time to start
	time.Sleep(10 * time.Second)
	hub := newHub()
	go hub.run()

	go newUpdater(hub).run()
	reader := newReader()

	http.HandleFunc("/ws", func(w http.ResponseWriter, r *http.Request) {
		currencies(hub, reader, w, r)
	})
	log.Fatal(http.ListenAndServe(":80", nil))
}
