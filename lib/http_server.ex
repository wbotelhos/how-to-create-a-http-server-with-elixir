defmodule HttpServer do
  def start(port) do
    {:ok, listen_socket} = :gen_tcp.listen(port, [:binary, packet: :raw, active: false, reuseaddr: true])

    IO.puts("Server running on #{port}...\n")

    accept_connection(listen_socket)
  end

  def accept_connection(listen_socket) do
    IO.puts("Waiting for connection...\n")

    {:ok, client_socket} = :gen_tcp.accept(listen_socket)

    IO.puts("Connection accepted!\n")

    process_request(client_socket)

    accept_connection(listen_socket)
  end

  def process_request(client_socket) do
    IO.puts("Processing request...\n")

    client_socket
    |> read_request
    |> create_response()
    |> write_response(client_socket)
  end

  def create_response(request) do
    if String.match?(request, ~r{GET /error}) do
      raise(request)
    end

    body = "Hello HTTP Server!"

    """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: #{byte_size(body)}\r
    \r
    #{body}
    """
  end

  def read_request(client_socket) do
    {:ok, request} = :gen_tcp.recv(client_socket, 0)

    request
  end

  def write_response(response, client_socket) do
    :ok = :gen_tcp.send(client_socket, response)

    IO.puts("Response:\n\n#{response}\n")

    :gen_tcp.close(client_socket)
  end
end
