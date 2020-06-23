class CreateClaim < ActiveRecord::Migration[6.0]
  def change
    create_table :claims do |t|
      t.integer :profile_id
      t.integer :user_id
      t.string :uuid
      t.integer :status, default: 0
    end

    add_index :claims, :uuid
  end
end
