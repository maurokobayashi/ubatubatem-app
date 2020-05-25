class ChangeDeliveryFee < ActiveRecord::Migration[6.0]
  def up
    change_column_default(:deliveries, :delivery_fee, from: 0, to: nil)
  end

  def down
    change_column_default(:deliveries, :delivery_fee, from: nil, to: 0)
  end
end
