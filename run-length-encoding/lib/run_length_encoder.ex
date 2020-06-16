defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string

    Regex.split(~r/(.)\1{0,}/, string, include_captures: true, trim: true)
    |> Enum.reduce("", fn x, acc ->
      if String.length(x) > 1 do
        "#{acc}#{String.length(x)}#{String.first(x)}"
      else
        "#{acc}#{String.first(x)}"
      end
    end)
  end

  String.duplicate("a", 5)

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.split(~r/([0-9]{1,}.)|./, string, include_captures: true, trim: true)
    |> Enum.reduce("", fn x, acc ->
      "#{acc}#{decoding(x)}"
    end)
  end

  defp decoding(code) do
    if String.length(code) > 1 do
      num =
        String.slice(code, 0..-2)
        |> String.to_integer()

      char = String.last(code)

      String.duplicate(char, num)
    else
      code
    end
  end
end
