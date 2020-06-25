class CreateSearchHistory < ActiveRecord::Migration[6.0]
  def change
    create_table :search_histories do |t|
      t.integer :user_id
      t.string :query
      t.integer :result_qty
      t.datetime :created_at
    end

    add_index :search_histories, :query
  end
end
