# == Schema Information
#
# Table name: addresses
#
#  id          :bigint           not null, primary key
#  profile_id  :integer          not null
#  logradouro  :string
#  numero      :string
#  complemento :string
#  bairro_id   :integer
#
class Address < ApplicationRecord
  belongs_to :profile
  belongs_to :bairro

  validates :bairro, presence: { message: 'Informe um bairro' }, on: :update
end
