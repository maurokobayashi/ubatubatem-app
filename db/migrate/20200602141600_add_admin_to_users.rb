class AddAdminToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin, :boolean, default: false
    User.find_by(email: "mauro.kobayashi@gmail.com").update_attribute(:admin, true)
  end
end
