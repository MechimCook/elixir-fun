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
    Integer.digits(code, 2)
    |> do_commands()
    |> Enum.reject(fn x -> x == nil end)
  end

  defp do_commands([1, j, e, b, w]), do: [jump(j), eyes(e), blink(b), wink(w)]
  defp do_commands([1, e, b, w]), do: [wink(w), blink(b), eyes(e), "jump"]
  defp do_commands([1, b, w]), do: [wink(w), blink(b), "close your eyes"]
  defp do_commands([1, w]), do: [wink(w), "double blink"]
  defp do_commands([1]), do: ["wink"]
  defp do_commands(_), do: []

  defp wink(1), do: "wink"
  defp wink(_), do: nil
  defp blink(1), do: "double blink"
  defp blink(_), do: nil
  defp eyes(1), do: "close your eyes"
  defp eyes(_), do: nil
  defp jump(1), do: "jump"
  defp jump(_), do: nil
end
