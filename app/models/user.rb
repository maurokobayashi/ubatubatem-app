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
#  last_login                :datetime
#
class User < ApplicationRecord
  include Trestle::Auth::ModelMethods
  include Trestle::Auth::ModelMethods::Rememberable

  # bookmarks many to many association
  has_many :bookmarks, dependent: :destroy
  has_many :profiles, through: :bookmarks, dependent: :destroy

  has_one :profile, dependent: :destroy

  validates :email, presence: { message: 'Informe um email' }
  validates :password_digest, presence: { message: 'Informe uma senha' }

  ###########################################################################

  def self.authenticate(_login, _password)
    login = _login.strip.downcase
    password = _password.strip.downcase
    signed_user = nil

    user = User.left_outer_joins(:profile).where(email: login)
      .or(User.left_outer_joins(:profile).where(profiles: {username: login}))
      .first

    if user.present? && user.authenticate(password)
      signed_user = user
    end

    return signed_user
  end

  def bookmarked?(profile)
    self.bookmarks.exists?(profile: profile)
  end

  def is_business
    self.profile.present?
  end

  def is_consumer
    !is_business
  end

  def new_profiles_count
    Profile.active.where("created_at > ?", self.last_login).count
  end

  def refresh_remember_token
    self.update(remember_token: SecureRandom.urlsafe_base64)
  end

  def update_last_login
    self.update(last_login: DateTime.now)
  end
end
