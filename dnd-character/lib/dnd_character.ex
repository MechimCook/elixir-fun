defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    Integer.floor_div(score, 2) - 5
  end

  @spec ability :: pos_integer()
  def ability do
    Enum.map([1, 2, 3, 4], fn _x -> Enum.random(1..6) end)
    |> Enum.sort()
    |> Enum.take(-3)
    |> Enum.sum()
  end

  @spec character :: t()
  def character do
    constitution = ability()

    %DndCharacter{
      strength: ability(),
      dexterity: ability(),
      constitution: constitution,
      intelligence: ability(),
      wisdom: ability(),
      charisma: ability(),
      hitpoints: modifier(constitution) + 10
    }
  end
end
