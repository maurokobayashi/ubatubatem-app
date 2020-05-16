# == Schema Information
#
# Table name: addresses
#
#  id          :bigint           not null, primary key
#  profile_id  :integer
#  logradouro  :string
#  numero      :string
#  complemento :string
#  bairro      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Address < ApplicationRecord
  belongs_to :profile
end
