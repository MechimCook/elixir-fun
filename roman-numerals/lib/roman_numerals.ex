defmodule RomanNumerals do
  @numeral_map [
    {"M", 1000},
    {"CM", 900},
    {"D", 500},
    {"CD", 400},
    {"C", 100},
    {"XC", 90},
    {"L", 50},
    {"XL", 40},
    {"X", 10},
    {"IX", 9},
    {"V", 5},
    {"IV", 4},
    {"I", 1}
  ]
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    parse_integer("", number, @numeral_map)
  end

  defp parse_integer(acc, _number, []), do: acc

  defp parse_integer(acc, number, [{roman_char, divisor} | tail]) do
    case div(number, divisor) do
      0 ->
        acc

      x ->
        Enum.reduce(0..(x - 1), acc, fn _x, acc -> acc <> roman_char end)
    end
    |> parse_integer(rem(number, divisor), tail)
  end
end
