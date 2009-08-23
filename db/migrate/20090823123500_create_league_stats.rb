class CreateLeagueStats < ActiveRecord::Migration
  def self.up
    create_table :league_stats do |t|
      t.integer  :user_id
      t.integer  :league_id
      t.integer  :played,                   :default => 0
      t.integer  :won,                      :default => 0
      t.integer  :lost,                     :default => 0
      t.integer  :win_percent,              :default => 0
      
      t.datetime :last_played_at
      
      t.datetime :last_won_at
      t.datetime :last_lost_at

      t.integer  :longest_winning_streak,   :default => 0
      t.integer  :longest_losing_streak,    :default => 0

      t.datetime :last_on_top_at
      t.datetime :last_on_bottom_at
      
      t.integer  :longest_on_top_streak,    :default => 0
      t.integer  :longest_on_bottom_streak, :default => 0
    end
  end

  def self.down
    drop_table :league_stats
  end
end
