package main

import (
	"log"

	"github.com/mediocregopher/radix.v2/redis"
)

// Reader reads currencies from redis
type Reader struct {
	redis *redis.Client
}

func newReader() *Reader {
	redis, err := redis.Dial("tcp", "redis:6379")
	if err != nil {
		log.Fatal("No redis connection")
	}
	return &Reader{redis: redis}
}

func (r *Reader) getCurrencies() []byte {
	lastCurrencies, err := r.redis.Cmd("GET", "currencies").Str()
	if err != nil {
		log.Println("Cannot get currencies:", err)
	}
	return []byte(lastCurrencies)
}
