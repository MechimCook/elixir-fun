defmodule Forth do
  @opaque evaluator :: map

  @doc """
  Create a new evaluator.
  """
  @spec new() :: evaluator
  def new(),
    do: %{
      stack: [],
      words: %{" " => " "}
    }

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t()) :: evaluator
  def eval(%{words: words, stack: stack}, s) do
    words =
      Regex.scan(~r/(?<=:).+(?=;)/, s)
      |> Enum.reduce(words, &add_words(&1, &2))

    s =
      format_string(s, words)
      |> (&(stack ++ &1)).()
      |> proccess_string()

    %{words: words, stack: s}
  end

  defp format_string(s, words) do
    Regex.replace(~r/:.+;/, s, "")
    |> String.replace(Map.keys(words), fn key -> Map.get(words, key) end)
    |> String.upcase()
    |> String.split(~r/[^[:alnum:]\/*+€-]/u, trim: true)
    |> Enum.map(fn x ->
      case Integer.parse(x) do
        {num, ""} -> num
        _ -> x
      end
    end)
  end

  defp declare_words([word | meaning], words) do
    case(Integer.parse(word)) do
      {_num, ""} -> raise(Forth.InvalidWord)
      _ -> Map.put(words, word, Enum.join(meaning, " ") |> String.trim())
    end
  end

  defp add_words([declaration], words),
    do: String.split(declaration, ~r/[^[:alnum:]\/*+€-]/u, trim: true) |> declare_words(words)

  # empty array
  defp proccess_string([]), do: []
  # arithmetic

  defp proccess_string([first | [second | ["-" | s]]]),
    do: proccess_string([first - second | s])

  defp proccess_string([first | [second | ["+" | s]]]),
    do: proccess_string([first + second | s])

  defp proccess_string([first | [second | ["*" | s]]]),
    do: proccess_string([first * second | s])

  defp proccess_string([first | [second | ["/" | _s]]]) when first == 0 or second == 0,
    do: raise(Forth.DivisionByZero)

  defp proccess_string([first | [second | ["/" | s]]]),
    do: proccess_string([div(first, second) | s])

  # stack manipulation
  defp proccess_string([first | ["DUP" | s]]),
    do: proccess_string([first | [first | s]])

  defp proccess_string([_first | ["DROP" | s]]),
    do: proccess_string(s)

  defp proccess_string([first | [second | ["SWAP" | s]]]),
    do: proccess_string([second | [first | s]])

  defp proccess_string([first | [second | ["OVER" | s]]]),
    do: proccess_string([first | [second | [first | s]]])

  defp proccess_string([under_flow | _s]) when under_flow in ["DROP", "DUP", "SWAP", "OVER"],
    do: raise(Forth.StackUnderflow)

  defp proccess_string([_second | [under_flow | _s]]) when under_flow in ["SWAP", "OVER"],
    do: raise(Forth.StackUnderflow)

  defp proccess_string([first | _s]) when is_binary(first) and first not in ["-", "+", "/", "*"],
    do: raise(Forth.UnknownWord)

  # last 2
  defp proccess_string([first | [second]]), do: [first | proccess_string([second])]
  # if number is not used yet or all numbers
  defp proccess_string([first | [second | s]]),
    do:
      if(Enum.any?(s, &is_binary(&1)),
        do: proccess_string([first | proccess_string([second | s])]),
        else: [first | [second | s]]
      )

  defp proccess_string([s | []]),
    do: [s]

  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  @spec format_stack(evaluator) :: String.t()
  def format_stack(%{stack: stack}), do: Enum.join(stack, " ")

  defmodule StackUnderflow do
    defexception []
    def message(_), do: "stack underflow"
  end

  defmodule InvalidWord do
    defexception word: nil
    def message(e), do: "invalid word: #{inspect(e.word)}"
  end

  defmodule UnknownWord do
    defexception word: nil
    def message(e), do: "unknown word: #{inspect(e.word)}"
  end

  defmodule DivisionByZero do
    defexception []
    def message(_), do: "division by zero"
  end
end
