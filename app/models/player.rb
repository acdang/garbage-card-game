class Player < ActiveRecord::Base
    has_many :play_rounds
    has_many :rounds, through: :play_rounds

    def self.new_player(f_name, l_name)
        Player.create(first_name: f_name, last_name: l_name, is_cpu: false)
    end

    def self.check_player(f_name, l_name)
        self.find_by(first_name: f_name, last_name: l_name, is_cpu: false)
    end

    # return full name
    def full_name
        "#{self.first_name} #{self.last_name}"
    end

    # return all games played by a player
    def games
        self.rounds.reload
        # get all game_ids from all player's rounds
        game_ids = self.rounds.map {|round| round.game_id}.uniq

        # return an array of all games played by player
        Game.find(game_ids)
    end

    # return total num games a player has played (completed or not completed)
    def total_num_games
        self.games.count
    end

    def total_num_completed_games
        self.games.select {|game| game.is_complete == true}.count
    end

    # return total num of games a player has won
    def num_games_won
        # get all player's completed games
        # get round id's of those
        # in each play_round with round ids in array check if is_player == self && is_winner == true is >= 2


        # self.rounds.reload
        # # get all of a player's rounds ids
        # all_round_ids = self.rounds.map {|round| round.id}.uniq
        # # in each play_round with round ids in array check if is_player == self && is_winner == true is >= 2
        # binding.pry
        # wins = all_round_ids.map do |round_id|
        #     if self.play_rounds.where(["round_id = ? and is_winner = ?", "#{round_id}", "true"]).count >= 2
        #         1
        #         binding.pry
        #     end
        # end
        # binding.pry
        # wins.count
    end
end
