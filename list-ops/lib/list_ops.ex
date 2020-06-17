defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l), do: count(l, 0)
  def count([], c), do: c
  def count([_head | tail], c), do: count(tail, c + 1)

  @spec reverse(list) :: list
  def reverse(l), do: reverse(l, [])
  defp reverse([], l), do: l
  defp reverse([element | tail], list), do: reverse(tail, [element | list])

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: map(l, [], f)
  defp map([], l, _f), do: l
  defp map([element | tail], list, f), do: [f.(element) | map(tail, list, f)]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: filter(l, [], f)
  defp filter([], l, _f), do: l

  defp filter([element | tail], list, f) do
    if f.(element), do: [element | filter(tail, list, f)], else: filter(tail, list, f)
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _f), do: acc
  def reduce([element | tail], acc, f), do: reduce(tail, f.(element, acc), f)

  @spec append(list, list) :: list
  def append([], b), do: b
  def append([a_element | a_tail], b), do: [a_element | append(a_tail, b)]

  @spec concat([[any]]) :: [any]
  def concat(ll), do: concat(ll, [])
  defp concat([], l), do: l
  defp concat([element | tail], list), do: append(element, concat(tail, list))
end
