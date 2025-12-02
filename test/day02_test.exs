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
end
