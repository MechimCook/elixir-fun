defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """

  @spec score(String.t()) :: non_neg_integer
  def score(word), do: score(0, word, 1)
  defp score(count, "", _), do: count

  defp score(count, word, 1),
    do:
      Regex.scan(~r/[AEIOULNRST]/i, word, return: :index)
      |> (&(length(&1) + count)).()
      |> score(word, 2)

  defp score(count, word, 2),
    do:
      Regex.scan(~r/[DG]/i, word, return: :index)
      |> (&(length(&1) * 2 + count)).()
      |> score(word, 3)

  defp score(count, word, 3),
    do:
      Regex.scan(~r/[BCMP]/i, word, return: :index)
      |> (&(length(&1) * 3 + count)).()
      |> score(word, 4)

  defp score(count, word, 4),
    do:
      Regex.scan(~r/[FHVWY]/i, word, return: :index)
      |> (&(length(&1) * 4 + count)).()
      |> score(word, 5)

  defp score(count, word, 5),
    do:
      Regex.scan(~r/[K]/i, word, return: :index)
      |> (&(length(&1) * 5 + count)).()
      |> score(word, 8)

  defp score(count, word, 8),
    do:
      Regex.scan(~r/[JX]/i, word, return: :index)
      |> (&(length(&1) * 8 + count)).()
      |> score(word, 10)

  defp score(count, word, 10),
    do: Regex.scan(~r/[QZ]/i, word, return: :index) |> (&(length(&1) * 10 + count)).()
end
