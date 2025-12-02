defmodule Day02 do
  @example "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

  def run do
    test_ids(@example, &valid?/1)
    test_ids(File.read!("data/day02-1.txt"), &valid?/1)
    IO.puts("There are more suspicious patterns...")
    test_ids(@example, &extended_valid?/1)
    test_ids(File.read!("data/day02-1.txt"), &extended_valid?/1)
  end

  def test_ids(content, valid_fn) do
    content
    |> parse_ranges()
    |> Enum.reduce(0, fn range, sum ->
      for item <- range, not valid_fn.(item), reduce: sum do
        acc -> acc + item
      end
    end)
    |> IO.puts()
  end

  def parse_ranges(content) do
    content
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.map(fn range ->
      String.split(range, "-", trim: true) |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.map(fn [start, stop] -> start..stop end)
  end

  def valid?(item) do
    s = Integer.to_string(item)
    # This assumes that all graphemes are single-byte, which is true for digits.
    l = byte_size(s)

    not (rem(l, 2) == 0 and has_pattern?(s, l, div(l, 2)))
  end

  def extended_valid?(item) do
    string = Integer.to_string(item)
    # This assumes that all graphemes are single-byte, which is true for digits.
    length = byte_size(string)

    Enum.all?(1..div(length, 2)//1, fn pattern_length ->
      !has_pattern?(string, length, pattern_length)
    end)
  end

  def has_pattern?(_, 1, _), do: true

  def has_pattern?(string, length, pattern_length) when pattern_length > 0 do
    pattern = String.slice(string, 0, pattern_length)
    rem(length, pattern_length) == 0 and length(String.split(string, pattern, trim: true)) == 0
  end
end

Day02.run()
