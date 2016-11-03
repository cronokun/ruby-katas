gem "minitest"
require "minitest/autorun"

# Fib numbers:
# 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, ...
# as in
# F(n) = F(n-1) + F(n-2) where F(0) = 0 and F(1) = 1.
#
# Check that given prod, such exists as F(n) * F(n+1) = prod.
# In that case retun `[F(n), F(n+1), true]`.
#
# Else return `[F(m), F(m+1), false]` with
# F(m) beeing smallest one F(m) + F(m+1) > prod.

class ProductFib
  attr_reader :prod

  def self.test(prod)
    self.new(prod).product_fib
  end

  def initialize(prod)
    @prod = prod
  end

  def product_fib
    a, b = fib_pairs.detect { |fib_a, fib_b| fib_a * fib_b >= prod }
    [a, b, a * b == prod]
  end

  private

  def fib_pairs
    FibPairsGenerator.new
  end
end

class FibPairsGenerator
  include Enumerable

  attr_reader :current_pair

  def initialize
    @current_pair = [0, 1]
  end

  def each
    return self.dup unless block_given?
    loop do
      yield succ # FIXME returns [1,1] on the first run, not [0,1]
    end
  end

  def succ
    a, b = current_pair
    @current_pair = [b, a + b]
  end

  def rewind
    initialize
  end

  alias next succ
end

class TestProductFib < Minitest::Test
  def test_true_case
    assert_equal [55, 89, true], ProductFib.test(4895)
  end

  def test_false_case
    assert_equal [89, 144, false], ProductFib.test(5895)
  end
end
