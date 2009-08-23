class RenameMatchToMatchIdForUserStats < ActiveRecord::Migration
  def self.up
    rename_column :user_stats, :match, :match_id
  end

  def self.down
    rename_column :user_stats, :match_id, :match
  end
end
