# DZEN

https://dzen.clean-code.club

Website showing live updating currencies(when stock markets are not closed). The app is still under development, it does not have tests and can get performance and architecture improvements but it's fully functional.

It works nice on mobile. You can add it on home screen and use like an app.

![alt mobile_home](https://git.clean-code.club/drshnitsel/dzen/raw/master/documentation/mobile_home.jpg)
![alt mobile_app](https://git.clean-code.club/drshnitsel/dzen/raw/master/documentation/mobile_app.jpg)

## Running aplication

To run the application you need to install docker https://www.docker.com (for linux hosts you need to install docker-compose too)

Then simply run `docker-compose up`

The application should be available at http://localhost:8081

To run development environment run `docker-compose -f devel-compose.yml up`

## Components

### Front

Very small static html, css and js files without any frameworks(less than 5kb). It allows to instantly load app even on a poor connection. Also, static web files are easier to serve compared to dynamic you don't need to think about the cache, performance is much greater and it's more secure.

Front is connected to socket-server through websockets. socket-server sends to front information when currencies are updated.

### Socket-server

Websocket server written in go because we need to have many parallel connections( go is a good choice for concurrent programming because of goroutines and channels).

It gets information from redis(records and pubsub for updates) and then sends it to all connected clients.

### Redis

Is used as a database and pubsub. It connects together updater, socket-server and admin(not yet implemented).

### Updater

Ruby app that collects currency values from different sources and publishes them to redis.

### Balancer

nginx server used to serve different applications on one port. Also, it is easy to add https to whole application here

## Architecture

I have chosen to use microservice architecture here because it's more effective to implement different paths with different tools(see examples above). And it's easier to scale(we may want to have more front and socket server instances, but one admin and updater instances are always enough)
