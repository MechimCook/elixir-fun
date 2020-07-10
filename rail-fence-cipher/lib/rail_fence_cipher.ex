defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t(), pos_integer) :: String.t()
  def encode("", _), do: ""
  def encode(str, 1), do: str
  def encode(str, rails) when rails > byte_size(str), do: str

  def encode(str, rails) do
    (Enum.to_list(0..(rails - 1)) ++ Enum.to_list((rails - 2)..1))
    |> Stream.cycle()
    |> Enum.take(byte_size(str))
    |> Enum.reduce({%{}, String.codepoints(str)}, fn index,
                                                     {encoded, [current | codepoints]} = acc ->
      acc = {Map.update(encoded, index, current, &(&1 <> current)), codepoints}
    end)
    |> proccess_map_tuple()
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """

  @spec decode(String.t(), pos_integer) :: String.t()
  def decode("", _), do: ""
  def decode(str, 1), do: str
  def decode(str, rails) when rails > byte_size(str), do: str

  def decode(str, rails) do
    cypher = String.codepoints(str)

    (Enum.to_list(1..rails) ++ Enum.to_list((rails - 1)..2))
    |> Stream.cycle()
    |> Enum.take(byte_size(str))
    |> fence(cypher, 1, rails)
  end

  defp fence(key, cypher, current_rail, max_rail),
    do: fence({key, cypher}, current_rail, max_rail)

  defp fence({key, cypher}, max_rail, max_rail) do
    Enum.map_reduce(key, {max_rail, cypher}, &proccess_cypher(&1, &2))
    |> proccess_tuple()
  end

  defp fence({key, cypher}, current_rail, max_rail) do
    Enum.map_reduce(key, {current_rail, cypher}, &proccess_cypher(&1, &2))
    |> remove_rail()
    |> fence(current_rail + 1, max_rail)
  end

  defp proccess_cypher(value, {current_rail, [current | cypher]} = acc),
    do: if(value == current_rail, do: {current, {current_rail, cypher}}, else: {value, acc})

  defp proccess_cypher(value, {current_rail, []} = acc), do: {value, acc}

  defp proccess_map_tuple({encoded, _}), do: Map.values(encoded) |> Enum.join()

  defp proccess_tuple({cypher, _}), do: Enum.join(cypher)
  defp remove_rail({key, {_rail, cypher}}), do: {key, cypher}
end
