class ChangeSubCategsCategId < ActiveRecord::Migration[6.0]
  def up
    change_column_null(:sub_categs, :categ_id, false)
  end

  def down
    change_column_null(:sub_categs, :categ_id, true)
  end
end
