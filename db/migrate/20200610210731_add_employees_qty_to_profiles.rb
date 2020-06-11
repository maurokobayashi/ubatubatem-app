class AddEmployeesQtyToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :employees_qty, :integer
  end
end
