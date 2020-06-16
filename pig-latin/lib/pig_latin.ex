defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @vowels ["a", "e", "i", "o", "u"]
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    # split phrase to words
    |> String.split()
    |> Enum.reduce("", fn word, acc ->
      acc <> " #{move_constats(word)}ay"
    end)
    |> String.trim()
  end

  defp move_constats(word) do
    cond do
      String.starts_with?(word, @vowels) ->
        word

      String.starts_with?(word, ["x", "y"]) ->
        if Enum.member?(@vowels, String.slice(word, 1..1)) do
          (String.slice(word, 1..-1) <> String.first(word))
          |> move_constats()
        else
          word
        end

      String.starts_with?(word, "qu") ->
        (String.slice(word, 2..-1) <> String.slice(word, 0..1))
        |> move_constats()

      true ->
        (String.slice(word, 1..-1) <> String.first(word))
        |> move_constats()
    end
  end
end
