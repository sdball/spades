require 'combinatorial'

class TestCombinatorial < MiniTest::Unit::TestCase
  def test_factorial
    known_factorials = {
      -4 => 1,
      0 => 1,
      1 => 1,
      2 => 2,
      3 => 6,
      4 => 24,
      5 => 120
    }
    known_factorials.each_pair do |number, result|
      assert_equal(result, Math.factorial(number))
    end
  end

  def test_combinatorial
    known_combinatorials = {
      [3,1] => 3,
      [10,2] => 45,
      [12,6] => 924
    }
    known_combinatorials.each_pair do |operands, result|
      assert_equal(result, Math.combinatorial(operands[0], operands[1]))
    end
  end

  # benchmarks, only run if tests pass
  def bench_factorial
    assert_performance_linear do |n| # n is a range value
      Math.factorial(n)
    end
  end

  def bench_combinatorial
    assert_performance_linear do |n| # n is a range value
      Math.combinatorial(n,6)
    end
  end

end