class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :title
      t.string :tagline
      t.text :bio
      t.string :whatsapp
      t.string :phone_secondary
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
