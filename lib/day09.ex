defmodule Day09 do
  def run do
    tiles =
      File.read!("data/day09.txt")
      |> parse_floor()

    tiles |> find_largest_square() |> IO.inspect()
  end

  def parse_floor(content) do
    content
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_point/1)
  end

  def find_largest_square(floor) do
    floor
    |> Enum.zip_reduce(
      Stream.unfold(tl(floor), fn tail -> if tail == [], do: nil, else: {tail, tl(tail)} end),
      0,
      fn a, other_squares, max_square_size ->
        other_squares
        |> Enum.reduce(max_square_size, fn b, acc -> max(square_size(a, b), acc) end)
      end
    )
  end

  def parse_point(line) do
    [x, y] = String.split(line, ",")
    {String.to_integer(x), String.to_integer(y)}
  end

  def square_size({x1, y1}, {x2, y2}) do
    (abs(x2 - x1) + 1) * (abs(y2 - y1) + 1)
  end
end

Day09.run()
