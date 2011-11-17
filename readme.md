# Purpose

Calculate the probabilities that the 2 of Clubs through Ace of Clubs, or any
Spade will win the first trick in a simplified game of Spades.

The game is simplified in that card play for the first trick is completely automated:

- if a player holds any clubs, they must play their lowest club
- otherwise, the play may play any heart or diamond
- if the player holds only spades, they must play one

The winner of the trick is the highest club or a spade.

# Usage

The probabilities are calculated by taking a sample of N random decks containing
M cards and playing through their first tricks.

    # Run calculations with default (100 decks with 8 cards each)
    $ rake odds

    # 10000 decks containing 52 cards
    $ rake odds DECKS=10_000 CARDS=52

# Tests

The script is fully unit tested using minitest, run tests with `rake` or `rake tests`
