class Round  < ActiveRecord::Base
    belongs_to :game
    has_many :play_rounds
    has_many :players, through: :play_rounds

    def self.new_round
        Round.create
    end

    # given a round id, return array of rounds of that game
    def self.rounds_of_game(game_id)
        Round.all.select {|round| round.game_id == game_id}
    end
end
