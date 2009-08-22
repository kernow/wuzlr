class AddUserToLeagues < ActiveRecord::Migration
  def self.up
    add_column :leagues, :user_id, :integer
  end

  def self.down
    remove_column :leagues, :user_id
  end
end
