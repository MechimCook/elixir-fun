defmodule Say do
  @doc """
  Translate a positive integer into English.
  """
  @under_20 [
    "",
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "ten",
    "eleven",
    "twelve",
    "thirteen",
    "fourteen",
    "fifteen",
    "sixteen",
    "seventeen",
    "eighteen",
    "nineteen"
  ]
  @over_19 ["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
  @over_100 ["", "thousand", "million", "billion"]
  @spec in_english(integer) :: {atom, String.t()}

  def in_english(number) when number > 999_999_999_999, do: {:error, "number is out of range"}
  def in_english(number) when number < 0, do: {:error, "number is out of range"}
  def in_english(number) when number == 0, do: {:ok, "zero"}

  def in_english(number) do
    english =
      Integer.digits(number)
      |> into_hundreds([], 0)
      |> String.trim()

    {:ok, english}
  end

  defp into_hundreds([], sorted, count), do: sorted

  defp into_hundreds(unsorted, sorted, count) do
    {remaining, grouped} = Enum.split(unsorted, -3)
    next = hundreds_to_english(grouped)

    if next == "" do
      into_hundreds(remaining, "#{sorted}", count + 1)
    else
      into_hundreds(remaining, "#{next} #{Enum.at(@over_100, count)} #{sorted}", count + 1)
    end
  end

  defp hundreds_to_english([0, 0, 0]), do: ""

  defp hundreds_to_english(numbers) do
    case numbers do
      [0, y, z] ->
        teens(y, z)

      [x, y, z] ->
        ["#{Enum.at(@under_20, x)} hundred " | teens(y, z)]

      [x, y] ->
        teens(x, y)

      [x] ->
        [Enum.at(@under_20, x)]
    end
  end

  defp teens(tenz, singlez) do
    case tenz do
      1 ->
        Enum.at(@under_20, singlez + 10)

      0 ->
        Enum.at(@under_20, singlez)

      _ ->
        if singlez == 0 do
          Enum.at(@over_19, tenz)
        else
          "#{Enum.at(@over_19, tenz)}-#{Enum.at(@under_20, singlez)}"
        end
    end
  end
end
