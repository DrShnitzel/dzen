package main

import (
	"log"
	"net/http"
)

func main() {
	hub := newHub()
	go hub.run()

	go newUpdater(hub).run()
	reader := newReader()

	http.HandleFunc("/ws", func(w http.ResponseWriter, r *http.Request) {
		currencies(hub, reader, w, r)
	})
	log.Fatal(http.ListenAndServe(":80", nil))
}
