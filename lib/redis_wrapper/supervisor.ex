defmodule RedisWrapper.Supervisor do
  use Supervisor

  def start_link(connection_string \\ System.get_env("REDIS_URL")) do
    :supervisor.start_link(__MODULE__, connection_string)
  end

  def init(connection_string) do
    children = [worker(RedisWrapper.Server, connection_string)]
    supervise(children, strategy: :one_for_one)
  end
end
