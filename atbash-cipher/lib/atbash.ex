defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """

  @cypher [
    {97, 122},
    {98, 121},
    {99, 120},
    {100, 119},
    {101, 118},
    {102, 117},
    {103, 116},
    {104, 115},
    {105, 114},
    {106, 113},
    {107, 112},
    {108, 111},
    {109, 110},
    {65, 90},
    {66, 89},
    {67, 88},
    {68, 87},
    {69, 86},
    {70, 85},
    {71, 84},
    {72, 83},
    {73, 82},
    {74, 81},
    {75, 80},
    {76, 79},
    {77, 78}
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
