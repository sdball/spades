module Spades
  def self.winning_card(*trick)
    trick = trick[0] if trick[0].is_a? Array
    trick.sort.last
  end
end
