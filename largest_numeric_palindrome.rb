gem "minitest"
require "minitest/autorun"

class LargestNumericPalindrome
  attr_reader :numbers

  def initialize(*numbers)
    @numbers = numbers
  end

  # FIXME don't just look for palindroms amongs products,
  #       but create palindromes from products.
  def find
    productions.select { |n| palindrome?(n) }.max
  end

  # TODO it should be largest number!
  def make_palindorme(number)
    digits = number.to_s.chars.revert
    if digits[0] == digits[1]
      digits[0] + make_palindorme(digits[2..-1]) + digits[1]
    else
      # TODO what?
    end
  end

  private

  def productions
    all_combinations.map { |ns| ns.inject(:*) }
  end

  def all_combinations
    (1..numbers.size).inject([]) do |memo, size|
      memo.concat numbers.combination(size).to_a
    end
  end

  def palindrome?(number)
    number.to_s.reverse == number.to_s
  end
end

class TestLargestNumericPalindrome < Minitest::Test
  def test_simple_pilindrome
    assert_equal 121, LargestNumericPalindrome.new(11, 11).find
  end

  def test_from_codewars
    assert_equal 81518, LargestNumericPalindrome.new(937,113).find
    assert_equal 484,   LargestNumericPalindrome.new(657,892).find
    assert_equal 868,   LargestNumericPalindrome.new(48,9,3,67).find
  end
end
