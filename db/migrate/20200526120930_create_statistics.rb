class CreateStatistics < ActiveRecord::Migration[6.0]
  def change
    create_table :statistics do |t|
      t.integer :profile_id
      t.integer :event
      t.datetime :created_at

      t.timestamps
    end
  end
end
