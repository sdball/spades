# Initial Thoughts

P: player playing card
X, Y, Z: other players

A first glance it seems like there's only one restriction for the 2C
probability: P needs to hold all the clubs. For 3C then P needs to hold all the
clubs except 2. Etc.

But this is too simple.

For the 2, P must hold all the clubs AND X, Y, Z cannot hold only spades.

For the spade, P must have only spades? How else could they play a spade on the
first trick?

## Classes?

- Deck
- Game
- Player
- Trick
- Card

# Skeleton files

To get the ball rolling I created my standard script directory

- /lib
- /test
- Rakefile

# Code structure

Rather than create objects for every data structure, using ruby's existing
structures wherever possible should keep things simple. My general rule is that
if the object just holds data it should be a hash. Further, if I can't think of
good unit tests for a class then I'm probably making a design mistake.

I've decided to make a Game class, and probably a Card class.

## Game

- array of Cards
- the players hands
- method to play the next trick
- method to compare/sort Cards
- method to declare winning card of a trick

## Card

- Suit
- Rank

Looking at this, it sure seems like Card could just be a hash.

# Playing the Game

1. Shuffle the deck
2. Deal 13 cards to each player
3. Sort each hand of cards
4. Shift the lowest card from each hand (? does this work for selecting the next
   card to play from each hand ?) to play the trick
5. Determine the winning card for the trick

To handle all this, I'd say have a Spades module to hold:

- Game class
- Deck class
- Card class

The cards, being Spades::Card, should know how to compare themselves:
e.g. 2 of clubs < 5 of clubs < X of spades

-------

# The Question of Probability

All this is great, but now to the problem of calculating probabilities.

The obvious idea is to generate every possible game/hand combination and check
the first trick for each. Yikes.

I'll need to roll up to generalizable rules.

It's obvious that randomly dealing hands and seeing the results of the first
trick isn't a feasible method to check the probability.

First, let's figure out the number of possible deals.

first hand: (52 choose 13) possible hands = 635013559600
second hand: (39 choose 13) possible hands = 8122425444
third hand: (26 choose 13) possible hands = 10400600
last hand: 1

So 635013559600 * 8122425444 * 10400600 * 1 = 53644737765488792839237440000

Wolfram|Alpha tells me that's ... just exceedingly huge. Even if I spend just
0.1 milliseconds to deal and evaluate it would take 170.1 quadrillion years to
complete. Ok, that's out.

Maybe it's not as complicated as that, since we only care about the first trick?

Hm, maybe if I try to work some out by hand a method or pattern will reveal
itself.

## 2 of clubs

This requires that one player hold all clubs (otherwise another player will play
their club and win), and no player holds only spades (otherwise they will trump
and win):

That leaves 39 cards for the other hands to be dealt from:

(39 choose 13) * (26 choose 13) = 8122425444 * 10400600 = 84478098072866400

But that includes the possibilities of all spades. The number of possibilities
of all clubs hand with an all spades hand:

(26 choose 13) = 10400600

That leaves 84478098072866400 - 10400600 = 84478098062465800 ways for the first
trick to be taken with the 2 of clubs.

84478098062465800 / 53644737765488792839237440000
Odds: 1.5747695 * 10^-12

Ok. We are dealing with huge numbers.

## 3 of clubs

This requires that one player hold 12 clubs and not the 2 of clubs; and no
player holds only spades.

Since their hand's last card just needs to not be the two of clubs, they have
(39 choose 1) = 39 possibilities.

That means there are:

([40 - 1] choose 1) * (39 choose 13) * (26 choose 13) possible deals for a
player to get 12 clubs and not the 2 of clubs.

39 * 8122425444 * 10400600 = 3294645824841789600

A 12 clubs hand and all spades hand probability would be:

(27 choose 1) * (26 choose 13) = 27 * 10400600 = 280816200

3294645824841789600 - 280816200 = 3294645824560973400

3294645824560973400 / 53644737765488792839237440000
Odds: 6.1416011 * 10^-11

## K of clubs

Jumping ahead to the K of clubs might lend some additional insight.

For the king of clubs to win requires that one player hold the king and ace of
clubs and no player holds all spades.

Odds of a hand with only the king and ace of clubs:
([50 - 11] choose 11) * (39 choose 13) * (26 choose 13)
= 1676056044 * 8122425444 * 10400600 = 141590026860652482124521600

Odds of a hand with K,A of clubs and a hand with only spades:
13 spades + 2 clubs = 15 locked cards => 37 cards left to distribute
(37 choose 11) * (26 choose 13) = 854992152 * 10400600 = 8892431376091200

141590026860652482124521600 - 8892431376091200 = 141590026851760050748430400

Odds of king of clubs winning first trick:
141590026851760050748430400 / 53644737765488792839237440000 = 2.63940 * 10^-3

# Moving to ruby

It's pretty clear that the program will need to do combinatorial math.

