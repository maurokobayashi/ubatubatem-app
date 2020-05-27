class AddAliasToSubCategs < ActiveRecord::Migration[6.0]
  def change
    add_column :sub_categs, :alias, :string, null: false
    add_index :sub_categs, :alias
  end
end
