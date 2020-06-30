defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input), do: Enum.reduce(input, %{}, fn {k, v}, acc -> map_array(acc, k, v) end)

  defp map_array(map, value, [key | []]), do: Map.put(map, String.downcase(key), value)

  defp map_array(map, value, [key | keys]),
    do: Map.put(map, String.downcase(key), value) |> map_array(value, keys)
end
