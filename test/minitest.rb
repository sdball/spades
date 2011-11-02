require './lib/deck.rb'
require 'minitest/autorun'

class TestDeck < MiniTest::Unit::TestCase
  def setup
    @deck = Deck.new
  end

  def test_returns_4
    assert_equal 4, @deck.returns_4
    refute_equal 5, @deck.returns_4
  end

end