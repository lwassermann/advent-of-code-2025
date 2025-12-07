defmodule Day05Test do
  use ExUnit.Case

  import Day05

  test "merge_overlapping_ranges" do
    assert merge_overlapping_ranges([]) == []
    assert merge_overlapping_ranges([3..5]) == [3..5]
    assert merge_overlapping_ranges([3..5, 10..14, 12..18, 16..20]) == [3..5, 10..20]
  end

  test "power example input" do
    example =
      """
      3-5
      10-14
      16-20
      12-18

      1
      5
      8
      11
      17
      32
      """

    inventory = example |> parse_fresh_ranges()

    assert inventory
           |> filter_fresh_ingredients()
           |> length() == 3

    assert inventory |> count_fresh_ingredient_ids() == 14
  end
end
