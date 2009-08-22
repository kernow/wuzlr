class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.time :started_at
      t.time :finished_at
      t.integer :red_score
      t.integer :blue_score
      t.integer :league_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :matches
  end
end
