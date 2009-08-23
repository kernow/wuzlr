class CreateFifaTeams < ActiveRecord::Migration
  def self.up
    create_table :fifa_teams do |t|
      t.string :name
      t.string :flag
      
      t.integer :goals_for
      t.integer :goals_against
      t.integer :penalty_goal
      t.integer :goals_for_average
      t.integer :yellow_cards
      t.integer :second_yellow_cards
      t.integer :red_cards
      t.integer :matches_played
      t.integer :won
      t.integer :draw
      t.integer :lost
    end
  end

  def self.down
    drop_table :fifa_teams
  end
end
