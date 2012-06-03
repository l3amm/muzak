class AddTimerToUser < ActiveRecord::Migration
  def change
    add_column :users, :timer, :integer
  end
end
