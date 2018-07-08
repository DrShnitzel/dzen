package main

import (
	"log"

	"github.com/mediocregopher/radix.v2/pubsub"
	"github.com/mediocregopher/radix.v2/redis"
)

// Updater recieves new curency values from redis pubsub and sens them to hub
type Updater struct {
	hub    *Hub
	pubsub *pubsub.SubClient
}

func newUpdater(hub *Hub) *Updater {
	redis, err := redis.Dial("tcp", "redis:6379")
	if err != nil {
		log.Fatal("No redis connection")
	}
	pubsub := pubsub.NewSubClient(redis)
	pubsub.Subscribe("curences-chanel")

	return &Updater{
		hub:    hub,
		pubsub: pubsub,
	}
}

func (u *Updater) run() {
	for {
		currences := u.pubsub.Receive().Message
		message := []byte(currences)
		u.hub.message <- message
	}
}
