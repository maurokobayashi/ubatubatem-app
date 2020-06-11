class CreateFeatures < ActiveRecord::Migration[6.0]
  def change
    create_table :features do |t|
      t.integer :profile_id, null: false

      t.boolean :delivery, default: false
      t.boolean :ponto_comercial, default: false
      t.boolean :produtor_local, default: false

      t.boolean :vegetariano, default: false
      t.boolean :natural, default: false

      t.boolean :vegano, default: false
      t.boolean :organico, default: false
      t.boolean :lactose, default: false
      t.boolean :gluten, default: false
      t.boolean :diabetico, default: false

      t.boolean :plus_size, default: false
    end

    add_index :features, :profile_id
  end
end
