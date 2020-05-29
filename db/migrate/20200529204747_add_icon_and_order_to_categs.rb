class AddIconAndOrderToCategs < ActiveRecord::Migration[6.0]
  def change
    add_column :categs, :icon, :string
    add_column :categs, :order, :integer
  end
end
