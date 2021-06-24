class Round  < ActiveRecord::Base
    belongs_to :game
    has_many :play_rounds
    has_many :players, through: :play_rounds

    def self.new_round
        Round.create
    end
end
