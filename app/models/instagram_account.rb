# == Schema Information
#
# Table name: instagram_accounts
#
#  id                :bigint           not null, primary key
#  username          :string
#  access_token      :string
#  instagram_user_id :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class InstagramAccount < ApplicationRecord
  belongs_to :profile, dependent: :destroy
end
