defmodule Day04 do
  def run do
    grid =
      File.read!("data/day04.txt")
      |> parse_grid_into_map()

    grid
    |> mark_accessible_rolls()
    |> total_accessible_rolls()
    |> IO.puts()

    IO.puts("Let's remove them to access some more.")

    grid
    |> remove_accessible_rolls()
    |> total_accessible_rolls()
    |> IO.puts()
  end

  def parse_grid_into_map(content) do
    content
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, x} ->
      String.split(row, "", trim: true)
      |> Enum.with_index()
      |> Enum.map(fn {cell, y} -> {{x, y}, cell} end)
    end)
    |> Enum.into(%{})
  end

  def mark_accessible_rolls(grid) do
    grid
    |> Enum.map(fn {position, cell} ->
      if is_roll?(cell) and is_accessible?(grid, position) do
        {position, "x"}
      else
        {position, cell}
      end
    end)
    |> Enum.into(%{})
  end

  def remove_accessible_rolls(grid, accessible \\ 0) do
    reduced = mark_accessible_rolls(grid)
    now_accessible = total_accessible_rolls(reduced)

    if now_accessible > accessible do
      remove_accessible_rolls(reduced, now_accessible)
    else
      reduced
    end
  end

  def total_accessible_rolls(grid) do
    grid
    |> Map.values()
    |> Enum.filter(fn cell -> cell == "x" end)
    |> length()
  end

  def is_accessible?(grid, {x, y}) do
    [
      # left column
      {x - 1, y - 1},
      {x + 0, y - 1},
      {x + 1, y - 1},
      # above
      {x - 1, y},
      # below
      {x + 1, y},
      # right column
      {x - 1, y + 1},
      {x + 0, y + 1},
      {x + 1, y + 1}
    ]
    |> Enum.map(fn pos -> Map.get(grid, pos, ".") end)
    |> Enum.filter(&is_roll?/1)
    |> length() < 4
  end

  def is_roll?(cell), do: cell == "@"
end

Day04.run()
