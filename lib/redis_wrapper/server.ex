defmodule RedisWrapper.Server do
  use GenServer

  alias Exredis, as: E
  alias Exredis.Api, as: R

  def start_link(connection_string) do
    :gen_server.start_link({:local, :redis_wrapper}, __MODULE__, connection_string, [])
  end

  def init(connection_string) do
    {_, env_connection_string } = :application.get_env(:redis_wrapper, :connection_string)
    client = E.start_using_connection_string(connection_string || env_connection_string)
    {:ok, client}
  end

  def handle_call({:ping}, _from, client) do
    {:reply, client |> R.ping, client}
  end
end

