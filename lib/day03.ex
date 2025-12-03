defmodule Day03 do
  def run do
    File.read!("data/day03.txt")
    |> switch_batteries(2)
    |> IO.puts()

    IO.puts("That was not enough to overcome the static friction. Again with more batteries...")

    File.read!("data/day03.txt")
    |> switch_batteries(12)
    |> IO.puts()
  end

  def switch_batteries(content, bank_count) do
    content
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_bank_joltages/1)
    |> Enum.map(fn bank -> maximize_joltage(bank, bank_count) end)
    |> Enum.sum()
  end

  def maximize_joltage(bank, bank_count) when length(bank) < bank_count do
    raise ArgumentError
  end

  def maximize_joltage(bank, bank_count) when length(bank) == bank_count do
    calculate_combined_joltage(bank)
  end

  def maximize_joltage(bank, bank_count) when length(bank) > bank_count do
    maximize_joltage(deselect_from(bank), bank_count)
  end

  def maximize_joltage(_), do: raise(ArgumentError)

  def deselect_from(batteries) do
    {_, discard_index} =
      batteries
      |> Enum.with_index()
      |> Enum.reduce_while({List.first(batteries), 0}, fn {joltage, _} = battery,
                                                          {discard_value, _} = discard ->
        cond do
          # The battery marked for discarding has a higher joltage than the current one.
          discard_value > joltage ->
            {:cont, battery}

          # The current battery has the same joltage. We can discard either.
          discard_value == joltage ->
            {:cont, discard}

          # The next battery has a higher joltage, which means it should move left.
          discard_value < joltage ->
            {:halt, discard}
        end
      end)

    List.delete_at(batteries, discard_index)
  end

  defp calculate_combined_joltage(batteries), do: Enum.join(batteries) |> String.to_integer()

  def parse_bank_joltages(bank_desciption) do
    bank_desciption
    |> String.to_charlist()
    |> Enum.map(&parse_digit/1)
  end

  # UTF8 uses the ASCII codepoints for digits, to avoid some confusions when it
  # was introduced.
  def parse_digit(char) when char >= 48 and char < 58, do: char - 48
  def parse_digit(_), do: raise(ArgumentError)
end

Day03.run()
