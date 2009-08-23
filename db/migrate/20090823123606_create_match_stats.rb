class CreateMatchStats < ActiveRecord::Migration
  def self.up
    create_table :match_stats do |t|
      t.integer  :user_id
      t.integer  :match_id
      t.boolean  :won
      t.integer  :by
    end
  end

  def self.down
    drop_table :match_stats
  end
end
