defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input, steps \\ 0) when input < 1 or not is_integer(input),
    do: raise(FunctionClauseError)

  def calc(1, steps), do: steps
  def calc(input, steps) when rem(input, 2) == 0, do: calc(div(input, 2), steps + 1)
  def calc(input, steps), do: calc(3 * input + 1, steps + 1)
end
