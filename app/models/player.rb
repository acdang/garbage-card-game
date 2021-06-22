class Player < Active Record::Base
    has_many :play_rounds
    has_many :rounds, through: :play_rounds
end
