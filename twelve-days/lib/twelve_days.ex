# defmodule TwelveDays do
#   @gifts [
#     " a Partridge in a Pear Tree.",
#     " two Turtle Doves, and",
#     " three French Hens,",
#     " four Calling Birds,",
#     " five Gold Rings,",
#     " six Geese-a-Laying,",
#     " seven Swans-a-Swimming,",
#     " eight Maids-a-Milking,",
#     " nine Ladies Dancing,",
#     " ten Lords-a-Leaping,",
#     " eleven Pipers Piping,",
#     " twelve Drummers Drumming,"
#   ]
#   @days [
#     "zerotht",
#     "first",
#     "second",
#     "third",
#     "fourth",
#     "fifth",
#     "sixth",
#     "seventh",
#     "eighth",
#     "ninth",
#     "tenth",
#     "eleventh",
#     "twelfth"
#   ]
#   @doc """
#   Given a `number`, return the song's verse for that specific day, including
#   all gifts for previous days in the same line.
#   """
#   @spec verse(number :: integer) :: String.t()
#   def verse(number) do
#     gifts =
#       Enum.take(@gifts, number)
#       |> Enum.reverse()
#       |> Enum.join()
#
#     "On the #{Enum.at(@days, number)} day of Christmas my true love gave to me:#{gifts}"
#   end
#
#   @doc """
#   Given a `starting_verse` and an `ending_verse`, return the verses for each
#   included day, one per line.
#   """
#   @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
#   def verses(starting_verse, ending_verse) do
#     Enum.reduce(starting_verse..ending_verse, "", fn number, acc -> "#{acc}#{verse(number)}\n" end)
#     |> String.trim()
#   end
#
#   @doc """
#   Sing all 12 verses, in order, one verse per line.
#   """
#   @spec sing() :: String.t()
#   def sing, do: verses(1, 12)
# end

defmodule TwelveDays do
  @presents [
    "twelve Drummers Drumming",
    "eleven Pipers Piping",
    "ten Lords-a-Leaping",
    "nine Ladies Dancing",
    "eight Maids-a-Milking",
    "seven Swans-a-Swimming",
    "six Geese-a-Laying",
    "five Gold Rings",
    "four Calling Birds",
    "three French Hens",
    "two Turtle Doves",
    "a Partridge in a Pear Tree"
  ]
  @numbers [
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
    "On the #{Enum.at(@numbers, number - 1)} day of Christmas my true love gave to me: #{
      presents_for_day(number)
    }."
  end

  defp presents_for_day(number) do
    @presents
    |> Enum.take(-number)
    |> to_phrase
  end

  defp to_phrase([only]), do: only
  defp to_phrase([all_before_last, last]), do: "#{all_before_last}, and #{last}"
  defp to_phrase([first | others]), do: "#{first}, #{to_phrase(others)}"

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.map(&verse(&1))
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing, do: verses(1, 12)
end
