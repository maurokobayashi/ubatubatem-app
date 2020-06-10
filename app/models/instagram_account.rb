# == Schema Information
#
# Table name: instagram_accounts
#
#  id                :bigint           not null, primary key
#  profile_id        :integer
#  username          :string
#  access_token      :string
#  instagram_user_id :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class InstagramAccount < ApplicationRecord

  USERNAME_MAX_LENGTH = 30

  belongs_to :profile, dependent: :destroy

  validates :username, uniqueness: { message: 'Este Instagram já está cadastrado' }

  def has_permissions?
    self.access_token.present?
  end
end
