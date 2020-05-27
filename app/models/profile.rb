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
#
class Profile < ApplicationRecord
  include PgSearch::Model
    pg_search_scope :search_by_title_and_tagline,
    against: {
      title: 'A',
      tagline: 'B'
    },
    using: {
      tsearch: {
        prefix: true,
        any_word: true
      }
    }

  has_one :instagram_account, dependent: :destroy
  has_one :address, dependent: :destroy
  has_one :delivery, dependent: :destroy
  has_many :opening_hours, dependent: :destroy
  has_many :statistics, dependent: :destroy
  belongs_to :sub_categ

  enum status: { novo: 0, ativo: 1, denunciado: 2, inativo: 3 }

  def initials
    title.split.first(2).map(&:first).join
  end
end
