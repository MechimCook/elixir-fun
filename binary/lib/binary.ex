defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t()) :: non_neg_integer
  def to_decimal(string),
    do: if(String.match?(string, ~r/[^10]+/), do: 0, else: from_binary(string))

  defp from_binary(string) do
    String.codepoints(string)
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.reduce(0, fn {num, idx}, acc ->
      digit = String.to_integer(num)
      if idx == 0, do: acc + digit, else: acc + :math.pow(digit * 2, idx)
    end)
  end
end
