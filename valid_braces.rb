# frozen_string_literal: true

gem "minitest"
require "minitest/autorun"

class ValidBraces
  attr_reader :str

  BRAICES_PAIRS_REGEXP = %r"\(\)|\{\}|\[\]"

  def valid?(str)
    return true if str.empty?
    return false unless str[BRAICES_PAIRS_REGEXP]
    valid? str.gsub(BRAICES_PAIRS_REGEXP, "")
  end
end

class TestValidBraces < Minitest::Test
  def test_length_quickcheck
    assert_equal false, ValidBraces.new.valid?("(")
    assert_equal false, ValidBraces.new.valid?("(){")
  end

  def test_simple_paranteces_case
    assert_equal true, ValidBraces.new.valid?("()")
    assert_equal true, ValidBraces.new.valid?("[]")
    assert_equal true, ValidBraces.new.valid?("{}")
  end

  def test_mixed_braces
    assert_equal true, ValidBraces.new.valid?("()[]{}")
  end

  def test_nested_braces
    assert_equal true, ValidBraces.new.valid?("([{}])")
  end

  def test_incorrect_mixed_braces
    assert_equal false, ValidBraces.new.valid?("([)]")
  end
end
