require './lib/spades/deck.rb'

class TestSpadesCard < MiniTest::Unit::TestCase
  def test_deck_not_divisible_by_four_is_rejected
    assert_raises(Spades::ArgumentError) { Spades.deck(9) }
  end

  def test_deck_greater_than_52_is_rejected
    assert_raises(Spades::ArgumentError) { Spades.deck(56) }
  end

  def test_deck_8
    deck = [
      Spades::Card.new('2c'),
      Spades::Card.new('3c'),
      Spades::Card.new('2d'),
      Spades::Card.new('3d'),
      Spades::Card.new('2h'),
      Spades::Card.new('3h'),
      Spades::Card.new('2s'),
      Spades::Card.new('3s')
    ]
    gen_deck = Spades.deck(8)
    assert_equal(8, deck.length)
    assert_equal(deck, gen_deck)
  end
end
