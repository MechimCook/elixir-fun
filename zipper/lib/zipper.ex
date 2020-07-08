defmodule(Zipper) do
  defstruct focus: nil, trail: []
  @type t :: %Zipper{focus: any, trail: list}
  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree), do: %Zipper{focus: bin_tree, trail: []}

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(%{focus: bin_tree, trail: []}), do: bin_tree
  def to_tree(zipper), do: up(zipper) |> to_tree()

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value(%Zipper{focus: %{value: value}}), do: value

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left(%{focus: %{left: nil}}), do: nil

  def left(%{focus: %{value: value, left: left, right: right}, trail: trail}),
    do: %Zipper{focus: left, trail: [{value, :right, right} | trail]}

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right(%{focus: %{value: value, left: left, right: right}, trail: trail}),
    do: %Zipper{focus: right, trail: [{value, :left, left} | trail]}

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up(%{trail: []}), do: nil

  def up(%{focus: right, trail: [{value, :left, left} | trail]}),
    do: %Zipper{focus: %BinTree{value: value, left: left, right: right}, trail: trail}

  def up(%{focus: left, trail: [{value, :right, right} | trail]}),
    do: %Zipper{focus: %BinTree{value: value, left: left, right: right}, trail: trail}

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(zipper, value), do: Map.update!(zipper, :focus, &Map.put(&1, :value, value))

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(zipper, left), do: Map.update!(zipper, :focus, &Map.put(&1, :left, left))

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(zipper, right), do: Map.update!(zipper, :focus, &Map.put(&1, :right, right))
end
