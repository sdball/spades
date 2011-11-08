require 'spades'

class TestSpadesGame < MiniTest::Unit::TestCase
  def test_high_club_wins
    trick = create_cards('2c', '3c', '4c', '5c')
    assert_equal(Spades::Card.new('5c'), Spades.winning_card(trick))
  end

  def test_spade_wins
    trick = create_cards('qc', 'kc', 'ac', '2s')
    assert_equal(Spades::Card.new('2s'), Spades.winning_card(trick))
  end

  def test_invalid_trick_rejected
    invalid_trick = create_cards('2c', '3c', '2h')
    assert_raises(Spades::ArgumentError) { Spades.winning_card(invalid_trick) }
  end

  def test_dealing_cards
    deck = Spades.deck(16)
    hands = Spades.deal(deck)
    hands.each do |hand|
      assert_equal 4, hand.length
    end
  end

  def create_cards(*cards)
    cards.map { |card| Spades::Card.new(card) }
  end
end
