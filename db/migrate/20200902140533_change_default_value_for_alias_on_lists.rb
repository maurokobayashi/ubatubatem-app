class ChangeDefaultValueForAliasOnLists < ActiveRecord::Migration[6.0]
  def up
    change_column_default :lists, :alias, nil
  end

  def down
    change_column_default :lists, :alias, ""
  end
end
