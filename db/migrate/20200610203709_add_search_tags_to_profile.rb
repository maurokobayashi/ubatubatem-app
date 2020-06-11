class AddSearchTagsToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :search_tags, :string
  end
end
