class AddShopperIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :shopper_id, :integer
  end
end
