# == Schema Information
#
# Table name: profiles
#
#  id              :bigint           not null, primary key
#  user_id         :integer
#  title           :string
#  tagline         :string
#  bio             :text
#  whatsapp        :string
#  phone_secondary :string
#  status          :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Profile < ApplicationRecord
  belongs_to :user
  has_one :address, dependent: :destroy

  enum status: { novo: 0, ativo: 1, denunciado: 2, inativo: 3 }
end
