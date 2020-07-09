defmodule CustomSet do
  @opaque t :: %__MODULE__{map: map}

  defstruct map: []

  @spec new(Enum.t()) :: t
  def new(enumerable), do: %CustomSet{map: Enum.uniq(enumerable)}

  @spec empty?(t) :: boolean
  def empty?(%{map: []}), do: true
  def empty?(_custom_set), do: false

  @spec contains?(t, any) :: boolean
  def contains?(%{map: map}, element), do: Enum.member?(map, element)

  @spec subset?(t, t) :: boolean
  def subset?(%{map: map_1}, %{map: map_2}),
    do: Enum.all?(map_1, &Enum.member?(map_2, &1))

  @spec disjoint?(t, t) :: boolean
  def disjoint?(%{map: []}, _), do: true
  def disjoint?(_, %{map: []}), do: true

  def disjoint?(%{map: map_1}, %{map: map_2}),
    do: !Enum.any?(map_1, &Enum.member?(map_2, &1))

  @spec equal?(t, t) :: boolean
  def equal?(%{map: map_1}, %{map: map_2}), do: :lists.sort(map_1) == :lists.sort(map_2)

  @spec add(t, any) :: t

  def add(%{map: map}, element), do: adding(map, element, [])
  # end
  defp adding([], element, before), do: %CustomSet{map: before ++ [element]}
  # element is in set
  defp adding([check | _set] = map, element, before) when check == element,
    do: %CustomSet{map: before ++ map}

  # adding element
  defp adding([check | _set] = map, element, before) when check > element,
    do: %CustomSet{map: before ++ [element | map]}

  defp adding([check | set], element, before), do: adding(set, element, before ++ [check])

  @spec intersection(t, t) :: t
  def intersection(%{map: []}, _), do: %CustomSet{map: []}
  def intersection(_, %{map: []}), do: %CustomSet{map: []}

  def intersection(%{map: map_1}, %{map: map_2}),
    do: %CustomSet{map: Enum.filter(map_1, &Enum.member?(map_2, &1))}

  @spec difference(t, t) :: t
  def difference(%{map: []}, _), do: %CustomSet{map: []}
  def difference(%{map: map}, %{map: []}), do: %CustomSet{map: map}

  def difference(%{map: map_1}, %{map: map_2}),
    do: %CustomSet{map: Enum.reject(map_1, &Enum.member?(map_2, &1))}

  @spec union(t, t) :: t
  def union(%{map: []}, %{map: map}), do: %CustomSet{map: map}
  def union(%{map: map}, %{map: []}), do: %CustomSet{map: map}

  def union(%{map: map_1}, %{map: map_2}),
    do: %CustomSet{map: Enum.uniq(map_1 ++ map_2)}
end
