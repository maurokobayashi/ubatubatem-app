class CreateLeadExcels < ActiveRecord::Migration[6.0]
  def change
    create_table :lead_excels do |t|
      t.string :instagram
      t.string :name
      t.string :whatsapp
      t.string :website
      t.string :logradouro
      t.string :numero
      t.string :bairro
      t.string :horarios
      t.string :categoria
      t.string :porte
    end
  end
end
