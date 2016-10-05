defmodule ExFCM.Mixfile do
  use Mix.Project

  def project do
    [app: :exfcm,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
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
      {:poison, ">= 0.0.0"},
      {:ex_doc, ">= 0.0.0", only: :dev} 
    ]
  end

  defp description do
    """
    Simple wrapper around Firebase Cloud Messaging that uses HTTPoison.
    """
  end

  defp package do
    [# These are the default files included in the package
     name: :exfcm,
     files: ["lib", "mix.exs"],
     maintainers: ["Jakub Hajto"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/Hajto/ExFCM"}]
  end
end
