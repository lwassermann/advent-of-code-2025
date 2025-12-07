defmodule Day05 do
  def run do
    inventory =
      File.read!("data/day05.txt")
      |> parse_fresh_ranges()

    inventory
    |> filter_fresh_ingredients()
    |> length()
    |> IO.puts()

    inventory
    |> count_fresh_ingredient_ids()
    |> IO.puts()
  end

  def parse_fresh_ranges(content) do
    [ranges, ids] = String.split(content, "\n\n")

    fresh_ranges =
      ranges |> String.split("\n", trim: true) |> Enum.map(&parse_id_range/1) |> sort_ranges()

    ingredients = ids |> String.split("\n", trim: true) |> Enum.map(&parse_ingredient_id/1)

    {fresh_ranges, ingredients}
  end

  def parse_ingredient_id(line), do: String.to_integer(line)

  def parse_id_range(line) do
    [from, to] =
      line
      |> String.split("-", trim: true)
      |> Enum.map(&String.to_integer(String.trim(&1)))

    from..to//1
  end

  def sort_ranges(ranges) do
    ranges
    |> Enum.sort()
    |> merge_overlapping_ranges()
  end

  def merge_overlapping_ranges([]), do: []
  def merge_overlapping_ranges([a]), do: [a]

  def merge_overlapping_ranges([a, b | rest]) do
    if Range.disjoint?(a, b) do
      [a | merge_overlapping_ranges([b | rest])]
    else
      merge_overlapping_ranges([Range.new(min(a.first, b.first), max(a.last, b.last)) | rest])
    end
  end

  def filter_fresh_ingredients({fresh_ranges, ingredients}) do
    ingredients
    |> Stream.filter(fn id -> is_fresh?(id, fresh_ranges) end)
    |> Enum.to_list()
  end

  def is_fresh?(id, [fresh_id_range | rest]) do
    cond do
      id < fresh_id_range.first -> false
      fresh_id_range.first <= id and id <= fresh_id_range.last -> true
      true -> is_fresh?(id, rest)
    end
  end

  def is_fresh?(_, []), do: false

  def count_fresh_ingredient_ids({fresh_ranges, _}) do
    fresh_ranges
    |> Enum.map(fn r -> r.last - r.first + 1 end)
    |> Enum.sum()
  end
end

Day05.run()
