defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> (&Regex.scan(~r/(([[:alnum:]-]){1,})/u, &1, capture: :first)).()
    |> Enum.reduce(%{}, fn [key], acc ->
      Map.update(acc, key, 1, &(&1 + 1))
    end)
  end
end
