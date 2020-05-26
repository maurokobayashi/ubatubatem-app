class CreateStatistics < ActiveRecord::Migration[6.0]
  def change
    create_table :statistics do |t|
      t.integer :profile_id, null: false
      t.integer :event, null: false
      t.datetime :created_at
    end
  end
end
