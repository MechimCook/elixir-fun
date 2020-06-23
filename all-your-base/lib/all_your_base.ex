defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """
  defguard is_base(base) when base > 1
  defguard both_are_bases(base_a, base_b) when is_base(base_a) and is_base(base_b)
  @spec convert(list, integer, integer) :: list

  def convert(digits, base_a, base_b) when not both_are_bases(base_a, base_b) or digits == [],
    do: nil

  def convert(digits, base_a, base_b) do
    if Enum.all?(digits, fn x -> x < base_a && x >= 0 end) do
      Enum.reverse(digits)
      |> (&to_10(0, &1, base_a, 0)).()
      |> Integer.digits(base_b)
    end
  end

  defp to_10(total, [], _base, _count), do: total

  defp to_10(total, [head | digits], base, count) do
    (total + head * :math.pow(base, count))
    |> to_10(digits, base, count + 1)
    |> floor()
  end
end
