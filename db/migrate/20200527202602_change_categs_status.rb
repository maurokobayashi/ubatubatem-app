class ChangeCategsStatus < ActiveRecord::Migration[6.0]
  def up
    change_column_null(:categs, :status, false)
    change_column_default(:categs, :status, from: nil, to: 0)

  end

  def down
    change_column_null(:categs, :status, true)
    change_column_default(:categs, :status, from: 0, to: nil)
  end
end
