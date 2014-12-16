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

  def handle_call({:get, key}, _from, client) do
    {:reply, client |> R.get(key), client}
  end

  def handle_call({:hgetall, key}, _from, client) do
    {:reply, client |> R.hgetall(key), client}
  end

  def handle_call({:smembers, key}, _from, client) do
    {:reply, client |> R.smembers(key), client}
  end

  def handle_cast({:set, key, value}, client) do
    client |> R.set(key, value)
    {:noreply, client}
  end

  def handle_cast({:sadd, key, value}, client) do
    client |> R.sadd(key, value)
    {:noreply, client}
  end

  def handle_cast({:incr, key}, client) do
    client |> R.incr(key)
    {:noreply, client}
  end

  def handle_cast({:hincrby, key, k, v}, client) do
    client |> R.hincrby(key, k, v)
    {:noreply, client}
  end

  def handle_cast({:hmset, key, values}, client) do
    client |> R.hmset(key, values)
    {:noreply, client}
  end
end

