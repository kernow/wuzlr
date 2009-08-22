class AddStateToMatches < ActiveRecord::Migration
  def self.up
    add_column :matches, :state, :string
  end

  def self.down
    drop_column :matches, :state
  end
end
