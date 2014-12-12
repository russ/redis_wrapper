use Mix.Config

config :redis_wrapper, connection_string: System.get_env("REDIS_URL")
