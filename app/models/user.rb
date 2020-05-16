# == Schema Information
#
# Table name: users
#
#  id                :bigint           not null, primary key
#  username          :string
#  instagram_token   :string
#  instagram_user_id :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class User < ApplicationRecord
  has_one :profile, dependent: :destroy
end
