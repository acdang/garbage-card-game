class CreatePlayRounds < ActiveRecord::Migration[6.1]
  def change
    create_table :play_rounds do |t|
      t.boolean :is_winner, default: false
      t.integer :round_id
      t.integer :player_id
    end      
  end
end
