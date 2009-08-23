class CreateUserStats < ActiveRecord::Migration
  def self.up
    create_table :user_stats do |t|
      t.integer :user_id
      t.integer :other_user_id
      t.string  :relation
      t.integer :match
      t.boolean :won
      t.integer :by
    end
  end

  def self.down
    drop_table :user_stats
  end
end
