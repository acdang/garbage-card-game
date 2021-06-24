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
        
    end
end
