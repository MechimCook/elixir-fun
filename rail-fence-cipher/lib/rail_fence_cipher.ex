defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t(), pos_integer) :: String.t()
  def encode("", _), do: ""
  def encode(str, 1), do: str
  def encode(str, rails), do: str |> to_charlist |> zigzag(rails) |> to_string

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """

  @spec decode(String.t(), pos_integer) :: String.t()
  def decode("", _), do: ""
  def decode(str, 1), do: str

  def decode(str, rails) do
    0..(String.length(str) - 1)
    |> zigzag(rails)
    |> Enum.zip(String.codepoints(str))
    |> Enum.sort()
    |> Enum.map_join(fn {_, v} -> v end)
  end

  defp zigzag(enum, rails), do: for(i <- 1..rails, {x, ^i} <- split(enum, rails), do: x)
  defp split(enum, rails), do: Enum.zip(enum, fence(rails))
  defp fence(rails), do: 1..(rails - 1) |> Stream.concat(rails..2) |> Stream.cycle()
end
