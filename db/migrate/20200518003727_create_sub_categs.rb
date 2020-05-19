class CreateSubCategs < ActiveRecord::Migration[6.0]
  def change
    create_table :sub_categs do |t|
      t.integer :categ_id, null: false
      t.string :name
      t.string :search_tags
      t.integer :status

    end
    add_index :sub_categs, :name
  end
end
