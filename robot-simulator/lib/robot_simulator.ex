defmodule RobotSimulator do
  @directions [:north, :east, :south, :west]
  @turns [{:north, :east}, {:east, :south}, {:south, :west}, {:west, :north}]

  defguard is_direction?(direction) when is_atom(direction) and direction in @directions
  defguard valid_position?(x, y) when is_integer(x) and is_integer(y)

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0})

  def create(direction, {x, y})
      when is_direction?(direction) and valid_position?(x, y),
      do: {direction, {x, y}}

  def create(direction, _position) when is_direction?(direction), do: {:error, "invalid position"}
  def create(_direction, _position), do: {:error, "invalid direction"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any

  def simulate({direction, position}, "L" <> tail),
    do: simulate({left(direction), position}, tail)

  def simulate({direction, position}, "R" <> tail),
    do: simulate({right(direction), position}, tail)

  def simulate({:north, {x, y}}, "A" <> tail), do: simulate({:north, {x, y + 1}}, tail)
  def simulate({:east, {x, y}}, "A" <> tail), do: simulate({:east, {x + 1, y}}, tail)
  def simulate({:south, {x, y}}, "A" <> tail), do: simulate({:south, {x, y - 1}}, tail)
  def simulate({:west, {x, y}}, "A" <> tail), do: simulate({:west, {x - 1, y}}, tail)
  def simulate(robot, ""), do: robot
  def simulate(_, _), do: {:error, "invalid instruction"}

  defp left(direction) do
    {new, _current} = Enum.find(@turns, fn {_new, current} -> current == direction end)
    new
  end

  defp right(direction) do
    {_current, new} = Enum.find(@turns, fn {current, _new} -> current == direction end)
    new
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction({direction, _position}), do: direction

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position({_direction, position}), do: position
end
