defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @word_borders "(?=[[:alnum:]])(?<![[:alnum:]'])|(?=[[:upper:]])(?<![[:upper:]])"
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    Regex.compile!("(?!#{@word_borders}).")
    |> Regex.replace(string, "")
    |> String.upcase()
  end
end
