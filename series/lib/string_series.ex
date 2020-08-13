defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  defguard is_valid(s, size) when size > 0 and byte_size(s) >= size
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) when is_valid(s, size),
    do: 0..(String.length(s) - size) |> Enum.map(&String.slice(s, &1..(&1 + size - 1)))

  def slices(s, size), do: []
end
