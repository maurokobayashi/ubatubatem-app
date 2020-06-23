class AddRestricaoEtariaToFeatures < ActiveRecord::Migration[6.0]
  def change
    add_column :features, :restricao_etaria, :boolean, default: false
  end
end
