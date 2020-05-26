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
#
class Profile < ApplicationRecord
  has_one :instagram_account, dependent: :destroy
  has_one :address, dependent: :destroy
  has_one :delivery, dependent: :destroy
  has_many :opening_hours, dependent: :destroy
  has_many :statistics, dependent: :destroy

  enum status: { novo: 0, ativo: 1, denunciado: 2, inativo: 3 }

  def initials
    title.split.first(2).map(&:first).join
  end
end
