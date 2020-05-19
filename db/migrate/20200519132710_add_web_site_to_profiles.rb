class AddWebSiteToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :website, :string
  end
end
