defmodule Day01 do
  @example "L68
L30
R48
L5
R60
L55
L1
L99
R14
L82"

  def run do
    part1(@example)
    part1(File.read!("data/day01-1.txt"))
    IO.puts("Switching to password method 0x434C49434B.")
    part2(@example)
    part2(File.read!("data/day01-1.txt"))
  end

  def part1(content) do
    part(content, fn movement, %{position: p, zero_count: z} ->
      case turn_dial(p, movement) do
        0 -> %{position: 0, zero_count: z + 1}
        new_p -> %{position: new_p, zero_count: z}
      end
    end)
  end

  def part2(content) do
    part(content, fn movement, %{position: p, zero_count: z} ->
      %{position: turn_dial(p, movement), zero_count: z + zero_passes(p, movement)}
    end)
  end

  def part(content, reduceFn) do
    content
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{position: 50, zero_count: 0}, reduceFn)
    |> report_result
  end

  def turn_dial(position, distance) when is_integer(distance),
    do: Integer.mod(position + distance, 100)

  def turn_dial(position, "L" <> distance), do: turn_dial(position, -String.to_integer(distance))
  def turn_dial(position, "R" <> distance), do: turn_dial(position, String.to_integer(distance))
  def turn_dial(_, movement), do: raise("Unparseable movement \"#{movement}\"")

  def report_result(%{position: p, zero_count: z}) do
    IO.puts("Turned the dial to #{p}, stopping at zero #{z} times.")
  end

  def zero_passes(0, "L" <> distance) do
    abs(div(-String.to_integer(distance), 100))
  end

  def zero_passes(position, "L" <> distance) do
    abs(div(position - 100 - String.to_integer(distance), 100))
  end

  def zero_passes(position, "R" <> distance) do
    abs(div(position + String.to_integer(distance), 100))
  end
end

Day01.run()
