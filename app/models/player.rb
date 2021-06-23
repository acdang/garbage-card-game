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

    # return total num of games a player has played
    # WILL SIMPLIFY
    def total_games
        # get all player's PlayRounds
        all_play_rounds = self.play_rounds

        # get all player's Round ids (uniq)
        all_round_ids_uniq = all_play_rounds.map {|play_round| play_round.round_id}.uniq

        # get all games (uniq) -- returned in an array
        all_games = Game.find(all_round_ids_uniq)

        # return count of games
        all_games.count

    end
end
