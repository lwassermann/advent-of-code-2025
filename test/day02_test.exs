defmodule Day02Test do
  use ExUnit.Case

  import Day02

  test "checking for a single repetition of digits" do
    assert valid?(11) == false
    assert valid?(446_446) == false
    assert valid?(38_593_859) == false

    assert valid?(12) == true
    assert valid?(101) == true
    assert valid?(111) == true
    assert valid?(1441) == true
  end

  test "checking for any repetitions in the digits" do
    assert extended_valid?(11) == false
    assert extended_valid?(446_446) == false
    assert extended_valid?(38_593_859) == false
    assert extended_valid?(111) == false
    assert extended_valid?(565_656) == false
    assert extended_valid?(2_121_212_121) == false

    assert extended_valid?(12) == true
    assert extended_valid?(101) == true
    assert extended_valid?(1441) == true
  end

  test "check task example" do
    example =
      """
      11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
      """

    assert test_ids(example, &valid?/1) == 1_227_775_554
    assert test_ids(example, &extended_valid?/1) == 4_174_379_265
  end
end
