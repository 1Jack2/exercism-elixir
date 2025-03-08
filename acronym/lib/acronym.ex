defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    # Remove punctuation except hyphens and spaces
    |> String.replace(~r/[^a-zA-Z\s-]/u, "")
    # Split on hyphens and spaces
    |> String.split(~r/[-\s]+/u)
    # Take the first letter of each word
    |> Enum.map(&String.first/1)
    # Convert to uppercase
    |> Enum.map(&String.upcase/1)
    # Join the letters
    |> Enum.join("")
  end
end
