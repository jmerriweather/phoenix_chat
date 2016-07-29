defmodule PhoenixChangeTransport.Socket.Message do
  @derive [Msgpax.Packer]
  defstruct topic: nil, event: nil, payload: nil, ref: nil
end

defmodule PhoenixChangeTransport.Socket.Reply do
  @derive [Msgpax.Packer]
  defstruct topic: nil, status: nil, payload: nil, ref: nil
end

defmodule PhoenixChangeTransport.Socket.Broadcast do
  @derive [Msgpax.Packer]
  defstruct topic: nil, event: nil, payload: nil
end