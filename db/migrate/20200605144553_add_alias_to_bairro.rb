class AddAliasToBairro < ActiveRecord::Migration[6.0]
  def up
    add_column :bairros, :alias, :string

    Bairro.all.each do |b|
      b.alias = b.name.parameterize
      b.save
    end
  end

  def down
    remove_column :bairros, :alias, :string
  end
end
