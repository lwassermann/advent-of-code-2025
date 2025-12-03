defmodule Day03 do
  def run do
    File.read!("data/day03-1.txt")
    |> switch_batteries()
    |> IO.puts()

    # IO.puts("There are more suspicious patterns...")

    # test_ids(File.read!("data/day03-1.txt"), &extended_valid?/1)
    # |> IO.puts()
  end

  def switch_batteries(content) do
    content
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_bank_joltages/1)
    |> Enum.map(&maximize_joltage/1)
    |> Enum.sum()
  end

  def maximize_joltage(bank) when length(bank) >= 2 do
    candidates =
      for joltage <- bank, reduce: %{max: nil, trailing_max: nil, leading_max: nil} do
        %{max: max, trailing_max: trailing_max} = acc ->
          cond do
            is_nil(max) or joltage > max ->
              %{max: joltage, trailing_max: nil, leading_max: max}

            is_nil(trailing_max) or joltage > trailing_max ->
              %{acc | trailing_max: joltage}

            true ->
              acc
          end
      end

    combine_joltage_candidates(candidates)
  end

  def maximize_joltage(_), do: raise(ArgumentError)

  defp combine_joltage_candidates(%{max: nil}), do: raise(ArgumentError)

  defp combine_joltage_candidates(%{max: _, trailing_max: nil, leading_max: nil}),
    do: raise(ArgumentError)

  # If the rightmost battery has the highest joltage
  defp combine_joltage_candidates(%{max: digit2, trailing_max: nil, leading_max: digit1}) do
    10 * digit1 + digit2
  end

  defp combine_joltage_candidates(%{max: digit1, trailing_max: digit2}), do: 10 * digit1 + digit2

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
