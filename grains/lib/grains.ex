defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  defguard is_valid(number) when number > 0 and number < 65
  @spec square(pos_integer) :: pos_integer
  def square(number) when is_valid(number),
    do: :math.pow(2, number - 1) |> round |> (&{:ok, &1}).()

  def square(_number), do: {:error, "The requested square must be between 1 and 64 (inclusive)"}

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    Enum.reduce(1..64, 0, fn number, acc ->
      square(number) |> elem(1) |> (&(&1 + acc)).()
    end)
    |> (&{:ok, &1}).()
  end
end
