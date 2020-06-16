class AddLastLoginToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :last_login, :datetime

    User.all.each do |user|
      user.last_login = user.updated_at
      user.save
    end
  end
end
