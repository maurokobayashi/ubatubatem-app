class DropDeliveries < ActiveRecord::Migration[6.0]
  def up
    drop_table :deliveries
  end

  def down
    create_table :deliveries do |t|
      t.integer :profile_id, null: false
      t.boolean :has_delivery, default: true
      t.boolean :has_retirada, default: false
      t.boolean :has_ponto_comercial, default: false
      t.integer :bairro_ids, array: true, default: []
    end
  end
end
