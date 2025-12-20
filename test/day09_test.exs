defmodule Day09Test do
  use ExUnit.Case

  import Day09

  test "example input" do
    example =
      """
      7,1
      11,1
      11,7
      9,7
      9,5
      2,5
      2,3
      7,3
      """

    tiles = example |> parse_floor()
    assert tiles |> find_largest_square() == 50
  end
end
