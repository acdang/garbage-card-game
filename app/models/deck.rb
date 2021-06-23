class Deck

    attr_accessor :cards, :players

    def initialize
        @cards = (1..52).to_a.shuffle
        # @players = []
    end

    def remove_card
        @cards.shift
    end

end
