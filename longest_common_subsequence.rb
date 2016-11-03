gem "minitest"
require "minitest/autorun"

class LCS
  def lcs(x, y)
    if x.empty? || y.empty?
      ""
    elsif x == y
      x
    elsif x[0] == y[0]
      x[0] << lcs( x[1..-1], y[1..-1] )
    elsif x[-1] == y[-1]
      lcs(x.chop, y.chop) << x[-1]
    else
      [ lcs(x, y.chop), lcs(x.chop, y) ].max_by(&:length)
    end
  end
end

class FooLCS
  def subsequences(str)
    (1..str.length).map { |i| str.chars.combination(i).to_a.map(&:join) }.flatten(1)
  end

  def lcs(x, y)
    (subsequences(x) & subsequences(y)).max { |s| s.length } || ""
  end
end

class TestLCS < Minitest::Test
  def setup
    @subject = FooLCS.new
  end

  def test_edge_case
    assert_equal "", @subject.lcs("", "")
  end

  def test_simplest_case
    assert_equal "ABC", @subject.lcs("ABC", "ABC")
  end

  def test_no_lcs
    assert_equal "", @subject.lcs("ABCJ", "DEF")
  end

  def test_first_property
    assert_equal "AANA", @subject.lcs("BANANA", "ATANA")
  end

  def test_second_property
    assert_equal "BCDG", @subject.lcs("ABCDEFG", "BCDGK")
  end

  def test_from_kata
    assert_equal "12356", @subject.lcs("132535365" , "123456789")
  end
end
