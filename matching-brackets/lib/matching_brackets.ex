defmodule MatchingBrackets do
  @check_brackets ~r/((\((?:[^\{\})(\[\]]+|(?R))*+\))|(\[(?:[^\{\})(\[\]]+|(?R))*+\])|(\{(?:[^\{\})(\[\]]+|(?R))*+\}))/
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    x =
      Regex.replace(@check_brackets, str, "")
      |> String.contains?(["[", "]", "{", "}", "(", ")"])
      |> (&!/1).()
  end
end
