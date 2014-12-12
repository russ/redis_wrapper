defmodule RedisWrapper.Mixfile do
  use Mix.Project

  def project do
    [app: :redis_wrapper,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: { RedisWrapper, [System.get_env("REDIS_URL") || "redis://127.0.0.1:6379"] }]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:exredis, github: "artemeff/exredis", ref: "91891dd"},
    ]
  end
end
