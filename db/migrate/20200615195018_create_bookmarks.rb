class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.references :user, index: true
      t.references :profile, index: true
      t.timestamps
    end

  end
end
