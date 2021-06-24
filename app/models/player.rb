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
    # given a round id, return true if player won that round
    def win_round?(round_id)
        self.play_rounds.find_by("round_id == #{round_id}").is_winner == true
    end

    # return total num of games a player has won
    def num_games_won
        # get all player's completed games
        completed_games = self.games.select {|game| game.is_complete == true}
        # get ids of those completed games
        completed_game_ids = completed_games.map {|game| game.id}
        
        won_games = completed_game_ids.map do |game_id|
            is_winner = Round.rounds_of_game(game_id).map do |round|
                self.win_round?(round.id)
            end
            is_winner.count(true) >= 2
        end
        won_games.count(true)
    end
end
