defmodule Day07 do
  @entry "S"
  @splitter "^"
  @empty_space "."
  @beam "|"

  def run do
    manifold =
      File.read!("data/day07.txt")
      |> build_tachyon_manifold()
      |> trace_timelines()

    manifold
    |> count_splits()
    |> IO.inspect()

    manifold
    |> count_timelines()
    |> IO.inspect()
  end

  def build_tachyon_manifold(content) do
    lines = content |> String.split("\n", trim: true)

    manifold_map =
      lines
      |> Enum.with_index(1)
      |> Enum.map(fn {row, x} ->
        row_items =
          String.split(row, "", trim: true)
          |> Enum.with_index(1)
          |> Enum.filter(fn {cell, _} -> cell != @empty_space end)
          |> Enum.map(fn {cell, y} -> {y, cell} end)
          |> Enum.into(%{})

        {x, row_items}
      end)
      |> Enum.into(%{})

    %{
      map: manifold_map,
      meta: %{splits: 0, rows: length(lines), columns: String.length(List.first(lines))}
    }
  end

  def trace_timelines(manifold) do
    trace_beam_at(manifold, 1)
  end

  def trace_beam_at(manifold = %{meta: %{rows: rows}}, x) when rows <= x, do: manifold

  def trace_beam_at(manifold, x) do
    manifold.map[x]
    |> Enum.reduce(manifold, fn {y, cell}, manifold ->
      case(cell) do
        @entry ->
          manifold
          |> put_in([:map, x + 1, y], 1)

        @splitter ->
          manifold

        timelines when is_number(timelines) ->
          trace_beam_to(manifold, timelines, {x + 1, y})
      end
    end)
    |> trace_beam_at(x + 1)
  end

  def trace_beam_to(manifold, timelines, {x, y}) do
    case manifold_at(manifold, {x, y}) do
      @empty_space ->
        put_in(manifold.map[x][y], timelines)

      beam when is_number(beam) ->
        update_in(manifold.map[x][y], &(&1 + timelines))

      @splitter ->
        manifold
        |> trace_beam_to(timelines, {x, y - 1})
        |> trace_beam_to(timelines, {x, y + 1})
        |> update_in([:meta, :splits], &(&1 + 1))
    end
  end

  defp manifold_at(manifold, {x, y}), do: get_in(manifold, [:map, x, Access.key(y, @empty_space)])

  def count_splits(manifold) do
    manifold.meta.splits
  end

  def count_timelines(manifold) do
    manifold.map[manifold.meta.rows]
    |> Enum.map(&elem(&1, 1))
    |> Enum.filter(&is_number/1)
    |> Enum.sum()
  end

  def print_manifold(manifold) do
    IO.puts("")

    manifold.map
    |> Enum.each(fn {_x, row} ->
      Range.new(1, manifold.meta.columns, 1)
      |> Enum.map(fn y -> Map.get(row, y, @empty_space) end)
      |> Enum.map(fn cell -> if is_number(cell), do: @beam, else: cell end)
      |> Enum.join("")
      |> IO.puts()
    end)
  end
end

Day07.run()
