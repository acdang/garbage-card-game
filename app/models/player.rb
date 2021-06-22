class Player < ActiveRecord::Base
    has_many :play_rounds
    has_many :rounds, through: :play_rounds
end
