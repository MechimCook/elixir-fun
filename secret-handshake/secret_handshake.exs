defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    case Integer.digits(code, 2) do
      [1, j, e, b, w] ->
        [jump(j), eyes(e), blink(b), wink(w)]

      [1, e, b, w] ->
        [wink(w), blink(b), eyes(e), "jump"]

      [1, b, w] ->
        [wink(w), blink(b), "close your eyes"]

      [1, w] ->
        [wink(w), "double blink"]

      [1] ->
        ["wink"]

      _ ->
        []
    end
    |> Enum.reject(fn x -> x == nil end)
  end

  defp wink(w) do
    if w == 1 do
      "wink"
    end
  end

  defp blink(w) do
    if w == 1 do
      "double blink"
    end
  end

  defp eyes(w) do
    if w == 1 do
      "close your eyes"
    end
  end

  defp jump(w) do
    if w == 1 do
      "jump"
    end
  end
end
