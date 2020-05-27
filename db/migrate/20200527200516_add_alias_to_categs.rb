class AddAliasToCategs < ActiveRecord::Migration[6.0]
  def change
    add_column :categs, :alias, :string, null: false
    add_index :categs, :alias
  end
end
