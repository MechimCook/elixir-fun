defmodule Hexadecimal do
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """
  @digits %{
    "0" => 0,
    "1" => 1,
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9,
    "A" => 10,
    "B" => 11,
    "C" => 12,
    "D" => 13,
    "E" => 14,
    "F" => 15,
    "a" => 10,
    "b" => 11,
    "c" => 12,
    "d" => 13,
    "e" => 14,
    "f" => 15
  }
  @spec to_decimal(binary) :: integer
  def to_decimal(string),
    do: if(String.match?(string, ~r/[^0-9a-f]+/i), do: 0, else: from_hexadecimal(string))

  defp from_hexadecimal(string) do
    String.codepoints(string)
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.reduce(0, fn {num, idx}, acc ->
      digit = @digits[num]
      if idx == 0, do: acc + digit, else: acc + digit * :math.pow(16, idx)
    end)
  end
end
