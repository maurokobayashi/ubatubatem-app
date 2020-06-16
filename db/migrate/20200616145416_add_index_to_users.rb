class AddIndexToUsers < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :email
    add_index :users, :remember_token
  end
end
