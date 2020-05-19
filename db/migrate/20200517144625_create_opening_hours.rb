class CreateOpeningHours < ActiveRecord::Migration[6.0]
  def change
    create_table :opening_hours do |t|
      t.integer :profile_id, null: false
      t.integer :day
      t.time :opens_at
      t.time :closes_at

    end
    add_index :opening_hours, :profile_id
  end
end
