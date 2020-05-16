class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :title
      t.string :tagline
      t.text :bio
      t.string :whatsapp
      t.string :phone_secondary
      t.integer :status

      t.timestamps
    end
    add_index :profiles, :user_id
  end
end
