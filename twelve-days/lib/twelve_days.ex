defmodule TwelveDays do
  @gifts [
    " a Partridge in a Pear Tree.",
    " two Turtle Doves, and",
    " three French Hens,",
    " four Calling Birds,",
    " five Gold Rings,",
    " six Geese-a-Laying,",
    " seven Swans-a-Swimming,",
    " eight Maids-a-Milking,",
    " nine Ladies Dancing,",
    " ten Lords-a-Leaping,",
    " eleven Pipers Piping,",
    " twelve Drummers Drumming,"
  ]
  @days [
    "zerotht",
    "first",
    "second",
    "third",
    "fourth",
    "fifth",
    "sixth",
    "seventh",
    "eighth",
    "ninth",
    "tenth",
    "eleventh",
    "twelfth"
  ]
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    gifts =
      Enum.take(@gifts, number)
      |> Enum.reverse()
      |> Enum.join()

    "On the #{Enum.at(@days, number)} day of Christmas my true love gave to me:#{gifts}"
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    Enum.reduce(starting_verse..ending_verse, "", fn number, acc -> "#{acc}#{verse(number)}\n" end)
    |> String.trim()
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end
end
