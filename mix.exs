defmodule Scraper.MixProject do
  use Mix.Project

  def project do
    [
      app: :scraper,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.4"},
      {:meeseeks, "~> 0.10.1"},
      {:jason, "~> 1.1"},
      {:timex, "~> 3.0"},
      {:credo, "~> 0.10.0", only: [:dev, :test], runtime: false}
    ]
  end
end
