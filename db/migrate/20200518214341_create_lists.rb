class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.string :cover_image_url
      t.string :title
      t.string :subtitle
      t.integer :profile_ids, array: true, default: []
      t.time :starts_at
      t.time :finishes_at
      t.datetime :expires_on
      t.integer :priority, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
