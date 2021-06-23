require_relative "player_hand.rb"
require_relative "deck.rb"

deck1 = Deck.new
puts(deck1.cards)
jon_hand = PlayerHand.new(deck1)
puts("jon_hand.cards" + jon_hand.cards.to_s)
puts("deck1.cards" + deck1.cards.to_s)

jon_hand.make_move
puts("jon_hand.cards" + jon_hand.cards.to_s)
puts("deck1.cards" + deck1.cards.to_s)
puts ""

jon_hand.make_move
puts("jon_hand.cards" + jon_hand.cards.to_s)
puts("deck1.cards" + deck1.cards.to_s)
puts ""

jon_hand.make_move
puts("jon_hand.cards" + jon_hand.cards.to_s)
puts("deck1.cards" + deck1.cards.to_s)
