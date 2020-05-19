class CreateInstagramAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :instagram_accounts do |t|
      t.integer :profile_id, null: false
      t.string :username
      t.string :access_token
      t.string :instagram_user_id

      t.timestamps
    end
    add_index :instagram_accounts, :profile_id
  end
end
