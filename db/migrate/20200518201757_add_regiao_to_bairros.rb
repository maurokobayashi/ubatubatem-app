class AddRegiaoToBairros < ActiveRecord::Migration[6.0]
  def up
    add_column :bairros, :regiao, :integer

    Bairro.all.each do |bairro|
      id = bairro.id
      bairro.regiao = 0 if (id>=1 && id<=9)
      bairro.regiao = 0 if (id>=27 && id<=28)
      bairro.regiao = 1 if (id>=10 && id<=13)
      bairro.regiao = 2 if (id>=29 && id<=44)
      bairro.regiao = 3 if (id>=14 && id<=26)

      bairro.save
    end
  end

  def down
    remove_column :bairros, :regiao
  end
end
