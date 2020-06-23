defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene
  defguard one_is_positive(a, b, c) when a > 0 and b > 0 and c > 0
  defguard check(a, b, c) when a > b and a > c and a >= b + c
  defguard illegal_triangle?(a, b, c) when check(a, b, c) or check(b, a, c) or check(c, a, b)

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) when not one_is_positive(a, b, c),
    do: {:error, "all side lengths must be positive"}

  def kind(a, b, c) when illegal_triangle?(a, b, c),
    do: {:error, "side lengths violate triangle inequality"}

  def kind(a, a, a), do: {:ok, :equilateral}
  def kind(a, a, _b), do: {:ok, :isosceles}
  def kind(_a, b, b), do: {:ok, :isosceles}
  def kind(a, _b, a), do: {:ok, :isosceles}
  def kind(_a, _b, _c), do: {:ok, :scalene}
end
