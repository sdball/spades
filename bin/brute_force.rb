##
# Hacked together script of experimentation
# Left here for posterity
#
module Spades
  def self.winner(trick)
    trick.sort.last
  end

  def self.next_play(hand)
    hand.sort!
    hand.each do |card|
      return card if card.value > 0
    end
    return hand.first
  end

  class Card
    include Comparable

    RANKS = {
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
      RANKS[rank] || rank.to_i
    end

    def numeric_suit
      SUITS[suit]
    end

    def to_s
      "#{@rank}#{@suit}"
    end

  end
end


if $0 == __FILE__
  c2 = Spades::Card.new('2c')
  c3 = Spades::Card.new('3c')
  played = 0
  won = 0
  all_clubs = 0
  deck = [
    Spades::Card.new('2c'),
    Spades::Card.new('3c'),
    # Spades::Card.new('4c'),
    Spades::Card.new('2h'),
    Spades::Card.new('3h'),
    # Spades::Card.new('4h'),
    Spades::Card.new('2d'),
    Spades::Card.new('3d'),
    # Spades::Card.new('4d'),
    Spades::Card.new('2s'),
    Spades::Card.new('3s'),
    # Spades::Card.new('4s')
  ]
  deck.combination(2) do |hand1|
    (deck - hand1).combination(2) do |hand2|
      (deck - hand1 - hand2).combination(2) do |hand3|
        hand4 = deck - hand1 - hand2 - hand3
        if hand1.sort == [c2, c3] or hand2.sort == [c2, c3] or hand3.sort == [c2, c3] or hand4.sort == [c2, c3]
          all_clubs += 1
        end
        played += 1
        trick = []
        trick << Spades.next_play(hand1)
        trick << Spades.next_play(hand2)
        trick << Spades.next_play(hand3)
        trick << Spades.next_play(hand4)
        if Spades.winner(trick) == c3
          puts "hand1: #{hand1}"
          puts "hand2: #{hand2}"
          puts "hand3: #{hand3}"
          puts "hand4: #{hand4}"
          puts "trick: #{trick}"
          puts
          won += 1
        end
      end
    end
  end
  puts "\n"
  puts won
  puts played
  puts won.to_f / played
  puts all_clubs
end
