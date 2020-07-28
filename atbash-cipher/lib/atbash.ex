defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """

  @cypher [
    {?a, ?z},
    {?b, ?y},
    {?c, ?x},
    {?d, ?w},
    {?e, ?v},
    {?f, ?u},
    {?g, ?t},
    {?h, ?s},
    {?i, ?r},
    {?j, ?q},
    {?k, ?p},
    {?l, ?o},
    {?m, ?n}
  ]

  @spec encode(String.t()) :: String.t()
  def encode(plaintext),
    do:
      plaintext
      |> String.replace(~r/[^[:alnum:]]/, "")
      |> String.downcase()
      |> String.to_charlist()
      |> Enum.map(&transform(&1))
      |> Enum.chunk_every(5)
      |> Enum.intersperse(' ')
      |> List.to_string()

  @spec decode(String.t()) :: String.t()
  def decode(cipher),
    do:
      cipher
      |> String.replace(" ", "")
      |> String.to_charlist()
      |> Enum.map(&transform(&1))
      |> List.to_string()

  defp transform(char), do: Enum.find_value(@cypher, char, &find_from_tuple(&1, char))

  defp find_from_tuple({char, to}, char), do: to
  defp find_from_tuple({to, char}, char), do: to
  defp find_from_tuple(_, _), do: nil
end
