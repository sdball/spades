require './lib/spades.rb'

class TestSpades < MiniTest::Unit::TestCase
  def test_high_club_wins
    trick = create_cards('2c', '3c', '4c', '5c')
    assert_equal(Spades::Card.new('5c'), Spades.winning_card(trick))
  end

  def test_spade_wins
    trick = create_cards('qc', 'kc', 'ac', '2s')
    assert_equal(Spades::Card.new('2s'), Spades.winning_card(trick))
  end

  def create_cards(*cards)
    cards.map { |card| Spades::Card.new(card) }
  end
end
