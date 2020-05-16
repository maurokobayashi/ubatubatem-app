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

  enum status: { lead: 0, claimed: 1, reported: 2, inactive: 3 }
end
