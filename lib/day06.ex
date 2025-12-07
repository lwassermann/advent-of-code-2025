defmodule Day06 do
  def run do
    File.read!("data/day06.txt")
    |> calculate_columns()
    |> Enum.sum()
    |> IO.inspect()

    File.read!("data/day06.txt")
    |> calculate_transposed_columns()
    |> Enum.sum()
    |> IO.inspect()
  end

  def calculate_columns(contents) do
    contents
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ~r"\s+", trim: true))
    |> Enum.map(&parse_cells/1)
    |> Enum.zip()
    |> Enum.map(&calculate_problem/1)
  end

  def calculate_transposed_columns(contents) do
    contents
    |> String.split("\n", trim: true)
    |> transpose_lines()
  end

  def calculate_problem(values) do
    operands = values |> Tuple.to_list() |> Enum.take(tuple_size(values) - 1)
    operation = elem(values, tuple_size(values) - 1)
    Enum.reduce(operands, fn a, b -> operation.(a, b) end)
  end

  def calculate_transposed_problem({operands, operations}) do
    Enum.reduce(operands, fn a, b -> operations.(a, b) end)
  end

  def transpose_lines(lines) do
    operands =
      lines
      |> Enum.take(length(lines) - 1)
      |> Enum.map(&String.graphemes/1)
      |> Enum.zip_with(&Enum.join(&1, ""))
      |> Enum.map(&String.trim/1)
      |> Enum.chunk_by(&(&1 == ""))
      |> Enum.reject(fn x -> x == [""] end)
      |> Enum.map(fn operands -> Enum.map(operands, &parse_cell/1) end)

    operations =
      lines |> List.last() |> String.split(~r"\s+", trim: true) |> Enum.map(&parse_cell/1)

    Enum.zip(operands, operations)
    |> Enum.map(&calculate_transposed_problem/1)
  end

  def parse_cells(cells), do: Enum.map(cells, &parse_cell/1)

  def parse_cell(cell) do
    case cell do
      "+" -> &Kernel.+/2
      "*" -> &Kernel.*/2
      _ -> String.to_integer(cell)
    end
  end
end

Day06.run()
