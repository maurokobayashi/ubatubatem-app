class AddBairroToAddresses < ActiveRecord::Migration[6.0]

  def up
    remove_column :addresses, :bairro
    add_column :addresses, :bairro_id, :integer
  end

  def down
    remove_column :addresses, :bairro_id
    add_column :addresses, :bairro, :string
  end
end
