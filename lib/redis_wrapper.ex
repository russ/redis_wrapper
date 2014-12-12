defmodule RedisWrapper do
  use Application

  def start(_type, connection_string) do
    RedisWrapper.Supervisor.start_link(connection_string)
  end

  def ping do
    :gen_server.call(:redis_wrapper , {:ping})
  end
end
