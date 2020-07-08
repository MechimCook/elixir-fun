defmodule BinarySearchTree do
  defstruct data: 0, left: nil, right: nil
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data), do: %BinarySearchTree{data: data, left: nil, right: nil}

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node

  def insert(%{data: data, right: nil} = tree, new_data) when data < new_data,
    do: Map.put(tree, :right, %{data: new_data, left: nil, right: nil})

  def insert(%{data: data, right: right} = tree, new_data) when data < new_data,
    do: Map.put(tree, :right, insert(right, new_data))

  def insert(%{data: data, left: nil} = tree, new_data),
    do: Map.put(tree, :left, %{data: new_data, left: nil, right: nil})

  def insert(%{data: data, left: left} = tree, new_data),
    do: Map.put(tree, :left, insert(left, new_data))

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(%{data: data, right: nil, left: nil}), do: [data]
  def in_order(%{data: data, right: nil, left: left}), do: in_order(left) ++ [data]
  def in_order(%{data: data, right: right, left: nil}), do: [data] ++ in_order(right)

  def in_order(%{data: data, right: right, left: left}),
    do: in_order(left) ++ [data] ++ in_order(right)
end
