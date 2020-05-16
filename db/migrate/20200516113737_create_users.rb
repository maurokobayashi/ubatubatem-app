class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :instagram_token
      t.string :instagram_user_id

      t.timestamps
    end
    add_index :users, :username
  end
end
