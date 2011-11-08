require 'spades/card'

class TestSpadesCard < MiniTest::Unit::TestCase
  def setup
    @two_of_clubs = Spades::Card.new('2c')
    @ace_of_clubs = Spades::Card.new('ac')
    @two_of_spades = Spades::Card.new('2s')
  end

  def test_ace_of_clubs_less_than_two_of_spades
    assert @ace_of_clubs < @two_of_spades
  end

  def test_two_of_clubs_less_than_ace_of_clubs
    assert @two_of_clubs < @ace_of_clubs
  end
end
