class Game < ActiveRecord::Base
    has_many :rounds

    def self.new_game
        Game.create(is_complete: false)
    end

    def finished
        Game.update(self.id, "is_complete" => true)
    end
    # return array of PlayRound winners of each round in a game
    def play_round_winners
        all_round_ids = self.rounds.map {|round| round.id}
        # get all play_rounds of those rounds
        game_play_rounds = all_round_ids.map {|round_id| PlayRound.where("round_id = #{round_id}")}.flatten
        # get all winning play_rounds
        game_play_rounds.select {|play_round| play_round.is_winner == true}
        # binding.pry
    end
    # return Player instance of a game's winner
    def get_winner
        # get array containing ids of the winning player of each round in a game
        # binding.pry
        winner_id_array = self.play_round_winners.map {|play_round| play_round.player_id}

        # determine which player_id had 2 or more wins
        game_winner_id = winner_id_array.find {|id| winner_id_array.count(id) >= 2}
        # binding.pry
        Player.find(game_winner_id)
    end
end
