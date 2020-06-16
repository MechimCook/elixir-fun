defmodule RobotSimulator do
  @directions [:north, :east, :south, :west]

  defguard is_direction(direction) when is_atom(direction) and direction in @directions

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
<<<<<<< HEAD
  def create(direction \\ :north, {x, y} \\ {0, 0})
      when is_direction(direction) and is_integer(x) and is_integer(y),
      do: {direction, {x, y}}

  def create(direction, _position) when is_direction(direction), do: {:error, "invalid position"}
  def create(_direction, _position), do: {:error, "invalid direction"}
=======

  def create(direction \\ :north, {x, y} \\ {0, 0})
      when is_integer(x) and is_integer(y) and is_direction(direction),
      do: {direction, {x, y}}

  def create(direction, _position) when is_direction(direction),
    do: {:error, "invalid position"}

  def create(_direction, _position),
    do: {:error, "invalid direction"}
>>>>>>> Robot-sim

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
<<<<<<< HEAD
  def simulate(robot, instructions) do
    String.codepoints(instructions)
    |> Enum.reduce_while(
      robot,
      fn instruction, robot ->
        case instruct(instruction, robot) do
          :error ->
            {:halt, {:error, "invalid instruction"}}

          new_robot ->
            {:cont, new_robot}
        end
      end
    )
  end
=======
>>>>>>> Robot-sim

  @right %{north: :east, east: :south, south: :west, west: :north}
  @left %{north: :west, east: :north, south: :east, west: :south}

<<<<<<< HEAD
  defp instruct("L", {direction, position}), do: {@left[direction], position}

  defp instruct("R", {direction, position}), do: {@right[direction], position}

  defp instruct("A", {direction, {x, y}}) do
    case direction do
      :north ->
        {direction, {x, y + 1}}

      :east ->
        {direction, {x + 1, y}}

      :south ->
        {direction, {x, y - 1}}

      :west ->
        {direction, {x - 1, y}}
    end
  end

  defp instruct(_, _), do: :error
=======
  def simulate({direction, position}, "L" <> tail),
    do: simulate({@left[direction], position}, tail)

  def simulate({direction, position}, "R" <> tail),
    do: simulate({@right[direction], position}, tail)

  def simulate({:north, {x, y}}, "A" <> tail), do: simulate({:north, {x, y + 1}}, tail)
  def simulate({:east, {x, y}}, "A" <> tail), do: simulate({:east, {x + 1, y}}, tail)
  def simulate({:south, {x, y}}, "A" <> tail), do: simulate({:south, {x, y - 1}}, tail)
  def simulate({:west, {x, y}}, "A" <> tail), do: simulate({:west, {x - 1, y}}, tail)
  def simulate(robot, ""), do: robot
  def simulate(_, _), do: {:error, "invalid instruction"}
>>>>>>> Robot-sim

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
