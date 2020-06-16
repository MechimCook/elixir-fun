defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) do
    if length(strand1) != length(strand2) do
      {:error, "Lists must be the same length"}
    else
      hammer_time(strand1, strand2, 0)
    end
  end

  defp hammer_time([curent | strand1], [compare | strand2], count) do
    if curent != compare do
      hammer_time(strand1, strand2, count + 1)
    else
      hammer_time(strand1, strand2, count)
    end
  end

  defp hammer_time([], [], count), do: {:ok, count}
end
