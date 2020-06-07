class RemoveDeliveryFeeFromDelivery < ActiveRecord::Migration[6.0]
  def up
    remove_column :deliveries, :delivery_fee
  end

  def down
    add_column :deliveries, :delivery_fee, :integer, default: 0
  end
end
