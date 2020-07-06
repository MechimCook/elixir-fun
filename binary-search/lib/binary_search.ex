defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, _key) when tuple_size(numbers) == 0, do: :not_found

  def search(numbers, key) do
    half =
      tuple_size(numbers)
      |> Integer.floor_div(2)

    index =
      Tuple.to_list(numbers)
      |> Enum.with_index()
      |> Enum.split(half)
      |> binary_search(key)

    if(index, do: {:ok, index}, else: :not_found)
  end

  # def search(numbers, key), do: if(elem(numbers, 0) == key, do: {:ok, 0}, else: :not_found)
  defp binary_search({[], [{key, index}]}, key), do: index
  defp binary_search({[], [{_value, _index}]}, _key), do: nil
  defp binary_search({[{_value, _index}], [{key, index}]}, key), do: index
  defp binary_search({[{key, index}], [{_value, _index}]}, key), do: index
  defp binary_search({[{_value1, _index1}], [{_value2, _index2}]}, _key), do: nil

  defp binary_search({list1, list2}, key) do
    index = binary_search_part(list1, key)

    if(!index) do
      binary_search_part(list2, key)
    else
      index
    end
  end

  defp binary_search_part(list, key),
    do: Enum.split(list, Integer.floor_div(length(list), 2)) |> binary_search(key)
end
