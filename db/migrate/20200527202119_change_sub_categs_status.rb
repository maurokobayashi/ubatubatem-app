class ChangeSubCategsStatus < ActiveRecord::Migration[6.0]
  def up
    change_column_null(:sub_categs, :status, false)
    change_column_default(:sub_categs, :status, from: nil, to: 0)

  end

  def down
    change_column_null(:sub_categs, :status, true)
    change_column_default(:sub_categs, :status, from: 0, to: nil)
  end
end
