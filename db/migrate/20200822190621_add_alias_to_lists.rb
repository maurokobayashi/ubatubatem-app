class AddAliasToLists < ActiveRecord::Migration[6.0]
  def change
    add_column :lists, :alias, :string, null: false
    add_index :lists, :alias
  end
end
