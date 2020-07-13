defmodule Bowling do
  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """
  @max_pins 10
  @max_frames 10
  @strike 10
  @max_balls 2
  @frame %{balls_left: 2, pins: @max_pins}
  @game %{frames: [], results: []}

  @spec start() :: any
  def start,
    do:
      Stream.iterate(@frame, & &1) |> Enum.take(@max_frames) |> (&Map.put(@game, :frames, &1)).()

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """

  @spec roll(any, integer) :: any | String.t()
  # errors
  def roll(_game, roll) when roll < 0, do: {:error, "Negative roll is invalid"}

  def roll(%{frames: [%{pins: pins} | _frames]}, roll) when roll > pins,
    do: {:error, "Pin count exceeds pins on the lane"}

  def roll(game, _roll) when is_list(game), do: {:error, "Cannot roll after game is over"}

  # rolling tenth frame with bonus
  def roll(%{frames: [%{balls_left: balls, pins: pins} | []], results: results}, roll)
      when roll == pins,
      do: %{frames: [%{pins: @max_pins}], bonus: balls, results: results ++ [roll]}

  # rolling tenth frame without bonus
  def roll(%{frames: [%{balls_left: balls, pins: pins} | []], results: results}, roll),
    do:
      if(balls == @max_balls,
        do: %{frames: [%{balls_left: 1, pins: pins - roll} | []], results: results ++ [roll]},
        else: results ++ [roll, 0]
      )

  # using bonus balls
  def roll(%{bonus: bonus, results: results}, roll),
    do:
      (case({bonus, roll}) do
         {1, _} ->
           results ++ [roll]

         {@max_balls, @max_frames} ->
           %{frames: [%{pins: @max_pins}], bonus: 1, results: results ++ [roll]}

         {@max_balls, _} ->
           %{frames: [%{pins: @max_pins - roll}], bonus: 1, results: results ++ [roll]}
       end)

  # strike rolls
  def roll(%{frames: [_frame | frames], results: results}, @max_pins),
    do: %{frames: frames, results: results ++ [@max_pins]}

  # not strike rolls
  def roll(%{frames: [%{balls_left: balls, pins: pins} | frames], results: results}, roll),
    do:
      if(balls == @max_balls,
        do: %{
          frames: [%{balls_left: 1, pins: pins - roll} | frames],
          results: results ++ [roll]
        },
        else: %{frames: frames, results: results ++ [roll]}
      )

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """

  @spec score(any) :: integer | String.t()
  def score(game, tally \\ 0)
  # last frame
  def score([ball1 | [ball2 | [ball3 | []]]], tally),
    do: tally + ball1 + ball2 + ball3

  # score strikes
  def score([@strike | [ball2 | [ball3 | game]]], tally),
    do: score([ball2 | [ball3 | game]], tally + @max_pins + ball2 + ball3)

  # score spares
  def score([ball1 | [ball2 | [ball3 | game]]], tally) when ball1 + ball2 == @max_pins,
    do: score([ball3 | game], tally + @max_pins + ball3)

  # score open frame
  def score([ball1 | [ball2 | game]], tally),
    do: score(game, tally + ball1 + ball2)

  # error
  def score(_game, _tally),
    do: {:error, "Score cannot be taken until the end of the game"}
end
