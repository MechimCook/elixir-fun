defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) when size > 0 do
    if String.length(s) >= size do
      Enum.map(0..(String.length(s) - size), fn x -> String.slice(s, x..(x + size - 1)) end)
    else
      []
    end
  end

  def slices(s, size) do
    []
  end
end
