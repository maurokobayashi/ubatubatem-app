class AddAvatarUrlToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :avatar_url, :string
  end
end
