defmodule Bob do
  def hey(input) do
    input = String.trim(input)

    cond do
      # address him without actually saying anything
      input == "" ->
        "Fine. Be that way!"

      String.last(input) == "?" ->
        questioning(input)

      # yelling
      yelling(input) ->
        "Whoa, chill out!"

      true ->
        "Whatever."
    end
  end

  defp questioning(input) do
    if yelling(input) do
      "Calm down, I know what I'm doing!"
    else
      "Sure."
    end
  end

  defp yelling(input) do
    String.upcase(input) == input && String.upcase(input) != String.downcase(input)
  end
end
