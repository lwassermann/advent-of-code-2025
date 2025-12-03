defmodule Day03Test do
  use ExUnit.Case

  test "parse_digit" do
    assert Day03.parse_digit(?0) == 0
    assert Day03.parse_digit(?1) == 1
    assert Day03.parse_digit(?2) == 2
    assert Day03.parse_digit(?3) == 3
    assert Day03.parse_digit(?4) == 4
    assert Day03.parse_digit(?5) == 5
    assert Day03.parse_digit(?6) == 6
    assert Day03.parse_digit(?7) == 7
    assert Day03.parse_digit(?8) == 8
    assert Day03.parse_digit(?9) == 9
  end

  test "select maximum joltage" do
    assert Day03.maximize_joltage(Day03.parse_bank_joltages("12")) == 12
    assert Day03.maximize_joltage(Day03.parse_bank_joltages("98")) == 98
    assert Day03.maximize_joltage(Day03.parse_bank_joltages("111211")) == 21
  end

  test "power task example" do
    example =
      "987654321111111
811111111111119
234234234234278
818181911112111
"

    assert Day03.switch_batteries(example) == 357
  end
end
