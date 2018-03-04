defmodule OmWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
   channel "room:*", OmWeb.RoomChannel
   channel "agar:*", OmWeb.AgarChannel
   channel "stik:*", OmWeb.StikChannel



  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket,
   timeout: 45_000
  # This ensures that any idle connections are closed by Phoenix
  # before they reach Heroku’s 55-second timeout window.

  # transport :longpoll, Phoenix.Transports.LongPoll

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.


  #  def connect(_params, socket) do
#    {:ok, socket}
#  end
  @max_age 2 * 7 * 24 * 60 * 60

  def connect(%{"token" => token}, socket) do
      case Phoenix.Token.verify(socket, "user socket", token, max_age: @max_age) do
        {:ok, user_id} ->
          user = Om.Repo.get!(Om.User, user_id)
          {:ok, assign(socket, :current_user, user)}
        {:error, _reason} ->
          :error
      end
  end

#  def connect(%{"token" => token}, socket) do
#    case Coherence.verify_user_token(socket, token, &assign/3) do
#      {:error, _} -> :error
#      {:ok, socket} -> {:ok, socket}
#    end
#  end


  def connect(_params, _socket), do: :error

  def id(socket), do: "users_socket:#{socket.assigns.current_user.id}"

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     SimpleChatWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil
end
