class Game < ActiveRecord::Base
    has_many :rounds

    def self.new_game
        Game.create(is_complete: false)
    end

    def finished
        Game.update(self.id, "is_complete" => true)
    end
end
