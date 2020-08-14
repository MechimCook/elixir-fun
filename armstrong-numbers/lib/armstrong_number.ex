defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    Integer.digits(number)
    |> (&power_up(&1, length(&1), 0)).()
    |> (&(&1 == number)).()
  end

  defp power_up([digit], power, acc), do: :math.pow(digit, power) + acc

  defp power_up([digit | digits], power, acc),
    do: power_up(digits, power, :math.pow(digit, power) + acc)
end
