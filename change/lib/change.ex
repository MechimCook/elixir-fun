defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(_coins, target) when target < 0, do: {:error, "cannot change"}
  def generate(_coins, target) when target == 0, do: {:ok, []}

  def generate(coins, target) do
    see_paths(coins, target)
    |> Enum.split_with(fn {coins_used, current_target} -> current_target == 0 end)
    |> case do
      {[], []} ->
        {:error, "cannot change"}

      {[], targets} ->
        generate(coins, targets)

      {[{coins_used, _0} | _other_solutions], _targets} ->
        {:ok, coins_used}
    end
  end

  # targets = [{coins_used, current_target}]
  defp see_paths([smallest | coins], targets) when is_list(targets),
    do:
      Enum.reject(targets, fn {_coins_used, current_target} ->
        current_target < 0 || current_target < smallest
      end)
      |> Enum.reduce([], fn current_target, acc ->
        acc ++ expand_path([smallest | coins], current_target)
      end)

  defp see_paths(coins, target), do: Enum.map(coins, fn coin -> {[coin], target - coin} end)

  defp expand_path(coins, {coins_used, target}),
    do:
      Enum.reject(coins, fn coin -> Enum.any?(coins_used, &(&1 < coin)) end)
      |> Enum.map(fn coin -> {[coin | coins_used], target - coin} end)
end
