# == Schema Information
#
# Table name: users
#
#  id                        :bigint           not null, primary key
#  email                     :string
#  password_digest           :string
#  first_name                :string
#  last_name                 :string
#  remember_token            :string
#  remember_token_expires_at :datetime
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  admin                     :boolean          default(FALSE)
#
class User < ApplicationRecord
  include Trestle::Auth::ModelMethods
  include Trestle::Auth::ModelMethods::Rememberable

  # bookmarks many to many association
  has_many :bookmarks, dependent: :destroy
  has_many :profiles, through: :bookmarks, dependent: :destroy

  has_one :profile, dependent: :destroy

  def self.authenticate(_username, _password)
    username = _username.strip.downcase
    password = _password.strip.downcase
    signed_user = nil

    profile = Profile.find_by(username: username)
    if profile.present?
      user = profile.user
      if user.present? && user.authenticate(password)
        signed_user = user
      end
    end
    return signed_user
  end

  def refresh_remember_token
    self.update(remember_token: SecureRandom.urlsafe_base64)
  end
end
