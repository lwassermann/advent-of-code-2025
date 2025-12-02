defmodule Day01 do
  def run do
    part1("L68
L30
R48
L5
R60
L55
L1
L99
R14
L82")
    part1(File.read!("data/day01-1.txt"))
  end

  def part1(content) do
    content
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{position: 50, zero_count: 0}, fn movement, %{position: p, zero_count: z} ->
      case turn_dial(p, movement) do
        0 -> %{position: 0, zero_count: z + 1}
        new_p -> %{position: new_p, zero_count: z}
      end
    end)
    |> report_part1_result
  end

  def turn_dial(position, distance) when is_integer(distance),
    do: Integer.mod(position + distance, 100)

  def turn_dial(position, "L" <> distance), do: turn_dial(position, -String.to_integer(distance))
  def turn_dial(position, "R" <> distance), do: turn_dial(position, String.to_integer(distance))
  def turn_dial(_, movement), do: raise("Unparseable movement \"#{movement}\"")

  def report_part1_result(%{position: p, zero_count: z}) do
    IO.puts("Turned the dial to #{p}, stopping at zero #{z} times.")
  end
end

Day01.run()
