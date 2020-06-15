class AddIndexToBairros < ActiveRecord::Migration[6.0]
  def change
    add_index :bairros, :alias
  end
end
