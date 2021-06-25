class Deck

    attr_accessor :cards

    def initialize
        @cards = (1..52).to_a.shuffle
    end

    def remove_card
        @cards.shift
    end

end
