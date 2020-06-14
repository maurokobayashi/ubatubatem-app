class AddFeaturesToFeatures < ActiveRecord::Migration[6.0]
  def change
    add_column :features, :plastico, :boolean, default: false
  end
end
