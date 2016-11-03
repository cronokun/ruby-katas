gem "minitest"
require "minitest/autorun"

class Sudoku
  attr_reader :grid, :size, :block_size

  def initialize(grid)
    @grid = grid
    @size = grid.size
    # TODO check that block size is integer
    @block_size = Math.sqrt(@size)
  end

  def valid?
    check_rows && check_columns && check_blocks
  end

  private

  def check_rows
    grid.all? &uniq_numbers_check
  end

  def check_columns
    grid.transpose.all? &uniq_numbers_check
  end

  def check_blocks
    blocks.all? &uniq_numbers_check
  end

  def blocks
    grid.map { |row| row.each_slice(block_size).to_a }
         .transpose
         .flatten(1)
         .each_slice(block_size)
         .map(&:flatten)
  end

  def uniq_numbers_check
    lambda { |row| row.sort == (1..size).to_a }
  end
end

class TestSudokuChecker < Minitest::Test
  def test_good_sudoku_9
    puzzle = Sudoku.new([
      [7,8,4, 1,5,9, 3,2,6],
      [5,3,9, 6,7,2, 8,4,1],
      [6,1,2, 4,3,8, 7,5,9],

      [9,2,8, 7,1,5, 4,6,3],
      [3,5,7, 8,4,6, 1,9,2],
      [4,6,1, 9,2,3, 5,8,7],
      
      [8,7,6, 3,9,4, 2,1,5],
      [2,4,3, 5,6,1, 9,7,8],
      [1,9,5, 2,8,7, 6,3,4]
    ])
    
    assert_equal true, puzzle.valid?
  end

  def test_good_sudoku_4
    puzzle = Sudoku.new([
      [1,4, 2,3],
      [3,2, 4,1],

      [4,1, 3,2],
      [2,3, 1,4]
    ])

    assert_equal true, puzzle.valid?
  end

  def test_bad_sudoku
    puzzle = Sudoku.new([
      [0,2,3, 4,5,6, 7,8,9],
      [1,2,3, 4,5,6, 7,8,9],
      [1,2,3, 4,5,6, 7,8,9],

      [1,2,3, 4,5,6, 7,8,9],
      [1,2,3, 4,5,6, 7,8,9],
      [1,2,3, 4,5,6, 7,8,9],

      [1,2,3, 4,5,6, 7,8,9],
      [1,2,3, 4,5,6, 7,8,9],
      [1,2,3, 4,5,6, 7,8,9]
    ])

    assert_equal false, puzzle.valid?
  end

  def test_irregular_sudoku
    puzzle = Sudoku.new([
      [1,2,3,4,5],
      [1,2,3,4],
      [1,2,3,4],  
      [1]
    ])

    assert_equal false, puzzle.valid?
  end
end
