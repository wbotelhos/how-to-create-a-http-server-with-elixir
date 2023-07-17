# How To Create a HTTP Server With Elixir

## Setup

```sh
git clone https://github.com/wbotelhos/how-to-create-a-http-server-with-elixir.git
cd how-to-create-a-http-server-with-elixir
```

## Run

On Terminal 1:

```sh
iex -S mix

HttpServer.start(4000)
```

On Terminal 2:

```sh
curl http://localhost:4000
```
