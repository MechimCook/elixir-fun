defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number),
    do: prime_factors(number)

  defp prime_factors(1), do: []

  defp prime_factors(num) when rem(num, 2) == 0, do: [2 | prime_factors(div(num, 2))]
  defp prime_factors(num) when 4 > num, do: [num]
  defp prime_factors(num), do: prime_factors(num, 3)

  defp prime_factors(num, next) when rem(num, next) == 0,
    do: [next | prime_factors(div(num, next))]

  defp prime_factors(num, next) when next + next > num, do: [num]
  defp prime_factors(num, next), do: prime_factors(num, next + 2)
end
