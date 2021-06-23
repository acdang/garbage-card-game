class PlayerHand

    attr_accessor :cards, :deck, :round_won

    def initialize(deck, player)
        @deck = deck
        @cards = []
        @player = player
        10.times do 
            @cards.append(deck.remove_card)
        end
        # deck.players << self
        @round_won = false
    end
    
    def make_move

        card = deck.remove_card

        while card do

            if card != nil
                card %= 13
            else
                return true
            end

            if card == 0
                # print out available spots to insert wild card
                # and prompt user to play wild in that spot
                if complete_hand?(@cards)
                    game_won
                end

                # delete later
                card = @cards[0]
                i = 0
                while card == nil do
                    i += 1
                    card = @cards[i]
                end

                @cards[i] = nil

            elsif card == 11 || card == 12
                return true

            else
                card = swap_cards(card)
                if complete_hand?(@cards)
                    win
                end
            end

        end

    end

    private

    def swap_cards(new)
        temp = @cards[new - 1]
        @cards[new - 1] = nil
        new = temp
        return new
    end

    def complete_hand?(array)
        array.uniq.size <= 1
    end

    def win
        @round_won = true
    end

end
