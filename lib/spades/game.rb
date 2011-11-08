module Spades
  ##
  # Given four Spades::Cards, return the winning card
  #
  # 2c = Spades::Card.new('c2')
  # 3c = Spades::Card.new('c2')
  # 4c = Spades::Card.new('c2')
  # 5c = Spades::Card.new('c2')
  # Spades.winning_card(2c, 3c, 4c, 5c)
  # => 5c
  def self.winning_card(*trick)
    trick = trick[0] if trick[0].is_a? Array
    raise ArgumentError, "Trick must have four cards." unless 4 == trick.length
    trick.sort.last
  end

  ##
  # Given an array of Spades::Cards return it as four arrays.
  #
  # deck = Spades.deck(52)
  # player1, player2, player3, player4 = Spades.deal(deck)
  def self.deal(deck)
    raise ArgumentError, "Deck must be divisible by four." unless 0 == deck.length % 4
    deal = deck.length / 4
    return [
      deck.slice!(0, deal),
      deck.slice!(0, deal),
      deck.slice!(0, deal),
      deck.slice!(0, deal)
    ]
  end
end