Time to find a ruby combination method!

Anything interesting in Fixnum?

    ruby-1.9.2-p290 > 1.methods - Class.new.methods
     => [:-@, :+, :-, :*, :/, :div, :%, :modulo, :divmod, :fdiv, :**, :abs,
    :magnitude, :~, :&, :|, :^, :[], :<<, :>>, :to_f, :size, :zero?, :odd?, :even?,
    :succ, :integer?, :upto, :downto, :times, :next, :pred, :chr, :ord, :to_i,
    :to_int, :floor, :ceil, :truncate, :round, :gcd, :lcm, :gcdlcm, :numerator,
    :denominator, :to_r, :rationalize, :singleton_method_added, :coerce, :i, :+@,
    :quo, :remainder, :real?, :nonzero?, :step, :to_c, :real, :imaginary, :imag,
    :abs2, :arg, :angle, :phase, :rectangular, :rect, :polar, :conjugate, :conj,
    :between?]

Doesn't look like it. Maybe Math?

    ruby-1.9.2-p290 :009 > Math.methods
     => [:atan2, :cos, :sin, :tan, :acos, :asin, :atan, :cosh, :sinh, :tanh, :acosh,
    :asinh, :atanh, :exp, :log, :log2, :log10, :sqrt, :cbrt, :frexp, :ldexp, :hypot,
    :erf, :erfc, :gamma, :lgamma, :freeze, :===, :==, :<=>, :<, :<=, :>, :>=, :to_s,
    :included_modules, :include?, :name, :ancestors, :instance_methods,
    :public_instance_methods, :protected_instance_methods,
    :private_instance_methods, :constants, :const_get, :const_set, :const_defined?,
    :const_missing, :class_variables, :remove_class_variable, :class_variable_get,
    :class_variable_set, :class_variable_defined?, :module_exec, :class_exec,
    :module_eval, :class_eval, :method_defined?, :public_method_defined?,
    :private_method_defined?, :protected_method_defined?, :public_class_method,
    :private_class_method, :autoload, :autoload?, :instance_method,
    :public_instance_method, :nil?, :=~, :!~, :eql?, :hash, :class,
    :singleton_class, :clone, :dup, :initialize_dup, :initialize_clone, :taint,
    :tainted?, :untaint, :untrust, :untrusted?, :trust, :frozen?, :inspect,
    :methods, :singleton_methods, :protected_methods, :private_methods,
    :public_methods, :instance_variables, :instance_variable_get,
    :instance_variable_set, :instance_variable_defined?, :instance_of?, :kind_of?,
    :is_a?, :tap, :send, :public_send, :respond_to?, :respond_to_missing?, :extend,
    :display, :method, :public_method, :define_singleton_method, :__id__,
    :object_id, :to_enum, :enum_for, :equal?, :!, :!=, :instance_eval,
    :instance_exec, :__send__]

Seriously? That's step one then.

Yikes, no factorial either.

So, creating those comes next. I've decided to implement them within the Math
module since they logically fit within it. Both are pretty straightforward
algorithms.

# Reconsidering probabilities

Hmm, I've figured my initial probability calculations wrong.

For the 3 of clubs: there are more possibilities that allow the 3 of clubs to
win the first trick than one player holding all the clubs except the 2. Another
player could hold a higher club IF they also hold the free roaming 2 of clubs.

This is further complicated as the club rank increases. The 4 of clubs winning
means that two players could also hold higher clubs as they respectively long as
they hold the 2 and 3 of clubs.

Hmm. Time to simplify the problem. I'll write a program to brute force the
probabilities of a deck with 16 cards to get some empirical results.

Ok. Brute forcing all combinations of a deck of 16 cards is too time consuming.
Going to a deck of 8.

# 2 of Clubs, Deck of 8, brute force analysis

Odds that 2C will win the first trick in a deck of 8 cards:

- won 288
- played 2520
- odds 0.11428571428571428
- hands that are all clubs: 360

(8 choose 2) * (6 choose 2) * (4 choose 2) = 2520

Odds that a player holds 2C and 3C:

((6 choose 2) * (4 choose 2)) * 4 = 360 / 2520 = .14285714285714285714

Hmm, a previous mathematical flaw exposed here. I have not been multiplying out
the change of holding all of a suit to four players.

# 3 of Clubs, Deck of 8, brute force analysis

- won 1872
- played 2520
- odds 0.7428571428571429

Only won if player was holding 3C and a spade.

# Any spade, Deck of 8, brute force analysis

- won 360
- played 2520
- odds 0.14285714285714285

-------

Perhaps I could focus on the variations of the first trick (requiring the two of
clubs).

Instead of evaluating the probabilities of an entire hand being dealt (52 choose
13), etc. just work on the number of possible first tricks that include the two
of clubs (since that will always be played)

(51 choose 4)

