defmodule Day01Test do
  use ExUnit.Case

  import Day01

  test "calculating new positions" do
    assert turn_dial(0, "R10") == 10
    assert turn_dial(0, "L10") == 90
    assert turn_dial(50, "R60") == 10
    assert turn_dial(50, "L60") == 90
  end

  test "calculating zero-passes (counterclockwise)" do
    assert zero_passes(50, "L10") == 0
    assert zero_passes(50, "L60") == 1
    assert zero_passes(50, "L160") == 2
    assert zero_passes(0, "L10") == 0
    assert zero_passes(0, "L110") == 1
  end

  test "calculating zero-passes (clockwise)" do
    assert zero_passes(50, "R10") == 0
    assert zero_passes(50, "R60") == 1
    assert zero_passes(50, "R160") == 2
    assert zero_passes(0, "R10") == 0
    assert zero_passes(0, "R110") == 1
  end
end
