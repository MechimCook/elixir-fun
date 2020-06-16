defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      length(a) == length(b) ->
        equal(a, b)

      length(a) > length(b) ->
        superlist(b, a)

      length(a) < length(b) ->
        sublist(a, b)
    end
  end

  defp sublist(a, b), do: if(compile(a, b), do: :sublist, else: :unequal)

  defp superlist(a, b), do: if(compile(a, b), do: :superlist, else: :unequal)

  defp equal(a, b), do: if(compile(a, b), do: :equal, else: :unequal)

  defp compile(smaller, bigger) do
    cond do
      length(bigger) < length(smaller) ->
        false

      List.starts_with?(bigger, smaller) ->
        true

      true ->
        compile(smaller, List.delete_at(bigger, 0))
    end
  end
end
