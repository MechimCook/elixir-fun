defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    split_base = String.codepoints(String.downcase(base))

    candidates
    |> Enum.reduce([], fn word, acc ->
      down_word = String.downcase(word)

      cond do
        String.length(base) != String.length(word) ->
          acc

        String.downcase(base) == down_word ->
          acc

        frequencies(split_base) == frequencies(String.codepoints(String.downcase(down_word))) ->
          acc ++ [word]

        true ->
          acc
      end
    end)
  end

  def frequencies(enumerable) do
    Enum.reduce(enumerable, %{}, fn key, acc ->
      case acc do
        %{^key => value} -> %{acc | key => value + 1}
        %{} -> Map.put(acc, key, 1)
      end
    end)
  end
end
