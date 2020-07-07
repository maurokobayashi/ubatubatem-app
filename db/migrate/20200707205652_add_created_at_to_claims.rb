class AddCreatedAtToClaims < ActiveRecord::Migration[6.0]
  def change
    add_column :claims, :created_at, :datetime
  end
end
