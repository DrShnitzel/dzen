package main

// Hub is responsable for broadcasting messages to all connected clients.
type Hub struct {
	clients map[*Client]bool
	add     chan *Client
	remove  chan *Client
	message chan []byte
}

func newHub() *Hub {
	return &Hub{
		clients: make(map[*Client]bool),
		add:     make(chan *Client),
		remove:  make(chan *Client),
		message: make(chan []byte),
	}
}

func (h *Hub) addClient(c *Client) {
	h.clients[c] = true
}

func (h *Hub) removeClient(c *Client) {
	if _, ok := h.clients[c]; ok {
		delete(h.clients, c)
		close(c.message)
	}
}

func (h *Hub) broadcast(message []byte) {
	for client := range h.clients {
		select {
		case client.message <- message:
		// if client not accepting message it's probably dead
		default:
			h.removeClient(client)
		}
	}
}

func (h *Hub) run() {
	for {
		select {
		case client := <-h.add:
			h.addClient(client)
		case client := <-h.remove:
			h.removeClient(client)
		case message := <-h.message:
			h.broadcast(message)
		}
	}
}
