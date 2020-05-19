class CreateLeadInstagrams < ActiveRecord::Migration[6.0]
  def change
    create_table :lead_instagrams do |t|
      t.string :instagram_user_id
      t.string :username
      t.string :title
      t.string :avatar_url
      t.datetime :created_at

    end
    add_index :lead_instagrams, :username
  end
end
