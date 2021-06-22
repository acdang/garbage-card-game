class Round  < Active Record::Base
    belongs_to :game
    has_many :play_rounds
    has_many :rounds, through: :play_rounds
end
