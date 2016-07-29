defmodule PhoenixChangeTransport.MsgPackSerializer do
  @behaviour Phoenix.Transports.Serializer

  alias Phoenix.Socket.Reply
  alias PhoenixChangeTransport.Socket.Message
  alias Phoenix.Socket.Broadcast

  @doc """
  Translates a `Phoenix.Socket.Broadcast` into a `Phoenix.Socket.Message`.
  """
  def fastlane!(%Broadcast{} = msg) do
    {:socket_push, :binary, Msgpax.pack!(%Message{
      topic: msg.topic,
      event: msg.event,
      payload: msg.payload
    })}
  end

  @doc """
  Encodes a `Phoenix.Socket.Message` struct to JSON string.
  """
  def encode!(%Reply{} = reply) do
    {:socket_push, :binary, Msgpax.pack!(%Message{
      topic: reply.topic,
      event: "phx_reply",
      ref: reply.ref,
      payload: %{status: reply.status, response: reply.payload}
    })}
  end
  #topic: nil, event: nil, payload: nil, ref: nil
  def encode!(%Phoenix.Socket.Message{} = msg) do
    {:socket_push, :binary, Msgpax.pack!(%Message{topic: msg.topic, event: msg.event, payload: msg.payload, ref: msg.ref})}
  end
  def encode!(%Message{} = msg) do
    {:socket_push, :binary, Msgpax.pack!(msg)}
  end

  @doc """
  Decodes JSON String into `Phoenix.Socket.Message` struct.
  """
  def decode!(message, _opts) do
    #IO.puts("message: #{inspect message}")
    unpacked = message
      |> Msgpax.unpack!()
    
    #IO.puts("message: #{inspect unpacked}")

    Phoenix.Socket.Message.from_map!(unpacked)
    #Maptu.struct!(Phoenix.Socket.Message, unpacked)
  end  
end