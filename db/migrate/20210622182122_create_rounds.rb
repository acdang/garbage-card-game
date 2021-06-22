class CreateRounds < ActiveRecord::Migration[6.1]
  def change
    create_table :rounds do |t|
      #primary key of :id is created for us!
      t.integer :game_id
    end    
  end
end
