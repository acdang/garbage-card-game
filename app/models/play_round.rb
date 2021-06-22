class PlayRound  < Active Record::Base
    belongs_to :player
    belongs_to :round
end 
   