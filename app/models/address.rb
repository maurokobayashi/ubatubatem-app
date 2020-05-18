# == Schema Information
#
# Table name: addresses
#
#  id          :bigint           not null, primary key
#  profile_id  :integer
#  logradouro  :string
#  numero      :string
#  complemento :string
#  bairro_id   :integer
#
class Address < ApplicationRecord
  belongs_to :profile
  belongs_to :bairro
end
