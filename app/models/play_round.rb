class PlayRound  < ActiveRecord::Base
    belongs_to :player
    belongs_to :round

    def self.new_lost_round
        PlayRound.create(is_winner: false)
    end

    def self.new_won_round
        PlayRound.create(is_winner: true)
    end
end 
