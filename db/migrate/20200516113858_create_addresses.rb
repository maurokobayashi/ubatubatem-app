class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.integer :profile_id, null: false
      t.string :logradouro
      t.string :numero
      t.string :complemento
      t.string :bairro

    end
    add_index :addresses, :profile_id
  end
end
