# == Schema Information
#
# Table name: profiles
#
#  id              :bigint           not null, primary key
#  title           :string
#  tagline         :string
#  bio             :text
#  whatsapp        :string
#  phone_secondary :string
#  status          :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  website         :string
#  avatar_url      :string
#  sub_categ_id    :integer          default(1), not null
#  username        :string
#  user_id         :integer
#
class Profile < ApplicationRecord
  # include PgSearch::Model
  #   pg_search_scope :search_full,
  #   against: {
  #     title: 'A',
  #     username: 'B',
  #     tagline: 'C'
  #   },
  #   using: {
  #     tsearch: {
  #       prefix: true,
  #       any_word: true
  #     }
  #   }

  has_one :instagram_account, dependent: :destroy
  has_one :address, dependent: :destroy
  has_one :bairro, through: :address
  has_one :delivery, dependent: :destroy
  has_many :opening_hours, dependent: :destroy
  has_many :statistics, dependent: :destroy
  belongs_to :sub_categ, optional: true
  belongs_to :user, optional: true

  TITLE_MAX_LENGTH = 30
  TAGLINE_MAX_LENGTH = 60
  BIO_MAX_LENGTH = 150

  scope :active, -> { where(status: ["aprovado", "reivindicado"]) }
  scope :order_by_title, -> { order(title: :asc) }

  validates :title, presence: { message: 'Informe um título' }
  validates :tagline, presence: { message: 'Informe um subtítulo' }
  validates :username, presence: { message: 'Informe um username' }
  validates :username, uniqueness: { message: 'Este username já esta sendo utilizado' }
  validates :username, length: { in: 2..30, message: 'O username deve ter entre 2 e 30 caracteres' }
  validate :username_format
  validate :username_available
  validates :title, length: { maximum: TITLE_MAX_LENGTH, message: 'O título deve possuir no máximo #{TITLE_MAX_LENGTH} caracteres' }
  validates :tagline, length: { maximum: TAGLINE_MAX_LENGTH, message: 'O subtítulo deve possuir no máximo #{TAGLINE_MAX_LENGTH} caracteres' }
  validates :bio, length: { maximum: BIO_MAX_LENGTH, message: 'Sua bio deve possuir no máximo #{BIO_MAX_LENGTH} caracteres' }

  enum status: { novo: 0, aprovado: 1, reivindicado: 2, inativo: 3 }

  ###########################################################################

  def closed?
    !open?
  end

  def completion_progress
    rate = 0
    rate+= 10 if title.present?
    rate+= 10 if tagline.present? && tagline != title
    rate+= 10 if bio.present?
    rate+= 10 if instagram_account.present? && instagram_account.has_permissions?
    rate+= 10 if whatsapp.present?
    rate+= 10 if address.present? && address.bairro.present?
    rate+= 10 if delivery.present? && delivery.is_configured?
    rate+= 10 if opening_hours.present?
    rate+= 10 if sub_categ.present?
    rate+= 10 if self.reivindicado?
    rate
  end

  def current_opening_day
    opening_hours.select{|oh| oh.wday == DateTime.now.wday}.last if opening_hours.present?
  end

  def initials
    title.split.first(2).map(&:first).join
  end

  def open?
    if opening_hours.blank?
      false
    else
      current = self.current_opening_day
      if current.present?
        start = DateTime.now.change({ hour: current.opens_at.hour, min: current.opens_at.min, sec: 0 })
        finish = DateTime.now.change({ hour: current.closes_at.hour, min: current.closes_at.min, sec: 0 })
        DateTime.now.between?(start, finish)
      else
        false
      end
    end
  end

  def profile_path
    "#{Ubatubatem::Application.config.root_url}/#{self.username}"
  end

  def show?
    self.aprovado? || self.reivindicado?
  end


private
  def username_available
    errors.add(:username, "Este username já está sendo utilizado") if USERNAME_UNAVAILABLE.include?( self.username )
  end

  def username_format
    # seguindo as regras do instagram
    errors.add(:username, "O username contém caracteres inválidos") unless !( self.username =~ /^([A-Za-z0-9._](?:(?:[A-Za-z0-9._]|(?:\.(?!\.))){2,28}(?:[A-Za-z0-9._]))?)$/ ).nil?
  end


end