The big huge number (52 choose 13) * (49 choose 13) * etc. is too much, because
it's assuming that the entire hand matters. We only care about the first four
cards.

(51 choose 4) will still include tricks that aren't possible, e.g. [2C, 3S, 4S,
5S]. But since we're just counting the combinations where 2C is a winner it
should only be less efficient; not less accurate.

Amusingly, if this checks out I'll simply be able to use Array.combination.

-------

Analyzing the first tricks only works if I can come up with a set of rules to
determine valid first tricks. The most obvious being that the two of clubs is
played.

Just filtering for groups of four cards that includes the four of clubs results
in false positives, e.g. [2c, 2h, 3h, 2d]

-------

Brute forcing a deck of 8 to count the number of possible first tricks.

(Done)

Ah, unfortunately that won't work. While there are only a limited number of
potential first tricks there are varying degrees of probability for each:

    {[2d, 2h, 2c, 2s]=>12,
     [3d, 2h, 2d, 2c]=>8,
     [2d, 2h, 3d, 2c]=>8,
     [3h, 2h, 2c, 2s]=>24,
     [3d, 2h, 3h, 2c]=>16,
     [3h, 2h, 3d, 2c]=>16,
     [2d, 2h, 3h, 2c]=>24,
     [3h, 2h, 2d, 2c]=>24,
     [2h, 3h, 2c, 2s]=>24,
     [3d, 3h, 2h, 2c]=>16,
     [2h, 3h, 3d, 2c]=>16,
     [2d, 3h, 2h, 2c]=>24,
     [2h, 3h, 2d, 2c]=>24,
     [2h, 2d, 2c, 2s]=>12,
     [3h, 2d, 2h, 2c]=>24,
     [2h, 2d, 3h, 2c]=>24,
     [3d, 2d, 2h, 2c]=>8,
     [2h, 2d, 3d, 2c]=>8,
     [2d, 3d, 2h, 2c]=>8,
     [3h, 3d, 2h, 2c]=>16,
     [2h, 3d, 3h, 2c]=>16,
     [2h, 3d, 2d, 2c]=>8,
     [2d, 2c, 3c, 2s]=>48,
     [3d, 2d, 2c, 3c]=>48,
     [2d, 3d, 2c, 3c]=>48,
     [3h, 2c, 3c, 2s]=>96,
     [3d, 3h, 2c, 3c]=>96,
     [3h, 3d, 2c, 3c]=>96,
     [2d, 3h, 2c, 3c]=>144,
     [3h, 2d, 2c, 3c]=>144,
     [2h, 2c, 3c, 2s]=>144,
     [3d, 2h, 2c, 3c]=>144,
     [2h, 3d, 2c, 3c]=>144,
     [2d, 2h, 2c, 3c]=>216,
     [2h, 2d, 2c, 3c]=>216,
     [3h, 2h, 2c, 3c]=>288,
     [2h, 3h, 2c, 3c]=>288}

-------

Back to the brute force analysis, perhaps I can use the actual results to
determine the general equation.

# 2 of Clubs, Deck of 8, brute force analysis

- won 288
- played 2520
- odds 0.11428571428571428

360 hands where a player holds all clubs
- 72 hands where another player holds all spades ??
= 288

How can I calculate that there are 72 hands where one player holds all clubs and
another player holds all spades?

(4 choose 2) * (2 choose 2) * 4 * 3 ?? Arrived at this equation experimenting
with W|A, why the 3?

# 3 of Clubs, Deck of 8, brute force analysis

- won 1872
- played 2520
- odds 0.7428571428571429
- 2520 - 1872 = 648 lost to a spade

# Any spade, Deck of 8, brute force analysis

- won 360
- played 2520
- odds 0.14285714285714285

# Quick sanity check

0.11428571428571428 + 0.7428571428571429 + 0.14285714285714285 = 1.00000000000000003

288 + 1872 + 360 = 2520

Ok, I'm reasonably sure that I finally haven't made a mistake with these
three calculations.

# Analyzing the brute force results

## 2 of Clubs

Now, why is the intersection of 360 hands with all clubs and 360 hands with all
spades 72?

Starting with 8 cards. Any one player gets all clubs:
(6 choose 2) * (4 choose 2) * 4

Any one player gets all clubs and any other player gets all spades:

(4 choose 2) * 4 * 3 = 72. **Ah, 4 players then 3 players.** That explains the 3
above.

So:

(6 choose 2) * (4 choose 2) * 4
- (4 choose 2) * 4 * 3

## 3 of Clubs

1872 tricks resulted in a win for the 3 of clubs.

Total number of tricks (2520)
- number of hands that are all spades (360)
- number of hands where 2c won (288)

# Running past the edge

I have to conclude that I lack that mathematical knowledge to derive the
solutions.

I have constructed a system that models the play of the game. I will use that
against a random selection of 1,000,000 deals from a 52 card deck to derive the
odds for each card of interest.
