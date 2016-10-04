defmodule ExFCM.Mixfile do
  use Mix.Project

  def project do
    [app: :exfcm,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.9.0"},
      {:poison, "~> 3.0"}
    ]
  end

  defp description do
    """
    A few sentences (a paragraph) describing the project.
    """
  end

  defp package do
    [# These are the default files included in the package
     name: :exfcm,
     files: ["lib", "mix.exs"],
     maintainers: ["Jakub Hajto"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/ericmj/postgrex"}]
  end
end
