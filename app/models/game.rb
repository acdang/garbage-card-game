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
        self.rounds.play_rounds.select {|play_round| play_round.is_winner == true}
    end
    # return Player instance of a game's winner
    def get_winner
        # get array containing ids of the winning player of each round in a game
        winner_id_array = self.play_round_winners.map {|play_round| play_round.player_id}

        # determine which player_id had 2 or more wins
        game_winner_id = winner_id_array.find {|id| game_winner_id.count(id) >= 2}
        Player.find(game_winner_id)
    end
end
