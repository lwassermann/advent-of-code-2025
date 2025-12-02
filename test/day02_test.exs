defmodule Day02Test do
  use ExUnit.Case

  test "checking for a single repetition of digits" do
    assert Day02.valid?(11) == false
    assert Day02.valid?(446_446) == false
    assert Day02.valid?(38_593_859) == false

    assert Day02.valid?(12) == true
    assert Day02.valid?(101) == true
    assert Day02.valid?(111) == true
    assert Day02.valid?(1441) == true
  end

  test "checking for any repetitions in the digits" do
    assert Day02.extended_valid?(11) == false
    assert Day02.extended_valid?(446_446) == false
    assert Day02.extended_valid?(38_593_859) == false
    assert Day02.extended_valid?(111) == false
    assert Day02.extended_valid?(565_656) == false
    assert Day02.extended_valid?(2_121_212_121) == false

    assert Day02.extended_valid?(12) == true
    assert Day02.extended_valid?(101) == true
    assert Day02.extended_valid?(1441) == true
  end

  test "check task example" do
    example =
      "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
"

    assert Day02.test_ids(example, &Day02.valid?/1) == 1_227_775_554
    assert Day02.test_ids(example, &Day02.extended_valid?/1) == 4_174_379_265
  end
end
