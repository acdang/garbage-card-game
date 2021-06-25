class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      #primary key of :id is created for us!
      t.boolean :is_complete, default: false
    end    
  end
end
