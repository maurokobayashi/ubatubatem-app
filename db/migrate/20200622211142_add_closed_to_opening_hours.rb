class AddClosedToOpeningHours < ActiveRecord::Migration[6.0]
  def change
    add_column :opening_hours, :closed, :boolean, default: true
  end
end
