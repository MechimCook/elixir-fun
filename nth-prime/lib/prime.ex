defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(1), do: 2
  def nth(count) when count > 1, do: nth([2], 3, count - 1)

  defp nth([nth_prime | _primes], _current, 0), do: nth_prime

  defp nth(primes, current, count) do
    if Enum.any?(primes, fn prime -> rem(current, prime) == 0 end) do
      nth(primes, current + 1, count)
    else
      nth([current | primes], current + 1, count - 1)
    end
  end
end
