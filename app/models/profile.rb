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
#  search_tags     :string
#  employees_qty   :integer
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

  TITLE_MAX_LENGTH = 30
  TAGLINE_MAX_LENGTH = 60
  BIO_MAX_LENGTH = 150
  USERNAME_MAX_LENGTH = 30
  SEARCH_TAGS_MAX_LENGTH = 150

  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address
  has_one :bairro, through: :address
  has_many :bookmarks, dependent: :destroy
  has_one :delivery, dependent: :destroy
  has_one :feature, dependent: :destroy
  has_one :instagram_account, dependent: :destroy
  accepts_nested_attributes_for :instagram_account
  has_many :opening_hours, -> { order(day: :asc) }, dependent: :destroy
  accepts_nested_attributes_for :opening_hours, allow_destroy: true, reject_if: lambda {|attr| attr['day'].blank?}
  has_many :statistics, dependent: :destroy
  belongs_to :sub_categ, optional: true
  belongs_to :user, optional: true

  scope :active, -> { where(status: ["aprovado", "reivindicado"]) }
  scope :order_by_title, -> { order(title: :asc) }

  validates :title, presence: { message: 'Informe um título' }
  validates :tagline, presence: { message: 'Informe um subtítulo' }
  validates :username, presence: { message: 'Informe um username' }
  validates :username, uniqueness: { message: 'Este username já esta sendo utilizado' }
  validates :username, length: { in: 2..USERNAME_MAX_LENGTH, message: 'O username deve ter entre 2 e #{USERNAME_MAX_LENGTH} caracteres' }
  validate :username_format
  validate :username_available
  validates :title, length: { maximum: TITLE_MAX_LENGTH, message: 'O título deve possuir no máximo #{TITLE_MAX_LENGTH} caracteres' }
  validates :tagline, length: { maximum: TAGLINE_MAX_LENGTH, message: 'O subtítulo deve possuir no máximo #{TAGLINE_MAX_LENGTH} caracteres' }
  validates :bio, length: { maximum: BIO_MAX_LENGTH, message: 'Sua bio deve possuir no máximo #{BIO_MAX_LENGTH} caracteres' }
  validates :search_tags, length: { maximum: SEARCH_TAGS_MAX_LENGTH, message: 'Os termos de busca devem possuir no máximo #{SEARCH_TAGS_MAX_LENGTH} caracteres' }

  enum status: { novo: 0, aprovado: 1, reivindicado: 2, inativo: 3 }

  ###########################################################################

  def avatar
    self.avatar_url || "avatar_empty"
  end

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

  def is_alimentacao?
    self.sub_categ.present? && self.sub_categ.categ.alias == "alimentacao"
  end

  def is_moda?
    self.sub_categ.present? && self.sub_categ.categ.alias == "moda"
  end

  def is_saude_e_beleza?
    self.sub_categ.present? && self.sub_categ.categ.alias == "saude-e-beleza"
  end

  def is_pets?
    self.sub_categ.present? && self.sub_categ.categ.alias == "pets"
  end

  def is_feito_a_mao?
    self.sub_categ.present? && self.sub_categ.categ.alias == "feito-a-mao"
  end

  def is_lojas?
    self.sub_categ.present? && self.sub_categ.categ.alias == "lojas"
  end

  def is_servicos?
    self.sub_categ.present? && self.sub_categ.categ.alias == "servicos"
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

  def setup_opening_hours
    example = OpeningHour.new(opens_at: Time.new(2000, 01, 01, 8, 0, 0, Time.find_zone("America/Sao_Paulo")), closes_at: Time.new(2000, 01, 01, 18, 0, 0, Time.find_zone("America/Sao_Paulo")))

    if self.opening_hours.blank?
      self.opening_hours = []
    else
      example = opening_hours.first
    end

    self.opening_hours.push OpeningHour.create(day: 0, opens_at: example.opens_at, closes_at: example.closes_at) unless self.opening_hours.any? { |oh| oh.seg? }
    self.opening_hours.push OpeningHour.create(day: 1, opens_at: example.opens_at, closes_at: example.closes_at) unless self.opening_hours.any? { |oh| oh.ter? }
    self.opening_hours.push OpeningHour.create(day: 2, opens_at: example.opens_at, closes_at: example.closes_at) unless self.opening_hours.any? { |oh| oh.qua? }
    self.opening_hours.push OpeningHour.create(day: 3, opens_at: example.opens_at, closes_at: example.closes_at) unless self.opening_hours.any? { |oh| oh.qui? }
    self.opening_hours.push OpeningHour.create(day: 4, opens_at: example.opens_at, closes_at: example.closes_at) unless self.opening_hours.any? { |oh| oh.sex? }
    self.opening_hours.push OpeningHour.create(day: 5, opens_at: example.opens_at, closes_at: example.closes_at) unless self.opening_hours.any? { |oh| oh.sab? }
    self.opening_hours.push OpeningHour.create(day: 6, opens_at: example.opens_at, closes_at: example.closes_at) unless self.opening_hours.any? { |oh| oh.dom? }
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
