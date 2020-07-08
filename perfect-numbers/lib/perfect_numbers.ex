defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number < 1,
    do: {:error, "Classification is only possible for natural numbers."}

  def classify(number), do: classifing(number)

  defp classifing(number),
    do:
      Stream.filter(1..number, &(rem(number, &1) == 0))
      |> Enum.reduce_while({0, number}, fn prime, {sum, running_number} ->
        cond do
          sum < number -> {:cont, {sum + prime, running_number}}
          sum > number -> {:halt, :abundant}
          true -> {:halt, :perfect}
        end
      end)
      |> classifed()

  defp classifed(results) when is_atom(results), do: {:ok, results}
  defp classifed(_results), do: {:ok, :deficient}
end
