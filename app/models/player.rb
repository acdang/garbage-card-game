class Player < ActiveRecord::Base
    has_many :play_rounds
    has_many :rounds, through: :play_rounds

    def self.new_player(f_name, l_name)
        Player.create(first_name: f_name, last_name: l_name, is_cpu: false)
    end

    def self.check_player(f_name, l_name)
        self.find_by(first_name: f_name, last_name: l_name, is_cpu: false)
    end

    # return number of games played by Player instance
    def num_of_games

    end
end
