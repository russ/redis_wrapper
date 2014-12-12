defmodule RedisWrapper do
  use Application

  def start(_type, connection_string) do
    RedisWrapper.Supervisor.start_link(connection_string)
  end

  def ping do
    :gen_server.call(:redis_wrapper, {:ping})
  end

  def get(key) do
    :gen_server.call(:redis_wrapper, {:get, key})
  end

  def hgetall(key) do
    :gen_server.call(:redis_wrapper, {:hgetall, key})
  end

  def set(key) do
    :gen_server.cast(:redis_wrapper, {:set, key})
  end

  def incr(key) do
    :gen_server.cast(:redis_wrapper, {:incr, key})
  end

  def hincrby(key, k, v) do
    :gen_server.cast(:redis_wrapper, {:hincrby, key, k, v})
  end

  def hmset(key, values) do
    :gen_server.cast(:redis_wrapper, {:hmset, key, values})
  end
end
