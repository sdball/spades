module Spades
  RANKS = {
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    '10' => 10,
    'j' => 11,
    'q' => 12,
    'k' => 13,
    'a' => 14
  }
  SUITS = {
    'c' => 1,
    'h' => 0,
    'd' => 0,
    's' => 10
  }
  ## Spades::Card
  #
  # A card in the game of Spades.
  #
  # Essentially just wrappers to evaluate card string representations.
  # Cards are initialized as two character strings: rank and suit.
  # Possible suits: c, h, d, s
  # Possible ranks: 2, 3, 4, 5, 6, 7, 8, 9, 10, j, q, k, a
  # 
  # A of Clubs
  # ac = Spades::Card.new('ac')
  #
  # 2 of Spades
  # s2 = Spades::Card.new('2s')
  #
  # ac < s2
  # => true
  class Card
    include Comparable
    attr_reader :rank, :suit

    def initialize(card)
      @rank, @suit = card.downcase.split('')
    end

    def <=>(other)
      return value <=> other.value
    end

    def value
      numeric_rank * numeric_suit
    end

    def numeric_rank
      RANKS[@rank]
    end

    def numeric_suit
      SUITS[@suit]
    end

    def to_s
      "#{@rank}#{@suit}"
    end
  end
end
