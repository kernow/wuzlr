class AddPlayedAndWinsAndLosesToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :played, :integer, :default => 0
    add_column :users, :won,    :integer, :default => 0
    add_column :users, :lost,   :integer, :default => 0
    
    add_column :users, :last_played_at, :datetime
    add_column :users, :last_won_at,    :datetime
    add_column :users, :last_lost_at,   :datetime
    
    add_column :users, :longest_winning_streak, :integer, :default => 0
    add_column :users, :longest_losing_streak,  :integer, :default => 0
  end

  def self.down
    remove_column :users, :played
    remove_column :users, :wins
    remove_column :users, :lost
    
    remove_column :users, :last_played_at
    remove_column :users, :last_won_at
    remove_column :users, :last_lost_at
    
    remove_column :users, :longest_winning_streak
    remove_column :users, :longest_losing_streak
  end
end
