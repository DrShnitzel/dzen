package main

import (
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/gorilla/websocket"
)

// Client handeles connection and messege sending to client application
type Client struct {
	hub     *Hub
	conn    *websocket.Conn
	message chan []byte
}

func newClient(hub *Hub, conn *websocket.Conn) *Client {
	client := &Client{
		hub:     hub,
		conn:    conn,
		message: make(chan []byte),
	}
	client.hub.add <- client
	return client
}

const (
	writeWait  = 10 * time.Second
	pongWait   = 60 * time.Second
	pingPeriod = 55 * time.Second
)

func (c *Client) writer() {
	ticker := time.NewTicker(pingPeriod)
	defer ticker.Stop()
	defer c.conn.Close()

	for {
		select {
		case message, ok := <-c.message:
			c.conn.SetWriteDeadline(time.Now().Add(writeWait))
			if !ok {
				c.conn.WriteMessage(websocket.CloseMessage, []byte{})
				return
			}

			w, err := c.conn.NextWriter(websocket.TextMessage)
			if err != nil {
				return
			}
			w.Write(message)

			n := len(c.message)
			for i := 0; i < n; i++ {
				w.Write(<-c.message)
			}

			if err := w.Close(); err != nil {
				return
			}
		case <-ticker.C:
			c.conn.SetWriteDeadline(time.Now().Add(writeWait))
			if err := c.conn.WriteMessage(websocket.PingMessage, nil); err != nil {
				return
			}
		}
	}
}

var upgrader = websocket.Upgrader{CheckOrigin: checkOrigin}

// Сonnection may come from diffirent port or domain
func checkOrigin(r *http.Request) bool {
	return true
}

func curences(hub *Hub, reader *Reader, w http.ResponseWriter, r *http.Request) {
	c, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		log.Print("upgrade:", err)
		return
	}

	client := newClient(hub, c)
	go client.writer()
	msg := reader.getCurences()
	fmt.Println(string(msg[:]))
	client.message <- msg
}
