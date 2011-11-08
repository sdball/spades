module Spades
  ## Spades.deck
  #
  # Creates an array of Spades::Card.
  #
  # 8 card deck
  # deck = Spades.deck(8)
  #
  # 52 card deck
  # deck = Spades.deck(52)
  def self.deck(count, shuffle = false)
    raise ArgumentError, "Deck must be divisible by 4." unless count % 4 == 0
    raise ArgumentError, "Maximum deck size is 52." if count > 52
    cards_per_suit = count / 4
    deck = []
    SUITS.keys.each do |suit|
      RANKS.keys.slice(0, cards_per_suit).each do |rank|
        deck << Spades::Card.new("#{rank}#{suit}")
      end
    end
    deck.shuffle! if shuffle
    deck
  end
end