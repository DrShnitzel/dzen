package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/websocket"
	"github.com/mediocregopher/radix.v2/pubsub"
	"github.com/mediocregopher/radix.v2/redis"
)

var upgrader = websocket.Upgrader{CheckOrigin: checkOrigin}

func checkOrigin(r *http.Request) bool {
	return true
}

func echo(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Connection created")

	client, err := redis.Dial("tcp", "redis:6379")
	if err != nil {
		log.Fatal("No redis connection")
	}
	defer client.Close()
	lastCurences, err := client.Cmd("GET", "curences").Str()
	if err != nil {
		log.Println("WriteMesage!:", err)
	}

	pubsub := pubsub.NewSubClient(client)
	defer pubsub.Client.Close()

	resp := pubsub.Subscribe("curences-chanel")
	fmt.Println(resp)

	c, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		log.Print("upgrade:", err)
		return
	}
	defer c.Close()

	err = c.WriteMessage(1, []byte(lastCurences))
	if err != nil {
		log.Println("WriteMesage:", err)
	}

	for {
		currences := pubsub.Receive().Message
		err = c.WriteMessage(1, []byte(currences))
		if err != nil {
			log.Println("write:", err)
			break
		}
	}
}

func main() {
	http.HandleFunc("/ws", echo)
	log.Fatal(http.ListenAndServe(":80", nil))
	fmt.Println("after")
}
