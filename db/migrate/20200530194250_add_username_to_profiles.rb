class AddUsernameToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :username, :string
    add_index :profiles, :username
  end
end
