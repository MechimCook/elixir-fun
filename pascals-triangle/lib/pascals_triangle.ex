defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num, triangle \\ [])
  def rows(0, triangle), do: Enum.reverse(triangle)
  def rows(num, []), do: rows(num - 1, [[1]])

  def rows(num, [prev | _rest] = triangle), do: rows(num - 1, [[1 | create_row(prev)] | triangle])

  defp create_row([[1]]), do: [1]

  defp create_row([1 | prev]) do
    Enum.map_reduce(prev, 1, fn current, last -> {current + last, current} end)
    |> Tuple.to_list()
    |> List.flatten()
  end
end
