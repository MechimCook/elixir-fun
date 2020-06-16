defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    roman_math(number, "")
  end

  # I- 1
  # under 4
  # V- 5
  # under 9
  # X- 10
  # under 40
  # L- 50
  # under 90
  # C- 100
  # under 400
  # D- 500
  # under 900
  # M- 1000
  # over 1000

  defp roman_math(number, sum) when number < 4, do: "#{sum}#{String.duplicate("I", number)}"
  defp roman_math(4, sum), do: "#{sum}IV"
  defp roman_math(number, sum) when number < 9, do: roman_math(number - 5, "#{sum}V")
  defp roman_math(9, sum), do: "#{sum}IX"
  defp roman_math(number, sum) when number < 40, do: roman_math(number - 10, "#{sum}X")
  defp roman_math(number, sum) when number < 50, do: roman_math(number - 40, "#{sum}XL")
  defp roman_math(number, sum) when number < 90, do: roman_math(number - 50, "#{sum}L")
  defp roman_math(number, sum) when number < 100, do: roman_math(number - 90, "#{sum}XC")
  defp roman_math(number, sum) when number < 400, do: roman_math(number - 100, "#{sum}C")
  defp roman_math(number, sum) when number < 500, do: roman_math(number - 400, "#{sum}CD")
  defp roman_math(number, sum) when number < 900, do: roman_math(number - 500, "#{sum}D")
  defp roman_math(number, sum) when number < 1000, do: roman_math(number - 900, "#{sum}CM")
  defp roman_math(number, sum), do: roman_math(number - 1000, "#{sum}M")
end
