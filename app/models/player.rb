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
        self.rounds.reload # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        # get all game_ids from all player's rounds
        game_ids = self.rounds.map {|round| round.game_id}.uniq

        # return an array of all games played by player
        Game.find(game_ids)
    end

    # return total num games a player has played (completed or not completed)
    # WILL SIMPLIFY
    def total_num_games
        self.games.count
    end

    def total_num_completed_games
        self.games.select {|game| game.is_complete == true}.count
    end



    # return total num of games a player has won
    def num_games_won
        # get all player's PlayRounds
        all_play_rounds = self.play_rounds #if nothing, return 0

        # get all player's Round ids (uniq)
        all_round_ids_uniq = all_play_rounds.map {|play_round| play_round.round_id}.uniq

        #get Rounds from those ids
        rounds = Round.find(all_round_ids_uniq)

        # get game ids from those Rounds
        all_game_ids_uniq = rounds.map {|round| round.game_id}.uniq

        # get all games (uniq) -- returned in an array
        all_games = Game.find(all_game_ids_uniq)

        # select all Games where winner_player_id == self.id ????????
        all_wins = all_games.map {|round| round.winner_player_id == self.id}

        # return count of winning games
        all_wins.count
    end

    # return a player's number of wins in a particular round
    def num_wins_in_round(round_id)
        # get all player's PlayRounds
        all_play_rounds = self.play_rounds #if nothing, return 0

        # get all PlayRounds of a particular round
        play_rounds = all_play_rounds.select {|play_round| play_round.round_id == round_id}

        # select PlayRounds player has won
        won = play_rounds.select {|play_round| is_winner == true}

        # return count
        won.count
    end
end
