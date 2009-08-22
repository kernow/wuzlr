class AddWinLossPercentageToUSers < ActiveRecord::Migration
  def self.up
    add_column :users, :win_loss_percentage, :float, :default => 0
  end

  def self.down
    remove_column :users, :win_loss_percentage
  end
end
