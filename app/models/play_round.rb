class PlayRound  < ActiveRecord::Base
    belongs_to :player
    belongs_to :round

    def self.new_lost_round(round_id, player_id)
        PlayRound.create(is_winner: false, round_id: round_id, player_id: player_id)
    end

    def self.new_won_round(round_id, player_id)
        PlayRound.create(is_winner: true, round_id: round_id, player_id: player_id)
    end
end 
