class Round  < ActiveRecord::Base
    belongs_to :game
    has_many :play_rounds
    has_many :rounds, through: :play_rounds

    def self.new_round(game_id)
        Round.create(game_id: game_id)
    end
end
