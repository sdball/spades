require './lib/combinatorial.rb'

class TestCombinatorial < MiniTest::Unit::TestCase
  def test_factorial
    assert_equal(1, Math.factorial(1))
  end

end