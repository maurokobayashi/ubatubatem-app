class AddSubCategIdToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :sub_categ_id, :integer, null: false, default: 1
  end
end
