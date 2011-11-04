require './lib/combinatorial.rb'

class TestCombinatorial < MiniTest::Unit::TestCase
  def test_factorial
    known_factorials = {
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

end