class AddPlayedAndWinsAndLosesToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :played, :integer
    add_column :users, :won,    :integer
    add_column :users, :lost,   :integer
    
    add_column :users, :last_played_at, :datetime
    add_column :users, :last_won_at,    :datetime
    add_column :users, :last_lost_at,   :datetime
    
    add_column :users, :longest_winning_streak, :integer
    add_column :users, :longest_losing_streak,  :integer
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
