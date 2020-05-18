class CreateBairros < ActiveRecord::Migration[6.0]
  def change
    create_table :bairros do |t|
      t.string :name
      t.float :lat
      t.float :lng

    end
    add_index :bairros, [:lat, :lng]
  end
end
