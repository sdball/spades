require 'rake'
require 'rake/testtask'

task :default => [:test]

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = FileList['test/test_helper.rb']
  t.warning = true
  t.verbose = true
end

desc "Calculate the odds for 2 Clubs through Ace of Clubs, and any Spade to win the first trick."
task :odds do |t|
  $LOAD_PATH << './lib'
  require 'spades'
  require 'combinatorial'
  cards = ENV['cards'] ? ENV['cards'].to_i : 8
  decks = ENV['decks'] ? ENV['decks'].to_i : 100
  winning_cards = Hash.new(0)
  decks.times do
    deck = Spades.deck(cards, true)
    player1, player2, player3, player4 = Spades.deal(deck)
    trick = []
    trick << Spades.next_play(player1)
    trick << Spades.next_play(player2)
    trick << Spades.next_play(player3)
    trick << Spades.next_play(player4)
    winning_cards[Spades.winning_card(trick).to_sym] += 1
  end

  Spades::RANKS.keys.each do |rank|
    puts "#{rank}c:\t%.2f (observed)" % (winning_cards["#{rank}c".to_sym] / decks.to_f)
  end
  puts "spade:\t%.2f (observed)" % (winning_cards["2s".to_sym] / decks.to_f)

end

