defmodule Day03Test do
  use ExUnit.Case

  test "power task example" do
    example =
      "987654321111111
811111111111119
234234234234278
818181911112111
"

    assert Day03.switch_batteries(example, 2) == 357
    assert Day03.switch_batteries(example, 12) == 3_121_910_778_619
  end

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

  test "select maximum joltage (2)" do
    assert Day03.maximize_joltage(Day03.parse_bank_joltages("12"), 2) == 12
    assert Day03.maximize_joltage(Day03.parse_bank_joltages("98"), 2) == 98
    assert Day03.maximize_joltage(Day03.parse_bank_joltages("111211"), 2) == 21
  end

  test "select maximum joltage (12)" do
    assert Day03.maximize_joltage(Day03.parse_bank_joltages("987654321111111"), 12) ==
             987_654_321_111

    assert Day03.maximize_joltage(Day03.parse_bank_joltages("811111111111119"), 12) ==
             811_111_111_119

    assert Day03.maximize_joltage(Day03.parse_bank_joltages("234234234234278"), 12) ==
             434_234_234_278

    assert Day03.maximize_joltage(Day03.parse_bank_joltages("818181911112111"), 12) ==
             888_911_112_111
  end

  test "deselect weakest battery" do
    assert Day03.deselect_from([1, 2]) == [2]
    assert Day03.deselect_from([4, 2, 3, 1, 3]) == [4, 3, 1, 3]
  end

  test "power example input" do
    assert Day03.maximize_joltage(
             Day03.parse_bank_joltages(
               "2232546378857275787561723292343835435343333776427842773354273372424413455462238746648634437374254318"
             ),
             12
           ) ==
             988_887_754_318

    assert Day03.maximize_joltage(
             Day03.parse_bank_joltages(
               "2232323232236223322223321222232212221212222222222332111132223222222222322133213322323133322222332224"
             ),
             12
           ) ==
             633_333_333_334
  end
end
