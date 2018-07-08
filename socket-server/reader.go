package main

import (
	"log"

	"github.com/mediocregopher/radix.v2/redis"
)

// Reader reads curences from redis
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

func (r *Reader) getCurences() []byte {
	lastCurences, err := r.redis.Cmd("GET", "curences").Str()
	if err != nil {
		log.Println("Cannot get curences:", err)
	}
	return []byte(lastCurences)
}
