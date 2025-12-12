defmodule Day04Test do
  use ExUnit.Case

  import Day04

  test "accessibility" do
    grid =
      """
      ..@@
      @@@.
      @@@@
      """
      |> parse_grid_into_map()

    assert is_accessible?(grid, {0, 2}) == true
    assert is_accessible?(grid, {0, 3}) == true
    assert is_accessible?(grid, {1, 1}) == false
    assert is_accessible?(grid, {1, 2}) == false
  end

  test "accessibility example input" do
    grid =
      """
      ..@@.@@@@.
      @@@.@.@.@@
      @@@@@.@.@@
      @.@@@@..@.
      @@.@@@@.@@
      .@@@@@@@.@
      .@.@.@.@@@
      @.@@@.@@@@
      .@@@@@@@@.
      @.@.@@@.@.
      """
      |> parse_grid_into_map()

    assert grid
           |> mark_accessible_rolls()
           |> total_accessible_rolls() == 13

    assert grid
           |> remove_accessible_rolls()
           |> total_accessible_rolls() == 43
  end
end
