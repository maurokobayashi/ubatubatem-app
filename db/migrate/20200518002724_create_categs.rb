class CreateCategs < ActiveRecord::Migration[6.0]
  def change
    create_table :categs do |t|
      t.string :name
      t.string :search_tags
      t.integer :status

    end
    add_index :categs, :name
  end
end
